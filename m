From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] for-each-ref: fix objectname:short bug
Date: Thu, 26 Aug 2010 17:34:29 -0400
Message-ID: <1282858469-22116-1-git-send-email-jaysoffian@gmail.com>
References: <AANLkTikhcAC6Nf=jWQN40ascodaCte6v6e1JPfv-=To-@mail.gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Jeff King <peff@peff.net>, Junio C Hamano <junio@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 26 23:34:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ook5x-0003Yb-3i
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 23:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659Ab0HZVep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 17:34:45 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57561 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab0HZVen (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 17:34:43 -0400
Received: by gxk23 with SMTP id 23so843727gxk.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 14:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=eMQCp+14WmTAud2PCAUgo/iimAOLMHx/OyYQdeqlBjg=;
        b=ptqwBu/jX37IsCFSBBE+u50jvw9ifwPe/BRy+hJbzUFz04HftwN4/2e37Z+VLdcjtR
         Z+Rq2lmlqAkyPQLAUoU3YNNwTkTiMvhv4Qdi6RalsT8q/l3EjyMAkpDydc+Qy61z/bRl
         9acCJenIOpdxQSDGlfVUuyJyZfEEzRAit/Img=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UWTOKGxyzbJQeMpwQQllfvf34Fl8epOeXHu43GPW9GthYAVkEHEzVwt+PI2f7zZcss
         m0uOotDaP5KHKLZaMYL9kVLGju0hrNOo9kQbUomIK37bvnVuwgYblXhZuYkyJlkchF4A
         59NcSIkVDHITmFO/X8w+HwifhNg7QNr/CZEio=
Received: by 10.150.8.10 with SMTP id 10mr850017ybh.391.1282858483042;
        Thu, 26 Aug 2010 14:34:43 -0700 (PDT)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id 18sm7936319ybk.7.2010.08.26.14.34.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Aug 2010 14:34:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.170.gb30b3d
In-Reply-To: <AANLkTikhcAC6Nf=jWQN40ascodaCte6v6e1JPfv-=To-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154564>

When objectname:short was introduced, it forgot to copy the result of
find_unique_abbrev. Because the result of find_unique_abbrev is a
pointer to static buffer, this resulted in the same value being
substituted in for each ref.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin/for-each-ref.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index a2b28c6..89e75c6 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -228,7 +228,8 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 			v->s = s;
 		}
 		else if (!strcmp(name, "objectname:short")) {
-			v->s = find_unique_abbrev(obj->sha1, DEFAULT_ABBREV);
+			v->s = xstrdup(find_unique_abbrev(obj->sha1,
+							  DEFAULT_ABBREV));
 		}
 	}
 }
-- 
1.7.2.2.170.gb30b3d
