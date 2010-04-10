From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] "status --ignored"
Date: Sat, 10 Apr 2010 03:44:30 -0400
Message-ID: <20100410074430.GA12567@coredump.intra.peff.net>
References: <20100410040959.GA11977@coredump.intra.peff.net>
 <1270885256-31589-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Raymond <esr@snark.thyrsus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 09:45:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0VNE-0001RI-4g
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 09:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816Ab0DJHoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 03:44:55 -0400
Received: from peff.net ([208.65.91.99]:46806 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743Ab0DJHoy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 03:44:54 -0400
Received: (qmail 16935 invoked by uid 107); 10 Apr 2010 07:44:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 10 Apr 2010 03:44:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Apr 2010 03:44:30 -0400
Content-Disposition: inline
In-Reply-To: <1270885256-31589-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144529>

On Sat, Apr 10, 2010 at 12:40:51AM -0700, Junio C Hamano wrote:

> > It wouldn't be too hard to add them in, and would look something like
> > the patch below.
> 
> As I didn't see a patch, I did a rough outline just for fun.

Gah. Yours is undoubtedly less ugly, but here was mine for reference.

diff --git a/dir.c b/dir.c
index cb83332..deee7c8 100644
--- a/dir.c
+++ b/dir.c
@@ -619,7 +619,9 @@ static int exclude_matches_pathspec(const char *path, int len,
 				return 1;
 		}
 	}
-	return 0;
+	/* ugh, I think this may be a long-standing bug, but
+	 * this code was never reachable before. */
+	return 1;
 }
 
 static int get_index_dtype(const char *path, int len)
diff --git a/wt-status.c b/wt-status.c
index 8ca59a2..53a7a5a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -366,6 +366,8 @@ static void wt_status_collect_untracked(struct wt_status *s)
 	if (!s->show_untracked_files)
 		return;
 	memset(&dir, 0, sizeof(dir));
+	/* should be conditional on s->show_ignored_files */
+	dir.flags |= DIR_COLLECT_IGNORED;
 	if (s->show_untracked_files != SHOW_ALL_UNTRACKED_FILES)
 		dir.flags |=
 			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
@@ -381,6 +383,14 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		s->workdir_untracked = 1;
 		string_list_insert(ent->name, &s->untracked);
 	}
+	for (i = 0; i < dir.ignored_nr; i++) {
+		struct dir_entry *ent = dir.ignored[i];
+		if (!cache_name_is_other(ent->name, ent->len))
+			continue;
+		if (!match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
+			continue;
+		string_list_insert(ent->name, &s->ignored);
+	}
 }
 
 void wt_status_collect(struct wt_status *s)
@@ -707,15 +717,15 @@ static void wt_shortstatus_status(int null_termination, struct string_list_item
 }
 
 static void wt_shortstatus_untracked(int null_termination, struct string_list_item *it,
-			    struct wt_status *s)
+			    struct wt_status *s, const char *marker)
 {
 	if (null_termination) {
-		fprintf(stdout, "?? %s%c", it->string, 0);
+		fprintf(stdout, "%s %s%c", marker, it->string, 0);
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
 		one = quote_path(it->string, -1, &onebuf, s->prefix);
-		color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "??");
+		color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), marker);
 		printf(" %s\n", one);
 		strbuf_release(&onebuf);
 	}
@@ -739,7 +749,11 @@ void wt_shortstatus_print(struct wt_status *s, int null_termination)
 		struct string_list_item *it;
 
 		it = &(s->untracked.items[i]);
-		wt_shortstatus_untracked(null_termination, it, s);
+		wt_shortstatus_untracked(null_termination, it, s, "??");
+	}
+	for (i = 0; i < s->ignored.nr; i++) {
+		struct string_list_item *it = &(s->ignored.items[i]);
+		wt_shortstatus_untracked(null_termination, it, s, "II");
 	}
 }
 
diff --git a/wt-status.h b/wt-status.h
index 9120673..0f5cf38 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -53,6 +53,7 @@ struct wt_status {
 	const char *prefix;
 	struct string_list change;
 	struct string_list untracked;
+	struct string_list ignored;
 };
 
 void wt_status_prepare(struct wt_status *s);
