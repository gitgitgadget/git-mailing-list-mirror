From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 5/5] worktree: add 'list' command
Date: Fri, 02 Oct 2015 13:33:22 -0700
Message-ID: <xmqqtwq93t9p.fsf@gitster.mtv.corp.google.com>
References: <1443786935-81131-1-git-send-email-rappazzo@gmail.com>
	<1443786935-81131-6-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sunshine@sunshineco.com, dturner@twopensource.com,
	git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 22:33:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi71K-0006pH-IR
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 22:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbbJBUdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 16:33:25 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35282 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbbJBUdY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 16:33:24 -0400
Received: by pacfv12 with SMTP id fv12so117830067pac.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 13:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=WDQrk+/rPz9HUlDiVDmmwRM8qMZ76oIXCy0e8sa+QzU=;
        b=LefYCHz0mP1mtcnGulexaQuMWVt02EyHI0QaZiH/e6hnhYVofCzZSuINazgNdCd8Y3
         0SBJb1G465DWkyy6grTLc0BUnDP5jmj+R/1VcoZMMi7OXw6lvWU1JEr/8OBu8qEzZgbh
         bPexSybJIozLnlpGGt+phbjOFDY2sJnR3qIcMZ01T68TJFjF+tYuay1apItGTcZ/1xov
         BcCYfJ+LnvSfJXuH15pxF3JVp3upd98LWBoceknYzEBv2G1Z3w2aX7IpA+ohbjoB7qk6
         s4nQ4crd+VagA3MoeNPTqiVrkkiwivo5KM4+iyW9MkDa21gnGwFeKujp3z9aE0Z5/cCX
         Mrww==
X-Received: by 10.68.197.7 with SMTP id iq7mr22444767pbc.108.1443818003947;
        Fri, 02 Oct 2015 13:33:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:5831:5c0e:ce5f:86ea])
        by smtp.gmail.com with ESMTPSA id tb9sm13614860pab.13.2015.10.02.13.33.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 02 Oct 2015 13:33:22 -0700 (PDT)
In-Reply-To: <1443786935-81131-6-git-send-email-rappazzo@gmail.com> (Michael
	Rappazzo's message of "Fri, 2 Oct 2015 07:55:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278945>

Michael Rappazzo <rappazzo@gmail.com> writes:

> +		if (!porcelain) {
> +			for (i = 0; worktrees[i]; i++) {
> +				int path_len = strlen(worktrees[i]->path);
> +				if (path_len > path_maxlen)
> +					path_maxlen = path_len;
> +				int sha1_len = strlen(
> +						find_unique_abbrev(worktrees[i]->head_sha1, DEFAULT_ABBREV));

decl-after-stmt.

If I were doing this, I'd probably do something like the attached
using a small helper function to make the primary logic easier to
see.

The first hunk below is unrelated but was to fix an obvious style
breakage I happened to have noticed nearby.

Thanks.


 builtin/worktree.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 268f9bf..3be8ec8 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -376,8 +376,8 @@ static void show_worktree_porcelain(struct worktree *worktree)
 	}
 	printf("\n");
 }
-static void show_worktree(
-		struct worktree *worktree, int path_maxlen, int abbrev_len)
+
+static void show_worktree(struct worktree *worktree, int path_maxlen, int abbrev_len)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int cur_path_len = strlen(worktree->path);
@@ -399,6 +399,22 @@ static void show_worktree(
 	strbuf_release(&sb);
 }
 
+static void measure_widths(struct worktree **wt, int *abbrev, int *maxlen)
+{
+	int i;
+
+	for (i = 0; wt[i]; i++) {
+		int sha1_len;
+		int path_len = strlen(wt[i]->path);
+
+		if (path_len > *maxlen)
+			*maxlen = path_len;
+		sha1_len = strlen(find_unique_abbrev(wt[i]->head_sha1, *abbrev));
+		if (sha1_len > *abbrev)
+			*abbrev = sha1_len;
+	}
+}
+
 static int list(int ac, const char **av, const char *prefix)
 {
 	int porcelain = 0;
@@ -413,21 +429,11 @@ static int list(int ac, const char **av, const char *prefix)
 		usage_with_options(worktree_usage, options);
 	else {
 		struct worktree **worktrees = get_worktrees();
-		int path_maxlen = 0;
-		int abbrev = 0;
-		int i;
-
-		if (!porcelain) {
-			for (i = 0; worktrees[i]; i++) {
-				int path_len = strlen(worktrees[i]->path);
-				if (path_len > path_maxlen)
-					path_maxlen = path_len;
-				int sha1_len = strlen(
-						find_unique_abbrev(worktrees[i]->head_sha1, DEFAULT_ABBREV));
-				if (sha1_len > abbrev)
-					abbrev = sha1_len;
-			}
-		}
+		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
+
+		if (!porcelain)
+			measure_widths(worktrees, &abbrev, &path_maxlen);
+
 		for (i = 0; worktrees[i]; i++) {
 			if (porcelain)
 				show_worktree_porcelain(worktrees[i]);
