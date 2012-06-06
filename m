From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/6] builtin/add.c: use path_excluded()
Date: Tue,  5 Jun 2012 22:45:17 -0700
Message-ID: <1338961519-30970-5-git-send-email-gitster@pobox.com>
References: <1338961519-30970-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 07:46:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sc94N-0002JF-LN
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 07:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847Ab2FFFpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 01:45:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45633 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753923Ab2FFFp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 01:45:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCD0E6005
	for <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=5RYN
	WXIGX3vasiWRRTdP8lko9EQ=; b=FLysLX/e2pl1MAsKeFVXiC5uCnJmlhjqQoXo
	RhJlusgJFLppvJvqPwvwTcDIdzlCNppHEwpnBiLFk6Y7Njcv1gq09hQl4yN6s/WI
	bpbwfgGuys+RdrycoCs4TGVEyzhpzN8aQKJ1TloQZX8EGLQLP/1Gi5XEDv5v4wdj
	PGN4+c4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ngl6d0
	XPj1xxkcI+I2wmgRqppQWdp9dhZIUQjdYtCwZ8+r+yKYJ3zOSwpnDcGCq/RokITc
	0OhTPk3reD/bFXn++O9jc6H+S5dZy7FVug7vWczzpx8qiAxrVBSP9Yx/iGgZ4xtM
	NPM1RvWsyjO1lY5cR4gK/qrkHj0sTIWm3gK5I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B56D76004
	for <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48DB96003 for
 <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:28 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc1.37.g09843ac
In-Reply-To: <1338961519-30970-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D221BBBE-AF9A-11E1-8343-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199302>

This only happens in --ignore-missing --dry-run codepath which
presumably nobody should care, but is for completeness.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/add.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index c59b0c9..e5b40d9 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -441,6 +441,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (pathspec) {
 		int i;
+		struct path_exclude_check check;
+
+		path_exclude_check_init(&check, &dir);
 		if (!seen)
 			seen = find_used_pathspec(pathspec);
 		for (i = 0; pathspec[i]; i++) {
@@ -448,7 +451,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			    && !file_exists(pathspec[i])) {
 				if (ignore_missing) {
 					int dtype = DT_UNKNOWN;
-					if (excluded(&dir, pathspec[i], &dtype))
+					if (path_excluded(&check, pathspec[i], -1, &dtype))
 						dir_add_ignored(&dir, pathspec[i], strlen(pathspec[i]));
 				} else
 					die(_("pathspec '%s' did not match any files"),
@@ -456,6 +459,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			}
 		}
 		free(seen);
+		path_exclude_check_clear(&check);
 	}
 
 	exit_status |= add_files_to_cache(prefix, pathspec, flags);
-- 
1.7.11.rc1.37.g09843ac
