From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 23:32:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702142321390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17875.13564.622087.63653@lisa.zopyra.com>
 <7vhctor78j.fsf@assigned-by-dhcp.cox.net> <17875.17647.74882.218627@lisa.zopyra.com>
 <7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net> <17875.30187.289679.417079@lisa.zopyra.com>
 <17875.30687.661794.512124@lisa.zopyra.com>
 <Pine.LNX.4.64.0702141314440.20368@woody.linux-foundation.org>
 <17875.33204.413186.355557@lisa.zopyra.com> <7vzm7gl8cf.fsf@assigned-by-dhcp.cox.net>
 <7vvei4l84q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702142303250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vire4l76a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Lear <rael@zopyra.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 23:32:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHSfp-00031o-Ev
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 23:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbXBNWcW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 17:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbXBNWcW
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 17:32:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:41568 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932620AbXBNWcV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 17:32:21 -0500
Received: (qmail invoked by alias); 14 Feb 2007 22:32:19 -0000
X-Provags-ID: V01U2FsdGVkX198LVNUrvh8MfuV/EZkLeko8uFH/nrkYzvlle+gIE
	d2Ow==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vire4l76a.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39766>

Hi,

On Wed, 14 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 14 Feb 2007, Junio C Hamano wrote:
> >
> >> By the way, I sometimes think it might be worth doing this:
> >> 
> >> 	$ chmod a-r .git/
> >> 
> >> We always access files by explicit paths and never ask "ls .git/foo*" to 
> >> find what are under .git/ directory.
> >
> > If so, please make it unconfigurable. I use tab-completion in the git 
> > directory quite often.
> 
> Do you mean "configurable"?

No. I meant "unconfigurable", since the sane default _would_ be a-r.

But then, I see that I was silly. This chmod is done on git-init time, and 
easy to undo _if_ you want it.

So, colour me a supporter of that feature.

> I wonder what you are doing inside .git directory in the first place.  
> I never chdir() into it myself, but that may be because I practicaly 
> live inside Emacs.

:-) Lucky you. Since long time, I became a vi user, not out of fun, but 
out of necessity. I had to work on many machines which had vi installed, 
but not emacs. On some, my quota was not large enough to compile the 
beast, so I eventually gave in.

Back to the subject: Sometimes I just want to look if a certain file is 
present. But I cannot be bothered to really type out ".git/index.lock", 
but rather I do ".g<TAB>/i<TAB>.<TAB>"...

Anyway, here is a minimal (completely untested) patch to do what you 
proposed:

-- snipsnap --

[PATCH] init: create GIT_DIR non-readable

We access all files in GIT_DIR by name, so we do not really need it to be 
readable. However, it is less easy to corrupt the repository 
unintentionally when it is not readable.

Those who want to be able to see the contents of GIT_DIR, always can just 
do a `chown u+r $GIT_DIR`.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 builtin-init-db.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 12e43d0..8496269 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -18,7 +18,7 @@
 
 static void safe_create_dir(const char *dir, int share)
 {
-	if (mkdir(dir, 0777) < 0) {
+	if (mkdir(dir, share ? 0777 : 0333) < 0) {
 		if (errno != EEXIST) {
 			perror(dir);
 			exit(1);
