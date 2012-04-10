From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [POC PATCH 5/5] sha1_file: make the pack machinery thread-safe
Date: Tue, 10 Apr 2012 20:39:10 +0700
Message-ID: <CACsJy8CwJ-sfj2yTqp+LJYt1bhsDqQ21ob_hp9iZRV82cF=sPg@mail.gmail.com>
References: <cover.1323419666.git.trast@student.ethz.ch> <dd2bf650b382f5aca727b7d93a48598fb1a2f7d9.1323419666.git.trast@student.ethz.ch>
 <CACsJy8AyphUD-vFwwgaW0eWG3ekgHA+tcAwV2zk5YGorkW0TzQ@mail.gmail.com> <8762d7zs67.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Herman <eric@freesa.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Apr 10 15:39:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHbIS-0004Jp-Nt
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 15:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758813Ab2DJNjn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Apr 2012 09:39:43 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:53204 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818Ab2DJNjm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Apr 2012 09:39:42 -0400
Received: by wejx9 with SMTP id x9so3270765wej.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 06:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=/rAJl6tGhUx411jZV1TP1i95PF6uem6UZRmDJuHIaZE=;
        b=kZMwCVEAG3nDKl56dbqb+NJplImRcwy8N9c0DUhfHmtbPUN9nYJFBOeuSkWoLUQSmU
         2O84SORQAT1QoREmRAlCCvGzJABLFlJZPK5JttZwbrbqbti/Mf+etJEb0T4uY7ymuieT
         MzJ7GOgA1TXVcr6k/OO4GvQ3FKVDRyX/qhUOKg/pCW+PyfJGUeBzphz1EHodK6k6CAmF
         TbwtwML8bX6ImHnNiU/wSt2VXTG299cud+ZwliciK+jvaQbqP54egs/ao5euhnkTWEwc
         62/l6td9U5iUsDjiZFc5r9EkMZbDIBePk1N06hEkXHQJYoHjQU+xtrq00V/4+ybaN5kk
         c27w==
Received: by 10.216.135.20 with SMTP id t20mr5840364wei.99.1334065180445; Tue,
 10 Apr 2012 06:39:40 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Tue, 10 Apr 2012 06:39:10 -0700 (PDT)
In-Reply-To: <8762d7zs67.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195081>

On Tue, Apr 10, 2012 at 7:29 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Fri, Dec 9, 2011 at 3:39 PM, Thomas Rast <trast@student.ethz.ch> =
wrote:
>>> More precisely speaking, this pushes the locking down from
>>> read_object() into bits of the pack machinery that cannot (yet) run=
 in
>>> parallel.
>>>
>>> There are several hacks here:
>>>
>>> a) prepare_packed_git() must be called before any parallel accesses
>>> =C2=A0 happen. =C2=A0It now unconditionally opens and maps all inde=
x files.
>>>
>>> b) similarly, prepare_replace_object() must be called before any
>>> =C2=A0 parallel read_sha1_file() happens
>>>
>>> This simplification lets us avoid locking outright to guard the ind=
ex
>>> accesses; locking is then mainly required for open_packed_git(),
>>> [un]use_pack(), and such.
>>>
>>> The ultimate goal would of course be to let at least _some_ pack
>>> accesses happen without any locking whatsoever. =C2=A0But grep alre=
ady
>>> benefits from it with a nice speed boost on non-worktree greps.
>>
>> (I'm running into multithread pack access problem in rev-list..)
>>
>> Why not put the global pointer "struct packed_git *packed_git" to
>> "struct pack_context" and avoid locking entirely? Resource usage is
>> like we run <n> different processes, I think, which is not too bad. =
We
>> may want to share a few static pack_* variables such as
>> pack_open_fds.. to avoid hitting system limits too fast.
>
> I was hesitating to do that because I think it's not the best solutio=
n
> yet. =C2=A0At least for 64bit systems, I thought of doing some or all=
 of:
>
> * opening/mapping the pack indexes immediately to avoid locking there
> =C2=A0(perhaps the POC already does this, I haven't looked again). =C2=
=A0If you
> =C2=A0have many packs this isn't cheap because the index must be veri=
fied.

Sharing mmapped pack indexes makes sense. We do full mmap there so it
eats address space in 32 bit systems (but still not a lot, linux-2.6
pack index is about 60MB).

I tried but could not find the index verifying code (i.e. recalculate
sha-1 and match with stored one) anywhere, so I suppose opening packs
and indexes is cheap.

> * mapping small packs immediately

We need to partition file handle space to avoid running out of file han=
dles.

> * mapping "the" big pack immediately (many repos will have a huge pac=
k
> =C2=A0from the initial clone)

We have sliding pack windows exactly for that: accessing >4GB packs in
32bit systems. So address space should not be an issue here.

> Put another way, my current concern is that on 64bit systems it's
> incredibly easy to share (who cares about a few GBs of mmap()?), wher=
eas
> on 32bit systems it probably matters much more, but there we also suf=
fer
> more from not sharing.

Having said all that, lock-free pack access does not work for me yet.
I keep get crashes deep in cache_or_unpack_entry :(
--=20
Duy
