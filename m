From: Yann Droneaud <yann@droneaud.fr>
Subject: [PATCH 1/4] test: add a library to detect an en_US.UTF-8 locale
Date: Thu,  6 Jan 2011 15:22:14 +0100
Message-ID: <4490926da28dcbfedc779cd32c5a59e20a1b55a2.1294312018.git.yann@droneaud.fr>
References: <1274193685-5468-1-git-send-email-yann@droneaud.fr> <4BF2BABC.2010405@drmicha.warpmail.net> <1274202486.4228.22.camel@localhost> <1274720888.4838.13.camel@localhost> <cover.1294312018.git.yann@droneaud.fr>
Cc: Yann Droneaud <yann@droneaud.fr>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 06 15:31:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Paqri-0001ez-Cv
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 15:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712Ab1AFOax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 09:30:53 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:34798 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab1AFOaw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 09:30:52 -0500
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jan 2011 09:30:51 EST
Received: from deela.quest-ce.net ([80.12.81.242])
	by mwinf5d25 with ME
	id sENz1f00D5DhHAg03ENzmC; Thu, 06 Jan 2011 15:22:59 +0100
Received: from deela.quest-ce.net (localhost.localdomain [127.0.0.1])
	by deela.quest-ce.net (8.14.4/8.14.4) with ESMTP id p06EMdBM031808;
	Thu, 6 Jan 2011 15:22:52 +0100
Received: (from ydroneaud@localhost)
	by deela.quest-ce.net (8.14.4/8.14.4/Submit) id p06EMd55031807;
	Thu, 6 Jan 2011 15:22:39 +0100
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <cover.1294312018.git.yann@droneaud.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164632>

Since one can't rely on "locale" command availability nor its -a output,
perl script t/lib-locale.pl first use setlocale() and langinfo(CODESET)
to search for a working en_US.UTF-8 locale among many name variants.

If this fail, the script fallback to "locale" usage with two steps:
- try the "charmap" keyword, for example LC_ALL=en_US locale charmap
- then try "-a" option and match a pattern looking to the
  locale names

Signed-off-by: Yann Droneaud <yann@droneaud.fr>
---
 t/lib-locale.pl |  167 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 167 insertions(+), 0 deletions(-)
 create mode 100755 t/lib-locale.pl

diff --git a/t/lib-locale.pl b/t/lib-locale.pl
new file mode 100755
index 0000000..33d47a5
--- /dev/null
+++ b/t/lib-locale.pl
@@ -0,0 +1,167 @@
+#!/usr/bin/env perl
+
+#
+# Copyright (c) 2011 Yann Droneaud <yann@droneaud.fr>
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see http://www.gnu.org/licenses/ .
+#
+
+use strict;
+if ($] > 5.004) {
+    use warnings; # unless $] < 5.0004;
+}
+use POSIX;
+
+# according to manpage: setlocale can be used starting from perl 5.004
+# starting from May 1997.
+require 5.004;
+
+# it can also be tested with  perl -V:d_setlocale
+# which must return something like "d_setlocale='define';"
+
+my $default_locale = setlocale(LC_ALL);
+
+# try a locale and return its codeset if available
+sub locale_get_codeset
+{
+    my ($locale) = @_;
+    my $codeset;
+    my $ret;
+
+    $ret = setlocale(LC_ALL, $locale);
+    if (!defined($ret)) {
+	# print "can't set locale $locale\n";
+	return undef;
+    }
+
+    #
+    # I18N::Langinfo is not available everywhere
+    # use the trick from perldoc I18N::Langinfo
+    #
+    $codeset = eval {
+	require I18N::Langinfo;
+	I18N::Langinfo->import(qw(langinfo CODESET));
+	langinfo(CODESET()); # note the ()
+    };
+
+    if (defined($@) && $@) {
+	print STDERR "error while testing codeset:\n $@";
+	return undef;
+    }
+
+    # restore locale
+    setlocale(LC_ALL, $default_locale);
+
+    return $codeset;
+}
+
+# check that given codeset match UTF-8
+sub codeset_check
+{
+    my ($codeset) = @_;
+
+    if (defined($codeset) && $codeset =~ /^UTF[_-]?8$/i) {
+	return 1;
+    }
+
+    return 0;
+}
+
+# try all those locales
+# require en_US with UTF-8
+my @locales = ( "en_US.UTF-8",
+		"en_US.utf8",
+		"en_US.UTF8",
+		"en_US.utf-8",
+		"en_US.UTF_8",
+		"en_US.utf_8",
+		"en_US" );
+
+my $locale;
+
+my $codeset;
+
+#
+# Check locale from within perl
+#
+foreach $locale (@locales) {
+
+    $codeset = locale_get_codeset($locale);
+
+    if (codeset_check($codeset)) {
+	print $locale, "\n";
+	exit 0;
+    }
+}
+
+#
+# if 'locale' command is available, test 'locale charmap'
+#
+foreach $locale (@locales) {
+
+    $codeset = `LC_ALL=$locale locale charmap 2>/dev/null`;
+
+    # if any error, skip
+    if ($!) {
+	last;
+    }
+
+    if (codeset_check($codeset)) {
+	print $locale, "\n";
+	exit 0;
+    }
+}
+
+#
+# try to execute "locale -a" command
+# this command is not always available and
+# output format is not normalized
+#
+use IPC::Open3;
+use File::Spec;
+
+open(NULLR, "<", File::Spec->devnull) || die "Can't open devnull: $!";
+open(NULLW, ">", File::Spec->devnull) || die "Can't open devnull: $!";
+
+my $pid = open3("<&NULLR", \*LOCALES, ">&NULLW" , "locale", "-a") || die "Can't launch locale -a: $!";
+
+while(<LOCALES>) {
+     chomp;
+     if (/(en_US\.([\w-]+))/i) {
+	 if (codeset_check($2)) {
+	     $locale = $1;
+	     last;
+	 }
+     }
+}
+
+waitpid($pid, 0);
+
+my $retcode = $?;
+
+close(LOCALES);
+
+if ($retcode == 0) {
+    if (defined $locale) {
+	print "$locale\n";
+	exit 0;
+    }
+}
+
+#
+# Nothing available,
+# at last, return an error
+#
+
+exit 1;
-- 
1.7.3.4
