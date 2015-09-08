From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git_connect: clarify conn->use_shell flag
Date: Tue, 08 Sep 2015 10:18:41 -0700
Message-ID: <xmqqwpw096dq.fsf@gitster.mtv.corp.google.com>
References: <CAOxFTcx9E_FtYD_Jn3+S3j-rwGO+hJSVXUC2S5ZBB6der7dUuw@mail.gmail.com>
	<20150904125448.GA25501@sigill.intra.peff.net>
	<xmqqpp1yf3qe.fsf@gitster.mtv.corp.google.com>
	<20150904214454.GA18320@sigill.intra.peff.net>
	<20150904224008.GA11164@sigill.intra.peff.net>
	<CAOxFTcz9dZRQVnVnt+GtzAiu+GBi7CPE17d7rGo3H0v56MMAZQ@mail.gmail.com>
	<20150908083314.GB2991@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 08 19:18:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZMXi-0006mp-Ut
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 19:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433AbbIHRSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 13:18:46 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34039 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbbIHRSn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 13:18:43 -0400
Received: by padhy16 with SMTP id hy16so127133309pad.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=iS9KUXhRsfWpd+zxVGc+PgeGtvRgT6uks70l3Y4Vm9Q=;
        b=CUtwK8otaD5ulOZGgGmIC8Hu42KPKOG2GFtstYFBBAEijJ7B7PHL4+sx5EaXBisl05
         EZRShAPoiq/JBP39LuHJK8wZCjBFKml6wS0WOwLL7aP/+nGsrFnWF9NgXhR8K0v0Fnbf
         quqqYjVoSBximSsOHyUaP1fdjky3NnieJJ2UMvLRwwQUNWum0SpCksKDjEAmHS6OA16s
         MQ/hx75fQuAML+t8YB4QeRv4qqqZB2XOiTrxJAg9jTLjlbnxpx5hkJEUDQDbiC58jOXQ
         YOVACIa+tV7V3DaWWUTklDceWXh2BVaO87laTTJdWl4gyITIwO753gxELYHxzYWpCK4e
         v78g==
X-Received: by 10.68.231.5 with SMTP id tc5mr60966687pbc.54.1441732722562;
        Tue, 08 Sep 2015 10:18:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:40ca:ccb5:4636:e6d])
        by smtp.gmail.com with ESMTPSA id c6sm4098564pat.13.2015.09.08.10.18.41
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 08 Sep 2015 10:18:41 -0700 (PDT)
In-Reply-To: <20150908083314.GB2991@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 8 Sep 2015 04:33:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277506>

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] git_connect: clarify conn->use_shell flag
>
> When executing user-specified programs, we generally always
> want to use a shell, for flexibility and consistency. One
> big exception is executing $GIT_SSH, which for historical
> reasons must not use a shell.
>
> Once upon a time the logic in git_connect looked like:
>
>   if (protocol == PROTO_SSH) {
> 	  ... setup ssh ...
>   } else {
> 	  ... setup local connection ...
> 	  conn->use_shell = 1;
>   }
>
> But over time the PROTO_SSH block has grown, and the "local"
> block has shrunk so that it contains only conn->use_shell;
> it's easy to miss at the end of the large block.  Moreover,
> PROTO_SSH now also sometimes sets use_shell, when the new
> GIT_SSH_COMMAND is used.
>
> To make the flow easier to follow, let's just set
> conn->use_shell when we're setting up the "conn" struct, and
> unset it (with a comment) in the historical GIT_SSH case.

Makes perfect sense.  I think another thing that falls into the same
class wrt readability is 'putty'; if the code does putty=0 at the
beginning of "various flavours of SSH", and sets it only when it
checks with "various flavours of plink" when GIT_SSH_COMMAND is not
set, the logic would be even clearer, I suspect.

> Note that for clarity we leave "use_shell" on in the case
> that we fall back to our default "ssh" This looks like a
> behavior change, but in practice run-command.c optimizes
> shell invocations without metacharacters into a straight
> execve anyway.

Hmm, interesting.  I am not sure if that has to be the way, though.
Wouldn't the resulting code become simpler if you do not do that?

That is, is is what I have in mind on top of your patch.  Did I
break something?

 connect.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/connect.c b/connect.c
index 6f3f85e..acd39d7 100644
--- a/connect.c
+++ b/connect.c
@@ -727,7 +727,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
 			const char *ssh;
-			int putty, tortoiseplink = 0;
+			int putty = 0, tortoiseplink = 0;
 			char *ssh_host = hostandport;
 			const char *port = NULL;
 			get_host_and_port(&ssh_host, &port);
@@ -749,9 +749,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 			}
 
 			ssh = getenv("GIT_SSH_COMMAND");
-			if (ssh)
-				putty = 0;
-			else {
+			if (!ssh) {
 				const char *base;
 				char *ssh_dup;
 
@@ -760,10 +758,10 @@ struct child_process *git_connect(int fd[2], const char *url,
 				 * GIT_SSH_COMMAND (and must remain so for
 				 * historical compatibility).
 				 */
+				conn->use_shell = 0;
+
 				ssh = getenv("GIT_SSH");
-				if (ssh)
-					conn->use_shell = 0;
-				else
+				if (!ssh)
 					ssh = "ssh";
 
 				ssh_dup = xstrdup(ssh);
@@ -771,8 +769,9 @@ struct child_process *git_connect(int fd[2], const char *url,
 
 				tortoiseplink = !strcasecmp(base, "tortoiseplink") ||
 					!strcasecmp(base, "tortoiseplink.exe");
-				putty = !strcasecmp(base, "plink") ||
-					!strcasecmp(base, "plink.exe") || tortoiseplink;
+				putty = tortoiseplink ||
+					!strcasecmp(base, "plink") ||
+					!strcasecmp(base, "plink.exe");
 
 				free(ssh_dup);
 			}
