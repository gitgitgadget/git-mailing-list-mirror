From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] revision: insert unsorted, then sort in prepare_revision_walk()
Date: Tue, 3 Apr 2012 10:44:30 +0700
Message-ID: <CACsJy8CSohtWUV_BT-d+tGX9R4LUr1K=jgFh841nST01QLSGuA@mail.gmail.com>
References: <201203291818.49933.mfick@codeaurora.org> <201204021024.49706.mfick@codeaurora.org>
 <CAJo=hJshOBg4pT8nuWZ=eZvj=E9x+4b9M_EANa=02x=NFW2OfQ@mail.gmail.com>
 <201204021049.04901.mfick@codeaurora.org> <CAJo=hJsprQtjDChtrSMcne+OCeUx=NVxLHs3k_qnYLzO=aQWuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Shawn Pearce <sop@google.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Apr 03 05:45:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEugA-0002Wc-Lt
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 05:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689Ab2DCDpD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Apr 2012 23:45:03 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:51066 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab2DCDpB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Apr 2012 23:45:01 -0400
Received: by wgbdr13 with SMTP id dr13so3296441wgb.1
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 20:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=8Hy11VvVRRpsRT6EZ37QVl3bM+rklC6XCRoDSf2Dfco=;
        b=CR0s1eQqtQBO3ibpG2v7L9mEyINA+kDFCvKb3/v4ZRtc3D7NTb18/FEHML1vAfqovX
         B5rBbOqXjzUbUSNeO2V8InmzFAGZAyue4bc1+fV3hLrX1rtnENEYdfUEr3xh6umTztvy
         ks785NGbORPjJWXieNJ6Blw+hFFlK/L4QDjVvpFNA+4nX9c9LX9rk9ZXKhSi+JZHqnGo
         L0GOjD4279bfxIqzzLzzCF/sHY5/mml0naFF8WFf1pov8It9F4p2DExa/R5m0S1WhE6c
         SwuhTWpni4NZcATJKMhAopV2+MwfTAvqXqyxbIPqkE53+9eNHg7Re27jJbGXu2Kv68Nh
         3xIA==
Received: by 10.180.85.35 with SMTP id e3mr1842682wiz.6.1333424700372; Mon, 02
 Apr 2012 20:45:00 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Mon, 2 Apr 2012 20:44:30 -0700 (PDT)
In-Reply-To: <CAJo=hJsprQtjDChtrSMcne+OCeUx=NVxLHs3k_qnYLzO=aQWuw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194589>

On Mon, Apr 2, 2012 at 11:51 PM, Shawn Pearce <spearce@spearce.org> wro=
te:
> On Mon, Apr 2, 2012 at 09:49, Martin Fick <mfick@codeaurora.org> wrot=
e:
>> On Monday, April 02, 2012 10:39:59 am Shawn Pearce wrote:
>>> On Mon, Apr 2, 2012 at 09:24, Martin Fick
>> <mfick@codeaurora.org> wrote:
>>> > On Saturday, March 31, 2012 04:11:01 pm Ren=C3=A9 Scharfe
>> wrote:
>>> Git can't really do the same thing as "cache the
>>> RevWalk". Its spawning a new process that needs to
>>> decompress and parse each commit object to determine its
>>> timestamp so the commits can be sorted into the priority
>>> queue. This is still an O(N) operation given N
>>> references.
>>
>> While I suspect this has been suggested before, an ondisk
>> cache of commits to timestamps would probably help here with
>> large repos. =C2=A0Such a cache could make even new processes
>> able to create this list much quicker. =C2=A0Since this cache
>> would contain immutable data, even if it is out of date it
>> would likely provided significant improvements by providing
>> most of the timestamps leaving only a few to parse from
>> newer commits?
>
> Probably. But we tend to hate caches in Git because they can get stal=
e
> and need to be rebuilt, and are redundant with the base data. The
> mythical "pack v4" work was going to approach this problem by storing
> the commit timestamps uncompressed in a more machine friendly format.
> Unfortunately the work has been stalled for years.

which reminds me, hello Nico!

On Sat, Feb 18, 2012 at 10:34 PM, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
>> By the way, is latest packv4 code available somewhere to fetch?
>
> Well, not yet.  Incidentally, I'm going in the Caribbeans for a week =
in
> a week, with no kids and only my wife who is going to be busy with sc=
uba
> diving activities.  Like I did last year, I'm going to take some time=
 to
> pursue my work on Pack v4 during that time.  And I intend to publish =
it
> when I come back, whatever state it is in, so someone else can comple=
te
> the work eventually (I have too much to do to spend significant time =
on
> Git these days).

How's the packv4 work going? Is it in a public place? I hope somebody
else may have spare time and be motivated enough to finish it.
--=20
Duy
