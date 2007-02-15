From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Thu, 15 Feb 2007 11:43:56 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702151126300.448@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702140909.28369.andyparkins@gmail.com> <slrnet5p5h.s9h.siprbaum@xp.machine.xx>
 <Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D35092.8040901@xs4all.nl> <7vr6sso8w8.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702142015150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy98o78i.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702142049430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wkshtxg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: hanwen@xs4all.nl,
	Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 15 11:44:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHe5q-0004eR-0O
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 11:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965829AbXBOKn6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 05:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965833AbXBOKn6
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 05:43:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:50512 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965829AbXBOKn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 05:43:58 -0500
Received: (qmail invoked by alias); 15 Feb 2007 10:43:56 -0000
X-Provags-ID: V01U2FsdGVkX1/4KTMmOxH46SNvURFSQmmfmrtL3dV8jSYWrlSbMt
	HcfA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v1wkshtxg.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39812>

Hi,

On Wed, 14 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I think we need to have a way to disable this setting, perhaps
> >> via an environment variable.
> >
> > Yes. Just set GIT_CONFIG=/what/ever, and it no longer reads from 
> > ~/.gitconfig or $prefix/etc/gitconfig.
> 
> I think GIT_CONFIG and GIT_LOCAL_CONFIG environment variables are 
> seriously misdesigned.

Okay for GIT_LOCAL_CONFIG. I do not remember off-hand who wanted it 
(Jakub? Pasky?), but it was in the context of gitweb.

However, GIT_CONFIG is meant to parse arbitrary config files. You can 
literally say

	GIT_CONFIG=/windows/C/WINNT/system.ini git config drivers.wave

and get the value for "wave" in system.ini, section [drivers].

BTW I find the HOME mangling in test-lib.sh insane. Here's a replacement:

-- snip --
[PATCH] Make tests independent of global config files

This was done by setting $HOME to somewhere bogus. A better method is
to reuse $GIT_CONFIG, which was invented for ignoring the global
config file explicitely.

Technically, setting GIT_CONFIG=.git/config could be wrong, but it
passes all the tests, and we can keep the tests that way.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 t/test-lib.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 37822fc..a403fe0 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -255,8 +255,8 @@ test_done () {
 PATH=$(pwd)/..:$PATH
 GIT_EXEC_PATH=$(pwd)/..
 GIT_TEMPLATE_DIR=$(pwd)/../templates/blt
-HOME=$(pwd)/trash
-export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR HOME
+GIT_CONFIG=.git/config
+export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG
 
 GITPERLLIB=$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
 export GITPERLLIB
-- snap --

>  - $GIT_CONFIG_SYSTEM environment, if set, names a file to be
>    read first.  It defaults to /etc/gitconfig.  You can set it
>    to /dev/null to avoid using /etc/gitconfig if you have
>    specific need.
> 
>  - Then $HOME/.gitconfig is read.
> 
>  - Then $GIT_DIR/config is read.

Yes, you can. But I'd rather not. The contents of /etc/gitconfig should be 
changed with care, and _if_ they are changed, you should be forced to 
override the settings explicitely in $HOME/.gitconfig.

Of course, this assumes a sensible administrator.

> I am not quite sure how $GIT_CONFIG and $GIT_CONFIG_LOCAL were meant to 
> be used.

As I said, I _think_ it was the gitweb people, who wanted to have this to 
point at some gitweb specific, global (i.e. repo-independent) config.

>  - $GIT_CONFIG environment, if set, names a file to be read
>    first.  We read it first.
> 
>  - If $GIT_CONFIG is unset, then $GIT_CONFIG_SYSTEM (or
>    /etc/gitconfig) and $HOME/.gitconfig are read, as above.
> 
>  - Next file to be read is $GIT_CONFIG_LOCAL (if set) or
>    $GIT_DIR/config.  When reading this file, if we read from
>    $GIT_CONFIG earlier, we read only "core.*" section from it.

I am all for removing support for $GIT_CONFIG_LOCAL. IMHO it really does 
not make sense, for the reasons you told in your email: important per-repo 
information would be ignored, but not global or system-wide settings.

GIT_CONFIG should be used when reading a config which is totally unrelated 
to a repository. (Or for testing.)

But this "core.*" stuff is insane. Please no.

BTW just to clarify a subtlety in the code (which looks ugly at first, but 
nothing else makes sense):

When using --get-all, (with the patch I sent out earlier) git-config reads 
/etc/gitconfig first, then ~/.gitconfig, and then .git/config.

When not using --get-all, it reads .git/config first, and if nothing was 
found yet, reads ~/.gitconfig, and if still nothing was found, 
/etc/gitconfig.

It seems convoluted at first, but is the only way we can check for unique 
settings. For example, if the system-wide default for "color.diff" is 
"false", but in your repo it is "auto", it should _not_ warn of ambiguous 
settings, while it should warn if you have both settings in .git/config.

Outside of git-config, such unique variables are always handled in a 
last-wins manner, so we are safe.

I would feel much better, though, if supporters of /etc/gitconfig spoke a 
little bit louder, before actually doing something about it.

Ciao,
Dscho
