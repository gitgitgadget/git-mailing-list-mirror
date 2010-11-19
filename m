From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 3/6] http-push: Normalise directory names when pushing to some WebDAV servers
Date: Fri, 19 Nov 2010 20:46:27 +0800
Message-ID: <1290170790-2200-4-git-send-email-rctay89@gmail.com>
References: <1290170790-2200-1-git-send-email-rctay89@gmail.com>
 <1290170790-2200-2-git-send-email-rctay89@gmail.com>
 <1290170790-2200-3-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	Gabriel Corona <gabriel.corona@enst-bretagne.fr>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 19 13:47:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJQN4-0001C8-B7
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 13:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101Ab0KSMrC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 07:47:02 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47695 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823Ab0KSMrA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 07:47:00 -0500
Received: by mail-pv0-f174.google.com with SMTP id 1so687011pvh.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 04:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/qGoEqyQf7C+h4OKiQ41Tyg0f6VnBJHE5i+ETK11JVE=;
        b=r1dBSzVBIzsA2hydPZlo4kkp1IFj5w8ntfqBFEhj7zzAaZBDjfBtV8Pm3HTfMvDF8i
         xYzP1BVBqHGtJVR5Z1mMvpDr9CaIzicmnTAtxIcT59WXRlmOoWESeUhQQ+aJQrtVifsM
         wVjgnE4/qKDtNBLaZFBl4+k3zZcDEewGp1BSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rYgU8C3/WQbx2NNb0YAFdCugg3C+Lx7JQWdb3u/QD+96G7hkza6RYZzMJupg8Drk3b
         h81P3uB52dfpZaw9Dbp0+3IcrhUSqTwSAjw2S8VdvT8CefKddyBjDg3+f3mAR0rRgceT
         gUDfXbilzU70xBb1WZee+zSjrq8MwY+3jHWWo=
Received: by 10.142.52.5 with SMTP id z5mr1666301wfz.155.1290170820393;
        Fri, 19 Nov 2010 04:47:00 -0800 (PST)
Received: from localhost.localdomain (cm69.zeta153.maxonline.com.sg [116.87.153.69])
        by mx.google.com with ESMTPS id q13sm1852420wfc.5.2010.11.19.04.46.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 04:46:59 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1290170790-2200-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161750>

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
1.7.3.67.g2a10b
