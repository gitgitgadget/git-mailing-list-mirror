From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] pack-objects: optimize "recency order"
Date: Fri, 28 Oct 2011 11:17:44 +0200
Message-ID: <CACBZZX7taoaRWALYd_scf6Z2Hr-xo3voNh=vx8LoPvU8Xo290w@mail.gmail.com>
References: <1310084657-16790-1-git-send-email-gitster@pobox.com>
 <1310084657-16790-3-git-send-email-gitster@pobox.com> <CACBZZX6Ss4jLtdrDhLUNKCUjEHjHHKzfv-LMkOyTPDhRUXm4sQ@mail.gmail.com>
 <7vy5w6xf7n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Dan McGee <dpmcgee@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 11:18:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJiZp-0007YN-I8
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 11:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424Ab1J1JSI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Oct 2011 05:18:08 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44154 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab1J1JSH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2011 05:18:07 -0400
Received: by bkbzt4 with SMTP id zt4so260309bkb.19
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 02:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=YMKNs/m5uQJGzZazPTLKFmaVW7vvGIRffXroBDZmOrU=;
        b=u/+6vdTDgAcqv9DT4Px4FxMk4FMXPpR4mPhb4QFf4SZw0wUxN68oogFUhWX/g7ACIe
         395QD2FghPiqropSfxHVZBxFgKmceItQETSK+VQ8MJpaTQbGWQlAvKGkIt4TSMyyG4rX
         plaoSeFyrR2tomt2N7FR7aMTV+WBKmEioMTBI=
Received: by 10.204.141.134 with SMTP id m6mr1524444bku.91.1319793485185; Fri,
 28 Oct 2011 02:18:05 -0700 (PDT)
Received: by 10.204.112.79 with HTTP; Fri, 28 Oct 2011 02:17:44 -0700 (PDT)
In-Reply-To: <7vy5w6xf7n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184344>

On Fri, Oct 28, 2011 at 00:05, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> We recently upgraded to 1.7.7 and I've traced a very large slowdown =
in
>> packing down to this commit.
>
> Does Dan McGee's series leading to 38d4deb (pack-objects: don't trave=
rse
> objects unnecessarily, 2011-10-18) help?

Yes it does!

When I do:

    git cherry-pick 703f05ad5835cff92b12c29aecf8d724c8c847e2..38d4deb

Here's the time on the linux-2.6.git repack with that series:

    real    0m53.969s
    user    0m47.063s
    sys     0m3.020s

On the repository I was having troubles with this was the result on
master:

    Total 911023 (delta 687744), reused 905500 (delta 683064)

    real    6m0.487s
    user    4m1.751s
    sys     1m56.331s

And with the cherry-pick:

    Total 911023 (delta 687744), reused 911023 (delta 687744)

    real    1m44.192s
    user    0m32.169s
    sys     0m4.383s

And with 1b4bb16b9ec331c91e28d2e3e7dee5070534b6a2 reverted:

    Total 911023 (delta 687744), reused 911023 (delta 687744)

    real    1m23.796s
    user    0m31.931s
    sys     0m3.549s

So it's still slower, but not intolerably slower. I'd be interested to
find out why we have that 20% difference that doesn't show up on
linux-2.6.git though, the repository is mostly source code but there
are some binary blobs in it as well, although not very large, the
overall size of the entire repository is <500MB.
