From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] rerere: Libify "rerere clear" and "rerere gc"
Date: Sun, 08 May 2011 13:06:55 -0700
Message-ID: <7v62plrm74.fsf@alter.siamese.dyndns.org>
References: <7vr58b22ny.fsf@alter.siamese.dyndns.org>
 <1304839851-6477-1-git-send-email-artagnon@gmail.com>
 <1304839851-6477-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 22:07:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJAG1-000708-Co
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 22:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542Ab1EHUHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 16:07:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab1EHUHI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 16:07:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 07E305850;
	Sun,  8 May 2011 16:09:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=bFwFE4+FzB7xBFSG7V5UU1P3esM=; b=kVjUJqe8wWIGPsZ7baWF
	Qy1POlC01WRcTGggPU5LoPCuGJ71n99l0QKH2/B2AC5eaARhmIenUeqPZrJ79628
	iSQA29NOoWQY9axgWNB62p1dymznGzL0jYX+j+IAmL+t4Q4mqZKUfXz9fIylGjS4
	n4glwrs15TXQ+0Gb0/Lo87U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=PHsghualusmHpLC7l92wojfjtWexr7m4xS0Fs7Mz4gT3W6
	DY6YnkBA5RB7FCQ6IsipfH8JipUp6IjDnPQ5UguvEA5Q3PXKSXWsewBAH5vncfgL
	Zx5ud2mdgxnqHQjhZMDqEz0C3BZ8WASSe1YJ4A7+i9+ElOeEqAhAYBMfX/GN8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BA999584B;
	Sun,  8 May 2011 16:09:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 03604584A; Sun,  8 May 2011
 16:09:01 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 07B376E6-79AF-11E0-B6A0-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173176>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/rerere.c b/rerere.c
> index 22dfc84..18c7413 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -623,6 +658,51 @@ int rerere(int flags)
>  	return do_plain_rerere(&merge_rr, fd);
>  }
>  
> +int rerere_garbage_collect(int flags)
> +{
> +	struct string_list merge_rr = STRING_LIST_INIT_DUP;
> +	struct string_list to_remove = STRING_LIST_INIT_DUP;
> +
> +	DIR *dir;
> +	struct dirent *e;
> +	int i, fd, cutoff;
> +	time_t now = time(NULL), then;
> +
> +	fd = setup_rerere(&merge_rr, flags);
> +	if (fd < 0)
> +		return 0;

Not a good taste in API design, I would have to say.  The callers may
already want to have interacted with the rerere mechanism before calling
into this function and that is exactly why setup_rerere() is a public API
from the beginning.  I would prefer to see you make it the caller's
responsibility just like the original code you moved from builtin/rerere.c
did.

> +	git_config(git_rerere_gc_config, NULL);
> +	dir = opendir(git_path("rr-cache"));
> +	if (!dir) {
> +		rollback_lock_file(&write_lock);
> +		return error_errno("Unable to open rr-cache directory");
> +	}

I have already commented on this part and showed an alternative.

Whatever you do, how about starting from just a simple code movement,
without any change in behaviour?

That not only makes it easier to review your subsequent changes on top of
the result, but the original "large code movement" patch infinitely easier
to review, as "blame rerere.c" can tell us that almost all the lines came
from builtin/rerere.c without any new bug slipping in.

-- >8 --
Subject: [PATCH] rerere: libify rerere_clear() and rerere_gc()

This moves the two features from builtin/rerere.c to a more library-ish
portion of the codebase.  No behaviour change.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rerere.c |   77 +------------------------------------------------
 rerere.c         |   84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 rerere.h         |    2 +
 3 files changed, 88 insertions(+), 75 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 8235885..08213c7 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -12,74 +12,6 @@ static const char * const rerere_usage[] = {
 	NULL,
 };
 
-/* these values are days */
-static int cutoff_noresolve = 15;
-static int cutoff_resolve = 60;
-
-static time_t rerere_created_at(const char *name)
-{
-	struct stat st;
-	return stat(rerere_path(name, "preimage"), &st) ? (time_t) 0 : st.st_mtime;
-}
-
-static time_t rerere_last_used_at(const char *name)
-{
-	struct stat st;
-	return stat(rerere_path(name, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
-}
-
-static void unlink_rr_item(const char *name)
-{
-	unlink(rerere_path(name, "thisimage"));
-	unlink(rerere_path(name, "preimage"));
-	unlink(rerere_path(name, "postimage"));
-	rmdir(git_path("rr-cache/%s", name));
-}
-
-static int git_rerere_gc_config(const char *var, const char *value, void *cb)
-{
-	if (!strcmp(var, "gc.rerereresolved"))
-		cutoff_resolve = git_config_int(var, value);
-	else if (!strcmp(var, "gc.rerereunresolved"))
-		cutoff_noresolve = git_config_int(var, value);
-	else
-		return git_default_config(var, value, cb);
-	return 0;
-}
-
-static void garbage_collect(struct string_list *rr)
-{
-	struct string_list to_remove = STRING_LIST_INIT_DUP;
-	DIR *dir;
-	struct dirent *e;
-	int i, cutoff;
-	time_t now = time(NULL), then;
-
-	git_config(git_rerere_gc_config, NULL);
-	dir = opendir(git_path("rr-cache"));
-	if (!dir)
-		die_errno("unable to open rr-cache directory");
-	while ((e = readdir(dir))) {
-		if (is_dot_or_dotdot(e->d_name))
-			continue;
-
-		then = rerere_last_used_at(e->d_name);
-		if (then) {
-			cutoff = cutoff_resolve;
-		} else {
-			then = rerere_created_at(e->d_name);
-			if (!then)
-				continue;
-			cutoff = cutoff_noresolve;
-		}
-		if (then < now - cutoff * 86400)
-			string_list_append(&to_remove, e->d_name);
-	}
-	for (i = 0; i < to_remove.nr; i++)
-		unlink_rr_item(to_remove.items[i].string);
-	string_list_clear(&to_remove, 0);
-}
-
 static int outf(void *dummy, mmbuffer_t *ptr, int nbuf)
 {
 	int i;
@@ -148,14 +80,9 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 		return 0;
 
 	if (!strcmp(argv[0], "clear")) {
-		for (i = 0; i < merge_rr.nr; i++) {
-			const char *name = (const char *)merge_rr.items[i].util;
-			if (!has_rerere_resolution(name))
-				unlink_rr_item(name);
-		}
-		unlink_or_warn(git_path("MERGE_RR"));
+		rerere_clear(&merge_rr);
 	} else if (!strcmp(argv[0], "gc"))
-		garbage_collect(&merge_rr);
+		rerere_gc(&merge_rr);
 	else if (!strcmp(argv[0], "status"))
 		for (i = 0; i < merge_rr.nr; i++)
 			printf("%s\n", merge_rr.items[i].string);
diff --git a/rerere.c b/rerere.c
index 22dfc84..dee2cb1 100644
--- a/rerere.c
+++ b/rerere.c
@@ -671,3 +671,87 @@ int rerere_forget(const char **pathspec)
 	}
 	return write_rr(&merge_rr, fd);
 }
+
+static time_t rerere_created_at(const char *name)
+{
+	struct stat st;
+	return stat(rerere_path(name, "preimage"), &st) ? (time_t) 0 : st.st_mtime;
+}
+
+static time_t rerere_last_used_at(const char *name)
+{
+	struct stat st;
+	return stat(rerere_path(name, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
+}
+
+static void unlink_rr_item(const char *name)
+{
+	unlink(rerere_path(name, "thisimage"));
+	unlink(rerere_path(name, "preimage"));
+	unlink(rerere_path(name, "postimage"));
+	rmdir(git_path("rr-cache/%s", name));
+}
+
+struct rerere_gc_config_cb {
+	int cutoff_noresolve;
+	int cutoff_resolve;
+};
+
+static int git_rerere_gc_config(const char *var, const char *value, void *cb)
+{
+	struct rerere_gc_config_cb *cf = cb;
+
+	if (!strcmp(var, "gc.rerereresolved"))
+		cf->cutoff_resolve = git_config_int(var, value);
+	else if (!strcmp(var, "gc.rerereunresolved"))
+		cf->cutoff_noresolve = git_config_int(var, value);
+	else
+		return git_default_config(var, value, cb);
+	return 0;
+}
+
+void rerere_gc(struct string_list *rr)
+{
+	struct string_list to_remove = STRING_LIST_INIT_DUP;
+	DIR *dir;
+	struct dirent *e;
+	int i, cutoff;
+	time_t now = time(NULL), then;
+	struct rerere_gc_config_cb cf = { 15, 60 };
+
+	git_config(git_rerere_gc_config, &cf);
+	dir = opendir(git_path("rr-cache"));
+	if (!dir)
+		die_errno("unable to open rr-cache directory");
+	while ((e = readdir(dir))) {
+		if (is_dot_or_dotdot(e->d_name))
+			continue;
+
+		then = rerere_last_used_at(e->d_name);
+		if (then) {
+			cutoff = cf.cutoff_resolve;
+		} else {
+			then = rerere_created_at(e->d_name);
+			if (!then)
+				continue;
+			cutoff = cf.cutoff_noresolve;
+		}
+		if (then < now - cutoff * 86400)
+			string_list_append(&to_remove, e->d_name);
+	}
+	for (i = 0; i < to_remove.nr; i++)
+		unlink_rr_item(to_remove.items[i].string);
+	string_list_clear(&to_remove, 0);
+}
+
+void rerere_clear(struct string_list *merge_rr)
+{
+	int i;
+
+	for (i = 0; i < merge_rr->nr; i++) {
+		const char *name = (const char *)merge_rr->items[i].util;
+		if (!has_rerere_resolution(name))
+			unlink_rr_item(name);
+	}
+	unlink_or_warn(git_path("MERGE_RR"));
+}
diff --git a/rerere.h b/rerere.h
index 595f49f..fcd8bc1 100644
--- a/rerere.h
+++ b/rerere.h
@@ -19,6 +19,8 @@ extern const char *rerere_path(const char *hex, const char *file);
 extern int has_rerere_resolution(const char *hex);
 extern int rerere_forget(const char **);
 extern int rerere_remaining(struct string_list *);
+extern void rerere_clear(struct string_list *);
+extern void rerere_gc(struct string_list *);
 
 #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
 	"update the index with reused conflict resolution if possible")
-- 
1.7.5.1.268.gce5bd
