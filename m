From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] wt-status: use "format" function attribute for
 status_printf
Date: Wed, 10 Jul 2013 01:40:50 -0400
Message-ID: <20130710054050.GA7206@sigill.intra.peff.net>
References: <20130710001659.GA11643@sigill.intra.peff.net>
 <20130710002328.GC19423@sigill.intra.peff.net>
 <7vmwpvt28j.fsf@alter.siamese.dyndns.org>
 <20130710052859.GA5339@sigill.intra.peff.net>
 <7vip0jt1sy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 10 07:40:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwn99-0006LT-0F
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 07:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903Ab3GJFkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 01:40:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:45376 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696Ab3GJFky (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 01:40:54 -0400
Received: (qmail 8374 invoked by uid 102); 10 Jul 2013 05:42:10 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Jul 2013 00:42:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jul 2013 01:40:50 -0400
Content-Disposition: inline
In-Reply-To: <7vip0jt1sy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230026>

On Tue, Jul 09, 2013 at 10:35:25PM -0700, Junio C Hamano wrote:

> > You can "fix" it with -Wno-zero-format-length, so the hassle is not
> > huge. 
> 
> Yes, or just do func(..., "%s", "") perhaps?  That also sound iffy.

I imagine that is the method intended by upstream (though who
knows...the whole warning seems kind of stupid to me; it is clear that
printf("") is a no-op, but it is obviously not clear that arbitrary
functions using __attribute__(format) are).

The patch to do it is below, but I actually think an explicit blank-line
function like:

  status_print_empty_line(s, color);

would be more obvious to a reader.

---
diff --git a/builtin/commit.c b/builtin/commit.c
index 6b693c1..1fe81bc 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -768,7 +768,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				committer_ident.buf);
 
 		if (ident_shown)
-			status_printf_ln(s, GIT_COLOR_NORMAL, "");
+			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
 
 		saved_color_setting = s->use_color;
 		s->use_color = 0;
diff --git a/wt-status.c b/wt-status.c
index b191c65..5876032 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -178,7 +178,7 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
 	} else {
 		status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
 	}
-	status_printf_ln(s, c, "");
+	status_printf_ln(s, c, "%s", "");
 }
 
 static void wt_status_print_cached_header(struct wt_status *s)
@@ -194,7 +194,7 @@ static void wt_status_print_cached_header(struct wt_status *s)
 		status_printf_ln(s, c, _("  (use \"git reset %s <file>...\" to unstage)"), s->reference);
 	else
 		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
-	status_printf_ln(s, c, "");
+	status_printf_ln(s, c, "%s", "");
 }
 
 static void wt_status_print_dirty_header(struct wt_status *s,
@@ -213,7 +213,7 @@ static void wt_status_print_dirty_header(struct wt_status *s,
 	status_printf_ln(s, c, _("  (use \"git checkout -- <file>...\" to discard changes in working directory)"));
 	if (has_dirty_submodules)
 		status_printf_ln(s, c, _("  (commit or discard the untracked or modified content in submodules)"));
-	status_printf_ln(s, c, "");
+	status_printf_ln(s, c, "%s", "");
 }
 
 static void wt_status_print_other_header(struct wt_status *s,
@@ -225,12 +225,12 @@ static void wt_status_print_trailer(struct wt_status *s)
 	if (!advice_status_hints)
 		return;
 	status_printf_ln(s, c, _("  (use \"git %s <file>...\" to include in what will be committed)"), how);
-	status_printf_ln(s, c, "");
+	status_printf_ln(s, c, "%s", "");
 }
 
 static void wt_status_print_trailer(struct wt_status *s)
 {
-	status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
+	status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 }
 
 #define quote_path quote_path_relative
@@ -1191,7 +1191,7 @@ void wt_status_print(struct wt_status *s)
 				on_what = _("Not currently on any branch.");
 			}
 		}
-		status_printf(s, color(WT_STATUS_HEADER, s), "");
+		status_printf(s, color(WT_STATUS_HEADER, s), "%s", "");
 		status_printf_more(s, branch_status_color, "%s", on_what);
 		status_printf_more(s, branch_color, "%s\n", branch_name);
 		if (!s->is_initial)
@@ -1204,9 +1204,9 @@ void wt_status_print(struct wt_status *s)
 	free(state.detached_from);
 
 	if (s->is_initial) {
-		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
+		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
-		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
+		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 	}
 
 	wt_status_print_updated(s);
@@ -1223,7 +1223,7 @@ void wt_status_print(struct wt_status *s)
 		if (s->show_ignored_files)
 			wt_status_print_other(s, &s->ignored, _("Ignored files"), "add -f");
 		if (advice_status_u_option && 2000 < s->untracked_in_ms) {
-			status_printf_ln(s, GIT_COLOR_NORMAL, "");
+			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 					 _("It took %.2f seconds to enumerate untracked files. 'status -uno'\n"
 					   "may speed it up, but you have to be careful not to forget to add\n"
