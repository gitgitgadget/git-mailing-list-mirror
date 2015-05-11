From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] bisect: print abbrev sha1 for first bad commit
Date: Sun, 10 May 2015 21:10:09 -0400
Message-ID: <20150511011009.GA21830@peff.net>
References: <1431128763-28453-1-git-send-email-tbsaunde@tbsaunde.org>
 <CAGZ79kYjES6DXmvQdmXLAXrKMGrnvQ-vqJuHQU2QxVC4+6M0aA@mail.gmail.com>
 <20150509014152.GA31119@tsaunders-iceball.corp.tor1.mozilla.com>
 <20150509040704.GA31428@peff.net>
 <20150510231110.GA25157@tsaunders-iceball.corp.tor1.mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Trevor Saunders <tbsaunde@tbsaunde.org>
X-From: git-owner@vger.kernel.org Mon May 11 03:10:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrcEd-0004vb-If
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 03:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbbEKBKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2015 21:10:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:56365 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751561AbbEKBKM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 21:10:12 -0400
Received: (qmail 26349 invoked by uid 102); 11 May 2015 01:10:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 10 May 2015 20:10:11 -0500
Received: (qmail 4189 invoked by uid 107); 11 May 2015 01:10:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 10 May 2015 21:10:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 May 2015 21:10:09 -0400
Content-Disposition: inline
In-Reply-To: <20150510231110.GA25157@tsaunders-iceball.corp.tor1.mozilla.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268753>

On Sun, May 10, 2015 at 07:12:45PM -0400, Trevor Saunders wrote:

> > Yeah, I have always found bisect's output somewhat silly. It prints the
> > "--raw" diff output, which is not incredibly useful. And then to top it
> > off, it does not feed the "--recursive" switch to the diff, so you don't
> > even get to see the real list of changed files.
> 
>  So, fun fact it doesn't actually always print the raw diffoutput if
>  there is no diff, for example a merge where both sides only touched
>  different files as in test 40 in t6030.

Ah, that makes sense. It's basically just feeding the commit to
"diff-tree" (except doing it internally rather than running it as a
separate program). And the defaults there do not show anything for merge
commits. It could do the equivalent of "--cc" (i.e., set the
dense_combined_merges flag in the "struct rev_info").

> > (Actually, it looks like all this is generated in bisect.c:show_diff_tree,
> > so it would have to be written in C; but it should be pretty easy to
> > tweak the display options).
> 
> yeah, that seems pretty straight forward, but I'm not really sure what
> to do about this case where no diff is printed, I guess I should figure
> out what bits need to be set for the commit to be shown anyway.

I'd argue for simply never showing the diff (dropping the "opt.diff = 1"
line from bisect.c:show_diff_tree), but that is mostly my personal
opinion. If we are going to show a diff, perhaps "--recursive
--name-status" would be the most friendly, with "--cc" for the merge
commits.

Translated into C, something like (this is completely untested):

diff --git a/bisect.c b/bisect.c
index 10f5e57..62786cf 100644
--- a/bisect.c
+++ b/bisect.c
@@ -876,6 +876,8 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	opt.abbrev = 0;
 	opt.diff = 1;
+	opt.combine_merges = 1;
+	opt.dense_combined_merges = 1;
 
 	/* This is what "--pretty" does */
 	opt.verbose_header = 1;
@@ -884,7 +886,8 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
 
 	/* diff-tree init */
 	if (!opt.diffopt.output_format)
-		opt.diffopt.output_format = DIFF_FORMAT_RAW;
+		opt.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
+	DIFF_OPT_SET(&opt.diffopt, RECURSIVE);
 
 	log_tree_commit(&opt, commit);
 }
