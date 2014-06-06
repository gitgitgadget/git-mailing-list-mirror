From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] Use starts_with() for C strings instead of memcmp()
Date: Fri, 06 Jun 2014 19:24:48 +0200
Message-ID: <5391F960.8070702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 06 19:26:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsxuA-0007Ih-Gd
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 19:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbaFFR0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 13:26:09 -0400
Received: from mout.web.de ([212.227.17.12]:52216 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334AbaFFR0I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 13:26:08 -0400
Received: from [192.168.178.27] ([79.253.174.36]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MhlP1-1X6M0L2b3L-00MvPB; Fri, 06 Jun 2014 19:25:18
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
X-Provags-ID: V03:K0:J3hO4500zE2lJpkS6gPYa5Kr63ZojgYKZH22y9lr5qFLk5K7pOz
 AS/Gw8YRC2anqp3hvOX2dB6hcxqmDa/4Y2TBxLPfcGpNHrIhMpM+uFPH/JQhMCPO1X/AmTk
 BUwJPxs9FXeopvXFmX0lPgULYV+XRS06d99cYvahJ/Sk5o3vKD0xxERlJtci/dXE95YipPE
 fMnKQUOkgIOZsyYIHCxmA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250951>

Convert three cases of checking for a constant prefix using memcmp() to
starts_with().  This way there is no need for magic string length
constants and we avoid running over the end of the string should it be
shorter than the prefix.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
These are the easy cases I found; there are several more comparisons
of strings to constants using memcmp().  Some could benefit from
skip_prefix(), others may need a bit more thought, and perhaps I
missed a few.

 builtin/for-each-ref.c | 2 +-
 fetch-pack.c           | 2 +-
 remote.c               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 3e1d5c3..4135980 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -193,7 +193,7 @@ static int verify_format(const char *format)
 		at = parse_atom(sp + 2, ep);
 		cp = ep + 1;
 
-		if (!memcmp(used_atom[at], "color:", 6))
+		if (starts_with(used_atom[at], "color:"))
 			need_color_reset_at_eol = !!strcmp(used_atom[at], color_reset);
 	}
 	return 0;
diff --git a/fetch-pack.c b/fetch-pack.c
index eeee2bb..b12bd4c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -507,7 +507,7 @@ static void filter_refs(struct fetch_pack_args *args,
 		int keep = 0;
 		next = ref->next;
 
-		if (!memcmp(ref->name, "refs/", 5) &&
+		if (starts_with(ref->name, "refs/") &&
 		    check_refname_format(ref->name, 0))
 			; /* trash */
 		else {
diff --git a/remote.c b/remote.c
index eea2c8d..0f6ef36 100644
--- a/remote.c
+++ b/remote.c
@@ -1194,7 +1194,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	case 1:
 		break;
 	case 0:
-		if (!memcmp(dst_value, "refs/", 5))
+		if (starts_with(dst_value, "refs/"))
 			matched_dst = make_linked_ref(dst_value, dst_tail);
 		else if (is_null_sha1(matched_src->new_sha1))
 			error("unable to delete '%s': remote ref does not exist",
-- 
2.0.0
