From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 1/3] rev-parse: exit with non-zero status if ref@{n} is not valid.
Date: Tue, 24 Aug 2010 14:52:42 +1000
Message-ID: <1282625564-12752-2-git-send-email-jon.seymour@gmail.com>
References: <20100824001454.GB17406@burratino>
Cc: gitster@pobox.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 24 06:53:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnlVu-00051F-17
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 06:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913Ab0HXExO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 00:53:14 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:44093 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892Ab0HXExL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 00:53:11 -0400
Received: by pxi10 with SMTP id 10so2528795pxi.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 21:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=km8Zi5xpuWOT8+gh/51Lbjvq+IHWppKy4RVzwflaF3o=;
        b=pwS+nbPCNx/3dwmSQtHe7bvxeEMLJwykv+BYZ0MtY/P2SPPY4/m90wcZ4BtOpKdiFU
         3k/qNG+q8dom73jNYnSqNJMU6lEQQvQisky6QS5DdN0/JudXj4Bh95wSgNpuhiGCoeS/
         oPM7GVXYXRRQ3JA+c5HluK8ZtrQggmStEzMvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kKRrL9XJ5jZ3fAVCVqziKduAy2p4JpX9fkXOdSGg4EGEcf/hp9RfDgZP+C7y53nKZk
         M+PUhgdqpeUI0k8zQZ1mtQnJp1KCdv8XI1D4FoTW/2VJ2RFuukjgw2Zso3RQcvgI+j9O
         QT05zfTMKUIhnfAVahNArFjknvO+2Oq4e+Ges=
Received: by 10.142.226.9 with SMTP id y9mr5310386wfg.178.1282625591325;
        Mon, 23 Aug 2010 21:53:11 -0700 (PDT)
Received: from localhost.localdomain ([120.16.94.110])
        by mx.google.com with ESMTPS id n2sm9394805wfl.1.2010.08.23.21.53.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 21:53:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.100.gceecd
In-Reply-To: <20100824001454.GB17406@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154288>

>From Junio's e-mail:

"The current behaviour of ref@{...} syntax parser is suboptimal:

    $ git rev-parse --verify jch@{99999} && echo true
    warning: Log for 'jch' only has 1368 entries.
    cfb88e9a8d4926b0011ae2dd67e1f57a98f4b768
    true

It even knows that it is running off the cut-off point; it should just
cause the caller to notice that fact.  I don't think changing it to error
out should cause any harm to existing callers."

With this change:

   $ git rev-parse --verify jch@{99999} || echo false
   fatal: Log for 'jch' only has 1368 entries.
   false

   $ git rev-parse jch@{99999} || echo false
   fatal: Log for 'jch' only has 1368 entries.
   false

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 sha1_name.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 4af94fa..10a4efe 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -430,10 +430,13 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 					"warning: Log for '%.*s' only goes "
 					"back to %s.\n", len, str,
 					show_date(co_time, co_tz, DATE_RFC2822));
-			else
-				fprintf(stderr,
-					"warning: Log for '%.*s' only has "
-					"%d entries.\n", len, str, co_cnt);
+			else {
+				free(real_ref);
+				die("Log for '%.*s' only has %d entries.",
+						len,
+						str,
+						co_cnt);
+			}
 		}
 	}
 
-- 
1.7.2.1.100.gceecd
