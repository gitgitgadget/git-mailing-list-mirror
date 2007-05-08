From: Liu Yubao <yubao.liu@gmail.com>
Subject: [PATCH] remove unnecessary loop
Date: Tue, 08 May 2007 11:18:31 +0800
Message-ID: <463FEC07.8080605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 05:21:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlGGe-0007uf-F5
	for gcvg-git@gmane.org; Tue, 08 May 2007 05:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245AbXEHDVa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 23:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755257AbXEHDVa
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 23:21:30 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:33241 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755245AbXEHDVa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 23:21:30 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1822539nzf
        for <git@vger.kernel.org>; Mon, 07 May 2007 20:21:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=hW/90+Zs0BDS5OUDVXAmyj0m7+HXzqQ6+Y6qIWriW49RqSibK0t6hbViBQRcTkgBL+uidnOtTF99tQ7KYQtS5szgBtUJ+tHQiTRRHvdNFaCyV6vXRiCOyh9N4scJUd+Lks9a6SE7ZryqGiJ+MvSireRgfgArFx0FQ/sGqF74bYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=Xft78vIrUpunpM6bI4dyq77EFkRLJAfQ4ywPXVrr8Tf/4PA6w0K1Jor68Cc9nVoQfIW/OjdTsI7Mo//5xfxns1Y85W+Orj04FXNy5ZLOFrpwoTC+fS4KPbsBvLRmMybNiHT5ZRE8MFXllsQQ0r7/0K5XeZIHxuFNXKOMtLwt5z4=
Received: by 10.114.195.19 with SMTP id s19mr2427442waf.1178594488866;
        Mon, 07 May 2007 20:21:28 -0700 (PDT)
Received: from ?192.168.88.85? ( [221.122.47.70])
        by mx.google.com with ESMTP id y11sm3160436pod.2007.05.07.20.21.27;
        Mon, 07 May 2007 20:21:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46525>

Hi,
   Here is a minor optimization, the involved second "for" loop doesn't
need to start from beginning.

Signed-off-by: Liu Yubao <yubao.liu@gmail.com>
---
 builtin-add.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 5e6748f..9d10fdc 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -239,20 +239,19 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		die("index file corrupt");
 
 	if (!ignored_too) {
-		int has_ignored = 0;
 		for (i = 0; i < dir.nr; i++)
 			if (dir.entries[i]->ignored)
-				has_ignored = 1;
-		if (has_ignored) {
+				break;
+		if (i < dir.nr) {
 			fprintf(stderr, ignore_warning);
-			for (i = 0; i < dir.nr; i++) {
+			do {
 				if (!dir.entries[i]->ignored)
 					continue;
 				fprintf(stderr, "%s", dir.entries[i]->name);
 				if (dir.entries[i]->ignored_dir)
 					fprintf(stderr, " (directory)");
 				fputc('\n', stderr);
-			}
+			} while (++i < dir.nr);
 			fprintf(stderr,
 				"Use -f if you really want to add them.\n");
 			exit(1);
-- 
1.5.2.rc0.95.ga0715-dirty
