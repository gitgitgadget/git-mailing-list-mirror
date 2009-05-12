From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] Extend sample pre-commit hook to check for non ascii
	file/usernames
Date: Tue, 12 May 2009 23:43:00 +0200
Message-ID: <20090512214250.GA22974@macbook.lan>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <20090512182828.GA26812@dpotapov.dyndns.org> <46a038f90905121140n61902c61qc3cd41100efee4ae@mail.gmail.com> <m3r5yukv6g.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 23:43:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3zkp-0006vj-8k
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 23:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbZELVnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 17:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbZELVnF
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 17:43:05 -0400
Received: from darksea.de ([83.133.111.250]:43636 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751377AbZELVnE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 17:43:04 -0400
Received: (qmail 31619 invoked from network); 12 May 2009 23:42:47 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 12 May 2009 23:42:47 +0200
Content-Disposition: inline
In-Reply-To: <m3r5yukv6g.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118958>

At the moment non-ascii encodings of file/usernames are not very well
supported by git. This will most likely change in the future but to
allow repositories to be portable among different file/operating systems
this check is enabled by default.

Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
---
On Tue, May 12, 2009 at 11:55:39AM -0700, Jakub Narebski wrote:
> Somebody asked for a pre-add hook in the past; it would be good place
> to put such check.  But in meantime you can do it using pre-commit
> hook instead, isn't it?

I actually had this in my queue to be submitted...

 templates/hooks--pre-commit.sample |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index 0e49279..83ff873 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -7,6 +7,39 @@
 #
 # To enable this hook, rename this file to "pre-commit".
 
+# If you want to allow non-ascii filenames or usernames set
+# this variable to true.
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
+
+	# non-ascii username issue a warning in git gui so tell the
+	# user to change it
+	if ! git config user.name | is_ascii; then
+		echo "Please only use ascii characters in your username!"
+		exit 1
+	fi
+
+	if ! git config user.email | is_ascii; then
+		echo "Please only use ascii characters in your email!"
+		exit 1
+	fi
+fi
+
 if git-rev-parse --verify HEAD 2>/dev/null
 then
 	against=HEAD
-- 
1.6.3
