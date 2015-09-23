From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 5/8] branch: drop non-commit error reporting
Date: Wed, 23 Sep 2015 13:38:19 -0700
Message-ID: <xmqqmvwcx45g.fsf@gitster.mtv.corp.google.com>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
	<1443031873-25280-6-git-send-email-Karthik.188@gmail.com>
	<xmqqfv25x80c.fsf@gitster.mtv.corp.google.com>
	<vpq6130ucbh.fsf@grenoble-inp.fr>
	<xmqqr3lox4kc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 23 22:38:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zeqo6-0008N2-DH
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 22:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855AbbIWUiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 16:38:22 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36157 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747AbbIWUiV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 16:38:21 -0400
Received: by pacgz1 with SMTP id gz1so403228pac.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 13:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=A887PuwN5nJQHTdT94g/O+83Au7am/46MOiGrB4M0qM=;
        b=Tgn5ATuRZWUC8TxJ8vcDEXZ/wj889Lbk3x3hN1WNo9GMZk0nIrjCPkOjqMczYfSIdu
         IOwJsHrBiVGi47lxyi0s9MpTO+w4AEOCxG1jNu4/DZBmDLUosm3jc00Y0trZDh0DWiFq
         FnnjXFDswdnkajaiSu62KrSO8G5VJ566pfxU70f7+lKfIoc48FWJZcDHROcnWriPSeJF
         z5DvlKU6SOrG7K9dP9tAf9LUUV9Ctt0EBYjT7G3Akrwvldz3Yss0dqUPo+9cTGWEP/dT
         s0NvXmBkWjVxnmTzBMzizdPak8+eKlS2qHtBZJ2UXda+pWYagc0ieqE0WJzWUgCmBm1j
         XsYA==
X-Received: by 10.68.108.101 with SMTP id hj5mr38858232pbb.156.1443040700801;
        Wed, 23 Sep 2015 13:38:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:a07c:76d3:22e9:4d3d])
        by smtp.gmail.com with ESMTPSA id qy5sm9600416pbb.16.2015.09.23.13.38.19
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 23 Sep 2015 13:38:20 -0700 (PDT)
In-Reply-To: <xmqqr3lox4kc.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 23 Sep 2015 13:29:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278513>

Junio C Hamano <gitster@pobox.com> writes:

>> BTW, this looks like an fsck bug:
>>
>> $ git fsck --strict
>> Checking object directories: 100% (256/256), done.
>> error: refs/heads/broken: not a commit
>> $ echo $?
>> 0
>
> Interesting.  Perhaps leave it as a MicroProject for GSoC next year?
> ;-)

Perhaps something like this (not even compile tested as both of my
worktrees are doing something else).  I didn't invent another error
class for cache-tree entry, as that falls into the same category as
"refs" where integrity constraint is that it has to point at a valid
object of an expected type.

 builtin/fsck.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 0794703..b9a74f0 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -38,6 +38,7 @@ static int show_dangling = 1;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
 #define ERROR_PACK 04
+#define ERROR_REFS 010
 
 #ifdef NO_D_INO_IN_DIRENT
 #define SORT_DIRENT 0
@@ -521,8 +522,10 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 		/* We'll continue with the rest despite the error.. */
 		return 0;
 	}
-	if (obj->type != OBJ_COMMIT && is_branch(refname))
+	if (obj->type != OBJ_COMMIT && is_branch(refname)) {
 		error("%s: not a commit", refname);
+		errors_found |= ERROR_REFS;
+	}
 	default_refs++;
 	obj->used = 1;
 	mark_object_reachable(obj);
@@ -585,17 +588,23 @@ static int fsck_head_link(void)
 		fprintf(stderr, "Checking HEAD link\n");
 
 	head_points_at = resolve_ref_unsafe("HEAD", 0, head_oid.hash, &flag);
-	if (!head_points_at)
+	if (!head_points_at) {
+		errors_found |= ERROR_REFS;
 		return error("Invalid HEAD");
+	}
 	if (!strcmp(head_points_at, "HEAD"))
 		/* detached HEAD */
 		null_is_error = 1;
-	else if (!starts_with(head_points_at, "refs/heads/"))
+	else if (!starts_with(head_points_at, "refs/heads/")) {
+		errors_found |= ERROR_REFS;
 		return error("HEAD points to something strange (%s)",
 			     head_points_at);
+	}
 	if (is_null_oid(&head_oid)) {
-		if (null_is_error)
+		if (null_is_error) {
+			errors_found |= ERROR_REFS;
 			return error("HEAD: detached HEAD points at nothing");
+		}
 		fprintf(stderr, "notice: HEAD points to an unborn branch (%s)\n",
 			head_points_at + 11);
 	}
@@ -615,6 +624,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 		if (!obj) {
 			error("%s: invalid sha1 pointer in cache-tree",
 			      sha1_to_hex(it->sha1));
+			errors_found |= ERROR_REFS;
 			return 1;
 		}
 		obj->used = 1;
