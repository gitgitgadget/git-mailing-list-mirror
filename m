From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/7] t4018 (funcname patterns): make configuration easier to
 track
Date: Sat, 21 May 2011 14:22:28 -0500
Message-ID: <20110521192228.GC10530@elie>
References: <BANLkTi=OXznTspN-CJjM0YXfqARxL=J+Ow@mail.gmail.com>
 <20110521185314.GA10530@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 21 21:22:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrl0-0005zQ-Gb
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 21:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560Ab1EUTWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 15:22:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34568 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab1EUTWc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 15:22:32 -0400
Received: by iwn34 with SMTP id 34so3765812iwn.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 12:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=4W+wGWfbNvQu8IVd8HOUZnFWMq+T6waFlyxH/LpMj6U=;
        b=IYqmyPem9npY3MiCFuYgzX1/RfH/vusAfQyjop3AsGWoHaSFXuvyWTMxS0FrcYjCY0
         RdQkqRWfxsrYN7rG8pcg6c16L63vB6V9uSTG9oK1XFcoJiWaBx+r0UerHcRXkyLSGPX0
         YReuDN/WH3r97okWaq6G31CzWuXJJFeBQlQMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sGSRC9lJWuWobPdwFYF384RXnd7beWkoihfvsRnKskXhov+kJTgG4yPIX5lTZfeW+1
         11zvxOiIx/NglVnfWXvSZqVC4RzoTTXstRoxMZmT/esGwXZsWRbpRQ1PWIefAAxl7oBb
         +ULgFCme4UhH556Bky33Mwq9ZnPjw4jALeOdo=
Received: by 10.42.151.73 with SMTP id d9mr6573362icw.2.1306005752275;
        Sat, 21 May 2011 12:22:32 -0700 (PDT)
Received: from elie (adsl-69-209-78-180.dsl.chcgil.ameritech.net [69.209.78.180])
        by mx.google.com with ESMTPS id gy41sm2074164ibb.5.2011.05.21.12.22.30
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 12:22:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110521185314.GA10530@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174169>

Introduce a "test_config" function to set a configuration variable
for use by a single test (automatically unsetting it when the
assertion finishes).  If this function is used consistently, the
configuration used in a test_expect_success block can be read at the
beginning of that block instead of requiring reading all the tests
that come before.  So it becomes a little easier to add new tests or
rearrange existing ones without fear of breaking configuration.

In particular, the test of alternation in xfuncname patterns also
checks that xfuncname takes precedence over funcname variable as a
sort of side-effect, since the latter leaks in from previous tests.
In the new syntax, the test has to say explicitly what variables it is
using, making the test clearer and a future regression in coverage
from carelessly editing the script less likely.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4018-diff-funcname.sh |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 24eb1a3..ce0a0e3 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -32,6 +32,11 @@ EOF
 
 sed 's/beer\\/beer,\\/' < Beer.java > Beer-correct.java
 
+test_config () {
+	git config "$1" "$2" &&
+	test_when_finished "git config --unset $1"
+}
+
 builtin_patterns="bibtex cpp csharp fortran html java objc pascal perl php python ruby tex"
 for p in $builtin_patterns
 do
@@ -63,29 +68,29 @@ test_expect_success 'preset java pattern' '
 	grep "^@@.*@@ public static void main("
 '
 
-git config diff.java.funcname '!static
-!String
-[^ 	].*s.*'
-
 test_expect_success 'custom pattern' '
+	test_config diff.java.funcname "!static
+!String
+[^ 	].*s.*" &&
 	git diff --no-index Beer.java Beer-correct.java |
 	grep "^@@.*@@ int special;$"
 '
 
 test_expect_success 'last regexp must not be negated' '
-	git config diff.java.funcname "!static" &&
+	test_config diff.java.funcname "!static" &&
 	git diff --no-index Beer.java Beer-correct.java 2>&1 |
 	grep "fatal: Last expression must not be negated:"
 '
 
 test_expect_success 'pattern which matches to end of line' '
-	git config diff.java.funcname "Beer$" &&
+	test_config diff.java.funcname "Beer$" &&
 	git diff --no-index Beer.java Beer-correct.java |
 	grep "^@@.*@@ Beer"
 '
 
 test_expect_success 'alternation in pattern' '
-	git config diff.java.xfuncname "^[ 	]*((public|static).*)$" &&
+	test_config diff.java.funcname "Beer$" &&
+	test_config diff.java.xfuncname "^[ 	]*((public|static).*)$" &&
 	git diff --no-index Beer.java Beer-correct.java |
 	grep "^@@.*@@ public static void main("
 '
-- 
1.7.5.1
