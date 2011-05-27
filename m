From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 3/3] verify_path: consider dos drive prefix
Date: Fri, 27 May 2011 18:00:40 +0200
Message-ID: <1306512040-1468-4-git-send-email-kusmabite@gmail.com>
References: <1306512040-1468-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, johannes.schindelin@gmx.de,
	j.sixt@viscovery.net, Theo Niessink <theo@taletn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 18:01:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPzTD-0000SD-S3
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 18:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084Ab1E0QA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 12:00:56 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52882 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755674Ab1E0QAz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 12:00:55 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so709158eyx.19
        for <git@vger.kernel.org>; Fri, 27 May 2011 09:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=FZesRc5kZJFDJhg3NPzCgynFPm7VIR3aVZnUkwb5kgI=;
        b=jaym788w5F7cSdhfcMzm0uLzRO7CpXoD65giR5Gk83b5XKJtd44N0Jryh6wHZLXrNl
         QAB4rhprDAXnBjzkMTzS0arxcZ5uzmAwzqQskRy6E4SDFKwrgSHGxnEyX5t2GCLaWV+c
         v2tJh5RNueDY/wIx4E0/77FcvI53l4F1eWp6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PoIPeGqnqMkAYDRkbAZJPst1hLnxkNikJYjAHZbNT08LEZuwmpBCYrg7Z9MuFguxr0
         cXgAuj6noVyi44QqbrfQmn8pUWq5bgF2YnY16Vh2f+igU8iSQpDNvnIXXeDk5uKR1gLG
         m8G23LtvjZiVvVIpRkC2/OGB1peIN67LPnWkk=
Received: by 10.213.26.195 with SMTP id f3mr2605507ebc.50.1306512054749;
        Fri, 27 May 2011 09:00:54 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id y6sm1338916eem.4.2011.05.27.09.00.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 May 2011 09:00:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.3775.ga8770a
In-Reply-To: <1306512040-1468-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174628>

If someone manage to create a repo with a 'C:' entry in the
root-tree, files can be written outside of the working-dir. This
opens up a can-of-worms of exploits.

Fix it by explicitly checking for a dos drive prefix when verifying
a paht. While we're at it, make sure that paths beginning with '\' is
considered absolute as well.

Noticed-by: Theo Niessink <theo@taletn.com>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 read-cache.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index f38471c..68faa51 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -753,11 +753,14 @@ int verify_path(const char *path)
 {
 	char c;
 
+	if (has_dos_drive_prefix(path))
+		return 0;
+
 	goto inside;
 	for (;;) {
 		if (!c)
 			return 1;
-		if (c == '/') {
+		if (is_dir_sep(c)) {
 inside:
 			c = *path++;
 			switch (c) {
-- 
1.7.5.3.3.g435ff
