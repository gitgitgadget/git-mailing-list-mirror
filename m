From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH 10/15] commit.c: fix a memory leak
Date: Tue, 24 Mar 2015 14:17:01 -0700
Message-ID: <xmqq7fu65c4y.fsf_-_@gitster.dls.corp.google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
	<1426897692-18322-11-git-send-email-sbeller@google.com>
	<xmqqk2ybatm1.fsf@gitster.dls.corp.google.com>
	<CACsJy8A3CptGYNAZ=+k0ykBCp6SGoOLY0nX20WkWQp=qUnxwWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 22:17:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaWCH-0001t4-94
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 22:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbbCXVRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 17:17:09 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751876AbbCXVRG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 17:17:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 573A641354;
	Tue, 24 Mar 2015 17:17:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yY39xR8ZZEwOsdMHq868P8MaQEg=; b=WD1l0A
	IVuCA/IzW7GYdOT8REtpnFeWujgTqIGuG20njFHDsIX45lnw1wu3MZHzOfwM1/GJ
	fUg6HlJ0k5eW7opcUyfV7TUDuqXGx8q4sLRRwwAe/4o8ksogIGtxAtxZre7ACl6C
	nk4vDNm9N/ZV1AcskKh1l6n9BaJ6rWN3i4eT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XVdyxVLWFvMbMUEk7ouJDXlrYuGr8yeO
	bIw3P70Iaem4TCOt+3/xKx9QFVE8dOEGvxu7A2/0O6PcSLCSTdqWaswrP5aup70I
	ErLa61Tc2kF/cnGP5cANKWuJc3sLTvUJj8y7gQ072uz2zuCLFg11Sdpdxxk77EWD
	7qEkz5Glgw4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4FBC541353;
	Tue, 24 Mar 2015 17:17:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D4F941351;
	Tue, 24 Mar 2015 17:17:02 -0400 (EDT)
In-Reply-To: <CACsJy8A3CptGYNAZ=+k0ykBCp6SGoOLY0nX20WkWQp=qUnxwWg@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 24 Mar 2015 20:42:17 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1D7B7276-D26B-11E4-9A64-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266228>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Mar 21, 2015 at 10:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> A further tangent (Duy Cc'ed for this point).  We might want to
>> rethink the interface to ce_path_match() and report_path_error()
>> so that we do not have to do a separate allocation of "has this
>> pathspec been used?" array.  This was a remnant from the olden days
>> back when pathspec were mere "const char **" where we did not have
>> any room to add per-item bit---these days pathspec is repreasented
>> as an array of "struct pathspec" and we can afford to add a bit
>> to the structure---which will make this kind of leak much less
>> likely to happen.
>
> I just want to say "noted" (and therefore in my backlog). But no
> promise that it will happen any time soon. Low hanging fruit, perhaps
> some people may be interested..

OK, the other one I just did so that we won't forget.  Otherwise we
will leave too many loose ends untied.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Tue, 24 Mar 2015 14:12:10 -0700
Subject: [PATCH] report_path_error(): move to dir.c

The expected call sequence is for the caller to use match_pathspec()
repeatedly on a set of pathspecs, accumulating the "hits" in a
separate array, and then call this function to diagnose a pathspec
that never matched anything, as that can indicate a typo from the
command line, e.g. "git commit Maekfile".

Many builtin commands use this function from builtin/ls-files.c,
which is not a very healthy arrangement.  ls-files might have been
the first command to feel the need for such a helper, but the need
is shared by everybody who uses the "match and then report" pattern.

Move it to dir.c where match_pathspec() is defined.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/ls-files.c | 43 -------------------------------------------
 cache.h            |  1 -
 dir.c              | 43 +++++++++++++++++++++++++++++++++++++++++++
 dir.h              |  1 +
 4 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 47c3880..47d70b2 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -354,49 +354,6 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 	}
 }
 
-int report_path_error(const char *ps_matched,
-		      const struct pathspec *pathspec,
-		      const char *prefix)
-{
-	/*
-	 * Make sure all pathspec matched; otherwise it is an error.
-	 */
-	struct strbuf sb = STRBUF_INIT;
-	int num, errors = 0;
-	for (num = 0; num < pathspec->nr; num++) {
-		int other, found_dup;
-
-		if (ps_matched[num])
-			continue;
-		/*
-		 * The caller might have fed identical pathspec
-		 * twice.  Do not barf on such a mistake.
-		 * FIXME: parse_pathspec should have eliminated
-		 * duplicate pathspec.
-		 */
-		for (found_dup = other = 0;
-		     !found_dup && other < pathspec->nr;
-		     other++) {
-			if (other == num || !ps_matched[other])
-				continue;
-			if (!strcmp(pathspec->items[other].original,
-				    pathspec->items[num].original))
-				/*
-				 * Ok, we have a match already.
-				 */
-				found_dup = 1;
-		}
-		if (found_dup)
-			continue;
-
-		error("pathspec '%s' did not match any file(s) known to git.",
-		      pathspec->items[num].original);
-		errors++;
-	}
-	strbuf_release(&sb);
-	return errors;
-}
-
 static const char * const ls_files_usage[] = {
 	N_("git ls-files [options] [<file>...]"),
 	NULL
diff --git a/cache.h b/cache.h
index f23fdbe..8ec0b65 100644
--- a/cache.h
+++ b/cache.h
@@ -1411,7 +1411,6 @@ extern int ws_blank_line(const char *line, int len, unsigned ws_rule);
 #define ws_tab_width(rule)     ((rule) & WS_TAB_WIDTH_MASK)
 
 /* ls-files */
-int report_path_error(const char *ps_matched, const struct pathspec *pathspec, const char *prefix);
 void overlay_tree_on_cache(const char *tree_name, const char *prefix);
 
 char *alias_lookup(const char *alias);
diff --git a/dir.c b/dir.c
index 797805d..5d6e102 100644
--- a/dir.c
+++ b/dir.c
@@ -377,6 +377,49 @@ int match_pathspec(const struct pathspec *ps,
 	return negative ? 0 : positive;
 }
 
+int report_path_error(const char *ps_matched,
+		      const struct pathspec *pathspec,
+		      const char *prefix)
+{
+	/*
+	 * Make sure all pathspec matched; otherwise it is an error.
+	 */
+	struct strbuf sb = STRBUF_INIT;
+	int num, errors = 0;
+	for (num = 0; num < pathspec->nr; num++) {
+		int other, found_dup;
+
+		if (ps_matched[num])
+			continue;
+		/*
+		 * The caller might have fed identical pathspec
+		 * twice.  Do not barf on such a mistake.
+		 * FIXME: parse_pathspec should have eliminated
+		 * duplicate pathspec.
+		 */
+		for (found_dup = other = 0;
+		     !found_dup && other < pathspec->nr;
+		     other++) {
+			if (other == num || !ps_matched[other])
+				continue;
+			if (!strcmp(pathspec->items[other].original,
+				    pathspec->items[num].original))
+				/*
+				 * Ok, we have a match already.
+				 */
+				found_dup = 1;
+		}
+		if (found_dup)
+			continue;
+
+		error("pathspec '%s' did not match any file(s) known to git.",
+		      pathspec->items[num].original);
+		errors++;
+	}
+	strbuf_release(&sb);
+	return errors;
+}
+
 /*
  * Return the length of the "simple" part of a path match limiter.
  */
diff --git a/dir.h b/dir.h
index 55e5345..ed336ad 100644
--- a/dir.h
+++ b/dir.h
@@ -135,6 +135,7 @@ extern char *common_prefix(const struct pathspec *pathspec);
 extern int match_pathspec(const struct pathspec *pathspec,
 			  const char *name, int namelen,
 			  int prefix, char *seen, int is_dir);
+extern int report_path_error(const char *ps_matched, const struct pathspec *pathspec, const char *prefix);
 extern int within_depth(const char *name, int namelen, int depth, int max_depth);
 
 extern int fill_directory(struct dir_struct *dir, const struct pathspec *pathspec);
-- 
2.3.4-449-gebec173
