From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2] Extend sample pre-commit hook to check for non ascii
	filenames
Date: Thu, 14 May 2009 19:59:01 +0200
Message-ID: <20090514175850.GA26267@macbook.lan>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <m3r5yukv6g.fsf@localhost.localdomain> <20090512214250.GA22974@macbook.lan> <200905122356.00659.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 19:59:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4fD9-00030Q-SV
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 19:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200AbZENR7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 13:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbZENR7F
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 13:59:05 -0400
Received: from darksea.de ([83.133.111.250]:44401 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751805AbZENR7E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 13:59:04 -0400
Received: (qmail 6661 invoked from network); 14 May 2009 19:58:50 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 14 May 2009 19:58:50 +0200
Content-Disposition: inline
In-Reply-To: <200905122356.00659.jnareb@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119205>

At the moment non-ascii encodings of filenames are not portably converted
between different filesystems by git. This will most likely change in the
future but to allow repositories to be portable among different file/operating
systems this check is enabled by default.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
On Tue, May 12, 2009 at 11:55:59PM +0200, Jakub Narebski wrote:
> On Tue, 12 May 2009, Heiko Voigt wrote:
> 
> > At the moment non-ascii encodings of file/usernames are not very well
> > supported by git. This will most likely change in the future but to
> > allow repositories to be portable among different file/operating systems
> > this check is enabled by default.
> 
> > +	# non-ascii username issue a warning in git gui so tell the
> > +	# user to change it
> > +	if ! git config user.name | is_ascii; then
> > +		echo "Please only use ascii characters in your username!"
> > +		exit 1
> > +	fi
> > +
> > +	if ! git config user.email | is_ascii; then
> > +		echo "Please only use ascii characters in your email!"
> > +		exit 1
> > +	fi
> 
> Actually 1.) there is no easy way to avoid non-ASCII names at least
> in user.name (I think they are not allowed in email), but 2.) there
> is no trouble with non-ASCII encoding of commits, as they have 
> 'encoding' header if it is not uft-8 (see *encoding* config variables).

I tried it and indeed it seems to work now. This hook originated from a
windows installation were having non-ascii characters resulted in a
strange warning from git gui each time you commit. So here is the
corrected patch.

 templates/hooks--pre-commit.sample |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index 0e49279..3083735 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -7,6 +7,26 @@
 #
 # To enable this hook, rename this file to "pre-commit".
 
+# If you want to allow non-ascii filenames set this variable to true.
+allownonascii=$(git config hooks.allownonascii)
+
+function is_ascii () {
+    test -z "$(cat | sed -e "s/[\ -~]*//g")"
+    return $?
+}
+
+if [ "$allownonascii" != "true" ]
+then
+	# until git can handle non-ascii filenames gracefully
+	# prevent them to be added into the repository
+	if ! git diff --cached --name-only --diff-filter=A -z \
+			| tr "\0" "\n" | is_ascii; then
+		echo "Non-ascii filenames are not allowed !"
+		echo "Please rename the file ..."
+		exit 1
+	fi
+fi
+
 if git-rev-parse --verify HEAD 2>/dev/null
 then
 	against=HEAD
-- 
1.6.3
