From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Wed, 14 Feb 2007 20:54:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702142049430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702140909.28369.andyparkins@gmail.com> <slrnet5p5h.s9h.siprbaum@xp.machine.xx>
 <Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D35092.8040901@xs4all.nl> <7vr6sso8w8.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702142015150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy98o78i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: hanwen@xs4all.nl,
	Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 20:54:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHQDH-0006TH-C4
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 20:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbXBNTyo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 14:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbXBNTyo
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 14:54:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:44449 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932510AbXBNTyn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 14:54:43 -0500
Received: (qmail invoked by alias); 14 Feb 2007 19:54:42 -0000
X-Provags-ID: V01U2FsdGVkX1+UBOBoSd6UjDdRSFeMzu1q8PtNl3I/gvHYFVTeZl
	TG3A==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vfy98o78i.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39737>

Hi,

On Wed, 14 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Stupid probably is too strong a word, but I think I'd agree we
> >> should default it to $(prefix)/etc and have distros override it
> >> in the Makefile.
> >
> > Fair enough. And my patch was not really complete. Please amend to spare 
> > me eternal shame:
> > --
> > [BROWN PAPERBAG PATCH ON TOP OF OTHER PATCH] 
> >
> > It is $prefix/etc/gitconfig now, and works also if you do not
> > `git config -l`. D'oh.
> 
> How would we run our tests without getting screwed by whatever
> non-standard values system-wide configuration may have?
> Currently we disable tester's ~/.gitconfig by exporting HOME
> from t/test-lib.sh, but that will not work for this.
> 
> I think we need to have a way to disable this setting, perhaps
> via an environment variable.

Yes. Just set GIT_CONFIG=/what/ever, and it no longer reads from 
~/.gitconfig or $prefix/etc/gitconfig.

But this possibly breaks down when creating a repository in a subdirectory 
of trash. Hmm.

> I do not think we need to support 'git config --system --set foo.bar 
> baz' but some people might have twisted minds ;-).

;-) Yes, I'd rather not have an administrator run git directly. But it 
_would_ be easy enough:

diff --git a/builtin-config.c b/builtin-config.c
index 0f9051d..a42d251 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -147,6 +152,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			} else {
 				die("$HOME not set");
 			}
+		else if (!strcmp(argv[1], "--system-wide")) {
+			setenv("GIT_CONFIG", ETC_GITCONFIG, 1);
 		} else if (!strcmp(argv[1], "--rename-section")) {
 			int ret;
 			if (argc != 4)
