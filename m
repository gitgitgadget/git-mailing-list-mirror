From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] Extend sample pre-commit hook to check for non ascii
	filenames
Date: Mon, 18 May 2009 11:50:44 +0200
Message-ID: <20090518095044.GB910@heiko-voigts-macbook.local>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <m3r5yukv6g.fsf@localhost.localdomain> <20090512214250.GA22974@macbook.lan> <200905122356.00659.jnareb@gmail.com> <20090514175850.GA26267@macbook.lan> <7vbpputewv.fsf@alter.siamese.dyndns.org> <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <200905122356.00659.jnareb@gmail.com> <20090514175850.GA26267@macbook.lan> <200905151657.47225.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 18 11:51:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5zUo-0003Hm-Lh
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 11:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759261AbZERJut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 05:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759268AbZERJus
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 05:50:48 -0400
Received: from darksea.de ([83.133.111.250]:58556 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759253AbZERJuq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 05:50:46 -0400
Received: (qmail 21155 invoked from network); 18 May 2009 11:50:38 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 18 May 2009 11:50:38 +0200
Content-Disposition: inline
In-Reply-To: <200905151657.47225.jnareb@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119435>

At the moment non-ascii encodings of filenames are not portably converted
between different filesystems by git. This will most likely change in the
future but to allow repositories to be portable among different file/operating
systems this check is enabled by default.

Signed-off-by: Heiko <hvoigt@hvoigt.net>
---
so here is a third version ...

On Fri, May 15, 2009 at 04:57:45PM +0200, Jakub Narebski wrote:
> On Thu, 14 May 2009, Heiko Voigt wrote:
> 
> > At the moment non-ascii encodings of filenames are not portably converted
> > between different filesystems by git. This will most likely change in the
> > future but to allow repositories to be portable among different file/operating
> > systems this check is enabled by default.
> 
> By the way, you might consider choosing shorter line length for commits,
> something around 70-76 characters per line; otherwise it is harder to
> reply to without linewrapping. 80 characters that you used is, IMHO,
> absolute maximum, and it is good that you kept to it.

Yeah, I admit they were a little bit long.

> > +function is_ascii () {
> > +    test -z "$(cat | sed -e "s/[\ -~]*//g")"
> > +    return $?
> > +}
> 
> From CodingGuidelines for shell scripts:
>  - We do not write the noiseword "function" in front of shell
>    functions.
> 
> (in short: do not use bash-specific features... unless, of course,
> you are modifying bash-completion script).

Addressed.

> Second, it would be nice to have comment about how to use this
> function (as it does not check file given by its argument, but
> rather its standard input). And perhaps also a comment that it
> works because ASCII printable characters begin with ' ' space
> (does it have to be escaped?) and end with '~' tilde[2].

Done

> 
> Third, isn't it useless use of 'cat'[3]? And wouldn't it be better
> to use 'tr' to either delete printable characters and check for
> anything left (as you do; BTW. wouldn't "return test ..." be simpler?),
> or use 'tr' to count non portable characters?

Yes indeed it was useless. I also switched from sed to tr.

> 
> [1] http://www.dwheeler.com/essays/fixing-unix-linux-filenames.html
> [2] http://en.wikipedia.org/wiki/ASCII#ASCII_printable_characters
> [3] http://partmaps.org/era/unix/award.html#cat

On Fri, May 15, 2009 at 11:11:12AM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> > +function is_ascii () {
> 
> We do not say "#!/bin/bash" at the beginning (hopefully), so let's not say
> "function " here.

See above.

> > +    test -z "$(cat | sed -e "s/[\ -~]*//g")"
> 
> Do you need "cat | "?

Also above.

> Does this script run under LC_ALL=C?  Can an i18n'ized sed interfere with
> what you are trying to do?

I now explicitely set LC_ALL=C for the tr call which should now be robust
against such cases.

> 
> > +    return $?
> 
> Do you need this, or does the function return the result of the last
> statment anyway?

I wasn't aware of that. Removed the return.

> > +		echo "Non-ascii filenames are not allowed !"
> > +		echo "Please rename the file ..."
> 
> Can we make this sound more like a _sample_ project policy?  It's not like
> we enforce that policy to other people's projects.

I've polished this so we are now more user friendly as well.

 templates/hooks--pre-commit.sample |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index 0e49279..91ab563 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -7,6 +7,38 @@
 #
 # To enable this hook, rename this file to "pre-commit".
 
+# If you want to allow non-ascii filenames set this variable to true.
+allownonascii=$(git config hooks.allownonascii)
+
+# is_ascii() Tests the string given given on standard input for
+# printable ascii conformance. We exploit the fact that the printable
+# range starts at the space character and ends with tilde.
+is_ascii() {
+    test -z "$(LC_ALL=C tr -d \ -~)"
+}
+
+if [ "$allownonascii" != "true" ]
+then
+	# until git can handle non-ascii filenames gracefully
+	# prevent them to be added into the repository
+	if ! git diff --cached --name-only --diff-filter=A -z \
+	   | tr "\0" "\n" | is_ascii; then
+		echo "Error: Preventing to add a non-ascii filename."
+		echo
+		echo "This can cause problems if you want to work together"
+		echo "with people on other platforms than you."
+		echo
+		echo "To be portable it is adviseable to rename the file ..."
+		echo
+		echo "If you know what you are doing you can disable this"
+		echo "check using:"
+		echo
+		echo "  git config hooks.allownonascii true"
+		echo
+		exit 1
+	fi
+fi
+
 if git-rev-parse --verify HEAD 2>/dev/null
 then
 	against=HEAD
-- 
1.6.3
