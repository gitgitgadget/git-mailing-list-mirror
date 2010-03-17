From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/16] revert_or_cherry_pick(): get oneline_body from
 get_oneline()
Date: Wed, 17 Mar 2010 07:15:46 -0500
Message-ID: <20100317121546.GK25641@progeny.tock>
References: <20100317113655.GA25470@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 13:15:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrs9u-00039R-P2
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 13:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711Ab0CQMPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 08:15:25 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65468 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752Ab0CQMPW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 08:15:22 -0400
Received: by pwi1 with SMTP id 1so661102pwi.19
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 05:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=prG6SddOZgFcpx9AJlBXe7t+to8gKB5QPAZR3tZGWXU=;
        b=GCv/cj07CcbGgXq9LOrVmO18QaNF/vfJlB3oA4SyvoYGmfARWEd12mX4M8SU5meskh
         DGIleREymMUC5xuApa0zbkqMLaVfJo3EWwtn0lL7ujAf+kg22YfmM+ihiCMBxCwfMM0M
         TIWpBmMjo+KR5clywNlrlO4h0H8CV1mAbs7VE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EWEx09BfhEE5cjs9hENsdOlDcDvk5F/2yyYgCfbeZv93jPOc1lB2gzdOrLnlxsJyQM
         VIK1nuXRKs90BnMCodNUmjrs7ty1ZnodXPfIIQ2gFdeBR9MdE7L34LI1ICdnMkaVOpZc
         C2i6iIkz48cHqnhScc5oxfjU9puxRXngrnW/U=
Received: by 10.114.248.3 with SMTP id v3mr578940wah.11.1268828121639;
        Wed, 17 Mar 2010 05:15:21 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm632791iwn.8.2010.03.17.05.15.20
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 05:15:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100317113655.GA25470@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142386>

Currently the one-line commit message for the cherry-picked commit
is found with strchr(get_oneline(), ' ').  That wastes a few CPU
cycles, and more importantly, it makes it difficult to tweak the
output from get_oneline() later.  Teach get_oneline() to store the
one-line commit message using a caller-supplied pointer to avoid these
problems.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Maybe the next few patches should be squashed.  They are separated one
commit per idea, but they affect the same code.

 builtin/revert.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index eff5268..4b2042f 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -73,7 +73,7 @@ static void parse_args(int argc, const char **argv)
 		exit(1);
 }
 
-static char *get_oneline(const char *message)
+static char *get_oneline(const char *message, char **body)
 {
 	char *result;
 	const char *p = message, *abbrev, *eol;
@@ -99,6 +99,7 @@ static char *get_oneline(const char *message)
 	memcpy(result + abbrev_len, "... ", 4);
 	memcpy(result + abbrev_len + 4, p, oneline_len);
 	result[abbrev_len + 4 + oneline_len] = '\0';
+	*body = result + abbrev_len + 4;
 	return result;
 }
 
@@ -249,7 +250,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
 	int i, index_fd, clean;
-	char *oneline, *reencoded_message = NULL;
+	char *oneline, *oneline_body, *reencoded_message = NULL;
 	const char *message, *encoding;
 	char *defmsg = git_pathdup("MERGE_MSG");
 	struct merge_options o;
@@ -341,15 +342,13 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 					git_commit_encoding, encoding)))
 		message = reencoded_message;
 
-	oneline = get_oneline(message);
+	oneline = get_oneline(message, &oneline_body);
 
 	if (action == REVERT) {
-		char *oneline_body = strchr(oneline, ' ');
-
 		base = commit;
 		next = parent;
 		add_to_msg("Revert \"");
-		add_to_msg(oneline_body + 1);
+		add_to_msg(oneline_body);
 		add_to_msg("\"\n\nThis reverts commit ");
 		add_to_msg(sha1_to_hex(commit->object.sha1));
 
-- 
1.7.0
