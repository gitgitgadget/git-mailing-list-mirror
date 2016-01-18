From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] shortlog: replace hand-parsing of author with
 pretty-printer
Date: Mon, 18 Jan 2016 18:04:35 -0500
Message-ID: <20160118230435.GA16898@sigill.intra.peff.net>
References: <20160118200136.GA9514@sigill.intra.peff.net>
 <20160118200248.GC15836@sigill.intra.peff.net>
 <20160118201337.GA15943@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 00:04:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLIqp-00067p-BU
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 00:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbcARXEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 18:04:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:55762 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755517AbcARXEi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 18:04:38 -0500
Received: (qmail 11390 invoked by uid 102); 18 Jan 2016 23:04:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 18:04:38 -0500
Received: (qmail 14938 invoked by uid 107); 18 Jan 2016 23:04:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 18:04:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jan 2016 18:04:35 -0500
Content-Disposition: inline
In-Reply-To: <20160118201337.GA15943@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284335>

On Mon, Jan 18, 2016 at 03:13:37PM -0500, Jeff King wrote:

> On Mon, Jan 18, 2016 at 03:02:48PM -0500, Jeff King wrote:
> 
> > +	format_commit_message(commit, "%an <%ae>", &author, &ctx);
> > +	/* we can detect a total failure only by seeing " <>" in the output */
> > +	if (author.len <= 3) {
> >  		warning(_("Missing author: %s"),
> >  		    oid_to_hex(&commit->object.oid));
> > [...]
> > +		goto out;
> >  	}
> 
> One note on this. In the linux.git tree, this warning actually triggers,
> because there is a commit with a bogus empty author:
> 
>   $ git log -1 --format=raw af25e94d4dc | grep ^author
>   author  <> 1120285620 -0700
> 
> Whereas in the original code, you really do get a line with a blank
> name.
> 
> I think what the new code does is quite reasonable, but I'm not sure if:
> 
>   1. People really want a syntactically valid empty name to be
>      represented.
> 
> and
> 
>   2. Regardless of the output, if kernel folks will be annoyed by the
>      warning whenever they run a full-repo shortlog.

After thinking on this, I'm in favor of removing this warning entirely.
My reasons are given in the commit message below, which can apply on top
of the series.  It could also be squashed in to 2/6, but given that it
is removing the test added by cd4f09e (shortlog: ignore commits with
missing authors, 2013-09-18), I think it's worth recording as a separate
commit.

-- >8 --
Subject: [PATCH] shortlog: don't warn on empty author

Git tries to avoid creating a commit with an empty author
name or email. However, commits created by older, less
strict versions of git may still be in the history.  There's
not much point in issuing a warning to stderr for an empty
author. The user can't do anything about it now, and we are
better off to simply include it in the shortlog output as an
empty name/email, and let the caller process it however they
see fit.

Older versions of shortlog differentiated between "author
header not present" (which complained) and "author
name/email are blank" (which included the empty ident in the
output).  But since switching to format_commit_message, we
complain to stderr about either case (linux.git has a blank
author deep in its history which triggers this).

We could try to restore the older behavior (complaining only
about the missing header), but in retrospect, there's not
much point in differentiating these cases. A missing
author header is bogus, but as for the "blank" case, the
only useful behavior is to add it to the "empty name"
collection.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/shortlog.c  |  8 --------
 t/t4201-shortlog.sh | 16 ----------------
 2 files changed, 24 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index adbf1fd..e32be39 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -149,13 +149,6 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	ctx.output_encoding = get_log_output_encoding();
 
 	format_commit_message(commit, "%an <%ae>", &author, &ctx);
-	/* we can detect a total failure only by seeing " <>" in the output */
-	if (author.len <= 3) {
-		warning(_("Missing author: %s"),
-		    oid_to_hex(&commit->object.oid));
-		goto out;
-	}
-
 	if (!log->summary) {
 		if (log->user_format)
 			pretty_print_commit(&ctx, commit, &oneline);
@@ -165,7 +158,6 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 
 	insert_one_record(log, author.buf, oneline.len ? oneline.buf : "<none>");
 
-out:
 	strbuf_release(&author);
 	strbuf_release(&oneline);
 }
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 82b2314..f5e6367 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -178,22 +178,6 @@ test_expect_success !MINGW 'shortlog encoding' '
 	git shortlog HEAD~2.. > out &&
 test_cmp expect out'
 
-test_expect_success 'shortlog ignores commits with missing authors' '
-	git commit --allow-empty -m normal &&
-	git commit --allow-empty -m soon-to-be-broken &&
-	git cat-file commit HEAD >commit.tmp &&
-	sed "/^author/d" commit.tmp >broken.tmp &&
-	commit=$(git hash-object -w -t commit --stdin <broken.tmp) &&
-	git update-ref HEAD $commit &&
-	cat >expect <<-\EOF &&
-	A U Thor (1):
-	      normal
-
-	EOF
-	git shortlog HEAD~2.. >actual &&
-	test_cmp expect actual
-'
-
 test_expect_success 'shortlog with revision pseudo options' '
 	git shortlog --all &&
 	git shortlog --branches &&
-- 
2.7.0.248.g5eafd77
