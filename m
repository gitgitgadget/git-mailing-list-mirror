From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH v3 3/5] builtin/mv.c: plug miniscule memory leak
Date: Thu,  6 Oct 2011 13:22:23 -0500
Message-ID: <U4wiHVyDLLG1PhI-8iY3YqpVXvr151LbD3OSy1NeXQm5ByYpuasT4PQ2mikx8l9NCM-x0SQVCoNYKu2B_37OiPIe7xhKUs0BWoBswpMpuwrxmIZKhEHGr_44lDLJGr3mebaKn5BoGro@cipher.nrlssc.navy.mil>
References: <VYN8m1JCy102-eaWWa-bsunEvt3zeXLJkVg7FZKZCtXT-Ww0vg7a8xA7NTvrZTiovKTnJ9Hlom0@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, peff@peff.net, j.sixt@viscovery.net,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 06 20:23:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBsbZ-0002nP-Gv
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 20:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758874Ab1JFSW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 14:22:59 -0400
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:45180 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751016Ab1JFSW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 14:22:57 -0400
Received: by mail3.nrlssc.navy.mil id p96IMpHX031890; Thu, 6 Oct 2011 13:22:51 -0500
In-Reply-To: <VYN8m1JCy102-eaWWa-bsunEvt3zeXLJkVg7FZKZCtXT-Ww0vg7a8xA7NTvrZTiovKTnJ9Hlom0@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 06 Oct 2011 18:22:51.0506 (UTC) FILETIME=[F555C520:01CC8454]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183009>

From: Brandon Casey <drafnel@gmail.com>

The "it" string would not be free'ed if base_name was non-NULL.
Let's free it.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 builtin/mv.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index e9d191f..5efe6c5 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -29,7 +29,11 @@ static const char **copy_pathspec(const char *prefix, const char **pathspec,
 			to_copy--;
 		if (to_copy != length || base_name) {
 			char *it = xmemdupz(result[i], to_copy);
-			result[i] = base_name ? xstrdup(basename(it)) : it;
+			if (base_name) {
+				result[i] = xstrdup(basename(it));
+				free(it);
+			} else
+				result[i] = it;
 		}
 	}
 	return get_pathspec(prefix, result);
-- 
1.7.7
