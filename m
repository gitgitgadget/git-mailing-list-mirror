From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 6/9] http-push: Normalise directory names when pushing to some WebDAV servers
Date: Thu, 25 Nov 2010 16:21:07 +0800
Message-ID: <1290673270-4284-7-git-send-email-rctay89@gmail.com>
References: <1290433298-6000-1-git-send-email-rctay89@gmail.com>
 <1290673270-4284-1-git-send-email-rctay89@gmail.com>
 <1290673270-4284-2-git-send-email-rctay89@gmail.com>
 <1290673270-4284-3-git-send-email-rctay89@gmail.com>
 <1290673270-4284-4-git-send-email-rctay89@gmail.com>
 <1290673270-4284-5-git-send-email-rctay89@gmail.com>
 <1290673270-4284-6-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	Gabriel Corona <gabriel.corona@enst-bretagne.fr>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 25 09:23:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLX6z-0000E8-PD
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 09:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739Ab0KYIXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 03:23:20 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34173 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab0KYIXT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 03:23:19 -0500
Received: by mail-iw0-f174.google.com with SMTP id 5so389iwn.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 00:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=o4XJM5uA+Juihijf/kr2O60Dd9jTbZEo5Q/xy4F66Ho=;
        b=EEOFMqqOiLu33CwghgP0X+U18ER9NnDdzwO2NFDZnldJO0YySmIa3oUsWMF/AZYCu/
         Wkt6aoKEespKRWXGwsnx5r+6l4Wwt8cmL4s6+wzg9JZB5qx+gpZZPQ10s+7VmzeLmcjZ
         KFapw1WMN3x/HNOUNBcT/Un35VKx2xLUmGn7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=slNuajAPGzwCrnaLeJC0e8P8E2FpRIYhSolrWRmXbzO1pFnfd7+MczoJOGkbx2QvUi
         OtswOhXBJoGdNdH9wmVSQKlJMpXzJrcdPfzDexSoAgi5XJMZl3b2mx339wpVaOQ5msqo
         iqGCEZG70Tq4NPYZfc8Emv78lbLaVwUpDg8XA=
Received: by 10.231.32.129 with SMTP id c1mr344640ibd.60.1290673399347;
        Thu, 25 Nov 2010 00:23:19 -0800 (PST)
Received: from localhost.localdomain (cm60.zeta152.maxonline.com.sg [116.87.152.60])
        by mx.google.com with ESMTPS id i16sm513271ibl.12.2010.11.25.00.23.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 00:23:18 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1290673270-4284-6-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162111>

Fix a bug when pushing to WebDAV servers which do not use a trailing
slash for collection names. The previous implementation fails to see
that the requested resource "refs/" is the same resource as "refs"
and loads every reference twice (once for refs/ and once for refs).

This implementation normalises every collection name by appending a
trailing slash if necessary.

This can be tested with old versions of Apache (such as the WebDAV
server of GMX, Apache 2.0.63).

Based-on-patch-by: Gabriel Corona <gabriel.corona@enst-bretagne.fr>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/http-push.c b/http-push.c
index c9bcd11..565e580 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1090,6 +1090,10 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
 	if (tag_closed) {
 		if (!strcmp(ctx->name, DAV_PROPFIND_RESP) && ls->dentry_name) {
 			if (ls->dentry_flags & IS_DIR) {
+
+				/* ensure collection names end with slash */
+				str_end_url_with_slash(ls->dentry_name, &ls->dentry_name);
+
 				if (ls->flags & PROCESS_DIRS) {
 					ls->userFunc(ls);
 				}
-- 
1.7.3.2.495.gc7b3f
