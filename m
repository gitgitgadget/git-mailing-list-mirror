From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/5] Introduce new pretty formats %g[sdD] for reflog
 information
Date: Fri, 16 Oct 2009 01:32:30 -0400
Message-ID: <20091016053230.GB10629@coredump.intra.peff.net>
References: <cover.1255645570.git.trast@student.ethz.ch>
 <012c71c4eab143691bc5e2d62b421f8c84effa0e.1255645570.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 16 07:33:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyfRb-0004sX-A1
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 07:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbZJPFdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 01:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbZJPFdK
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 01:33:10 -0400
Received: from peff.net ([208.65.91.99]:34516 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944AbZJPFdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 01:33:09 -0400
Received: (qmail 13201 invoked by uid 107); 16 Oct 2009 05:36:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 16 Oct 2009 01:36:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Oct 2009 01:32:30 -0400
Content-Disposition: inline
In-Reply-To: <012c71c4eab143691bc5e2d62b421f8c84effa0e.1255645570.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130456>

On Fri, Oct 16, 2009 at 12:41:46AM +0200, Thomas Rast wrote:

> Note that the --format="%h %gD: %gs" tests may not work in real
> repositories, as the --pretty formatter doesn't know to leave away the
> ": " on the last commit in an incomplete (because git-gc removed the
> old part) reflog.  This equivalence is nevertheless the main goal of
> this patch.

Yeah, I see what you are talking about in my git.git repo. I am tempted
to suggest cutting it out of both formats, as it is somewhat confusing,
but it does actually convey a slight bit of information (even if
information that is extremely unlikely to be of use).

I am also fine with leaving it, and if we one day invent the
"conditionally include the ': '" syntax, using it then.

> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 2a845b1..6359272 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -123,6 +123,9 @@ The placeholders are:
>  - '%s': subject
>  - '%f': sanitized subject line, suitable for a filename
>  - '%b': body
> +- '%gD': reflog selector, e.g., `refs/stash@{1}`
> +- '%gd': shortened reflog selector, e.g., `stash@{1}`
> +- '%gs': reflog subject
>  - '%Cred': switch color to red
>  - '%Cgreen': switch color to green
>  - '%Cblue': switch color to blue

Should we give a note that these do nothing if "-g" was not given?

> +	if (shorten) {
> +		if (last_ref != commit_reflog->reflogs->ref) {
> +			free(last_short_ref);
> +			last_short_ref = shorten_unambiguous_ref(commit_reflog->reflogs->ref, 0);
> +		}
> +		printed_ref = last_short_ref;

Clever. I hadn't considered caching, but you are right that
shorten_unambiguous_ref is a bit heavyweight to be calling for every
entry.

> diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
> index c18ed8e..cb8d0fd 100755
> --- a/t/t1411-reflog-show.sh
> +++ b/t/t1411-reflog-show.sh
> @@ -64,4 +64,16 @@ test_expect_success 'using --date= shows reflog date (oneline)' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '--format="%h %gD: %gs" is same as git-reflog' '
> +	git reflog >expect &&
> +	git log -g --format="%h %gD: %gs" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--format="%h %gD: %gs" is same as git-reflog (with date)' '
> +	git reflog --date=raw >expect &&
> +	git log -g --format="%h %gD: %gs" --date=raw >actual &&
> +	test_cmp expect actual
> +'

A test for '%gd' would be nice. A squashable one is below. I am tempted
to test all three forms in t6006, since the intent of that script is to
test all format specifiers. However, those tests would be somewhat
redundant with your t1411 tests.

---
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 59d1f62..d1f2476 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -162,4 +162,10 @@ test_expect_success 'empty email' '
 	}
 '
 
+test_expect_success '%gd shortens ref name' '
+	echo "master@{0}" >expect.gd-short &&
+	git log -g -1 --format=%gd refs/heads/master >actual.gd-short &&
+	test_cmp expect.gd-short actual.gd-short
+'
+
 test_done
