From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] ignore: info/exclude should trump core.excludesfile
Date: Wed, 22 Apr 2015 14:39:09 -0700
Message-ID: <xmqqvbgnderm.fsf@gitster.dls.corp.google.com>
References: <20150422150558.6326cb6152a306f028fb6ad3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yohei Endo <yoheie@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 23:39:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl2Mc-0001bx-NF
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 23:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757517AbbDVVjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 17:39:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751000AbbDVVjO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 17:39:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3140B4A6B2;
	Wed, 22 Apr 2015 17:39:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lGH7ZRgzHkG+wwqzPdt0nB5489Q=; b=LZm5yv
	1rlUS+EiWKGa7Gi7WtgdU6XGLsHL9I/20iuOtQtcuSwyy9MHH/2ePJIp5GrN40dJ
	vjSgYGqmXZrQwQCzTUQIXF2+Bz5rnqwq874g/JwxpXwtmMVsmIFFw3LRYg31Bwlc
	JTNCdEKCPZ1Hd5HV6lKUy/hbBpXaaqUhzOCFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LR+JoEhvQBI2SK47d3ndUNTfW3tkxmzM
	rRG2xCwIQaHHjpqdoWjeG9UT6r5Nsck0yyDP4zEUEfpfljgAX4WMJgEnkM7T6LLy
	CN4iPAGr60utIjrr5bpwjmtl4PfByNqE9Ap/TvIZZ+FQ4dZo2cSOgmzUkQK8qTCt
	xYDSbPXWPC0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 29A994A6B1;
	Wed, 22 Apr 2015 17:39:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B77B04A6AF;
	Wed, 22 Apr 2015 17:39:10 -0400 (EDT)
In-Reply-To: <20150422150558.6326cb6152a306f028fb6ad3@gmail.com> (Yohei Endo's
	message of "Wed, 22 Apr 2015 15:05:58 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 031D1108-E938-11E4-83CF-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267644>

$GIT_DIR/info/exclude and core.excludesfile (which falls back to
$XDG_HOME/git/ignore) are both ways to override the ignore pattern
lists given by the project in .gitignore files.  The former, which
is per-repository personal preference, should take precedence over
the latter, which is a personal preference default across different
repositories that are accessed from that machine.  The existing
documentation also agrees.

However, the precedence order was screwed up between these two from
the very beginning when 896bdfa2 (add: Support specifying an
excludes file with a configuration variable, 2007-02-27) introduced
core.excludesfile variable.

Noticed-by: Yohei Endo <yoheie@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is done on an old codebase and may not apply cleanly to more
   modern codebase easily.

 dir.c              | 10 +++++++---
 t/t0008-ignores.sh | 10 ++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 23b6de4..e67b6f9 100644
--- a/dir.c
+++ b/dir.c
@@ -1530,15 +1530,19 @@ void setup_standard_excludes(struct dir_struct *dir)
 	char *xdg_path;
 
 	dir->exclude_per_dir = ".gitignore";
-	path = git_path("info/exclude");
+
+	/* core.excludefile defaulting to $XDG_HOME/git/ignore */
 	if (!excludes_file) {
 		home_config_paths(NULL, &xdg_path, "ignore");
 		excludes_file = xdg_path;
 	}
-	if (!access_or_warn(path, R_OK, 0))
-		add_excludes_from_file(dir, path);
 	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
 		add_excludes_from_file(dir, excludes_file);
+
+	/* per repository user preference */
+	path = git_path("info/exclude");
+	if (!access_or_warn(path, R_OK, 0))
+		add_excludes_from_file(dir, path);
 }
 
 int remove_path(const char *name)
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index b4d98e6..38405de 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -775,4 +775,14 @@ test_expect_success PIPE 'streaming support for --stdin' '
 	echo "$response" | grep "^::	two"
 '
 
+test_expect_success 'info/exclude trumps core.excludesfile' '
+	echo >>global-excludes usually-ignored &&
+	echo >>.git/info/exclude "!usually-ignored" &&
+	>usually-ignored &&
+	echo "?? usually-ignored" >expect &&
+
+	git status --porcelain usually-ignored >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.0-rc3-227-gd45ce82
