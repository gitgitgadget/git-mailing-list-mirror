From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: git ls-files and ignored directories
Date: Fri, 01 Jun 2012 11:28:00 -0700
Message-ID: <7vipfa3n0v.fsf@alter.siamese.dyndns.org>
References: <20120530102218.0625CFC006A@dd24126.kasserver.com>
 <20120531101451.C35C5B4C00D@dd24126.kasserver.com>
 <20120601093757.GE32340@sigill.intra.peff.net>
 <7vr4tz3tpw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christoph Buchner <bilderbuchi@phononoia.at>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 20:28:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaWa3-00066i-BU
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 20:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933575Ab2FAS2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 14:28:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37125 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933431Ab2FAS2E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 14:28:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BB728536;
	Fri,  1 Jun 2012 14:28:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fHOYWoqhyPIDPkLa0EtIELuKWtA=; b=VVrBj6
	d0hYkDFisEt8ct7mK4Ts3DSyBt03zmKoikfeDEWJtsLP0AbLTYaBvqFaNw0ojSg6
	8Xpmdt58H5xidq7mHNzGQ0+ufHBHKgq3s8x577DTeQo+iZwWqpyM1G1PFoCAV8lT
	lwMDvfp0GTy9bEGtW2yo2teQajGHcbYGLC1r8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q5cPTsJQCdMK5r0NVzL+Y8HMhFwES++x
	RwF7+75n2yKpJwhaWP+kmCqZA5HmKymgw+saQNY9SmaxdphcOINl60ucHlanC/xy
	OSfX7OrwxS3u6z+T1xu8M1P2pa2yTyky4g2PomId6XsNiA6ZDuvt7yR6RR2nHYBP
	XW618tNEa+M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3280C8535;
	Fri,  1 Jun 2012 14:28:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C4B58534; Fri,  1 Jun 2012
 14:28:02 -0400 (EDT)
In-Reply-To: <7vr4tz3tpw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 01 Jun 2012 09:03:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85B40BE6-AC17-11E1-8BCB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199009>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> No, I don't think anybody is working on it at the moment (at least I
>> do not see anything near the time of that old discussion, nor do I
>> recall it being discussed since).
>>
>> +cc Clemens, in case he had any work-in-progress as a result that did
>> not end up getting published.
>
> I think the way the codepath for -i feeds path to excluded() is wrong.
>
> The excluded() interface relies on the fact that the caller has
> already checked foo/ before calling it for foo/bar; when asked to
> see if "foo/bar" is excluded, it does not consider if "foo/" is
> excluded---the caller should have already checked it.
>
> The loop for cached/stage case in builtin/ls-files.c::show_files()
> needs to learn to be more careful when DIR_SHOW_IGNORED is set in
> dir->flags.  It needs to call a new helper function that notices
> that the check is walking into a different directory from the path
> it checked last, and feed leading directories to excluded(), or
> something like that, instead of directly calling !excluded().

A naive and unoptimized implementation may look like this patch.

The "path_exclude_check" structure can be enhanced to record the
leading directory it has last checked to be known to be excluded so
that path_excluded() can check if the ce->name[] is still inside
that directory and return true early, but I'll leave it as an
exercise for interested readers while I look at other topics for the
upcoming release.

-- >8 --
Subject: ls-files -i: pay attention to exclusion of leading paths

"git ls-files --exclude=t/ -i" does not show paths in directory t/
that have been added to the index, but it should.

The excluded() API was designed for callers who walk the tree from
the top, checking each level of the directory hierarchy as it
descends if it is excluded, and not even bothering to recurse into
an excluded directory.  This would allow us optimize for a common
case by not having to check if the exclude pattern "foo/" matches
when looking at "foo/bar", because the caller should have noticed
that "foo" is excluded and did not even bother to read "foo/bar"
out of opendir()/readdir() to call it.

The code for "ls-files -i" however walks the index linearly, feeding
paths without checking if the leading directory is already excluded.

Introduce a helper function path_excluded() to let this caller
properly call excluded() check for higher hierarchies as necessary.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/ls-files.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 7cff175..40f8865 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -13,6 +13,7 @@
 #include "parse-options.h"
 #include "resolve-undo.h"
 #include "string-list.h"
+#include "strbuf.h"
 
 static int abbrev;
 static int show_deleted;
@@ -200,9 +201,50 @@ static void show_ru_info(void)
 	}
 }
 
+struct path_exclude_check {
+	struct dir_struct *dir;
+	struct strbuf path;
+};
+
+static void path_exclude_check_init(struct path_exclude_check *check,
+				    struct dir_struct *dir)
+{
+	check->dir = dir;
+	strbuf_init(&check->path, 256);
+}
+
+static void path_exclude_check_clear(struct path_exclude_check *check)
+{
+	strbuf_release(&check->path);
+}
+
+static int path_excluded(struct path_exclude_check *check, struct cache_entry *ce)
+{
+	int i, dtype;
+	struct strbuf *path = &check->path;
+	strbuf_setlen(path, 0);
+
+	for (i = 0; ce->name[i]; i++) {
+		int ch = ce->name[i];
+
+		if (ch == '/') {
+			dtype = DT_DIR;
+			if (excluded(check->dir, path->buf, &dtype))
+				return 1;
+		}
+		strbuf_addch(path, ch);
+	}
+	dtype = ce_to_dtype(ce);
+	return excluded(check->dir, ce->name, &dtype);
+}
+
 static void show_files(struct dir_struct *dir)
 {
 	int i;
+	struct path_exclude_check check;
+
+	if ((dir->flags & DIR_SHOW_IGNORED))
+		path_exclude_check_init(&check, dir);
 
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
@@ -215,9 +257,8 @@ static void show_files(struct dir_struct *dir)
 	if (show_cached | show_stage) {
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
-			int dtype = ce_to_dtype(ce);
-			if (dir->flags & DIR_SHOW_IGNORED &&
-			    !excluded(dir, ce->name, &dtype))
+			if ((dir->flags & DIR_SHOW_IGNORED) &&
+			    !path_excluded(&check, ce))
 				continue;
 			if (show_unmerged && !ce_stage(ce))
 				continue;
@@ -232,9 +273,8 @@ static void show_files(struct dir_struct *dir)
 			struct cache_entry *ce = active_cache[i];
 			struct stat st;
 			int err;
-			int dtype = ce_to_dtype(ce);
-			if (dir->flags & DIR_SHOW_IGNORED &&
-			    !excluded(dir, ce->name, &dtype))
+			if ((dir->flags & DIR_SHOW_IGNORED) &&
+			    !path_excluded(&check, ce))
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
@@ -247,6 +287,9 @@ static void show_files(struct dir_struct *dir)
 				show_ce_entry(tag_modified, ce);
 		}
 	}
+
+	if ((dir->flags & DIR_SHOW_IGNORED))
+		path_exclude_check_clear(&check);
 }
 
 /*
