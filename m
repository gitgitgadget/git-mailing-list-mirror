From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 2/4] builtin-remote: move duplicated cleanup code its own function
Date: Fri, 13 Feb 2009 03:54:33 -0500
Message-ID: <1234515275-91263-3-git-send-email-jaysoffian@gmail.com>
References: <1234515275-91263-1-git-send-email-jaysoffian@gmail.com>
 <1234515275-91263-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, peff@peff.net,
	gitster@pobox.com, barkalow@iabervon.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 09:56:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXtqd-0003hw-HM
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 09:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbZBMIyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 03:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbZBMIyp
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 03:54:45 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:55647 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbZBMIyn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 03:54:43 -0500
Received: by an-out-0708.google.com with SMTP id c2so626864anc.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 00:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=bXr4TK55jc2Xx4PlLRupC2ZKWTFzIK2RiEXHB8lEMBk=;
        b=pn20jL6OZlyj+JKLOfiMmtrOjEDkf2eJe+pcTKd30Ci/FRmyuhuITQnXc6OTnR7h1a
         /sQFM2mTzUByr4NLTu19+mB3Hur7KJPSFuC0MWPxrojo1aYcq6B+QMSE+xEH66x6bSmd
         SvtTsZFbaG2Mi1DHOvtFvTqIXAm0XV4eIy4Xg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rTHUYufkM+ip62/9sJW7RucIwlgChou6gbQQkGevfcjeeJsoVOhfaoyRVpe469l2Vz
         WjC0SwI0zgkjA/v0QSdOIMvbHGqXeypt9RMuZBNJeRamN8IOUxXxyBGQEZJCXBMt8zDk
         TYM2DgGFjyLVGO4ThQlnLhYGRYBTGglqELENg=
Received: by 10.100.107.17 with SMTP id f17mr2471618anc.51.1234515281859;
        Fri, 13 Feb 2009 00:54:41 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b29sm918666ana.11.2009.02.13.00.54.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 00:54:41 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.209.g7c178
In-Reply-To: <1234515275-91263-2-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109730>

Moved some identical lines of code into their own function in
preparation for adding additional functionality which will use this
function as well.

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
1.6.2.rc0.209.g7c178
