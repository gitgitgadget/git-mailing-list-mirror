From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] git_config_*: don't assume we are parsing a config file
Date: Wed, 20 Feb 2008 19:00:32 -0500
Message-ID: <20080221000032.GA6429@coredump.intra.peff.net>
References: <20080220235944.GA6278@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 01:01:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRysA-0001Wz-J9
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 01:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755026AbYBUAAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 19:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755330AbYBUAAf
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 19:00:35 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3733 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753299AbYBUAAf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 19:00:35 -0500
Received: (qmail 9383 invoked by uid 111); 21 Feb 2008 00:00:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 20 Feb 2008 19:00:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2008 19:00:32 -0500
Content-Disposition: inline
In-Reply-To: <20080220235944.GA6278@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74575>

These functions get called by other code, including parsing
config options from the command line. In that case,
config_file_name is NULL, leading to an ugly message or even
a segfault on some implementations of printf.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 8064cae..cba2bcf 100644
--- a/config.c
+++ b/config.c
@@ -280,11 +280,18 @@ int git_parse_ulong(const char *value, unsigned long *ret)
 	return 0;
 }
 
+static void die_bad_config(const char *name)
+{
+	if (config_file_name)
+		die("bad config value for '%s' in %s", name, config_file_name);
+	die("bad config value for '%s'", name);
+}
+
 int git_config_int(const char *name, const char *value)
 {
 	long ret;
 	if (!git_parse_long(value, &ret))
-		die("bad config value for '%s' in %s", name, config_file_name);
+		die_bad_config(name);
 	return ret;
 }
 
@@ -292,7 +299,7 @@ unsigned long git_config_ulong(const char *name, const char *value)
 {
 	unsigned long ret;
 	if (!git_parse_ulong(value, &ret))
-		die("bad config value for '%s' in %s", name, config_file_name);
+		die_bad_config(name);
 	return ret;
 }
 
-- 
1.5.4.2.247.g107bd
