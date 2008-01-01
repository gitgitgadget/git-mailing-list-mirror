From: Jeff King <peff@peff.net>
Subject: Re: git config problem with strange config files
Date: Tue, 1 Jan 2008 01:17:34 -0500
Message-ID: <20080101061734.GA15453@coredump.intra.peff.net>
References: <200712311847.41499.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Tue Jan 01 07:18:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9aS1-0001NG-UD
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 07:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbYAAGRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2008 01:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbYAAGRi
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 01:17:38 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4464 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbYAAGRh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 01:17:37 -0500
Received: (qmail 5172 invoked by uid 111); 1 Jan 2008 06:17:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 01 Jan 2008 01:17:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Jan 2008 01:17:34 -0500
Content-Disposition: inline
In-Reply-To: <200712311847.41499.kumbayo84@arcor.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69427>

On Mon, Dec 31, 2007 at 06:47:41PM +0100, Peter Oberndorfer wrote:

> In case of a strange .git/config file "git config key value" can
> create a bogus config entry, where one old value is wrong and the new
> value resides in the wrong section until the config file is fixed up
> by hand

This patch fixes the test case you gave.

Junio, even though such a config file should be rare, I think this is
v1.5.4 material. But there is one tricky thing which I will point out in
a followup mail.

-- >8 --
config: handle lack of newline at end of file better

The config parsing routines use the static global
'config_file' to store the FILE* pointing to the current
config file being parsed. The function get_next_char()
automatically converts an EOF on this file to a newline for
the convenience of its callers, and it sets config_file to
NULL to indicate that EOF was reached.

This throws away useful information, though, since some
routines want to call ftell on 'config_file' to find out
exactly _where_ the routine ended. In the case of a key
ending at EOF boundary, we ended up segfaulting in some
cases (changing that key or adding another key in its
section), or failing to provide the necessary newline
(adding a new section).

This patch adds a new flag to indicate EOF and uses that
instead of setting config_file to NULL. It also makes sure
to add newlines where necessary for truncated input. All
three included tests fail without the patch.
---
 config.c                |   14 +++++++++-----
 t/t1303-wacky-config.sh |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 5 deletions(-)
 create mode 100755 t/t1303-wacky-config.sh

diff --git a/config.c b/config.c
index fa56c70..7ef8b75 100644
--- a/config.c
+++ b/config.c
@@ -13,6 +13,7 @@
 static FILE *config_file;
 static const char *config_file_name;
 static int config_linenr;
+static int config_file_eof;
 static int zlib_compression_seen;
 
 static int get_next_char(void)
@@ -34,7 +35,7 @@ static int get_next_char(void)
 		if (c == '\n')
 			config_linenr++;
 		if (c == EOF) {
-			config_file = NULL;
+			config_file_eof = 1;
 			c = '\n';
 		}
 	}
@@ -118,7 +119,7 @@ static int get_value(config_fn_t fn, char *name, unsigned int len)
 	/* Get the full name */
 	for (;;) {
 		c = get_next_char();
-		if (c == EOF)
+		if (config_file_eof)
 			break;
 		if (!iskeychar(c))
 			break;
@@ -182,7 +183,7 @@ static int get_base_var(char *name)
 
 	for (;;) {
 		int c = get_next_char();
-		if (c == EOF)
+		if (config_file_eof)
 			return -1;
 		if (c == ']')
 			return baselen;
@@ -205,8 +206,7 @@ static int git_parse_file(config_fn_t fn)
 	for (;;) {
 		int c = get_next_char();
 		if (c == '\n') {
-			/* EOF? */
-			if (!config_file)
+			if (config_file_eof)
 				return 0;
 			comment = 0;
 			continue;
@@ -469,6 +469,7 @@ int git_config_from_file(config_fn_t fn, const char *filename)
 		config_file = f;
 		config_file_name = filename;
 		config_linenr = 1;
+		config_file_eof = 0;
 		ret = git_parse_file(fn);
 		fclose(f);
 		config_file_name = NULL;
@@ -918,6 +919,9 @@ int git_config_set_multivar(const char* key, const char* value,
 					contents, contents_sz,
 					store.offset[i]-2, &new_line);
 
+			if (copy_end > 0 && contents[copy_end-1] != '\n')
+				new_line = 1;
+
 			/* write the first part of the config */
 			if (copy_end > copy_begin) {
 				if (write_in_full(fd, contents + copy_begin,
diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
new file mode 100755
index 0000000..99985dc
--- /dev/null
+++ b/t/t1303-wacky-config.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='Test wacky input to git config'
+. ./test-lib.sh
+
+setup() {
+	(printf "[section]\n" &&
+	printf "  key = foo") >.git/config
+}
+
+check() {
+	echo "$2" >expected
+	git config --get "$1" >actual
+	git diff actual expected
+}
+
+test_expect_success 'modify same key' '
+	setup &&
+	git config section.key bar &&
+	check section.key bar
+'
+
+test_expect_success 'add key in same section' '
+	setup &&
+	git config section.other bar &&
+	check section.key foo &&
+	check section.other bar
+'
+
+test_expect_success 'add key in different section' '
+	setup &&
+	git config section2.key bar &&
+	check section.key foo &&
+	check section2.key bar
+'
+
+test_done
-- 
1.5.4.rc2.1103.g1042-dirty
