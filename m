From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 3/4] builtin/mv.c: plug miniscule memory leak
Date: Wed, 14 Sep 2011 20:59:38 -0500
Message-ID: <1316051979-19671-4-git-send-email-drafnel@gmail.com>
References: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrdmveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil>
 <1316051979-19671-1-git-send-email-drafnel@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
	bharrosh@panasas.com, trast@student.ethz.ch, zapped@mail.ru,
	Brandon Casey <drafnel@gmail.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Thu Sep 15 04:01:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R41GC-0007Vc-A8
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 04:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437Ab1IOCA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 22:00:59 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54642 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab1IOCA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 22:00:58 -0400
Received: by gyg10 with SMTP id 10so1875627gyg.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 19:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gv7xlg+GHp2ZiOg0nxJwXuzPVIR49+/KC8tBixbJePo=;
        b=hMZd9M2r/7jUFDDZfXhEpEW4Er7Ua4OA2WXVVUejxNHvyC1sXyZZTzjI8rRmYylj74
         BKQ4vDlH+TtPpTOCy3HUoMsLQTHU2IgJkR8TyIooWQfXQowKN9LfZkGm0b0/439VfXkH
         urWTHc3maKdc800qnA295dt3kNVqGjRvsIuDw=
Received: by 10.236.80.9 with SMTP id j9mr2929436yhe.94.1316052058382;
        Wed, 14 Sep 2011 19:00:58 -0700 (PDT)
Received: from localhost.localdomain ([96.19.140.155])
        by mx.google.com with ESMTPS id e61sm2291412yhm.2.2011.09.14.19.00.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Sep 2011 19:00:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1316051979-19671-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181424>

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
1.7.6.2
