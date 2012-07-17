From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Fix notes handling in rev-list
Date: Mon, 16 Jul 2012 23:46:40 -0400
Message-ID: <20120717034640.GB20945@sigill.intra.peff.net>
References: <20120325005504.GA27651@sigill.intra.peff.net>
 <1342463409-6919-1-git-send-email-jukka.lehtniemi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jukka Lehtniemi <jukka.lehtniemi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 05:46:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqykL-0008Pe-3g
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 05:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869Ab2GQDqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 23:46:45 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:33862
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752330Ab2GQDqn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 23:46:43 -0400
Received: (qmail 3409 invoked by uid 107); 17 Jul 2012 03:46:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jul 2012 23:46:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2012 23:46:40 -0400
Content-Disposition: inline
In-Reply-To: <1342463409-6919-1-git-send-email-jukka.lehtniemi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201586>

On Mon, Jul 16, 2012 at 09:30:09PM +0300, Jukka Lehtniemi wrote:

> @@ -111,6 +112,7 @@ static void show_commit(struct commit *commit, void *data)
>  		ctx.date_mode = revs->date_mode;
>  		ctx.date_mode_explicit = revs->date_mode_explicit;
>  		ctx.fmt = revs->commit_format;
> +		ctx.show_notes = revs->show_notes;
>  		pretty_print_commit(&ctx, commit, &buf);
>  		if (revs->graph) {
>  			if (buf.len) {

Makes sense. We were just failing to propagate the show_notes flag to
the pretty-print code, as log-tree does.

> @@ -159,6 +161,12 @@ static void show_commit(struct commit *commit, void *data)
>  	} else {
>  		if (graph_show_remainder(revs->graph))
>  			putchar('\n');
> +		if (revs->show_notes_given) {
> +			struct strbuf buf = STRBUF_INIT;
> +			format_display_notes(commit->object.sha1, &buf, 0, NOTES_SHOW_HEADER|NOTES_INDENT); 
> +			fwrite(buf.buf, 1, buf.len, stdout);
> +			strbuf_release(&buf);
> +		}

But why are we using show_notes_given here instead of show_notes? The
former is about "did we get any kind of --notes option on the
command-line". So doing "git rev-list --no-notes" would trigger it,
which seems wrong. We should simply be checking show_notes again, no?

Also, it seems odd to me to show the notes after graph_show_remainder.
Your first hunk is about passing the notes option to the pretty-printer,
which handles graph output already, and looks like this:

  $ git rev-list --oneline --graph --notes -2 HEAD
  * f6bbb09 Fix notes handling in rev-list
  | Notes:
  |     foobar
  | 
  * 31c7954 Update draft release notes for 7th batch

Just like log, the notes are part of the commit information to the right
of the graph. But this second hunk is for when we are not using the
pretty-printer at all, and the output looks like this:

  $ git rev-list --graph --notes -2 HEAD
  * f6bbb09529a4cc73446c7c115ac1468477bd0cc6

  Notes:
      foobar
  * 31c79549b85c6393be4f40432f5b86ebc097fc7e

which doesn't make sense; we've broken the graph with our notes output.
I think you would need to feed the output to the graph code. Something
like:

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ff5a383..dbe7349 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -157,6 +159,13 @@ static void show_commit(struct commit *commit, void *data)
 		}
 		strbuf_release(&buf);
 	} else {
+		if (revs->show_notes) {
+			struct strbuf buf = STRBUF_INIT;
+			format_display_notes(commit->object.sha1, &buf, 0,
+					     NOTES_SHOW_HEADER|NOTES_INDENT);
+			graph_show_commit_msg(revs->graph, &buf);
+			strbuf_release(&buf);
+		}
 		if (graph_show_remainder(revs->graph))
 			putchar('\n');
 	}

Except that it seems to introduce an extra newline before the notes, and
it is probably an abuse of graph_show_commit_msg (there is a
graph_show_strbuf which graph_show_commit_msg is built around, and it
could perhaps be made public). I'd look at how log-tree handles it for
inspiration.

> diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> index f94f0c4..ab616a0 100755
> --- a/t/t6006-rev-list-format.sh
> +++ b/t/t6006-rev-list-format.sh
> [...]
> @@ -19,6 +20,25 @@ test_cmp expect.$1 output.$1
>  "
>  }
>  
> +test_expect_success 'notes switch' "
> +cat >expect.notes_switch <<'EOF'
> +131a310eb913d107dd3c09a65d1651175898735d
> +
> +Notes:
> +    note foo
> +86c75cfd708a0e5868dc876ed5b8bb66c80b4873
> +EOF
> +git rev-list --notes master >output.notes_switch &&
> +test_cmp expect.notes_switch output.notes_switch
> +"
> +
> +test_format notes %N <<'EOF'
> +commit 131a310eb913d107dd3c09a65d1651175898735d
> +note foo
> +
> +commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
> +EOF
> +

Nice. Of the four behaviors I mentioned in my previous review:

  1. --notes shows notes

  2. --no-notes does not show notes

  3. when no options are given, notes are not displayed

  4. --format=%N shows notes

this tests 2 of them (1 and 4). I don't know if it is worth testing (2),
as it should not do anything (though it actually is broken with your
patch). It is definitely worth making sure (3) works, but it is
implicitly checked by the other tests in the script (which would break
if we started showing notes). Still, it might be worth adding an
explicit "rev-list does not show notes by default" to make sure it is
clearly documented with a test.

-Peff
