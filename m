From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 2/2] builtin-remote: make rm operation safer in mirrored repository
Date: Tue,  3 Feb 2009 12:51:13 -0500
Message-ID: <1233683473-87893-2-git-send-email-jaysoffian@gmail.com>
References: <1233683473-87893-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 18:52:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUPS6-00053L-RO
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 18:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbZBCRvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 12:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753051AbZBCRvV
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 12:51:21 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:37381 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbZBCRvU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 12:51:20 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1168459qwe.37
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 09:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=OryLzA3NLkp1I0RnuJ6ZM5RlpRo7x80jWSmCnHQ2HQg=;
        b=MVx6JbmhizVZW1CggmXtACU1Y8g5nzW7UgNprsd4kZyXwH2/d37UXrxJq8BNeqb9x2
         VsbTGH4nb0vINviKdvG/WIKXFfcA+2oo7cId8e5iUR38gWj2wx/i0Ub1T9rIQx4odn/u
         DobEUD1cVyGdvHBYkPu4hPmsOE5FS0Zv+viGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uFP/DtyI/Ivqv166sH5di5Izes7WaNSUTCe7NlP+voydiAKDas1O1eXODFBb0fcBvg
         rNGrV0rgAwmvT52JoBP2y4WhajrGRvs+ewCAmr+tuXbWK1uwgN7GStdgEWI5AooCVbPw
         gpHdNP2rCOD0z2ohnoK7dpWB+nfdObR2luaZk=
Received: by 10.214.150.9 with SMTP id x9mr4417622qad.139.1233683478814;
        Tue, 03 Feb 2009 09:51:18 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 5sm3106920qwg.45.2009.02.03.09.51.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 09:51:18 -0800 (PST)
X-Mailer: git-send-email 1.6.1.2.311.g2d7f3
In-Reply-To: <1233683473-87893-1-git-send-email-jaysoffian@gmail.com>
In-Reply-To: <76718490902030638y36299191i1fcc2ab8646b9593@mail.gmail.com>
References: <76718490902030638y36299191i1fcc2ab8646b9593@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108229>

"git remote rm <repo>" is happy to remove non-remote branches (and their
reflogs). This may be okay if the repository truely is a mirror, but if the
user had done "git remote add --mirror <repo>" by accident and was just
undoing their mistake, then they are left in a situation that is difficult to
recover from.

After this commit, "git remote rm" skips over non-remote branches and instead
advises the user on how to remove such branches using "git branch -d", which
itself has nice safety checks wrt to branch removal lacking from "git remote
rm".

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---

On Tue, Feb 3, 2009 at 2:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>> However, I have one small nit. The output produces long lines with a lot
>> of repeated text (assuming you have multiple matched branches, which is
>> likely if you have a mirrored setup). So maybe it would be nicer to have
>> something like:
>>
>>   warning: non-remote branches were not removed; you can delete them with:
>>           git branch -d master
>>           git branch -d next
>>           git branch -d topic
>>
>> which is a little more obvious (to me, anyway), and allows you to cut
>> and paste if you really did want to delete them.
>
> Thanks for a review, and I actually shared that exact nit when I first
> read the patch.  It would be a very good change to collect them in a list
> and show a single warning at the end (I do not have particular preference
> about the cut & paste-ability either way myself).

So much work for what seemed such a minor change. :) I hope this version is
well-polished enough.

 builtin-remote.c  |   27 +++++++++++++++++++++++++--
 t/t5505-remote.sh |   26 ++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 21885fb..ae1eed4 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -298,7 +298,7 @@ static int add_known_remote(struct remote *remote, void *cb_data)
 
 struct branches_for_remote {
 	struct remote *remote;
-	struct string_list *branches;
+	struct string_list *branches, *skipped;
 	struct known_remotes *keep;
 };
 
@@ -323,6 +323,14 @@ static int add_branch_for_removal(const char *refname,
 			return 0;
 	}
 
+	/* don't delete non-remote branches */
+	if (prefixcmp(refname, "refs/remotes")) {
+		if (!prefixcmp(refname, "refs/heads/"))
+			string_list_append(abbrev_branch(refname),
+					   branches->skipped);
+		return 0;
+	}
+
 	/* make sure that symrefs are deleted */
 	if (flags & REF_ISSYMREF)
 		return unlink(git_path("%s", refname));
@@ -542,7 +550,10 @@ static int rm(int argc, const char **argv)
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
@@ -590,6 +601,18 @@ static int rm(int argc, const char **argv)
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
1.6.1.2.311.g2d7f3
