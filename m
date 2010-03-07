From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 3/4] format-patch: add --no-cc, --no-to, and --no-add-headers
Date: Sun,  7 Mar 2010 13:33:17 -0800
Message-ID: <1267997598-20815-4-git-send-email-bebarino@gmail.com>
References: <7vk4torn8j.fsf@alter.siamese.dyndns.org>
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Steven Drake <sdrake@xnet.co.nz>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 22:33:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoO6e-0004xa-4l
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 22:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923Ab0CGVdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 16:33:32 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63874 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754802Ab0CGVda (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 16:33:30 -0500
Received: by gyh3 with SMTP id 3so553155gyh.19
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 13:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Sxnny7OcsnkcjCWc5Knua44E+5G85SvQ9+Y+NBMffo8=;
        b=oeYw4wYHAd8uVFCYzAGXLmZTczDUcGiAxj1TZLHMsMkNOA4YgFwTXqyr4TbOPqvjDm
         XNUcCSuhntIgk8KXLDyB8ZGQi9NCZCx+2o/lr4aJrBETjA3VMY1VLIoSrwM4+J6wgoqN
         tTqIJCdaoRkpOdD7/U6JU8EWiOSZUMtRrHw0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ou552rmZNhy1jQqbuZDcsJakQpay+tFjz/5256zdLvs6+VK+KODvWoeD4trTMqPzDk
         SMmpVtfG7+NPE8YYly5Y0VSdd61lhZ4lnxw8RbdMO/JmF0ieHrqYhD3bZYX3gXk6WszW
         fHWYV284sNTQ4yYznmYHAUbcIWJYA0KbeeY74=
Received: by 10.100.60.19 with SMTP id i19mr4119219ana.62.1267997610231;
        Sun, 07 Mar 2010 13:33:30 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 7sm1133128yxd.26.2010.03.07.13.33.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 13:33:29 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.171.geb5ee
In-Reply-To: <7vk4torn8j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141735>

These new options allow users to override their config settings for
format.cc, format.to and format.headers respectively. These options
only make git ignore the config settings and any previous command line
options, so you'll still have to add more command line options to add
extra headers. For example,

	$ cat .git/config
	[format]
		to = Someone <someone@out.there>
	$ git format-patch -1 --no-to --to="Someone Else <else@out.there>"

would format a patch addressed to "Someone Else" and not "Someone".

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin-log.c           |   25 ++++++++++++++++++-------
 t/t4014-format-patch.sh |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index dd8369f..00cddcc 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -869,19 +869,31 @@ static int inline_callback(const struct option *opt, const char *arg, int unset)
 
 static int header_callback(const struct option *opt, const char *arg, int unset)
 {
-	add_header(arg);
+	if (unset) {
+		string_list_clear(&extra_hdr, 0);
+		string_list_clear(&extra_to, 0);
+		string_list_clear(&extra_cc, 0);
+	} else {
+	    add_header(arg);
+	}
 	return 0;
 }
 
 static int to_callback(const struct option *opt, const char *arg, int unset)
 {
-	string_list_append(arg, &extra_to);
+	if (unset)
+		string_list_clear(&extra_to, 0);
+	else
+		string_list_append(arg, &extra_to);
 	return 0;
 }
 
 static int cc_callback(const struct option *opt, const char *arg, int unset)
 {
-	string_list_append(arg, &extra_cc);
+	if (unset)
+		string_list_clear(&extra_cc, 0);
+	else
+		string_list_append(arg, &extra_cc);
 	return 0;
 }
 
@@ -940,12 +952,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		  PARSE_OPT_NONEG | PARSE_OPT_NOARG },
 		OPT_GROUP("Messaging"),
 		{ OPTION_CALLBACK, 0, "add-header", NULL, "header",
-			    "add email header", PARSE_OPT_NONEG,
-			    header_callback },
+			    "add email header", 0, header_callback },
 		{ OPTION_CALLBACK, 0, "to", NULL, "email", "add To: header",
-			    PARSE_OPT_NONEG, to_callback },
+			    0, to_callback },
 		{ OPTION_CALLBACK, 0, "cc", NULL, "email", "add Cc: header",
-			    PARSE_OPT_NONEG, cc_callback },
+			    0, cc_callback },
 		OPT_STRING(0, "in-reply-to", &in_reply_to, "message-id",
 			    "make first mail a reply to <message-id>"),
 		{ OPTION_CALLBACK, 0, "attach", &rev, "boundary",
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 830ddb0..c7b6256 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -157,6 +157,44 @@ test_expect_success 'configuration To: header' '
 	grep "^To: R. E. Cipient <rcipient@example.com>\$" patch9
 '
 
+test_expect_success '--no-to overrides config.to' '
+
+	git config --replace-all format.to \
+		"R. E. Cipient <rcipient@example.com>" &&
+	git format-patch --no-to --stdout master..side |
+	sed -e "/^\$/q" >patch10 &&
+	! grep "^To: R. E. Cipient <rcipient@example.com>\$" patch10
+'
+
+test_expect_success '--no-to and --to replaces config.to' '
+
+	git config --replace-all format.to \
+		"Someone <someone@out.there>" &&
+	git format-patch --no-to --to="Someone Else <else@out.there>" \
+		--stdout master..side |
+	sed -e "/^\$/q" >patch11 &&
+	! grep "^To: Someone <someone@out.there>\$" patch11 &&
+	grep "^To: Someone Else <else@out.there>\$" patch11
+'
+
+test_expect_success '--no-cc overrides config.cc' '
+
+	git config --replace-all format.cc \
+		"C. E. Cipient <rcipient@example.com>" &&
+	git format-patch --no-cc --stdout master..side |
+	sed -e "/^\$/q" >patch12 &&
+	! grep "^Cc: C. E. Cipient <rcipient@example.com>\$" patch12
+'
+
+test_expect_success '--no-add-headers overrides config.headers' '
+
+	git config --replace-all format.headers \
+		"Header1: B. E. Cipient <rcipient@example.com>" &&
+	git format-patch --no-add-headers --stdout master..side |
+	sed -e "/^\$/q" >patch13 &&
+	! grep "^Header1: B. E. Cipient <rcipient@example.com>\$" patch13
+'
+
 test_expect_success 'multiple files' '
 
 	rm -rf patches/ &&
-- 
1.7.0.1.171.geb5ee
