Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF80262A7
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 10:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A2493
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 03:29:36 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 2EED824125;
	Wed, 25 Oct 2023 06:29:33 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qvb8m-2m4-00; Wed, 25 Oct 2023 12:29:32 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Christian Couder <christian.couder@gmail.com>,
	Charvi Mendiratta <charvi077@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH v3] git-rebase.txt: rewrite docu for fixup/squash (again)
Date: Wed, 25 Oct 2023 12:29:32 +0200
Message-ID: <20231025102932.1202299-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.42.0.419.g70bf8a5751
In-Reply-To: <20231023130016.1093356-1-oswald.buddenhagen@gmx.de>
References: <20231023130016.1093356-1-oswald.buddenhagen@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a clear top-down structure which makes it hopefully unambiguous
what happens when.

The behavior in the presence of multiple "fixup -c" is somewhat
questionable, as arguably it would be better to complain about it rather
than letting the last instance win. But for the time being we document
the status quo, with a note that it is not guaranteed. Note that
actually changing it would require --autosquash eliding the superseded
uses.

Also emphasize that the author info of the first commit is preserved
even in the presence of "fixup -c", as this diverges from "git commit
-c"'s behavior. New options matching the latter should be introduced for
completeness.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
v3:
- adjust to reality, and elaborate in the commit message why it's
  arguably somewhat suboptimal

i deliberated the 'command "pick"' word order swap suggested by marc,
but while it improves things locally, it somehow doesn't flow with the
"redundancy-reduced" last part of the sentence.

v2:
- slight adjustments inspired by marc. however, i left most things
  unchanged or even went in the opposite direction, because i assume the
  readers to be sufficiently context-sensitive, and the objective is
  merely to be not actively confusing. adding redundancy in the name of
  clarity would just make the text stylistically inferior and arguably
  harder to read.

Cc: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>
Cc: Christian Couder <christian.couder@gmail.com>
Cc: Charvi Mendiratta <charvi077@gmail.com>
Cc: Marc Branchaud <marcnarc@xiplink.com>
---
 Documentation/git-rebase.txt | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index e7b39ad244..578d1d34a6 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -890,20 +890,22 @@ command "pick" with the command "reword".
 To drop a commit, replace the command "pick" with "drop", or just
 delete the matching line.
 
-If you want to fold two or more commits into one, replace the command
-"pick" for the second and subsequent commits with "squash" or "fixup".
-If the commits had different authors, the folded commit will be
-attributed to the author of the first commit.  The suggested commit
-message for the folded commit is the concatenation of the first
-commit's message with those identified by "squash" commands, omitting the
-messages of commits identified by "fixup" commands, unless "fixup -c"
-is used.  In that case the suggested commit message is only the message
-of the "fixup -c" commit, and an editor is opened allowing you to edit
-the message.  The contents (patch) of the "fixup -c" commit are still
-incorporated into the folded commit. If there is more than one "fixup -c"
-commit, the message from the final one is used.  You can also use
-"fixup -C" to get the same behavior as "fixup -c" except without opening
-an editor.
+If you want to fold two or more commits into one (that is, to combine
+their contents/patches), replace the command "pick" for the second and
+subsequent commits with "squash" or "fixup".
+The commit message for the folded commit is the concatenation of the
+message of the first commit with those of commits identified by "squash"
+commands, omitting those of commits identified by "fixup" commands,
+unless "fixup -c" is used. In the latter case, the message is obtained
+only from the "fixup -c" commit (if multiple are present, the last one
+takes precedence, but this should not be relied upon).
+If the resulting commit message is a concatenation of multiple messages,
+an editor is opened allowing you to edit it. This is also the case for a
+message obtained via "fixup -c", while using "fixup -C" instead skips
+the editor; this is analogous to the behavior of `git commit`.
+The author information (including date/timestamp) always comes from
+the first commit; this is the case even if "fixup -c/-C" is used,
+contrary to what `git commit` does.
 
 `git rebase` will stop when "pick" has been replaced with "edit" or
 when a command fails due to merge errors. When you are done editing
-- 
2.42.0.419.g70bf8a5751

