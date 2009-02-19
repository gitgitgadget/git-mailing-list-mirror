From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Avoid segfault with 'git branch' when the HEAD is
	detached
Date: Wed, 18 Feb 2009 19:45:04 -0500
Message-ID: <20090219004504.GB25808@coredump.intra.peff.net>
References: <cover.1234980819u.git.johannes.schindelin@gmx.de> <ad680bce413ddea084d84b3fcd7c4cc356c3cb0e.1234980819u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jay Soffian <jaysoffian@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 19 01:46:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZx3u-0001x2-Tx
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 01:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbZBSApK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 19:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbZBSApJ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 19:45:09 -0500
Received: from peff.net ([208.65.91.99]:59213 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812AbZBSApI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 19:45:08 -0500
Received: (qmail 18117 invoked by uid 107); 19 Feb 2009 00:45:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 18 Feb 2009 19:45:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2009 19:45:04 -0500
Content-Disposition: inline
In-Reply-To: <ad680bce413ddea084d84b3fcd7c4cc356c3cb0e.1234980819u.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110597>

On Wed, Feb 18, 2009 at 07:14:59PM +0100, Johannes Schindelin wrote:

> A recent addition to the ref_item struct was not taken care of, leading
> to a segmentation fault when accessing the (uninitialized) "dest" member.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> 	Unfortunately not found by valgrind.

Meaning that the bug was created after your valgrind testing (which
takes a painfully long time to run, and so only happens occasionally),
and therefore you found it by hand? Or meaning that even running the
test suite with valgrind did not reveal the problem?

If the latter, isn't that an indication that this code path was not
being exercised by the test suite and it should be?

Now if only we had a way of measuring test coverage...

> --- a/builtin-branch.c
> +++ b/builtin-branch.c
> @@ -441,7 +441,9 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
>  	    is_descendant_of(head_commit, with_commit)) {
>  		struct ref_item item;
>  		item.name = xstrdup("(no branch)");
> +		item.len = strlen(item.name);
>  		item.kind = REF_LOCAL_BRANCH;
> +		item.dest = NULL;
>  		item.commit = head_commit;
>  		if (strlen(item.name) > ref_list.maxwidth)
>  			ref_list.maxwidth = strlen(item.name);

Maybe replace the repeated strlens below with item.len? I.e., squash in

diff --git a/builtin-branch.c b/builtin-branch.c
index 13e4de8..14d4b91 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -443,8 +443,8 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 		item.kind = REF_LOCAL_BRANCH;
 		item.dest = NULL;
 		item.commit = head_commit;
-		if (strlen(item.name) > ref_list.maxwidth)
-			ref_list.maxwidth = strlen(item.name);
+		if (item.len > ref_list.maxwidth)
+			ref_list.maxwidth = item.len;
 		print_ref_item(&item, ref_list.maxwidth, verbose, abbrev, 1, "");
 		free(item.name);
 	}

Other than that, patch looks obviously correct (and I did a quick scan
to see that there were no other locations).

-Peff
