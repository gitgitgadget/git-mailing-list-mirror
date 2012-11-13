From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] submodule: display summary header in bold
Date: Tue, 13 Nov 2012 00:44:47 -0500
Message-ID: <20121113054447.GB10995@sigill.intra.peff.net>
References: <1352653146-3932-1-git-send-email-artagnon@gmail.com>
 <1352653146-3932-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 06:45:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY9JA-00071a-9r
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 06:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778Ab2KMFox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 00:44:53 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45585 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155Ab2KMFow (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 00:44:52 -0500
Received: (qmail 19847 invoked by uid 107); 13 Nov 2012 05:45:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Nov 2012 00:45:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2012 00:44:47 -0500
Content-Disposition: inline
In-Reply-To: <1352653146-3932-4-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209577>

On Sun, Nov 11, 2012 at 10:29:06PM +0530, Ramkumar Ramachandra wrote:

> Currently, 'git diff --submodule' displays output with a bold diff
> header for non-submodules.  So this part is in bold:
> 
>     diff --git a/file1 b/file1
>     index 30b2f6c..2638038 100644
>     --- a/file1
>     +++ b/file1
> 
> For submodules, the header looks like this:
> 
>     Submodule submodule1 012b072..248d0fd:
> 
> Unfortunately, it's easy to miss in the output because it's not bold.
> Change this.

Reading this, I was at first concerned that you were using "bold" and
not DIFF_METAINFO. But:

> diff --git a/diff.c b/diff.c
> index b486070..51c0d6c 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2267,7 +2267,7 @@ static void builtin_diff(const char *name_a,
>  		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
>  		show_submodule_summary(o->file, one ? one->path : two->path,
>  				one->sha1, two->sha1, two->dirty_submodule,
> -				del, add, reset);
> +				set, del, add, reset);

This is correctly passing the DIFF_METAINFO color, which is in the "set"
variable. Good. I looked at the output on a sample repository, and it is
much easier to read (though I use magenta for my metainfo).

"set" is a terrible name for that variable (not your fault, of course).
When you re-roll (and I think you need to because of the diff_ui thing
in patch 2), would you mind throwing this cleanup in the middle?

-- >8 --
Subject: builtin_diff: rename "set" variable

Once upon a time the builtin_diff function used one color, and the color
variables were called "set" and "reset". Nowadays it is a much longer
function and we use several colors (e.g., "add", "del"). Rename "set" to
"meta" to show that it is the color for showing diff meta-info (it still
does not indicate that it is a "color", but at least it matches the
scheme of the other color variables).

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index e89a201..978e1af 100644
--- a/diff.c
+++ b/diff.c
@@ -2222,7 +2222,7 @@ static void builtin_diff(const char *name_a,
 	mmfile_t mf1, mf2;
 	const char *lbl[2];
 	char *a_one, *b_two;
-	const char *set = diff_get_color_opt(o, DIFF_METAINFO);
+	const char *meta = diff_get_color_opt(o, DIFF_METAINFO);
 	const char *reset = diff_get_color_opt(o, DIFF_RESET);
 	const char *a_prefix, *b_prefix;
 	struct userdiff_driver *textconv_one = NULL;
@@ -2269,24 +2269,24 @@ static void builtin_diff(const char *name_a,
 	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
-	strbuf_addf(&header, "%s%sdiff --git %s %s%s\n", line_prefix, set, a_one, b_two, reset);
+	strbuf_addf(&header, "%s%sdiff --git %s %s%s\n", line_prefix, meta, a_one, b_two, reset);
 	if (lbl[0][0] == '/') {
 		/* /dev/null */
-		strbuf_addf(&header, "%s%snew file mode %06o%s\n", line_prefix, set, two->mode, reset);
+		strbuf_addf(&header, "%s%snew file mode %06o%s\n", line_prefix, meta, two->mode, reset);
 		if (xfrm_msg)
 			strbuf_addstr(&header, xfrm_msg);
 		must_show_header = 1;
 	}
 	else if (lbl[1][0] == '/') {
-		strbuf_addf(&header, "%s%sdeleted file mode %06o%s\n", line_prefix, set, one->mode, reset);
+		strbuf_addf(&header, "%s%sdeleted file mode %06o%s\n", line_prefix, meta, one->mode, reset);
 		if (xfrm_msg)
 			strbuf_addstr(&header, xfrm_msg);
 		must_show_header = 1;
 	}
 	else {
 		if (one->mode != two->mode) {
-			strbuf_addf(&header, "%s%sold mode %06o%s\n", line_prefix, set, one->mode, reset);
-			strbuf_addf(&header, "%s%snew mode %06o%s\n", line_prefix, set, two->mode, reset);
+			strbuf_addf(&header, "%s%sold mode %06o%s\n", line_prefix, meta, one->mode, reset);
+			strbuf_addf(&header, "%s%snew mode %06o%s\n", line_prefix, meta, two->mode, reset);
 			must_show_header = 1;
 		}
 		if (xfrm_msg)
