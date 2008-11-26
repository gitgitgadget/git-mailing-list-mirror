From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (Eek!)] git diff does not honor --no-ext-diff
Date: Tue, 25 Nov 2008 23:52:41 -0800
Message-ID: <7vprkihqk6.fsf@gitster.siamese.dyndns.org>
References: <544dda350811252312u7ef5533bwb20b37640d861487@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Nazri Ramliy" <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 08:54:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5FDz-0000Lz-4d
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 08:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbYKZHw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 02:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbYKZHw5
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 02:52:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57695 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbYKZHw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 02:52:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5317517828;
	Wed, 26 Nov 2008 02:52:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C6DD31781F; Wed,
 26 Nov 2008 02:52:43 -0500 (EST)
In-Reply-To: <544dda350811252312u7ef5533bwb20b37640d861487@mail.gmail.com>
 (Nazri Ramliy's message of "Wed, 26 Nov 2008 15:12:25 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3B75B29A-BB8F-11DD-80F8-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101708>

"Nazri Ramliy" <ayiehere@gmail.com> writes:

> git-diff does not honor the --no-ext-diff option in both cases when the external
> diff program is set via diff.external and gitattributes.
>
> Is this intentional?

Judging from 72909be (Add diff-option --ext-diff, 2007-06-30), I think
this was intended in the sense that --ext-diff and --no-ext-diff were
meant to be no-op for "diff" itself when they were introduced.

Having said that, I do not know if I agree with the original intention.
It looks more like an oversight that came from focusing only on what a new
behaviour for the "log" family should be, than a logical design decision
to exclude "diff" from this codepath.

Wouldn't this be a better patch?

 builtin-diff.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git c/builtin-diff.c w/builtin-diff.c
index 7ceceeb..b90d8bc 100644
--- c/builtin-diff.c
+++ w/builtin-diff.c
@@ -290,6 +290,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	/* Otherwise, we are doing the usual "git" diff */
 	rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
 
+	/* Default to let external be used */
+	DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
+
 	if (nongit)
 		die("Not a git repository");
 	argc = setup_revisions(argc, argv, &rev, NULL);
@@ -298,7 +301,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		if (diff_setup_done(&rev.diffopt) < 0)
 			die("diff_setup_done failed");
 	}
-	DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
+
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
 
