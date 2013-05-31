From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/2] lookup_commit_reference_gently: do not read non-{tag,commit}
Date: Fri, 31 May 2013 10:16:44 +0200
Message-ID: <87fvx37edv.fsf@linux-k42r.v.cablecom.net>
References: <2d926e4dbd218b2305f50652c00a5c1d87e81208.1369943791.git.trast@inf.ethz.ch>
	<5cc40825d5b4fb3382e4c054c49adf5e6b6fe110.1369943791.git.trast@inf.ethz.ch>
	<CALkWK0nL4hPio74Hm+ctObNNFg9+=9brKXFK2ymGB=sPTAk1Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <kernel-hacker@bennee.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	=?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
	<pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 31 10:16:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiKW6-0003jA-1W
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 10:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540Ab3EaIQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 04:16:50 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:21696 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997Ab3EaIQr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 04:16:47 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 31 May
 2013 10:16:43 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 31 May 2013 10:16:44 +0200
In-Reply-To: <CALkWK0nL4hPio74Hm+ctObNNFg9+=9brKXFK2ymGB=sPTAk1Hg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 31 May 2013 12:13:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226076>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Thomas Rast wrote:
>> +       struct object *obj;
>> +       int type = sha1_object_info(sha1, NULL);
>> +       /* If it's neither tag nor commit, parsing the object is wasted effort */
>> +       if (type != OBJ_TAG && type != OBJ_COMMIT)
>> +               return NULL;
>> +       obj = deref_tag(parse_object(sha1), NULL, 0);
[...]
> In contrast, parse_object() first calls lookup_object() to look it up
> in some hashtable to get the type -- the packfile idx, presumably?
> Why don't you also do that instead of sha1_object_info()?  Or, why
> don't you wrap parse_object() in an API that doesn't go beyond the
> first blob check (and not execute parse_object_buffer())?
>
> Also, does this patch fix the bug Alex reported?
>
> Apologies if I've misunderstood something horribly (which does seem to
> be the case).

Yes, it does fix the bug.  (It's not really buggy, just slow.)

However, you implicitly point out an important point: If we have the
object, and it was already parsed (obj->parsed is set), parse_object()
is essentially free.  But sha1_object_info is not, it will in particular
unconditionally dig through long delta chains to discover the base type
of an object that has already been unpacked.


As for your original questions: lookup_object() is "do we have it in our
big object hashtable?" -- the one that holds many[1] objects, that Peff
recently sped up.

sha1_object_info() and read_object() are in many ways parallel functions
that do approximately the following:

  check all pack indexes for this object
  if we found a hit:
    attempt to unpack by recursively going through deltas
    (for _info, no need to unpack, but we still go through the delta
    chain because the type of object is determined by the innermost
    delta base)
  try to load it as a loose object
  it could have been repacked and pruned while we were looking, so:
    reload pack index information
    try the packs again (search indexes, then unpack)
  complain


[1]  blobs in particular are frequently not stored in that hash table,
because it is an insert-only table

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
