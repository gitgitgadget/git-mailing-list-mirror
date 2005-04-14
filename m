From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] git: report parse_commit() errors in rev-tree.c
Date: Thu, 14 Apr 2005 14:05:16 +0200
Message-ID: <20050414120516.GC14065@elte.hu>
References: <20050414112638.GA12593@elte.hu> <20050414113527.GA13790@elte.hu> <20050414115800.GB14065@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 14:03:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM337-0005Th-A5
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 14:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVDNMFi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 08:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVDNMFi
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 08:05:38 -0400
Received: from mx2.elte.hu ([157.181.151.9]:55427 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261482AbVDNMF3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 08:05:29 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 9CCC9319948;
	Thu, 14 Apr 2005 14:04:30 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 2475F1FC2; Thu, 14 Apr 2005 14:05:19 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050414115800.GB14065@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


make actual use of the parse_commit() return value and print a warning, 
instead of silently ignoring it. Should never trigger on a valid DB.

(alternatively we might use a die() in the sanity check place and could 
remove all the return code handling?)

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- rev-tree.c.orig
+++ rev-tree.c
@@ -64,6 +64,7 @@ static unsigned long parse_commit_date(c
 static int parse_commit(unsigned char *sha1)
 {
 	struct revision *rev = lookup_rev(sha1);
+	int ret = 0;
 
 	if (!(rev->flags & SEEN)) {
 		void *buffer, *bufptr;
@@ -81,13 +82,13 @@ static int parse_commit(unsigned char *s
 		bufptr += 46; /* "tree " + "hex sha1" + "\n" */
 		while (!memcmp(bufptr, "parent ", 7) && !get_sha1_hex(bufptr+7, parent)) {
 			add_relationship(rev, parent);
-			parse_commit(parent);
+			ret |= parse_commit(parent);
 			bufptr += 48;	/* "parent " + "hex sha1" + "\n" */
 		}
 		rev->date = parse_commit_date(bufptr);
 		free(buffer);
 	}
-	return 0;	
+	return ret;
 }
 
 static void read_cache_file(const char *path)
@@ -208,7 +209,8 @@ int main(int argc, char **argv)
 		}
 		if (nr >= MAX_COMMITS || get_sha1_hex(arg, sha1[nr]))
 			usage("rev-tree [--edges] [--cache <cache-file>] <commit-id> [<commit-id>]");
-		parse_commit(sha1[nr]);
+		if (parse_commit(sha1[nr]))
+			fprintf(stderr, "warning: rev-tree: bad commit!\n");
 		nr++;
 	}
 
