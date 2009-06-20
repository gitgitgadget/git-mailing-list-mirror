From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC PATCH] check for filenames that only differ in case to sample
	pre-commit hook
Date: Sat, 20 Jun 2009 14:14:39 +0200
Message-ID: <20090620121427.GC4876@heiko-voigts-macbook.local>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <m3r5yukv6g.fsf@localhost.localdomain> <20090512214250.GA22974@macbook.lan> <200905122356.00659.jnareb@gmail.com> <20090514175850.GA26267@macbook.lan> <46a038f90905150352q76157227q24c6b8c0befa4108@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 14:14:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHzT8-0007zs-Ax
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 14:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbZFTMOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 08:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbZFTMOk
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 08:14:40 -0400
Received: from darksea.de ([83.133.111.250]:56769 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751383AbZFTMOj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 08:14:39 -0400
Received: (qmail 30432 invoked from network); 20 Jun 2009 14:14:39 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 20 Jun 2009 14:14:39 +0200
Content-Disposition: inline
In-Reply-To: <46a038f90905150352q76157227q24c6b8c0befa4108@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121942>

This helps cross-platform projects on the case-sensitive filename side
of operating systems to use filenames that are nice for the
case-insensitive side

---
On Fri, May 15, 2009 at 12:52:41PM +0200, Martin Langhoff wrote:
> On Thu, May 14, 2009 at 7:59 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > At the moment non-ascii encodings of filenames are not portably converted
> > between different filesystems by git. This will most likely change in the
> > future but to allow repositories to be portable among different file/operating
> > systems this check is enabled by default.
>  - It'd be a good idea to add to the mix a check for filenames that
> are equivalent in case-insensitive FSs.

Totally untested. Just to get feedback if someone has ideas how this can
be solved more efficiently. I suspect that processing all files will
yield an unbearable performance degradation on large projects.

Let me know what you think. The wording of the error message is not yet
final.

 templates/hooks--pre-commit.sample |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index b11ad6a..32d1809 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -9,6 +9,10 @@
 
 # If you want to allow non-ascii filenames set this variable to true.
 allownonascii=$(git config hooks.allownonascii)
+# If you want to allow filenames that only differ in case set this
+# variable to true. NOTE: This can degrade performance on project with
+# lots of files
+allowcaseonly=$(git config hooks.allowcaseonly)
 
 # Cross platform projects tend to avoid non-ascii filenames; prevent
 # them from being added to the repository. We exploit the fact that the
@@ -32,6 +36,23 @@ then
 	exit 1
 fi
 
+# check for names that already exist but only differ in case
+# which can be problematic on non-casesensitive filesystems
+if [ "$allowcaseonly" != "true" ] &&
+	test -z "$(git ls-files | LC_ALL=C tr -s [A-Z] [a-z] | uniq -d)"
+then
+	echo "Error: Attempt to add file which already exists in different case"
+	echo
+	echo "If you know what you are doing you can disable this"
+	echo "check using:"
+	echo
+	echo "  git config hooks.allowcaseonly true"
+	echo
+	exit 1
+fi
+
 if git-rev-parse --verify HEAD >/dev/null 2>&1
 then
 	against=HEAD
-- 
1.6.3.2.203.g9a122
