From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH v2] Allow git-shell to be used as a ssh forced-command
Date: Tue, 21 Apr 2009 13:46:08 +0400
Message-ID: <2pQA2nR7mckXWlZ1caYVRbSAd+A@7qgLKkvX/1U6eu9avhKQpU/1pEI>
References: <20090418063100.GA18568@glandium.org> <1240292586-28192-1-git-send-email-mh@glandium.org> <20090421080559.GI25059@dpotapov.dyndns.org>
Reply-To: rea-git@codelabs.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 11:47:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwCa2-0004mA-Eb
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 11:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910AbZDUJqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 05:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755773AbZDUJqR
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 05:46:17 -0400
Received: from 0.mx.codelabs.ru ([144.206.177.45]:55744 "EHLO 0.mx.codelabs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755500AbZDUJqQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2009 05:46:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:Content-Type:Content-Disposition:Content-Transfer-Encoding:In-Reply-To:Sender;
	b=FImoJzhZ10Oj5cU2W07/pvBcnxUxwau0Awok3tj6qvuJRSG/Q6yp7HG8yi+F5fnXLGPcqVAcFnfbvCO5rsbunmyWetsIrYrhxMd1mFmi3Pu3i9ft//LOT1t2/Ae3eo5SRJiiai2ifx/aqqXsm8vk99IdOP2GjXiLQji2I7gK2os=;
Received: from amnesiac.at.no.dns (ppp91-77-11-47.pppoe.mtu-net.ru [91.77.11.47])
	by 0.mx.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1LwCYM-000H7e-RK; Tue, 21 Apr 2009 13:46:11 +0400
Content-Disposition: inline
In-Reply-To: <20090421080559.GI25059@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117119>

Dmitry, *, good day.

Tue, Apr 21, 2009 at 12:05:59PM +0400, Dmitry Potapov wrote:
> On Tue, Apr 21, 2009 at 07:43:06AM +0200, Mike Hommey wrote:
> > When using a forced-command, OpenSSH sets the SSH_ORIGINAL_COMMAND
> > variable to what would otherwise be passed to $SHELL -c. When this
> > variable is set and git-shell was given no argument, we use it.
> > 
> > Signed-off-by: Mike Hommey <mh@glandium.org>
> > ---
> >  shell.c |    9 +++++++--
> >  1 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/shell.c b/shell.c
> > index b968be7..86c9273 100644
> > --- a/shell.c
> > +++ b/shell.c
> > @@ -72,11 +72,16 @@ int main(int argc, char **argv)
> >  	/*
> >  	 * We do not accept anything but "-c" followed by "cmd arg",
> >  	 * where "cmd" is a very limited subset of git commands.
> > +	 * If no argument is given at all, see whether we were run from
> > +	 * a ssh forced-command and use the original command if so.
> >  	 */
> >  	else if (argc != 3 || strcmp(argv[1], "-c"))
> > -		die("What do you think I am? A shell?");
> > +		if (argc != 1 || !(prog = getenv("SSH_ORIGINAL_COMMAND")))
> > +			die("What do you think I am? A shell?");
> > +
> > +	if (!prog)
> 
> It appears to me that 'prog' may be used unitialized here.

True.  The proper patch would be
-----
From 898e5ae3891d294ee5cb28a430093aced7cb26bd Mon Sep 17 00:00:00 2001
From: Mike Hommey <mh@glandium.org>
Date: Tue, 21 Apr 2009 07:43:06 +0200
Subject: [PATCH] Allow git-shell to be used as a ssh forced-command

When using a forced-command, OpenSSH sets the SSH_ORIGINAL_COMMAND
variable to what would otherwise be passed to $SHELL -c. When this
variable is set and git-shell was given no argument, we use it.

Signed-off-by: Mike Hommey <mh@glandium.org>
Patch-problem-spotted-by: Dmitry Potapov <dpotapov@gmail.com>
Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 shell.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/shell.c b/shell.c
index b968be7..93aeded 100644
--- a/shell.c
+++ b/shell.c
@@ -47,7 +47,7 @@ static struct commands {
 
 int main(int argc, char **argv)
 {
-	char *prog;
+	char *prog = NULL;
 	struct commands *cmd;
 	int devnull_fd;
 
@@ -72,11 +72,16 @@ int main(int argc, char **argv)
 	/*
 	 * We do not accept anything but "-c" followed by "cmd arg",
 	 * where "cmd" is a very limited subset of git commands.
+	 * If no argument is given at all, see whether we were run from
+	 * a ssh forced-command and use the original command if so.
 	 */
 	else if (argc != 3 || strcmp(argv[1], "-c"))
-		die("What do you think I am? A shell?");
+		if (argc != 1 || !(prog = getenv("SSH_ORIGINAL_COMMAND")))
+			die("What do you think I am? A shell?");
+
+	if (!prog)
+		prog = argv[2];
 
-	prog = argv[2];
 	if (!strncmp(prog, "git", 3) && isspace(prog[3]))
 		/* Accept "git foo" as if the caller said "git-foo". */
 		prog[3] = '-';
-- 
1.6.1.3
-----
-- 
Eygene
