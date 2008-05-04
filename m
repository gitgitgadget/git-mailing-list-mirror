From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] diff: make "too many files" rename warning optional
Date: Sat, 03 May 2008 17:10:57 -0700
Message-ID: <7vy76rrkry.fsf@gitster.siamese.dyndns.org>
References: <20080430172136.GA22601@sigill.intra.peff.net>
 <20080430172553.GC23747@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 04 02:12:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsRpj-0004N3-Ij
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 02:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163AbYEDALQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 20:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754821AbYEDALQ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 20:11:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38096 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753068AbYEDALP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 20:11:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3EC5E4132;
	Sat,  3 May 2008 20:11:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 002F14131; Sat,  3 May 2008 20:11:07 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9BD3EFC6-196E-11DD-8E2C-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81121>

Jeff King <peff@peff.net> writes:

> In many cases, the warning ends up as clutter, because the
> diff is being done "behind the scenes" from the user (e.g.,
> when generating a commit diffstat), and whether we show
> renames or not is not particularly interesting to the user.
>
> However, in the case of a merge (which is what motivated the
> warning in the first place), it is a useful hint as to why a
> merge with renames might have failed.
>
> This patch makes the warning optional based on the code
> calling into diffcore. We default to not showing the
> warning, but turn it on for merges.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This neglects the case where the user specifically does a diff asking
> for renames, but we turn it off. Maybe when "-M" is specified on the
> commandline to git-diff, we should set this option as well.

That sounds sensible.  Like this?

diff --git a/diff.c b/diff.c
index f735519..e8a9286 100644
--- a/diff.c
+++ b/diff.c
@@ -2443,6 +2443,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
 			return -1;
 		options->detect_rename = DIFF_DETECT_RENAME;
+		options->warn_on_too_large_rename = 1;
 	}
 	else if (!prefixcmp(arg, "-C")) {
 		if (options->detect_rename == DIFF_DETECT_COPY)
@@ -2450,6 +2451,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
 			return -1;
 		options->detect_rename = DIFF_DETECT_COPY;
+		options->warn_on_too_large_rename = 1;
 	}
 	else if (!strcmp(arg, "--no-renames"))
 		options->detect_rename = 0;
