From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 12/21] builtin-remote: refactor duplicated cleanup code
Date: Wed, 25 Feb 2009 03:32:19 -0500
Message-ID: <3feb0316f93ae0959fd321e40bcf64fd050a9e7d.1235546708.git.jaysoffian@gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 09:35:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFF7-0000Xo-Qz
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759872AbZBYIdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759883AbZBYIdI
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:33:08 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:53623 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758793AbZBYIdA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:33:00 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1285047yxm.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 00:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=picXgcdqvVJC2h9rQ/i49CUlncOKfRF8XLLjVypD4ts=;
        b=S9Q2Etya5SiQ3xMfGl949fM2/W3UYCkfGysjFlnH5/GPk3sU5vyhRUOBh3/ogBTeHb
         7mVGCVJTOJvJsRVq1JEWNYBQE5kay72y6p65kfh54C+pK/1QDsq35wl7J5MMHWzU/1RU
         qgBgKyJ4LyfRG11l1cgyqiR/9nv05a6DCepKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=SuK3rMXUJE2BQaG8bUFcbinH7DdgRpb7CTY/lJ1lnewbsw4pkQiTJS1oAMMY/AHNeL
         YmMxWEo51yamVAofA4R1yjhLhXdaJ+PWpwUm2PqzzQpzsjbsBJIFYjMBfillstz+oHtT
         XBMSKDR0jjNmlAkeavCEHFyySHaQIhfFzj3Ok=
Received: by 10.100.33.4 with SMTP id g4mr816317ang.133.1235550778415;
        Wed, 25 Feb 2009 00:32:58 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d35sm2145383and.38.2009.02.25.00.32.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 00:32:57 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111400>

This patch moves identical lines of code into a cleanup function. The
function has two callers and is about to gain a third.

Also removed a bogus NEEDSWORK comment per Daniel Barkalow:

  Actually, the comment is wrong; "remote" comes from remote_get(),
  which returns things from a cache in remote.c; there could be a
  remote_put() to let the code know that the caller is done with the
  object, but it wouldn't presently do anything.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index ac69d37..b89a353 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -632,6 +632,13 @@ static void show_list(const char *title, struct string_list *list,
 		printf("    %s\n", list->items[i].string);
 }
 
+static void free_remote_ref_states(struct ref_states *states)
+{
+	string_list_clear(&states->new, 0);
+	string_list_clear(&states->stale, 0);
+	string_list_clear(&states->tracked, 0);
+}
+
 static int get_remote_ref_states(const char *name,
 				 struct ref_states *states,
 				 int query)
@@ -738,10 +745,7 @@ static int show(int argc, const char **argv)
 			}
 		}
 
-		/* NEEDSWORK: free remote */
-		string_list_clear(&states.new, 0);
-		string_list_clear(&states.stale, 0);
-		string_list_clear(&states.tracked, 0);
+		free_remote_ref_states(&states);
 	}
 
 	return result;
@@ -792,10 +796,7 @@ static int prune(int argc, const char **argv)
 			warn_dangling_symref(dangling_msg, refname);
 		}
 
-		/* NEEDSWORK: free remote */
-		string_list_clear(&states.new, 0);
-		string_list_clear(&states.stale, 0);
-		string_list_clear(&states.tracked, 0);
+		free_remote_ref_states(&states);
 	}
 
 	return result;
-- 
1.6.2.rc1.291.g83eb
