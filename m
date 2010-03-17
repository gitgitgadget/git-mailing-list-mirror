From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 14/16] revert: clarify label on conflict hunks
Date: Wed, 17 Mar 2010 07:19:38 -0500
Message-ID: <20100317121938.GN25641@progeny.tock>
References: <20100317113655.GA25470@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 13:19:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrsDl-0005MD-Rn
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 13:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783Ab0CQMTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 08:19:15 -0400
Received: from mail-px0-f198.google.com ([209.85.216.198]:35862 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754694Ab0CQMTO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 08:19:14 -0400
Received: by pxi36 with SMTP id 36so452244pxi.21
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+r1GxSSBh4UiKE6j7S6b64SzR4/zr39XBJo4pVYKw2Q=;
        b=QDgwjyuCAggdFVC2+y5qDXNvkSXgHjk6Y9LPaKqAoqxCbfPlQRfnkOM5zYPgyS2DWO
         kgj5QayK1bpGYpAlyI2aJKzSmdPaNNhQtROEVNtwa9LhFqPxvU7/ZqdWmAuerGL1h8W8
         yXnVYs8O1diiV7RyuSc0iWTacrz5ZLwx4Y1RU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jkQuqPZ6f3BvD71SFhIws5/MZqEc71gSaj0d98LM6qNAyMSbKwR92ebQWx8Mgo2KzW
         G2FzS+ioFMpOX2n1JUFeSDDsWbN4XuYdOuANcsg3W26KzaD8e9mAPLdYESMCcmSrK22/
         JHwOTrMqOsNgCGt33Ua3BvqTDH2sMqyY7f7sk=
Received: by 10.115.51.14 with SMTP id d14mr555236wak.156.1268828353675;
        Wed, 17 Mar 2010 05:19:13 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm6344215iwn.15.2010.03.17.05.19.12
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 05:19:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100317113655.GA25470@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142389>

When reverting a commit, the commit being merged is not the commit
to revert itself but its parent.  Clarify the text in conflict
hunks to explain this.

Example:

	<<<<<<< HEAD
	Something old.
	Something new.
	Something blue.
	=======
	Something old.
	Something rotten.
	Something blue.
	>>>>>>> parent of ac789a9... Remove rotten line

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
New patch: a small fix.

 builtin/revert.c                |   14 +++++++++-----
 t/t3507-cherry-pick-conflict.sh |    4 ++--
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 6a47655..56f2947 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -73,11 +73,11 @@ static void parse_args(int argc, const char **argv)
 		exit(1);
 }
 
-static char *get_oneline(const char *message, char **body)
+static char *get_oneline(const char *message, int revert, char **body)
 {
 	char *result, *q;
-	const char *p = message, *abbrev, *eol;
-	int abbrev_len, oneline_len;
+	const char *p = message, *prefix, *abbrev, *eol;
+	int prefix_len, abbrev_len, oneline_len;
 
 	if (!p)
 		die ("Could not read commit message of %s",
@@ -91,10 +91,14 @@ static char *get_oneline(const char *message, char **body)
 			; /* do nothing */
 	} else
 		eol = p;
+	prefix = revert ? "parent of " : "";
+	prefix_len = revert ? strlen("parent of ") : 0;
 	abbrev = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
 	abbrev_len = strlen(abbrev);
 	oneline_len = eol - p;
-	q = result = xmalloc(abbrev_len + strlen("... ") + oneline_len + 1);
+	q = result = xmalloc(prefix_len + abbrev_len +
+			     strlen("... ") + oneline_len + 1);
+	q = mempcpy(q, prefix, prefix_len);
 	q = mempcpy(q, abbrev, abbrev_len);
 	*body = q = mempcpy(q, "... ", strlen("... "));
 	q = mempcpy(q, p, oneline_len);
@@ -341,7 +345,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 					git_commit_encoding, encoding)))
 		message = reencoded_message;
 
-	oneline = get_oneline(message, &oneline_body);
+	oneline = get_oneline(message, action == REVERT, &oneline_body);
 
 	if (action == REVERT) {
 		base = commit;
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index e856356..6a20817 100644
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -138,7 +138,7 @@ test_expect_success 'revert also handles conflicts sanely' '
 	a
 	=======
 	b
-	>>>>>>> objid picked
+	>>>>>>> parent of objid picked
 	EOF
 	{
 		git checkout picked -- foo &&
@@ -183,7 +183,7 @@ test_expect_success 'revert conflict, diff3 -m style' '
 	c
 	=======
 	b
-	>>>>>>> objid picked
+	>>>>>>> parent of objid picked
 	EOF
 
 	git update-index --refresh &&
-- 
1.7.0
