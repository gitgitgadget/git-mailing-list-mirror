From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 3/3] Add sideband status report to git-archive protocol
Date: Mon, 11 Sep 2006 12:34:10 +0200
Message-ID: <45053BA2.6050502@innova-card.com>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>	<7vk64ctctv.fsf@assigned-by-dhcp.cox.net> <7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>, git@vger.kernel.org,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Sep 11 12:34:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMj7I-0006Yi-O4
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 12:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWIKKd6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 06:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWIKKd6
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 06:33:58 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:15813 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750708AbWIKKd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 06:33:57 -0400
Received: by nz-out-0102.google.com with SMTP id n1so479610nzf
        for <git@vger.kernel.org>; Mon, 11 Sep 2006 03:33:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=Pz4AMTm1c71MundkUoHC0xYaNM37iOJuhB7LlNilWp2M4kUuMFEl9V0TwXkB1Ktf7RHMoedTdYtID/y7Qen1w9Tvf4Ym7atVn+U/KIpnvQY1EEaZInFXcI+g6kYvCrtGchBdt/pztQbTz6BY3LonhyBih0FcU/iTnaRTKMm6+Es=
Received: by 10.64.143.4 with SMTP id q4mr4449416qbd;
        Mon, 11 Sep 2006 03:33:56 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id f18sm3479885qba.2006.09.11.03.33.54;
        Mon, 11 Sep 2006 03:33:56 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26848>

Junio C Hamano wrote:
> Using the refactored sideband code from existing upload-pack protocol,
> this lets the error condition and status output sent from the remote
> process to be shown locally.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---

[snip]

> -}
> +	while (1) {
> +		struct pollfd pfd[2];
> +		char buf[16384];
> +		ssize_t sz;
> +		pid_t pid;
> +		int status;
> +
> +		pfd[0].fd = fd1[0];
> +		pfd[0].events = POLLIN;
> +		pfd[1].fd = fd2[0];
> +		pfd[1].events = POLLIN;
> +		if (poll(pfd, 2, -1) < 0) {
> +			if (errno != EINTR) {
> +				error("poll failed resuming: %s",
> +				      strerror(errno));
> +				sleep(1);
> +			}
> +			continue;
> +		}
> +		if (pfd[0].revents & (POLLIN|POLLHUP)) {
> +			/* Data stream ready */
> +			sz = read(pfd[0].fd, buf, sizeof(buf));
> +			send_sideband(1, 1, buf, sz, DEFAULT_PACKET_MAX);
> +		}
> +		if (pfd[1].revents & (POLLIN|POLLHUP)) {
> +			/* Status stream ready */
> +			sz = read(pfd[1].fd, buf, sizeof(buf));
> +			send_sideband(1, 2, buf, sz, DEFAULT_PACKET_MAX);
> +		}
>  
> +		if (((pfd[0].revents | pfd[1].revents) & POLLHUP) == 0)
> +			continue;
> +		/* did it die? */
> +		pid = waitpid(writer, &status, WNOHANG);
> +		if (!pid) {
> +			fprintf(stderr, "Hmph, HUP?\n");
> +			continue;
> +		}

I get a lot of "Hmph, HUP?" messages when testing "git-archive
--remote" command. One guess: this can be due to the fact that when
the writer process exits, it first closes its fd but do not send a
SIGCHLD signal right after to its parent.

Therefore poll() can return POLLHUP flag to the parent process but
waitpid still returns 0 because the writer process has still not sent
SIGCHLD signal to its parent.

How about this patch ? If poll() doesn't only return the single POLLIN
flag, then either the pipe has been closed because the write process
died or something wrong happened. In all these cases we can wait for
the writer process to exit then die.

-- >8 --

diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index 42cb9f8..2ebe9a0 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -114,7 +114,6 @@ int cmd_upload_archive(int argc, const c
 		struct pollfd pfd[2];
 		char buf[16384];
 		ssize_t sz;
-		pid_t pid;
 		int status;
 
 		pfd[0].fd = fd1[0];
@@ -140,13 +139,11 @@ int cmd_upload_archive(int argc, const c
 			send_sideband(1, 2, buf, sz, LARGE_PACKET_MAX);
 		}
 
-		if (((pfd[0].revents | pfd[1].revents) & POLLHUP) == 0)
-			continue;
-		/* did it die? */
-		pid = waitpid(writer, &status, WNOHANG);
-		if (!pid) {
-			fprintf(stderr, "Hmph, HUP?\n");
+		if ((pfd[0].revents | pfd[1].revents) == POLLIN)
 			continue;
+
+		if (waitpid(writer, &status, 0) < 0) {
+			die("waitpid failed: %s", strerror(errno));
 		}
 		if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
 			send_sideband(1, 3, deadchild, strlen(deadchild),
