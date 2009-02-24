From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 02/23] builtin-remote: move duplicated cleanup code its own function
Date: Tue, 24 Feb 2009 04:50:50 -0500
Message-ID: <84dd248aa6381f1f0a533203fdb0614a90460635.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:52:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbty4-0001hq-HN
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886AbZBXJvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755866AbZBXJvY
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:51:24 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:21822 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755769AbZBXJvV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:51:21 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1005599yxm.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=HPso39GyzJEFjcmes83CU6jJJzP1Jnn8+8K2VCuM3pQ=;
        b=LibMXYbqJUMrWmFaxwaGyxjbfdn1aj4VCsHJrfG/8sSJLGiEwb/hl3ovqXqrFL3WyM
         hgRpK0qGDkexqvZToCHRZaEqgXKZ+weehFaMsg5theMEfuo8SH6tjmVpALf+1G6mlldH
         kQkm06q9J+9GXoAJspspUsnZ5cys1cOghonh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JvUXskvA98cbkhYjlucGGSLvDjoC+VDRY++TlsfhfvgLMmoSyTdDgkwPUROH5CUSM+
         /D4/rvAm5gkzNcW6AbAsNlcg/ubzpe6Lq6mDL1AA6tNm58putP/CuVgzeqyFpKY4ZQW1
         rsutUR1wLcFvtRby+MoKdEEzsuh6legl1jA5s=
Received: by 10.100.5.16 with SMTP id 16mr5405720ane.146.1235469080080;
        Tue, 24 Feb 2009 01:51:20 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d29sm9072446and.54.2009.02.24.01.51.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:51:19 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111252>

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
1.6.2.rc1.291.g83eb
