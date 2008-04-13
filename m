From: Alberto Bertogli <albertito@gmail.com>
Subject: [PATCH] builtin-apply: Show a more descriptive error on failure when opening a patch
Date: Sun, 13 Apr 2008 15:56:31 -0300
Message-ID: <1208112991-21598-1-git-send-email-albertito@gmail.com>
Cc: Alberto Bertogli <albertito@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 20:58:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jl7Os-0003F1-GY
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 20:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbYDMS5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 14:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbYDMS5V
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 14:57:21 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:27191 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbYDMS5U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 14:57:20 -0400
Received: by an-out-0708.google.com with SMTP id d31so329400and.103
        for <git@vger.kernel.org>; Sun, 13 Apr 2008 11:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=y5lFG9K3NUNlXtqsZx3DWXSiUe1o0LyEzV3GB8SZDDE=;
        b=anlfa0BWdzopMnsnvrTum51bfPEE6rAs/49AJ+TlfiYD+M7mA9i+8THnrYZuMCah/996NBPgag5UO9M7/XHDujVzyuuNpYGoJVFtdER7c1PmxjIpX64XvqHLAv7oyfakbg/5L7Jx5e/w9rqRy7V/j/b2XPxEzz8PCeDxQp4W0Xo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=fIBLHvxaePNHHov8HlmxUIwTYdF42kE9o1b5/qvCRmpOQsYAdF0j/aQ61cnNiEAkLXictwdtBcUxBNLMK3MmL6MzhIxeOqVnAbVB6TJedYIFPeasxT4KWurxHLUMEFWNwd0RRgBTUdGlcyveNxo246NklBM/URE8VO18hrfakkk=
Received: by 10.100.239.11 with SMTP id m11mr3860153anh.158.1208113036706;
        Sun, 13 Apr 2008 11:57:16 -0700 (PDT)
Received: from gmail.com ( [201.253.179.18])
        by mx.google.com with ESMTPS id s30sm9523884elf.16.2008.04.13.11.57.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Apr 2008 11:57:15 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.104.ge4331
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79415>

When a patch can't be opened (it doesn't exist, there are permission
problems, etc.) we get the usage text, which is not a proper indication of
failure.

This patch fixes that by simply doing a perror() instead.

Signed-off-by: Alberto Bertogli <albertito@gmail.com>
---
 builtin-apply.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index abe73a0..d80b231 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -3120,8 +3120,11 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			arg = prefix_filename(prefix, prefix_length, arg);
 
 		fd = open(arg, O_RDONLY);
-		if (fd < 0)
-			usage(apply_usage);
+		if (fd < 0) {
+			perror("Error opening patch");
+			return 1;
+		}
+
 		read_stdin = 0;
 		set_default_whitespace_mode(whitespace_option);
 		errs |= apply_patch(fd, arg, inaccurate_eof);
-- 
1.5.5.104.ge4331
