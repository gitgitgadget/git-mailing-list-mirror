From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/8] cherry: split off function to print output lines
Date: Wed, 16 Mar 2011 02:12:48 -0500
Message-ID: <20110316071248.GH5988@elie>
References: <20110316024959.GA24932@elie>
 <20110316065256.GA5988@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 08:12:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzkug-0000mD-JV
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 08:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970Ab1CPHM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 03:12:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48938 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933Ab1CPHMx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 03:12:53 -0400
Received: by gyf1 with SMTP id 1so539184gyf.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 00:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=rQDk/enHoLvlg0RiPX5USxR0MzUJc11IweGZS3H1gvA=;
        b=MKxAz+hRB8SONEkq1DFIJl5/legcjjIYr470Yxjnw/vp5NCzVwGqdjM7IeBJKq4+25
         EbhS2OKj2kh0eRKE9/Sg0b2oFrzxHWOX7hZGTdXV0+fbj2xEF8NwOBf+zxL9hPKFmfjZ
         HlfmEvkCe5/XV3MOlL4w1ggZ58rezdIBgLuWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ptiv5ovM6eohQRCSirYzzCdfCjUSjJ1kkgrOUz95xwhWE0g6c4G71wjkmOJN60boWL
         wVotMym0CdScgOA2l6+i4Ol5Hkldp8SFGyIz6iXWgpm7Q5HxN/6y7mwHaeC/dbuC6Wae
         zB3MRZNV2p7tAT5h1bS6OCX0mWsfup4PH3+3w=
Received: by 10.150.72.32 with SMTP id u32mr1005815yba.69.1300259572767;
        Wed, 16 Mar 2011 00:12:52 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id q18sm3374703ybk.11.2011.03.16.00.12.51
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 00:12:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316065256.GA5988@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169115>

Readers uninterested in the details of "git cherry"'s output format
can see

	print_commit('-', commit, verbose, abbrev);

and ignore the details.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/log.c |   34 ++++++++++++++++++----------------
 1 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index f5ed690..99e33b3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1352,6 +1352,23 @@ static const char * const cherry_usage[] = {
 	NULL
 };
 
+static void print_commit(char sign, struct commit *commit, int verbose,
+			 int abbrev)
+{
+	if (!verbose) {
+		printf("%c %s\n", sign,
+		       find_unique_abbrev(commit->object.sha1, abbrev));
+	} else {
+		struct strbuf buf = STRBUF_INIT;
+		struct pretty_print_context ctx = {0};
+		pretty_print_commit(CMIT_FMT_ONELINE, commit, &buf, &ctx);
+		printf("%c %s %s\n", sign,
+		       find_unique_abbrev(commit->object.sha1, abbrev),
+		       buf.buf);
+		strbuf_release(&buf);
+	}
+}
+
 int cmd_cherry(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -1436,22 +1453,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		commit = list->item;
 		if (has_commit_patch_id(commit, &ids))
 			sign = '-';
-
-		if (verbose) {
-			struct strbuf buf = STRBUF_INIT;
-			struct pretty_print_context ctx = {0};
-			pretty_print_commit(CMIT_FMT_ONELINE, commit,
-					    &buf, &ctx);
-			printf("%c %s %s\n", sign,
-			       find_unique_abbrev(commit->object.sha1, abbrev),
-			       buf.buf);
-			strbuf_release(&buf);
-		}
-		else {
-			printf("%c %s\n", sign,
-			       find_unique_abbrev(commit->object.sha1, abbrev));
-		}
-
+		print_commit(sign, commit, verbose, abbrev);
 		list = list->next;
 	}
 
-- 
1.7.4.1
