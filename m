From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Read default options from config file
Date: Sat, 11 Jun 2005 03:09:31 +0200
Message-ID: <20050611010931.GA13272@diku.dk>
References: <20050609010056.GA9084@diku.dk> <20050609083243.GD29665@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Holmsand <holmsand@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 03:06:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DguRo-0002Te-Uq
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 03:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVFKBKR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 21:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVFKBKR
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 21:10:17 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:60384 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261498AbVFKBJc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2005 21:09:32 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 2F5FD6E2711; Sat, 11 Jun 2005 03:08:42 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id D607B6E270B; Sat, 11 Jun 2005 03:08:41 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 993C161FE0; Sat, 11 Jun 2005 03:09:31 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050609083243.GD29665@pasky.ji.cz>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@ucw.cz> wrote Thu, Jun 09, 2005:
> Dear diary, on Thu, Jun 09, 2005 at 03:00:56AM CEST, I got a letter
> where Jonas Fonseca <fonseca@diku.dk> told me that...
> > 
> > Dan Holmsand <holmsand@gmail.com> wrote Wed, Jun 08, 2005:
> > > - Automatic color if the COGITO_AUTO_COLOR environment variable is set.
> > 
> > [ This has been discussed before. Default arguments. The 'new' cg
> >   wrapper makes this very easy. Not as smart as your env variable
> >   handling tho'. ]
> > 
> > The default options are read only for Cogito calls going through the new
> > cg wrapper which makes it trivial to 'overwrite' them by just calling
> > cg-COMMAMD.
> 
> No, this is the wrong way. The 'cg' wrapper must not really do anything
> special on its own. It's not a _replacement_ for direct calling of the
> cg-scripts, it's just an aid for people who don't want to get used to
> it. So please do this in cg-Xlib.
> 
> Also, I'd prefer the config file to be something like ~/.cgrc. I want to
> reserve the .conf file for something more sophisticated. ;-)

With the optparse stuff in things got a lot easier. I took the idea to
check for stole from Dan Holmsands patches to only read it when stdout
is a terminal. So the file is really only for interactive usage.

---

Introduce ~/.cgrc config file. The file is read on startup if stdout is
a terminal and may contain information about default command line
options. Each line consists of a command name and a list of options.
Lines not starting with a 'Cogito' command name are ignored.

To always have cg-log and cg-diff colorize the output put the followig
in ~/.cgrc:

	log -c
	diff -c

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 Documentation/make-cogito-asciidoc |   13 +++++++++++++
 cg-Xlib                            |    7 +++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/Documentation/make-cogito-asciidoc b/Documentation/make-cogito-asciidoc
--- a/Documentation/make-cogito-asciidoc
+++ b/Documentation/make-cogito-asciidoc
@@ -140,6 +140,19 @@ FILE::
 	Indicates an already existing filename - always relative to the root
 	of the repository.
 
+FILES
+-----
+~/.cgrc::
+	This file is read on startup if \`stdout\` is a terminal and may
+	contain information about default command line options. Each line
+	consists of a command name and a list of options. Lines not
+	starting with a 'Cogito' command name are ignored. To have
+	\`cg-log\` and \`cg-diff\` colorize the output put the following
+	in ~/.cgrc:
+
+		log -c
+		diff -c
+
 COPYRIGHT
 ---------
 Copyright (C) Petr Baudis, 2005.
diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -150,6 +150,13 @@ done
 ARGS=("$@")
 ARGPOS=0
 
+if [ -t 1 -a -e "$HOME/.cgrc" ]; then
+	_cg_name=${_cg_cmd#cg-}
+	_cg_defaults="$(sed -n "/^$_cg_name/s/^$_cg_name //p" < $HOME/.cgrc)"
+	ARGS=($_cg_defaults "${ARGS[@]}")
+fi
+
+
 optshift() {
 	unset ARGS[$ARGPOS]
 	ARGS=("${ARGS[@]}")
-- 
Jonas Fonseca
