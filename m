From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix `git rev-list --show-notes HEAD` when there are no
 notes
Date: Sun, 23 Aug 2015 13:43:09 -0400
Message-ID: <20150823174309.GA24735@sigill.intra.peff.net>
References: <0LZlZ2-1Z1Zyn1mzk-00lZ3Z@mail.gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 23 19:43:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTZIr-0004xh-9d
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 19:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbbHWRnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2015 13:43:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:48763 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752123AbbHWRnM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2015 13:43:12 -0400
Received: (qmail 29749 invoked by uid 102); 23 Aug 2015 17:43:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Aug 2015 12:43:12 -0500
Received: (qmail 16330 invoked by uid 107); 23 Aug 2015 17:43:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Aug 2015 13:43:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Aug 2015 13:43:09 -0400
Content-Disposition: inline
In-Reply-To: <0LZlZ2-1Z1Zyn1mzk-00lZ3Z@mail.gmx.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276415>

On Sat, Aug 22, 2015 at 05:14:39PM +0200, Johannes Schindelin wrote:

> The `format_display_notes()` function clearly assumes that the data
> structure holding the notes has been initialized already, i.e. that the
> `display_notes_trees` variable is no longer `NULL`.
> 
> However, when there are no notes whatsoever, this variable is still
> `NULL`, even after initialization.
> 
> So let's be graceful and just return if that data structure is `NULL`.

Hrm. This is supposed to be made non-NULL by calling init_display_notes.
The "git-log" code does this properly, and can show notes. The
"rev-list" code does not, and hits this assert. But that also means that
it cannot actually _show_ notes, and your patch is papering over the
problem.

I would think we would need something more like this:

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ff84a82..fc73a6f 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -279,6 +279,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int bisect_show_vars = 0;
 	int bisect_find_all = 0;
 	int use_bitmap_index = 0;
+	struct userformat_want w;
 
 	git_config(git_default_config, NULL);
 	init_revisions(&revs, prefix);
@@ -349,6 +350,14 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	    revs.diff)
 		usage(rev_list_usage);
 
+	memset(&w, 0, sizeof(w));
+	userformat_find_requirements(NULL, &w);
+
+	if (!revs.show_notes_given && w.notes)
+		revs.show_notes = 1;
+	if (revs.show_notes)
+		init_display_notes(&revs.notes_opt);
+
 	save_commit_buffer = (revs.verbose_header ||
 			      revs.grep_filter.pattern_list ||
 			      revs.grep_filter.header_list);

but it looks like that is not enough to convince the pretty-printer to
actually show notes (I suspect we need something like the
pretty_ctx->notes_message setup that is in show_log()).

I don't know how deeply anybody _cares_ about showing notes via
rev-list. It has clearly never worked. But rather than silently
accepting --show-notes (and not showing any notes!), perhaps we should
tell the user that it does not work. Likewise, the "%N" --format
specifier never expands in rev-list, and should probably be removed from
the rev-list documentation.

Although...

> Reported in https://github.com/msysgit/git/issues/363.

After reading your subject, I wondered why "git rev-list --show-notes
HEAD" did not crash for me (whether or not I had notes). But the key
element from that issue is the addition of "--grep", which is what
triggers us to actually look at the notes (since rev-list otherwise does
not support displaying them). And that _does_ work with my patch above.
So perhaps that is useful, though again, it has never worked in the
past (and with your patch, it would silently return no results, whether
the grep matched or not).

Of course it's a terrible interface to make "--show-notes --grep" grep
the notes, but not actually _show_ them. :-/

> diff --git a/notes.c b/notes.c
> index df08209..24a335a 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -1266,7 +1266,10 @@ void format_display_notes(const unsigned char *object_sha1,
>  			  struct strbuf *sb, const char *output_encoding, int raw)
>  {
>  	int i;
> -	assert(display_notes_trees);
> +
> +	if (!display_notes_trees)
> +		return;
> +

So I'm not really in favor of this approach, but if we do go that route,
the comment above the declaration of format_display_notes needs to be
updated.

-Peff
