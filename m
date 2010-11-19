From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 5/6] http-push: check path length before using it
Date: Fri, 19 Nov 2010 20:46:29 +0800
Message-ID: <1290170790-2200-6-git-send-email-rctay89@gmail.com>
References: <1290170790-2200-1-git-send-email-rctay89@gmail.com>
 <1290170790-2200-2-git-send-email-rctay89@gmail.com>
 <1290170790-2200-3-git-send-email-rctay89@gmail.com>
 <1290170790-2200-4-git-send-email-rctay89@gmail.com>
 <1290170790-2200-5-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	Gabriel Corona <gabriel.corona@enst-bretagne.fr>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 19 13:47:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJQN5-0001C8-EY
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 13:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301Ab0KSMrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 07:47:09 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43624 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab0KSMrH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 07:47:07 -0500
Received: by pwj1 with SMTP id 1so706938pwj.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 04:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8WssdQEjwYvuvONzPvTlto1fgfHsxApb/yOBLpuFX/Q=;
        b=iDavFfjVfCXRBgaQ/oFkZxyn5sGl4+joxlQdV0YJtZcSE1HXutcrc9bE+3MtFzpSnP
         Uk/zvjYKrskPdNsSdYkuZ1ZFzCAMKmuEBP8qqsjtQDAWssgwTLgPOR1Y0gXSIbIXRJPJ
         R0WLpcb63tC8EKu9K+M+Kv/EKNC9Om/VQDpxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=McPhcn24rLRCWug2FJ+2yWz2fL8swHfER2XIEt/5iyMhkSDSFVKsuVxQTnFmlw6j50
         80i6sZeV+LDEDDlT4meQUiDJMJdSdTpfvPQ/TWob+npJNwqdDGjAIdcdON4LIPy5hAVI
         ELj3qsDVSDPQo1J32IwpL9s+v8kXEkHL0oOZM=
Received: by 10.142.164.11 with SMTP id m11mr1643608wfe.109.1290170826657;
        Fri, 19 Nov 2010 04:47:06 -0800 (PST)
Received: from localhost.localdomain (cm69.zeta153.maxonline.com.sg [116.87.153.69])
        by mx.google.com with ESMTPS id q13sm1852420wfc.5.2010.11.19.04.47.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 04:47:05 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1290170790-2200-5-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161749>

We use path_len to skip the base url/path, but we do not know for sure
if path does indeed contain the base url/path. Check if this is so.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/http-push.c b/http-push.c
index 565e580..1c34b00 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1116,8 +1116,14 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
 				}
 			}
 			if (path) {
-				path += repo->path_len;
-				ls->dentry_name = xstrdup(path);
+				if (strncmp(path,
+					    (repo->path ? repo->path : repo->url),
+					    repo->path_len) == 0) {
+					path += repo->path_len;
+					ls->dentry_name = xstrdup(path);
+				} else
+					error("Parsed path '%s' does not match url: '%s'\n",
+					      path, (repo->path ? repo->path : repo->url));
 			}
 		} else if (!strcmp(ctx->name, DAV_PROPFIND_COLLECTION)) {
 			ls->dentry_flags |= IS_DIR;
-- 
1.7.3.67.g2a10b
