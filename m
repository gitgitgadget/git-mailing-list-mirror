From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/4] msvc: Fix an "unrecognized option" linker warning
Date: Wed, 20 Jan 2010 19:25:51 +0000
Message-ID: <4B5758BF.9090806@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 21:35:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXhGm-0001cs-LN
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 21:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522Ab0ATUfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 15:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754406Ab0ATUfF
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 15:35:05 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:42661 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753662Ab0ATUfE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 15:35:04 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1NXhGV-0001wx-ez; Wed, 20 Jan 2010 20:35:01 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137572>


Having recently added support for building git-imap-send on
Windows, we now link against OpenSSL libraries, and the linker
issues the following warning:

    warning LNK4044: unrecognized option '/lssl'; ignored

In order to suppress the warning, we change the msvc linker
script to translate an '-lssl' parameter to the ssleay32.lib
library.

Note that the linker script was already including ssleay32.lib
(along with libeay32.lib) as part of the translation of the
'-lcrypto' library parameter.  However, libeay32.dll does not
depend on ssleay32.dll and can be used stand-alone, so we remove
ssleay32.lib from the '-lcrypto' translation.

The dependence of ssleay32.dll on libeay32.dll is represented in
the Makefile by the NEEDS_CRYPTO_WITH_SSL build variable.

Also, add the corresponding change to the buildsystem generator.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/vcbuild/scripts/clink.pl |    1 +
 contrib/buildsystems/engine.pl  |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
index 8a2112f..4374771 100644
--- a/compat/vcbuild/scripts/clink.pl
+++ b/compat/vcbuild/scripts/clink.pl
@@ -31,6 +31,7 @@ while (@ARGV) {
 		push(@args, "iconv.lib");
 	} elsif ("$arg" eq "-lcrypto") {
 		push(@args, "libeay32.lib");
+	} elsif ("$arg" eq "-lssl") {
 		push(@args, "ssleay32.lib");
 	} elsif ("$arg" =~ /^-L/ && "$arg" ne "-LTCG") {
 		$arg =~ s/^-L/-LIBPATH:/;
diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 245af73..ce4eb1e 100644
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -322,6 +322,7 @@ sub handleLinkLine
             push(@libs, "zlib.lib");
 	} elsif ("$part" eq "-lcrypto") {
             push(@libs, "libeay32.lib");
+        } elsif ("$part" eq "-lssl") {
             push(@libs, "ssleay32.lib");
         } elsif ($part =~ /^-/) {
             push(@lflags, $part);
-- 
1.6.6
