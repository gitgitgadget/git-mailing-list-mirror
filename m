From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] write_index: optionally allow broken null sha1s
Date: Mon, 26 Aug 2013 17:36:29 -0400
Message-ID: <20130826213628.GB25452@sigill.intra.peff.net>
References: <20130824013310.GA9343@sigill.intra.peff.net>
 <20130825061500.GR2882@elie.Belkin>
 <20130825095818.GA12556@sigill.intra.peff.net>
 <20130825195412.GA2752@elie.Belkin>
 <xmqqob8lj8dx.fsf@gitster.dls.corp.google.com>
 <20130826143135.GB14858@sigill.intra.peff.net>
 <xmqq38pwjv89.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 23:36:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE4Sj-0004CZ-DV
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 23:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271Ab3HZVgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 17:36:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:40229 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095Ab3HZVgc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 17:36:32 -0400
Received: (qmail 875 invoked by uid 102); 26 Aug 2013 21:36:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Aug 2013 16:36:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Aug 2013 17:36:29 -0400
Content-Disposition: inline
In-Reply-To: <xmqq38pwjv89.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233034>

On Mon, Aug 26, 2013 at 09:02:46AM -0700, Junio C Hamano wrote:

> > There's one subtle thing I didn't mention in the "it is already on stack
> > overflow". If you have a version of git which complains about the null
> > sha1, then the SO advice is already broken. But if the SO works, then
> > you do not have a version of git which complains. So why do you care?
> >
> > And the answer is: you may be pushing to a remote with a version of git
> > that complains, and which has receive.fsckObjects set (and in many
> > cases, that remote is GitHub, since we have had that check on for a
> > while).
> >
> > I don't know if it is worth spelling that out or not.
> 
> Probably not.
> 
> You could aim to correct each and every wrong suggestions on a site
> where misguided leads other misguided, but it is a hopeless task.

I do no think the advice on SO was misguided. My point was that a reader
of the revised commit message mentioning SO may wonder "why would people
on SO suggest that? It does not work since we introduced the check in
the first place".

But if neither you nor Jonathan wondered about it, then it is probably
not worth caring.

> >> > After this patch, do you think (in a separate change) it would make
> >> > sense for cache-tree.c::update_one() to check for null sha1 and error
> >> > out unless GIT_ALLOW_NULL_SHA1 is true?  That would let us get rid of
> >> > the caveat from the last paragraph.
> [...]

Hmm. We are already complaining about the null sha1 in most cases,
because we do not have the object. It is only for submodules that the
bogus entry can make it into a tree.  So I tried this:

diff --git a/cache-tree.c b/cache-tree.c
index 0bbec43..0ec3923 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -343,7 +343,8 @@ static int update_one(struct cache_tree *it,
 			entlen = pathlen - baselen;
 			i++;
 		}
-		if (mode != S_IFGITLINK && !missing_ok && !has_sha1_file(sha1)) {
+		if ((mode != S_IFGITLINK && !missing_ok && !has_sha1_file(sha1))
+		    || (mode == S_IFGITLINK && is_null_sha1(sha1))) {
 			strbuf_release(&buffer);
 			return error("invalid object %06o %s for '%.*s'",
 				mode, sha1_to_hex(sha1), entlen+baselen, path);
diff --git a/t/t7009-filter-branch-null-sha1.sh b/t/t7009-filter-branch-null-sha1.sh
index 50d5689..59c5edc 100755
--- a/t/t7009-filter-branch-null-sha1.sh
+++ b/t/t7009-filter-branch-null-sha1.sh
@@ -31,10 +31,10 @@ test_expect_success 'filter commands are still checked' '
 	git commit -a -m "back to normal"
 '
 
-test_expect_success 'filter commands are still checked' '
+test_expect_success 'complain about trees that are broken after filtering' '
 	test_must_fail git filter-branch \
 		--force --prune-empty \
-		--index-filter "git rm --cached --ignore-unmatch three.t"
+		--index-filter ""
 '
 
 test_expect_success 'removing the broken entry works' '

But it doesn't work. The reason is that we do not need to re-make the
cache-tree, because we are just handing back the crap that we got from
the original tree. And I do not think we would want to invalidate the
whole cache tree just on the off chance that it has a problem;
filter-branch is slow enough as it is.

So I think we are better off to let filter-branch run at full speed,
even if optimizations like cache-tree mean we are missing out on
validating all of the data.  If you want to know whether your repo is in
good shape, you should run `git fsck`.

-Peff

PS I got more information from the user who originally experienced this
   problem (and yes, it was a submodule entry). It turns out that he had
   done some unusual stuff with having a git repository inside his Eclipse
   project, and adding it as a sub-project of his build.  So it was
   almost certainly EGit/JGit which wrote the bad entry in the first
   place (and he is making a bug report to EGit folks).
