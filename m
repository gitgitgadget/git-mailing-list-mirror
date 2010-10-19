From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: [PATCH] ignore SIGINT&QUIT while waiting for external
 command
Date: Tue, 19 Oct 2010 14:16:38 -0500
Message-ID: <20101019191638.GI25139@burratino>
References: <20101019045300.GA18043@gnu.kitenet.net>
 <AANLkTi=tvyzyz2xpezufHLFc44HDbtMibkhNEvYxPB2g@mail.gmail.com>
 <20101019115943.GA8065@dpotapov.dyndns.org>
 <20101019133236.GA804@sigill.intra.peff.net>
 <20101019134040.GA3956@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Joey Hess <joey@kitenet.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 19 21:26:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8Hpo-0000fM-3u
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 21:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105Ab0JST0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 15:26:50 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47914 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031Ab0JST0t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 15:26:49 -0400
Received: by qyk12 with SMTP id 12so689488qyk.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 12:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=oicstXs2kHhMq+QlTy0uSja4U3mPUMZPxfp9E9hqgKo=;
        b=iHkflMHK2w0fTUHCbF5ZAsxLgrMrRzrmHLR2JldNvXPCZMIlSwutN9LmT06mVRf+Nw
         u5fiuAN3xnbfarO4vI8afZpfhfQfHcJ72oI25XgSgYmLCWq2Syxf7XrB/x2M4jnMb+gJ
         PC6rxSyVNGLdGXOojG9bOAkctuOQcXMMhNeDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=X3kXozfDMLiwsw4+GoxeUDyzT3Tb1K/bVbc2aQaSnNlMCajcPqoRxADrbwhzUBu1JG
         Iwv7YCVl5SnJF5eFXwDrBCiu9G1XcKwPmPkpFSbZzcBIfFNQMg1pQ97pbA3QfTlFZRSI
         P96djb12Za0jAu5Dc7GEw8P5vYxAPq4FFqi/M=
Received: by 10.103.219.16 with SMTP id w16mr4016798muq.81.1287516019571;
        Tue, 19 Oct 2010 12:20:19 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id d17sm3807926fav.29.2010.10.19.12.20.16
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 12:20:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101019134040.GA3956@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159359>

Jeff King wrote:
> On Tue, Oct 19, 2010 at 09:32:36AM -0400, Jeff King wrote:

>> I think you could just replace your signal() calls with:
>> 
>>   sigchain_push(SIGINT, SIG_IGN);
>>   ...
>>   sigchain_pop(SIGINT);
>
> Which, FWIW, would look like this:

Something in this direction on top?

I think sigchain_push ought to accept a context object.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/run-command.c b/run-command.c
index 24e0f46..efdac84 100644
--- a/run-command.c
+++ b/run-command.c
@@ -103,6 +103,7 @@ static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
 	while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
 		;	/* nothing */
 
+	the_child = NULL;
 	sigchain_pop(SIGINT);
 	sigchain_pop(SIGQUIT);
 
@@ -139,6 +140,19 @@ static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
 	return code;
 }
 
+static struct child_process *the_child;
+
+static void interrupted_with_child(int sig)
+{
+	if (the_child && the_child->pid > 0) {
+		while ((waiting = waitpid(pid, NULL, 0)) < 0 && errno == EINTR)
+			;	/* nothing */
+		the_child = NULL;
+	}
+	sigchain_pop(sig);
+	raise(sig);
+}
+
 int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
@@ -206,8 +220,11 @@ fail_pipe:
 		notify_pipe[0] = notify_pipe[1] = -1;
 
 	fflush(NULL);
-	sigchain_push(SIGINT, SIG_IGN);
-	sigchain_push(SIGQUIT, SIG_IGN);
+	if (the_child)
+		die("What?  _Two_ children?");
+	the_child = cmd;
+	sigchain_push(SIGINT, interrupted_with_child);
+	sigchain_push(SIGQUIT, interrupted_with_child);
 	cmd->pid = fork();
 	if (!cmd->pid) {
 		sigchain_pop(SIGINT);
