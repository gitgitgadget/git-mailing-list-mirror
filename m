From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] run-command: simplify wait_or_whine
Date: Sat, 1 Jun 2013 21:21:33 +0700
Message-ID: <CACsJy8Df-O=D5LQBXCbiVLB=uHfn6ETbAxADWq3hd-9pPX4+mg@mail.gmail.com>
References: <1370094715-2684-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"John J. Franey" <jjfraney@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 01 16:22:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uimh7-0005pA-GF
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 16:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467Ab3FAOWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 10:22:06 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:59493 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506Ab3FAOWE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 10:22:04 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so4867249obc.3
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 07:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tMtqRaPRd7Dc5lIcsacmP5Z0hFGvRgzM1coKglDgu1A=;
        b=CA2hB2GrrWotB8w6/eFVS5uCHxRSciLUvm9tWZg08A6dxa8EVZgqnwjA5ANp3o/Hl3
         b/00mhrLMGTmytZhaNkmgStlh5nSm0AQ1Og4PGhQ9pE5YIEaQc7OzPTCxrNY7W5UYtvs
         DBFcQMFR/IjGXoL7/UWYPaKRYGE7rccj942AFhwZc+rOUPnvICYWlYucDXcjUlfldluB
         hDfOQSTQJ85pCn6ekRxv3ngHhDXGhWur+l1E9UsCeSr+mNboZpldDVOcD+CsWVvLhh0y
         lhBUPvILzT1d9t+yiV+bKiUTVlHrX2Nz2/BEA7R4tBV7csg7sAmDDm7cSVxQrOayBiZx
         0ung==
X-Received: by 10.182.111.164 with SMTP id ij4mr7593295obb.59.1370096523896;
 Sat, 01 Jun 2013 07:22:03 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Sat, 1 Jun 2013 07:21:33 -0700 (PDT)
In-Reply-To: <1370094715-2684-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226133>

On Sat, Jun 1, 2013 at 8:51 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Nobody is checking for specific error codes; it's the errno that's
> important.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  run-command.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 1b32a12..e54e943 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -244,21 +244,11 @@ static int wait_or_whine(pid_t pid, const char *argv0)
>                 code = WTERMSIG(status);
>                 if (code != SIGINT && code != SIGQUIT)
>                         error("%s died of signal %d", argv0, code);
> -               /*
> -                * This return value is chosen so that code & 0xff
> -                * mimics the exit code that a POSIX shell would report for
> -                * a program that died from this signal.
> -                */
> -               code += 128;
>         } else if (WIFEXITED(status)) {

The original commit that introduces this says

    run_command: encode deadly signal number in the return value

    We now write the signal number in the error message if the program
    terminated by a signal. The negative return value is constructed such that
    after truncation to 8 bits it looks like a POSIX shell's $?:

       $ echo 0000 | { git upload-pack .; echo $? >&2; } | :
       error: git-upload-pack died of signal 13
       141

    Previously, the exit code was 255 instead of 141.

So this is part of the interface to the user. With your changes, the
exit code is now different. I tested by force segfaulting upload-pack.
$? returned 11. So NAK.
--
Duy
