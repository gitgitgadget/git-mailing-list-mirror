From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH/RFC] fast-import: insert new object entries at start of
 hash bucket
Date: Tue, 23 Nov 2010 15:29:37 -0800
Message-ID: <AANLkTimG2V2h=z3t0kHxOy65W7JjayNb1RA8E4AabCV+@mail.gmail.com>
References: <20101123075348.GA10367@burratino> <AANLkTikqUjjjMRzWTcEOs+2PGu=-9VVbdn0YgpabFaDu@mail.gmail.com>
 <20101123231718.GA4317@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Raja R Harinath <harinath@hurrynot.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 00:30:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL2JO-0001E0-FK
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 00:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab0KWXaB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 18:30:01 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41188 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160Ab0KWXaA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 18:30:00 -0500
Received: by iwn33 with SMTP id 33so692707iwn.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 15:30:00 -0800 (PST)
Received: by 10.231.10.132 with SMTP id p4mr9022168ibp.40.1290554999020; Tue,
 23 Nov 2010 15:29:59 -0800 (PST)
Received: by 10.231.162.65 with HTTP; Tue, 23 Nov 2010 15:29:37 -0800 (PST)
In-Reply-To: <20101123231718.GA4317@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162034>

On Tue, Nov 23, 2010 at 3:17 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Shawn Pearce wrote:
>> On Mon, Nov 22, 2010 at 11:53 PM, Jonathan Nieder <jrnieder@gmail.co=
m> wrote:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 The way I
>> read this store_tree() code, every subdirectory is recursed into eve=
n
>> if no modifications were made inside of that subdirectory during the
>> current commit.
>
> Doesn't the is_null_sha1 check avoid that?

Oh, right, yes.  That check avoids processing a tree that wasn't
modified.  Damn that code isn't very clear.  :-(

> To further explain the workload: svn-fe receives its blobs from svn
> in the form of deltas. =A0So the conversation might go like this:
=2E..
> Current svn-fe in vcs-svn-pu requests the preimage blobs using marks,
> but the idea is the same.
>
> If this proves a bottleneck I suppose we could cache the content of
> frequently-requested old blobs and keep pointers to that in the
> in-core tree.

OK, now I get it.

fast-import already uses sha1_file.c's delta base cache for the delta
bases that are frequently accessed.  It *may* help an importer that
needs to keep refetching the same blob to cache the blob itself rather
than its delta base (and reapply every time).  It might not help too,
it may hurt to try and keep recently accessed objects that the
importer won't need to request again.

--=20
Shawn.
