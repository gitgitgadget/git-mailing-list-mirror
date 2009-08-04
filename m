From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Mon, 3 Aug 2009 23:07:21 -0400
Message-ID: <9e4733910908032007td74ef9fp669d0d958df67c1@mail.gmail.com>
References: <20090803034741.23415.qmail@science.horizon.com>
	 <alpine.LFD.2.01.0908031924230.3270@localhost.localdomain>
	 <alpine.LFD.2.01.0908031938280.3270@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: George Spelvin <linux@horizon.com>, git@vger.kernel.org,
	appro@fy.chalmers.se, appro@openssl.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 04 05:07:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYAN8-0001Om-Hu
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 05:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890AbZHDDHW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Aug 2009 23:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754809AbZHDDHW
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 23:07:22 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:57975 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbZHDDHV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Aug 2009 23:07:21 -0400
Received: by an-out-0708.google.com with SMTP id d40so4862492and.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 20:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=w7Z73SbybmKCVEfnkaN5M97B+lehw3HXb9NJzzCRxHs=;
        b=DzfxwKvPswIjwywD69kl7ByYAhyOpCBEeXoIqfcMtYQQmi6mn+myBSQLZknX+KLbn5
         QnM6ZLIVB+9+3DZxw3UduF4+fNSJ00ppPq16zAL8hzaiP3HwPbKSMRO51licxeVNZ362
         94Er3Kas7zVe7alBL8lvE0k64aa9VcWQZpBSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VcmDR+03wbhryqdtDYmnVPeY02BGxDk6ZGZJwSmmRaeC+8PtfuTS7Vb8YgCG6buHOQ
         leantRcTg5UI4/3B1jGw3pV8ajDgf1JVoK2D+0VBvwFGyNjxGta2W/j0qGItIACyYXPn
         +tCv6qap0KlrA2aht17l1DZqYSsL9vJo51Rj0=
Received: by 10.100.189.8 with SMTP id m8mr8161671anf.110.1249355241944; Mon, 
	03 Aug 2009 20:07:21 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0908031938280.3270@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124746>

On Mon, Aug 3, 2009 at 10:51 PM, Linus
Torvalds<torvalds@linux-foundation.org> wrote:
>
>
> On Mon, 3 Aug 2009, Linus Torvalds wrote:
>>
>> The thing that I'd prefer is simply
>>
>> =A0 =A0 =A0 git fsck --full
>>
>> on the Linux kernel archive. For me (with a fast machine), it takes =
about
>> 4m30s with the OpenSSL SHA1, and takes 6m40s with the Mozilla SHA1 (=
ie
>> using a NO_OPENSSL=3D1 build).
>>
>> So that's an example of a load that is actually very sensitive to SH=
A1
>> performance (more so than _most_ git loads, I suspect), and at the s=
ame
>> time is a real git load rather than some SHA1-only microbenchmark. I=
t also
>> shows very clearly why we default to the OpenSSL version over the Mo=
zilla
>> one.
>
> "perf report --sort comm,dso,symbol" profiling shows the following fo=
r
> 'git fsck --full' on the kernel repo, using the Mozilla SHA1:
>
> =A0 =A047.69% =A0 =A0 =A0 =A0 =A0 =A0 =A0 git =A0/home/torvalds/git/g=
it =A0 =A0 [.] moz_SHA1_Update
> =A0 =A022.98% =A0 =A0 =A0 =A0 =A0 =A0 =A0 git =A0/lib64/libz.so.1.2.3=
 =A0 =A0 =A0 [.] inflate_fast
> =A0 =A0 7.32% =A0 =A0 =A0 =A0 =A0 =A0 =A0 git =A0/lib64/libc-2.10.1.s=
o =A0 =A0 =A0[.] __GI_memcpy
> =A0 =A0 4.66% =A0 =A0 =A0 =A0 =A0 =A0 =A0 git =A0/lib64/libz.so.1.2.3=
 =A0 =A0 =A0 [.] inflate
> =A0 =A0 3.76% =A0 =A0 =A0 =A0 =A0 =A0 =A0 git =A0/lib64/libz.so.1.2.3=
 =A0 =A0 =A0 [.] adler32
> =A0 =A0 2.86% =A0 =A0 =A0 =A0 =A0 =A0 =A0 git =A0/lib64/libz.so.1.2.3=
 =A0 =A0 =A0 [.] inflate_table
> =A0 =A0 2.41% =A0 =A0 =A0 =A0 =A0 =A0 =A0 git =A0/home/torvalds/git/g=
it =A0 =A0 [.] lookup_object
> =A0 =A0 1.31% =A0 =A0 =A0 =A0 =A0 =A0 =A0 git =A0/lib64/libc-2.10.1.s=
o =A0 =A0 =A0[.] _int_malloc
> =A0 =A0 0.84% =A0 =A0 =A0 =A0 =A0 =A0 =A0 git =A0/home/torvalds/git/g=
it =A0 =A0 [.] patch_delta
> =A0 =A0 0.78% =A0 =A0 =A0 =A0 =A0 =A0 =A0 git =A0[kernel] =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 [k] hpet_next_event
>
> so yeah, SHA1 performance matters. Judging by the OpenSSL numbers, th=
e
> OpenSSL SHA1 implementation must be about twice as fast as the C vers=
ion
> we use.

Would there happen to be a SHA1 implementation around that can compute
the SHA1 without first decompressing the data? Databases gain a lot of
speed by using special algorithms that can directly operate on the
compressed data.

>
> That said, under "normal" git usage models, the SHA1 costs are almost
> invisible. So git-fsck is definitely a fairly unusual case that stres=
ses
> the SHA1 performance more than most git lods.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Jon Smirl
jonsmirl@gmail.com
