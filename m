From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] git-daemon: fix segfaulting in child_handler() in AIX
Date: Thu, 21 Apr 2011 22:43:26 +0200
Message-ID: <BANLkTinu0Rx9AM-+S8fyC97vUXXgeT5jbQ@mail.gmail.com>
References: <1302886260-25860-1-git-send-email-spartacus06@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Seth Jennings <spartacus06@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 22:43:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QD0jB-0005GR-0G
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 22:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902Ab1DUUnr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Apr 2011 16:43:47 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64095 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533Ab1DUUnq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2011 16:43:46 -0400
Received: by pwi15 with SMTP id 15so57423pwi.19
        for <git@vger.kernel.org>; Thu, 21 Apr 2011 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=MFA+G7O2bsK65xmS+qUs+NNSxHIY3ItZHDU6tInHiWI=;
        b=JR3Yn9mmNjMKnRx1ctwZjvK+s0TpAi+lhcHFp9Yfj+GoAmT42B/sYQdJ0nxlbti2Fo
         5wsXO9l+PJTVppN540kyxugSJ7eFIrl36KU7uL3VvXg+3ut5TFAlMZ3+tIO79mW7KEL9
         7bHgQkHvF/RbrXboDc3LtEFYu7kmpjIWarmKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=LlrZ05/2FxZ1rMWOGRn+9olI9s9NVkDmefyG0keZPHFy9AjaV6LyhrDtzaCzqlj6I/
         +12QZmAcKxK7YPnSbPb0Sr4ZLZwj9optneK9mbtW/wONRIcVTSy7uDndz7msGt6iBZuX
         Oq8+LeXm5XKidvwR+8Iw9XE+zWh7y/Pam8Yxg=
Received: by 10.68.37.72 with SMTP id w8mr492022pbj.263.1303418626167; Thu, 21
 Apr 2011 13:43:46 -0700 (PDT)
Received: by 10.68.42.198 with HTTP; Thu, 21 Apr 2011 13:43:26 -0700 (PDT)
In-Reply-To: <1302886260-25860-1-git-send-email-spartacus06@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171918>

On Fri, Apr 15, 2011 at 6:51 PM, Seth Jennings <spartacus06@gmail.com> =
wrote:
> This issue seems to be specific to git-daemon on AIX built with xlc.
> After commit 695605b5080e1957bd9dab1fed35a7fee9814297 (from Aug 2008)=
,
> git-daemon segfaults in child_handler() inside the signal() syscall
> immediately after any remote clone/pull operation. =A0While it is not
> fully understood why this happens, changing signal() to sigaction()
> resolves the issue.
>
> This commit converts singal() to sigaction() in child_handler().

At first I thought that a change like this would break the
Windows-port, because our win32-implementation of sigaction does not
support SIGCHLD. But looking at the code (and MSDN), our
win32-implementation of signal doesn't either. However, our
signal-implementation piggy-backs on the signal-implementation in
msvcrt.dll for non-SIGALRM signals, and microsoft's implementation
does not seem to update errno in this case. So, this patch will
introduce an error-line saying "sigaction only implemented for
SIGALRM".

Exactly what SHOULD be done for Windows in this case isn't entirely
clear. Perhaps we should just ignore it?

Apart from this, I must say I agree with Christian; we should find out
exactly why a change like this is needed.

> ---
> =A0daemon.c | =A0 10 ++++++++--
> =A01 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/daemon.c b/daemon.c
> index 4c8346d..3ea5b2c 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -715,7 +715,10 @@ static void child_handler(int signo)
> =A0 =A0 =A0 =A0 * upon signal receipt
> =A0 =A0 =A0 =A0 * SysV needs the handler to be rearmed
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 signal(SIGCHLD, child_handler);
> + =A0 =A0 =A0 struct sigaction sigact;
> + =A0 =A0 =A0 memset(&sigact, 0, sizeof(sigact));
> + =A0 =A0 =A0 sigact.sa_handler =3D child_handler;
> + =A0 =A0 =A0 sigaction(SIGCHLD, &sigact, NULL);
> =A0}
>
> =A0static int set_reuse_addr(int sockfd)
> @@ -889,7 +892,10 @@ static int service_loop(struct socketlist *sockl=
ist)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pfd[i].events =3D POLLIN;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 signal(SIGCHLD, child_handler);
> + =A0 =A0 =A0 struct sigaction sigact;

This gives a warning on MinGW:
daemon.c: In function 'service_loop':
daemon.c:895: warning: ISO C90 forbids mixed declarations and code
