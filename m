From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/7] log --decorate: do not leak "commit" color into the next item
Date: Wed,  4 Mar 2015 13:33:23 -0800
Message-ID: <1425504803-16039-8-git-send-email-gitster@pobox.com>
References: <xmqqpp9628tl.fsf@gitster.dls.corp.google.com>
 <1425504803-16039-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 22:34:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTGvW-0007RC-Sr
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 22:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbbCDVdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 16:33:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752173AbbCDVdw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 16:33:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F3C43C7B1;
	Wed,  4 Mar 2015 16:33:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=99X/
	C2Wgv1kEjDAag2dqT5G+9fM=; b=uENhO8F+vAr7yRYZM9W1urvjYFUzYdVADzcp
	Udv1M/d5m9BuODvZa8VoWeTYJvacuIEvxktBLWkzsdHli4KY1UTzxd6uyS8vVq2s
	+Nz2mpcNGpm0fUfYRfsihUYCWRtox/Zmtae4DJZOvJmUk0xrfRZ6doa8cJi9f46r
	qvMwZHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=UlxvW0
	SdW+4Bhr0mJ3xWml3NbTDXyl3DLKKVVPKynsYz2gitVFoq1eN4+wxukqiYgemlO+
	pJYBjYA82oTvRSi/yJSqBPWbUvQzb/KIMh0nS2X65iLA1r5584QO81MlLNzjCdkx
	5isjAVcBgS1JtDgkhsUGufkRP4ki/LgaMT25s=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 281233C7B0;
	Wed,  4 Mar 2015 16:33:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9889F3C797;
	Wed,  4 Mar 2015 16:33:44 -0500 (EST)
X-Mailer: git-send-email 2.3.1-318-g5233f23
In-Reply-To: <1425504803-16039-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 227D0CFE-C2B6-11E4-8973-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264788>

In "git log --decorate", you would see the commit header like this:

    commit ... (HEAD, jc/decorate-leaky-separator-color)

where "commit ... (" is painted in color.diff.commit, "HEAD" in
color.decorate.head, ", " in color.diff.commit, the branch name in
color.decorate.branch and then closing ")" in color.diff.commit.

If you wanted to paint the HEAD and local branch name in the same
color as the body text (perhaps because cyan and green are too faint
on a black-on-white terminal to be readable), you would not want to
have to say

    [color "decorate"]
        head = black
        branch = black

because that you would not be able to reuse same configuration on a
white-on-black terminal.  You would naively expect

    [color "decorate"]
        head = normal
	branch = normal

to work, but unfortunately it does not.  It paints the string "HEAD"
and the branch name in the same color as the opening parenthesis or
comma between the decoration elements.  This is because the code
forgets to reset the color after printing the "prefix" in its own
color.

It theoretically is possible that some people were expecting and
relying on that the attribute set as the "diff.commit" color, which
is used to draw these opening parenthesis and inter-item comma, is
inherited by the drawing of branch names, but it is not how the
coloring works everywhere else.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt         |  7 +++++++
 log-tree.c                       |  1 +
 t/t4207-log-decoration-colors.sh | 16 ++++++++--------
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f1cf571..6d65033 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -155,6 +155,13 @@ color::
        `reverse`.  The first color given is the foreground; the
        second is the background.  The position of the attribute, if
        any, doesn't matter.
++
+The attributes are meant to be reset at the beginning of each item
+in the colored output, so setting color.decorate.branch to `black`
+will paint that branch name in a plain `black`, even if the previous
+thing on the same output line (e.g. opening parenthesis before the
+list of branch names in `log --decorate` output) is set to be
+painted with `bold` or some other attribute.
 
 
 Variables
diff --git a/log-tree.c b/log-tree.c
index 1982631..11676d5 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -200,6 +200,7 @@ void format_decorations(struct strbuf *sb,
 	while (decoration) {
 		strbuf_addstr(sb, color_commit);
 		strbuf_addstr(sb, prefix);
+		strbuf_addstr(sb, color_reset);
 		strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
 		if (decoration->type == DECORATION_REF_TAG)
 			strbuf_addstr(sb, "tag: ");
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index 925f577..6b8ad4f 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -44,15 +44,15 @@ test_expect_success setup '
 '
 
 cat >expected <<EOF
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_HEAD}HEAD${c_reset}${c_commit},\
- ${c_tag}tag: v1.0${c_reset}${c_commit},\
- ${c_tag}tag: B${c_reset}${c_commit},\
- ${c_branch}master${c_reset}${c_commit})${c_reset} B
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_tag}tag: A1${c_reset}${c_commit},\
- ${c_remoteBranch}other/master${c_reset}${c_commit})${c_reset} A1
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_stash}refs/stash${c_reset}${c_commit})${c_reset}\
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}${c_commit},\
+ ${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit},\
+ ${c_reset}${c_tag}tag: B${c_reset}${c_commit},\
+ ${c_reset}${c_branch}master${c_reset}${c_commit})${c_reset} B
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A1${c_reset}${c_commit},\
+ ${c_reset}${c_remoteBranch}other/master${c_reset}${c_commit})${c_reset} A1
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_stash}refs/stash${c_reset}${c_commit})${c_reset}\
  On master: Changes to A.t
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
 EOF
 
 # We want log to show all, but the second parent to refs/stash is irrelevant
-- 
2.3.1-316-g7c93423
