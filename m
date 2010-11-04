From: Arnout Engelen <arnouten@bzzt.net>
Subject: Re: [PATCH] log which temporary file could not be created
Date: Thu, 4 Nov 2010 01:24:50 +0100
Message-ID: <20101104002450.GQ9348@bzzt.net>
References: <20101009201751.GK9348@bzzt.net> <20101010024124.GA20305@burratino> <20101010103327.GO9348@bzzt.net> <20101010180909.GA12320@burratino> <7v8w24oygk.fsf@alter.siamese.dyndns.org> <20101018092000.GH9348@bzzt.net> <20101021205800.GC12685@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 01:25:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDndV-0001Wo-66
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 01:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202Ab0KDAY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 20:24:56 -0400
Received: from smtp-1.concepts.nl ([213.197.30.124]:37309 "EHLO
	smtp-1.concepts.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627Ab0KDAYz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 20:24:55 -0400
Received: from 5ee5397b.ftth.concepts.nl
	([94.229.57.123] helo=mail.bzzt.net ident=Debian-exim)
	by smtp-1.concepts.nl with esmtp (Exim 4.69)
	(envelope-from <arnouten@bzzt.net>)
	id 1PDndJ-00031f-NW; Thu, 04 Nov 2010 01:24:49 +0100
Received: from arnouten by localhost with local (Exim 4.69)
	(envelope-from <arnouten@bzzt.net>)
	id 1PDndK-0002FQ-99; Thu, 04 Nov 2010 01:24:50 +0100
Content-Disposition: inline
In-Reply-To: <20101021205800.GC12685@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: arnouten@bzzt.net
X-SA-Exim-Scanned: No (on localhost); SAEximRunCond expanded to false
X-Concepts-MailScanner-Information: Please contact abuse@concepts.nl for more information
X-Concepts-MailScanner-ID: 1PDndJ-00031f-NW
X-Concepts-MailScanner: Found to be clean
X-Concepts-MailScanner-SpamCheck: 
X-Concepts-MailScanner-From: arnouten@bzzt.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160651>

Thanks for your feedback. 

Modified patch all the way below ;)

On Thu, Oct 21, 2010 at 03:58:00PM -0500, Jonathan Nieder wrote:
> A strdup() takes much more than a strncpy() last time I checked.  So I'm
> glad to see you're using the latter. :)

:)

> Is exit(-1) portable?  I'd suggest using die() or usage().

I think it is, but 'usage' is indeed neater. Done.

> > +			// temporary file in nonexistent directory
> // does not work on C89-based compilers (sadly, there are still many
> in wide use).  

Changed to /* */

> > +			xmkstemp(strdup("/tmp/does/not/exist/testXXXXXX"));
> 
> Probably better to take a parameter with the filename.

Done

> > +++ b/t/t0007-mktemp.sh
> > +		test-mktemp $2 &>actual
> 
> &> does not work on most shells.

Changed to '2>', tested with zsh, ksh and bash.

> Might be clearer to spell these out:
> 
>  test_expect_success 'mktemp to nonexistent directory prints filename' '
> 	test_must_fail test-mktemp doesnotexist/testXXXXXX 2>err &&
> 	grep "doesnotexist/test" err
>  '
> 
>  test_expect_success POSIXPERM 'mktemp to unwritable directory prints filename' '
> 	mkdir cannotwrite &&
> 	chmod -w cannotwrite &&
> 	test_when_finished "chmod +w cannotwrite" &&
> 	test_must_fail test-mktemp cannotwrite/testXXXXXX 2>err &&
> 	grep "cannotwrite/test" err
>  '
> 
> This probably would belong in t0070-fundamental.sh.

Done and moved

> > --- a/wrapper.c
> > +++ b/wrapper.c
> > @@ -212,20 +212,42 @@ FILE *xfdopen(int fd, const char *mode)
> >  int xmkstemp(char *template)
> >  {
> >  	int fd;
> > +	char originalTemplate[255];
> 
> The existing convention is to use lowercase, brief names, with
> underscores separating words where appropraite.  See "Chapter 4:
> Naming" from Documentation/CodingStyle in linux-2.6 for explanation.

Changed to 'origtemplate'

> > +	strncpy(originalTemplate, template, 255);
> > +	originalTemplate[254] = '\0';
> 
> Maybe strlcpy() would be simpler?

Jep, thanks, didn't know that one. Changed.

> >  	fd = mkstemp(template);
> > -	if (fd < 0)
> > -		die_errno("Unable to create temporary file");
> > +	if (fd < 0) {
> > +		if (strlen(template) == 0) {
> > +			template = originalTemplate;
> > +		}
> 
> Useless use of strlen().  You probably wanted 'if (!template[0])'.

I thought strlen() would be a bit neater/more readable - but changed.

> Unnecessary brace clutter (see Documentation/CodingGuidelines for
> explanation).

Changed

> > +		if (*template == '/') {
> > +			die_errno("Unable to create temporary file '%s'", template);
> > +		} else {
> > +			die_errno("Unable to create temporary file '%s' at %s", template, getcwd(NULL, 0));
> 
> Okay.  is_absolute_path() might be helpful on Windows.

Changed.

Verified the testcases still succeed. 

The patch below:
- copies the original template to the stack, to be able to log it in case
  mkstemp clears it
- on failure, logs the modified template, if any, or the original one
- logs the CWD when the template is relative
- adds a test testing this gives sane output (and doesn't crash, etc)

Signed-off-by: Arnout Engelen <arnouten@bzzt.net>
---
 Makefile               |    1 +
 t/t0070-fundamental.sh |   13 +++++++++++++
 test-mktemp.c          |   14 ++++++++++++++
 wrapper.c              |   26 ++++++++++++++++++++++----
 4 files changed, 50 insertions(+), 4 deletions(-)
 create mode 100644 test-mktemp.c

diff --git a/Makefile b/Makefile
index 1f1ce04..30aafa2 100644
--- a/Makefile
+++ b/Makefile
@@ -428,6 +428,7 @@ TEST_PROGRAMS_NEED_X += test-string-pool
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-treap
 TEST_PROGRAMS_NEED_X += test-index-version
+TEST_PROGRAMS_NEED_X += test-mktemp
 
 TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
 
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 680d7d6..9bee8bf 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -12,4 +12,17 @@ test_expect_success 'character classes (isspace, isalpha etc.)' '
 	test-ctype
 '
 
+test_expect_success 'mktemp to nonexistent directory prints filename' '
+	test_must_fail test-mktemp doesnotexist/testXXXXXX 2>err &&
+	grep "doesnotexist/test" err
+'
+
+test_expect_success POSIXPERM 'mktemp to unwritable directory prints filename' '
+	mkdir cannotwrite &&
+	chmod -w cannotwrite &&
+	test_when_finished "chmod +w cannotwrite" &&
+	test_must_fail test-mktemp cannotwrite/testXXXXXX 2>err &&
+	grep "cannotwrite/test" err
+'
+
 test_done
diff --git a/test-mktemp.c b/test-mktemp.c
new file mode 100644
index 0000000..30e266a
--- /dev/null
+++ b/test-mktemp.c
@@ -0,0 +1,14 @@
+/*
+ * test-mktemp.c: code to exercise the creation of temporary files
+ */
+#include "wrapper.h"
+
+int main(int argc, char *argv[])
+{
+	if (argc != 2) {
+		usage("Expected 1 parameter defining the temporary file template");
+	}
+	xmkstemp(strdup(argv[1]));
+
+	return 0;
+}
diff --git a/wrapper.c b/wrapper.c
index fd8ead3..b5f10d1 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -212,20 +212,38 @@ FILE *xfdopen(int fd, const char *mode)
 int xmkstemp(char *template)
 {
 	int fd;
+	char origtemplate[255];
+	strlcpy(origtemplate, template, 255);
 
 	fd = mkstemp(template);
-	if (fd < 0)
-		die_errno("Unable to create temporary file");
+	if (fd < 0) {
+		if (!template[0])
+			template = origtemplate;
+
+		if (is_absolute_path(template))
+			die_errno("Unable to create temporary file '%s'", template);
+		else
+			die_errno("Unable to create temporary file '%s' at %s", template, getcwd(NULL, 0));
+	}
 	return fd;
 }
 
 int xmkstemp_mode(char *template, int mode)
 {
 	int fd;
+	char origtemplate[255];
+	strlcpy(origtemplate, template, 255);
 
 	fd = git_mkstemp_mode(template, mode);
-	if (fd < 0)
-		die_errno("Unable to create temporary file");
+	if (fd < 0) {
+		if (!template[0])
+			template = origtemplate;
+
+		if (is_absolute_path(template))
+			die_errno("Unable to create temporary file '%s'", template);
+		else
+			die_errno("Unable to create temporary file '%s' at %s", template, getcwd(NULL, 0));
+	}
 	return fd;
 }
 
-- 
1.7.2.3
