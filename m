From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] grep: --full-tree
Date: Tue, 24 Nov 2009 00:56:32 -0800
Message-ID: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 24 09:57:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCrCh-00073G-PR
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 09:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbZKXI4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 03:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbZKXI4h
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 03:56:37 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60127 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216AbZKXI4h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 03:56:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8159C82462;
	Tue, 24 Nov 2009 03:56:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=YUbZ
	SHvM4LVRMufIZmtaH9agnEY=; b=jXaRoi9Rnf9lmgoZWd/XM7wlgTS0yavzcghC
	6Bve1y58A2shcRGqNznkueDhi5vXD4ibG03wktVIZ73EnGv6H7l0S5L2gEJRGJ2s
	MDacv9dvU+Q8V4+wtEocdZlYR1U/8lr1QSGiZ+apL+A79t9htuLPs0KAnIn7/i4F
	uXbNz9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ok6
	IX2aepC23t0sksn0a6O/F6BZWacaj/4LvyNmq2CZaVvppZjGR+pSb2PGl7t/F6Ww
	no5qG1OiTxMicZHLzlkWZK9euLEpbgFyUq7UMuGHS5wZ/X8Vp/hwk+ElmDX3YAUA
	8mwdx5Hp6ZnVgNuEVLsiOI2kTnw9q9HyFAUt5Dms=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6229782460;
	Tue, 24 Nov 2009 03:56:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 987458245E; Tue, 24 Nov
 2009 03:56:34 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 47E777A0-D8D7-11DE-A4FA-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133570>

While working inside a deep subdirectory, it sometimes is necessary to
find a string you see in a file you are working on from the files in the
entire project.  This is especially true when you are dipping your toe
into an unfamiliar project.

By default, "git grep" limits its search space to the current directory
and below (i.e. as if "-r ." is specified), and it is rather cumbersome to
repeat ../ as many times as necessary.  This new option tells "git grep"
not to limit the search space to the current directory.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * In http://article.gmane.org/gmane.comp.version-control.git/111717, I
   once argued in the opposite way, but I think it is Ok to aim for making
   the default --full-tree in the longer run (cf. $gmane/127885).  This is
   the first step in that direction.

   I am not sure if there can be a sane way to flip the default without
   hurting existing scripts and users.  Backward compatibility always is
   a pain.

 builtin-grep.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 761799d..5787f35 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -693,6 +693,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 {
 	int hit = 0;
 	int cached = 0;
+	int full_tree = 0;
 	int external_grep_allowed = 1;
 	int seen_dashdash = 0;
 	struct grep_opt opt;
@@ -732,6 +733,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BIT('H', NULL, &opt.pathname, "show filenames", 1),
 		OPT_NEGBIT(0, "full-name", &opt.relative,
 			"show filenames relative to top directory", 1),
+		OPT_BIT(0, "full-tree", &full_tree,
+			"search from the top of the tree", 1),
 		OPT_BOOLEAN('l', "files-with-matches", &opt.name_only,
 			"show only filenames instead of matching lines"),
 		OPT_BOOLEAN(0, "name-only", &opt.name_only,
@@ -862,7 +865,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 
 	if (i < argc)
 		paths = get_pathspec(prefix, argv + i);
-	else if (prefix) {
+	else if (prefix && !full_tree) {
 		paths = xcalloc(2, sizeof(const char *));
 		paths[0] = prefix;
 		paths[1] = NULL;
-- 
1.6.6.rc0.47.g1fdffa.dirty
