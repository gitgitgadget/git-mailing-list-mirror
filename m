From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 0/4] optimizing upload-pack ref peeling
Date: Thu, 4 Oct 2012 11:01:26 +0200
Message-ID: <CACBZZX6hoXdP5fV8NSmkEOvm1eayyCH+vSJYSpd=ZL0XjC68HQ@mail.gmail.com>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
 <20121003180324.GB27446@sigill.intra.peff.net> <CACBZZX4Grya=FbL9XEh_EK6KVsFZYWCuHveV2QevcBwr+iYTMQ@mail.gmail.com>
 <20121003212007.GC4484@sigill.intra.peff.net> <CACBZZX6yMfeOx6x4iy8beq5niy9HvPq0c8ND5jZkoiJWAgVjfw@mail.gmail.com>
 <20121003231529.GA11618@sigill.intra.peff.net> <CACBZZX5Sm++Wjyoue-qk7TjwxUM3QihXfWGtEHhOq=VtkgvNbQ@mail.gmail.com>
 <20121004075609.GA1355@sigill.intra.peff.net> <20121004080438.GA31305@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:27:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtVH-0001w8-T3
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400Ab2JDJBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 05:01:48 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33692 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab2JDJBr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 05:01:47 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so217187obb.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 02:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JOpif/4Bx5pkrS8W2/FxiYBPJ7m+IwmN8GoE5XZjYEc=;
        b=Lk9ecvl0TrvL7n0ERfOogzUIii6oj4Iro991uUpV+wdFBn4Ao52oZ8B0n57BQkwKRt
         mht4FrArsjJoTSbYjzt7MCI06eRBx0KX79cazG/1p7M5MXzPtv/74DDkZN/KLV5A+J/z
         FO34YGal2JdIbVWETQRPnMbrXq9f2BQ4iBEB8y1p+TTY1Dgm7u9aO18OfnOhi5lBUiXE
         kt+MPE2dPaSGxpwQgIvHgkNrxXdm7P0Hv5ePHjqBSrCm+zbiN0QdhRKgQi2c5/UNW4ct
         PbTUJ1SIYCRWuLyS+e+frkOZ1XsMiG1KE+0vNfaAkOUPSkExlrL/L2hy4zFLjzzQirCh
         d3QA==
Received: by 10.60.13.41 with SMTP id e9mr3797259oec.15.1349341306536; Thu, 04
 Oct 2012 02:01:46 -0700 (PDT)
Received: by 10.60.94.225 with HTTP; Thu, 4 Oct 2012 02:01:26 -0700 (PDT)
In-Reply-To: <20121004080438.GA31305@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207002>

On Thu, Oct 4, 2012 at 10:04 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 04, 2012 at 03:56:09AM -0400, Jeff King wrote:
>
>>   [1/4]: peel_ref: use faster deref_tag_noverify
>>   [2/4]: peel_ref: do not return a null sha1
>>   [3/4]: peel_ref: check object type before loading
>>   [4/4]: upload-pack: use peel_ref for ref advertisements
>
> I included my own timings in the final one, but my "pathological" case
> at the end is a somewhat made-up attempt to emulate what you described.
> Can you double-check that this series still has a nice impact on your
> real-world repository?

It does, here's best of five for, all compiled with -g -O3:

v1.7.8:

    $ time (echo 0000 | ~/g/git/git-upload-pack . | pv >/dev/null)
    3.49MB 0:00:00 [ 5.3MB/s] [  <=>

           ]

    real    0m0.660s
    user    0m0.604s
    sys     0m0.248s

master without your patches:

    $ time (echo 0000 | ~/g/git/git-upload-pack . | pv >/dev/null)
    3.49MB 0:00:00 [10.2MB/s] [  <=>

           ]

    real    0m0.344s
    user    0m0.300s
    sys     0m0.172s

master with your patches:

    $ time (echo 0000 | ~/g/git/git-upload-pack . | pv >/dev/null)
    3.49MB 0:00:00 [31.8MB/s] [  <=>

           ]

    real    0m0.113s
    user    0m0.088s
    sys     0m0.088s
