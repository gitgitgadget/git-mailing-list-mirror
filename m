X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Do not ignore hidden refs
Date: Sat, 18 Nov 2006 05:11:37 +0100
Message-ID: <20061118041137.6064.75827.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Sat, 18 Nov 2006 04:11:52 +0000 (UTC)
Cc: <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31751>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlHYR-0005j8-27 for gcvg-git@gmane.org; Sat, 18 Nov
 2006 05:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755943AbWKRELj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 23:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755864AbWKRELj
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 23:11:39 -0500
Received: from w241.dkm.cz ([62.24.88.241]:2266 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1755943AbWKRELj (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 23:11:39 -0500
Received: (qmail 6075 invoked from network); 18 Nov 2006 05:11:37 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1) by localhost
 with SMTP; 18 Nov 2006 05:11:37 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Some of the ref manipulation tools (git-for-each-ref and git-show-ref in
particular) would not handle hidden (~ /^\./) refs. This may be an
acceptable or possibly even desirable behaviour for the ref walkers and
repackers, but git-show-ref hiddenrefname must work.

This makes Git not ignore hidden refs at all. I'm not opposed to making
some particular parts of the ref interface to continue to ignore hidden
refs, but the restriction cannot be so deep.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 refs.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index f003a0b..06fa5c2 100644
--- a/refs.c
+++ b/refs.c
@@ -141,7 +141,8 @@ static struct ref_list *get_ref_dir(cons
 			int flag;
 			int namelen;
 
-			if (de->d_name[0] == '.')
+			if (de->d_name[0] == '.' && (de->d_name[1] == '\0'
+			    || (de->d_name[1] == '.' && de->d_name[2] == '\0')))
 				continue;
 			namelen = strlen(de->d_name);
