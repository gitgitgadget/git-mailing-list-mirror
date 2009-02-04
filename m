From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] builtin-remote: make rm operation safer in mirrored repository
Date: Wed,  4 Feb 2009 11:06:07 -0500
Message-ID: <1233763567-6155-1-git-send-email-jaysoffian@gmail.com>
References: <76718490902040756m1f5c6f37o45865c51ad1a2e6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 17:09:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUkHv-0007oQ-35
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 17:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554AbZBDQGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 11:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753926AbZBDQGS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 11:06:18 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:37460 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbZBDQGR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 11:06:17 -0500
Received: by qyk4 with SMTP id 4so3455535qyk.13
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 08:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=zAnzSf9gf1GwtrVmqBoIszYLLziPG9doAKjeUAKJ/qw=;
        b=U9Cbz2zSGdQq9ucrqBDNWxT5xuoHOLWSuV9yUyfyuA1FiuMWy1H0cP4ncgBrPjjtNv
         boQluLLONK0nYc0cJTcbyrmmnZDbei/Rh30gJNo0TsY3cWQj/xKO0x9/pLpuoJaAudGp
         rBCxYpVvkWo3i4ctWJp12YGUb9tzim0GmxHiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Ps6H/RsBFNyPY6uCXBCjnjk/Wdymk2E/d4PgRBzpU1FpLNet69ynqeLUwLQKqMwsCn
         +aDaLmbi52v+prOIsJdGEGgK46MwUe9RcnCQQwKEYCVrsEmWDufnzf27FjFrQuYBwB+w
         NIWFrTa/IMDQioXyw7gRBGaDK/F7qU3SvbiCo=
Received: by 10.214.242.13 with SMTP id p13mr10713994qah.75.1233763570553;
        Wed, 04 Feb 2009 08:06:10 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 7sm234795qwf.9.2009.02.04.08.06.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 08:06:09 -0800 (PST)
X-Mailer: git-send-email 1.6.1.2.322.g9a647
In-Reply-To: <76718490902040756m1f5c6f37o45865c51ad1a2e6d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108387>

"git remote rm <repo>" is happy to remove non-remote refs (and their
reflogs in the case of branches). This may be okay if the repository truely is a mirror, but if the
user had done "git remote add --mirror <repo>" by accident and was just
undoing their mistake, then they are left in a situation that is difficult to
recover from.

After this commit, "git remote rm" skips over non-remote refs. The user is
advised on how remove branches using "git branch -d", which itself has nice
safety checks wrt to branch removal lacking from "git remote rm". Non-remote
non-branch refs are skipped silently.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
On Wed, Feb 4, 2009 at 10:56 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> In particular though, I noticed that w/o this check, I was emitting an
> incorrect message about anything under refs/tags. I thought about
> saying "and you can clean up these ignored tags like so", but that is
> likely to emit a huge number of messages, so I thought it best just to
> silently ignore non-remote non-branch refs. Perhaps I should better
> explain that in a code comment.

I think I made what's going on clearer, assuming this is what we want to do.
Slightly revised the commit message.

This thread is getting sotra long, so here's the gmane threaded view for
easier following:

http://thread.gmane.org/gmane.comp.version-control.git/107982/

 builtin-remote.c  |   29 +++++++++++++++++++++++++++--
 t/t5505-remote.sh |   26 ++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 21885fb..db18bcf 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -298,7 +298,7 @@ static int add_known_remote(struct remote *remote, void *cb_data)
 
 struct branches_for_remote {
 	struct remote *remote;
-	struct string_list *branches;
+	struct string_list *branches, *skipped;
 	struct known_remotes *keep;
 };
 
@@ -323,6 +323,16 @@ static int add_branch_for_removal(const char *refname,
 			return 0;
 	}
 
+	/* don't delete non-remote refs */
+	if (prefixcmp(refname, "refs/remotes")) {
+		/* advise user how to delete local branches */
+		if (!prefixcmp(refname, "refs/heads/"))
+			string_list_append(abbrev_branch(refname),
+					   branches->skipped);
+		/* silently skip over other non-remote refs */
+		return 0;
+	}
+
 	/* make sure that symrefs are deleted */
 	if (flags & REF_ISSYMREF)
 		return unlink(git_path("%s", refname));
@@ -542,7 +552,10 @@ static int rm(int argc, const char **argv)
 	struct strbuf buf = STRBUF_INIT;
 	struct known_remotes known_remotes = { NULL, NULL };
 	struct string_list branches = { NULL, 0, 0, 1 };
-	struct branches_for_remote cb_data = { NULL, &branches, &known_remotes };
+	struct string_list skipped = { NULL, 0, 0, 1 };
+	struct branches_for_remote cb_data = {
+		NULL, &branches, &skipped, &known_remotes
+	};
 	int i, result;
 
 	if (argc != 2)
@@ -590,6 +603,18 @@ static int rm(int argc, const char **argv)
 		result = remove_branches(&branches);
 	string_list_clear(&branches, 1);
 
+	if (skipped.nr) {
+		fprintf(stderr, skipped.nr == 1 ?
+			"Note: A non-remote branch was not removed; "
+			"to delete it, use:\n" :
+			"Note: Non-remote branches were not removed; "
+			"to delete them, use:\n");
+		for (i = 0; i < skipped.nr; i++)
+			fprintf(stderr, "  git branch -d %s\n",
+				skipped.items[i].string);
+	}
+	string_list_clear(&skipped, 0);
+
 	return result;
 }
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 1f59960..bc5b7ce 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -107,6 +107,32 @@ test_expect_success 'remove remote' '
 )
 '
 
+test_expect_success 'remove remote protects non-remote branches' '
+(
+	cd test &&
+	(cat >expect1 <<EOF
+Note: A non-remote branch was not removed; to delete it, use:
+  git branch -d master
+EOF
+    cat >expect2 <<EOF
+Note: Non-remote branches were not removed; to delete them, use:
+  git branch -d foobranch
+  git branch -d master
+EOF
+) &&
+	git tag footag
+	git config --add remote.oops.fetch "+refs/*:refs/*" &&
+	git remote rm oops 2>actual1 &&
+	git branch foobranch &&
+	git config --add remote.oops.fetch "+refs/*:refs/*" &&
+	git remote rm oops 2>actual2 &&
+	git branch -d foobranch &&
+	git tag -d footag &&
+	test_cmp expect1 actual1 &&
+	test_cmp expect2 actual2
+)
+'
+
 cat > test/expect << EOF
 * remote origin
   URL: $(pwd)/one
-- 
1.6.1.2.322.g9a647
