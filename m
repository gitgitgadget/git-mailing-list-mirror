From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>
Subject: Re: Poor performance of git describe in big repos
Date: Thu, 30 May 2013 17:01:58 +0100
Message-ID: <CAJ-05NOjVhb+3Cab7uQE8K3VE0Q2GhqR3FE=WzJZvSn8Djt6tw@mail.gmail.com>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
	<CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
	<CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
	<87ehcoeb3t.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 30 18:02:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui5Ik-0002W8-QK
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 18:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934210Ab3E3QCB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 12:02:01 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:55718 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757561Ab3E3QB7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 12:01:59 -0400
Received: by mail-ob0-f178.google.com with SMTP id fb19so936938obc.37
        for <git@vger.kernel.org>; Thu, 30 May 2013 09:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=NHugd2twKovWLZVRSPsXiiuhQmYSZGLyUwKq5W7PLlw=;
        b=PI6+h7ScKXBjpNDGaocb/ueoJjF0eETuxWfcGL+shprxoffijIhOYmCdjGbTOm6TGE
         cTBxfGLe46ArzxrF6NYn2dhvHZDpnyZu2BCr538YVIJ/3ycjdglQkj866Nac5l3zNzqt
         3+PN544h5waDkgcZjIOIxlBXa0ip+FAaZ9zCmHzWgwskGqtzsIfd6JGhKK8R7LoYk4yG
         HYM6dIFZGlwxKIWvSpoqdDjguBHIJCtMuoYtdSg8qwskJ+JQ62SHTbOof+eVgnNBHa0P
         CJdsEwMnv4DQ96kx7Mgb7nUglkYow79B2sRambpdL/Gy+u0GfSeKw2dMmvh6ejeiH0Ve
         vXsA==
X-Received: by 10.182.111.199 with SMTP id ik7mr4387234obb.44.1369929718749;
 Thu, 30 May 2013 09:01:58 -0700 (PDT)
Received: by 10.76.98.137 with HTTP; Thu, 30 May 2013 09:01:58 -0700 (PDT)
In-Reply-To: <87ehcoeb3t.fsf@linux-k42r.v.cablecom.net>
X-Google-Sender-Auth: mLnvQnsQHmLKAWq4pw_la9EQ2ZM
X-Gm-Message-State: ALoCoQmC/t8T5B4ayx0cOPgnIMoQqhN6OBURMXvcDgB5EMMSyZ2abmyBEDwFbFN+r8y5bzqe/4CP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226017>

On 30 May 2013 16:33, Thomas Rast <trast@inf.ethz.ch> wrote:
> Alex Benn=C3=A9e <kernel-hacker@bennee.com> writes:
>
>>  41.58%   git  libcrypto.so.1.0.0  [.] sha1_block_data_order_ssse3
>>  33.62%   git  libz.so.1.2.3.4     [.] inflate_fast
>>  10.39%   git  libz.so.1.2.3.4     [.] adler32
>>   2.03%   git  [kernel.kallsyms]   [k] clear_page_c
>
> Do you have any large blobs in the repo that are referenced directly =
by
> a tag?

Most probably. I've certainly done a bunch of releases (which are tagge=
d) were
the last thing that was updated was an FPGA image.

> Because this just so happens to exactly reproduce your symptoms:
>
>   # in a random git.git
>   $ time git describe --debug
>   [...]
>   real    0m0.390s
>   user    0m0.037s
>   sys     0m0.011s
>   $ git tag big1 $(dd if=3D/dev/urandom bs=3D1M count=3D512 | git has=
h-object -w --stdin)
>   512+0 records in
>   512+0 records out
>   536870912 bytes (537 MB) copied, 45.5088 s, 11.8 MB/s
>   $ time git describe --debug
>   [...]
>   real    0m1.875s
>   user    0m1.738s
>   sys     0m0.129s
>   $ git tag big2 $(dd if=3D/dev/urandom bs=3D1M count=3D512 | git has=
h-object -w --stdin)
>   512+0 records in
>   512+0 records out
>   536870912 bytes (537 MB) copied, 44.972 s, 11.9 MB/s
>   $ time git describe --debugsuche zur Beschreibung von HEAD
>   [...]
>   real    0m3.620s
>   user    0m3.357s
>   sys     0m0.248s
>
> (I actually ran the git-describe invocations more than once to ensure
> that they are again cache-hot.)

That looks pretty promising as a replication.

> git-describe should probably be fixed to avoid loading blobs, though =
I'm
> not sure off hand if we have any infrastructure to infer the type of =
a
> loose object without inflating it.  (This could probably be added by
> inflating only the first block.)  We do have this for packed objects,=
 so
> at least for packed repos there's a speedup to be had.

Will it be loading the blob for every commit it traverses or just ones =
that hit
a tag? Why does it need to load the blob at all? Surely the commit
tree state doesn't
need to be walked down?

>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch



--=20
Alex, homepage: http://www.bennee.com/~alex/
