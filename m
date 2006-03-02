From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Prevent --index-info from ignoring -z.
Date: Thu, 2 Mar 2006 12:21:33 -0500
Message-ID: <20060302172133.GA19111@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Mar 02 18:22:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FErUi-0005Eq-Ph
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 18:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbWCBRVh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 12:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbWCBRVh
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 12:21:37 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:28369 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751589AbWCBRVh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 12:21:37 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FErUX-0002Gb-Rn
	for git@vger.kernel.org; Thu, 02 Mar 2006 12:21:29 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9D68A20FBBF; Thu,  2 Mar 2006 12:21:33 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17097>

If git-update-index --index-info -z is used only the first
record given to the process will actually be updated as
the -z option is ignored until after all index records
have been read and processed.  This meant that multiple
null terminated records were seen as a single record which
was lacking a trailing LF, however since the first record
ended in a null the C string handling functions ignored the
trailing garbage.  So --index-info should be required to be
the last command line option, much as --stdin is required
to be the last command line option.  Because --index-info
implies --stdin this isn't an issue as the user shouldn't
be passing --stdin when also passing --index-info.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---

 update-index.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

base eab8a06b5f0937ead199cbd35950a213486f34eb
last 77565623e6c7a02ead3d080816c761da85421781
diff --git a/update-index.c b/update-index.c
index ce1db38..797245a 100644
--- a/update-index.c
+++ b/update-index.c
@@ -577,9 +577,11 @@ int main(int argc, const char **argv)
 				break;
 			}
 			if (!strcmp(path, "--index-info")) {
+				if (i != argc - 1)
+					die("--index-info must be at the end");
 				allow_add = allow_replace = allow_remove = 1;
 				read_index_info(line_termination);
-				continue;
+				break;
 			}
 			if (!strcmp(path, "--ignore-missing")) {
 				not_new = 1;
-- 
1.2.3.g5f0e
