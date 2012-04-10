From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [POC PATCH 5/5] sha1_file: make the pack machinery thread-safe
Date: Tue, 10 Apr 2012 14:29:20 +0200
Message-ID: <8762d7zs67.fsf@thomas.inf.ethz.ch>
References: <cover.1323419666.git.trast@student.ethz.ch>
	<dd2bf650b382f5aca727b7d93a48598fb1a2f7d9.1323419666.git.trast@student.ethz.ch>
	<CACsJy8AyphUD-vFwwgaW0eWG3ekgHA+tcAwV2zk5YGorkW0TzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Herman <eric@freesa.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 14:29:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHaCQ-0002pO-C2
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 14:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758611Ab2DJM3Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Apr 2012 08:29:25 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:48250 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755741Ab2DJM3Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Apr 2012 08:29:24 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.283.3; Tue, 10 Apr
 2012 14:29:20 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 10 Apr
 2012 14:29:20 +0200
In-Reply-To: <CACsJy8AyphUD-vFwwgaW0eWG3ekgHA+tcAwV2zk5YGorkW0TzQ@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Mon, 9 Apr 2012 21:43:56 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195080>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Fri, Dec 9, 2011 at 3:39 PM, Thomas Rast <trast@student.ethz.ch> w=
rote:
>> More precisely speaking, this pushes the locking down from
>> read_object() into bits of the pack machinery that cannot (yet) run =
in
>> parallel.
>>
>> There are several hacks here:
>>
>> a) prepare_packed_git() must be called before any parallel accesses
>> =C2=A0 happen. =C2=A0It now unconditionally opens and maps all index=
 files.
>>
>> b) similarly, prepare_replace_object() must be called before any
>> =C2=A0 parallel read_sha1_file() happens
>>
>> This simplification lets us avoid locking outright to guard the inde=
x
>> accesses; locking is then mainly required for open_packed_git(),
>> [un]use_pack(), and such.
>>
>> The ultimate goal would of course be to let at least _some_ pack
>> accesses happen without any locking whatsoever. =C2=A0But grep alrea=
dy
>> benefits from it with a nice speed boost on non-worktree greps.
>
> (I'm running into multithread pack access problem in rev-list..)
>
> Why not put the global pointer "struct packed_git *packed_git" to
> "struct pack_context" and avoid locking entirely? Resource usage is
> like we run <n> different processes, I think, which is not too bad. W=
e
> may want to share a few static pack_* variables such as
> pack_open_fds.. to avoid hitting system limits too fast.

I was hesitating to do that because I think it's not the best solution
yet.  At least for 64bit systems, I thought of doing some or all of:

* opening/mapping the pack indexes immediately to avoid locking there
  (perhaps the POC already does this, I haven't looked again).  If you
  have many packs this isn't cheap because the index must be verified.

* mapping small packs immediately

* mapping "the" big pack immediately (many repos will have a huge pack
  from the initial clone)

Put another way, my current concern is that on 64bit systems it's
incredibly easy to share (who cares about a few GBs of mmap()?), wherea=
s
on 32bit systems it probably matters much more, but there we also suffe=
r
more from not sharing.

Am I making any sense?

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
