From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/4] t4011: illustrate "diff-index -p" on stat-dirty paths
Date: Thu, 1 Mar 2012 10:05:59 +0100
Message-ID: <87399slmh4.fsf@thomas.inf.ethz.ch>
References: <1330568057-27304-1-git-send-email-gitster@pobox.com>
	<1330568057-27304-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 10:06:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S31xq-0002n9-Vy
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 10:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121Ab2CAJGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 04:06:11 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:10287 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965119Ab2CAJGF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 04:06:05 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 10:05:56 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 10:06:00 +0100
In-Reply-To: <1330568057-27304-3-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Wed, 29 Feb 2012 18:14:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191908>

Junio C Hamano <gitster@pobox.com> writes:

> The plumbing that looks at the working tree, i.e. "diff-index" and
> "diff-files", always emit the "diff --git a/path b/path" header lines
> without anything else for paths that are only stat-dirty (i.e. different
> only because the cached stat information in the index no longer matches
> that of the working tree, but the real contents are the same), when
> these commands are run with "-p" option to produce patches.
>
> Illustrate this current behaviour.  The new part that uses "-w" option
> demonstrates that we do not show any "diff --git" header for blobs whose
> true contents are different but compares the same when whitespaces are
> ignored, which is inconsistent with the behaviour for stat-dirty paths.
[...]
> -test_expect_success SYMLINKS 'diff identical, but newly created symlink' '
> +test_expect_success SYMLINKS 'diff identical, but newly created symlink and file' '
>  	cat >expected <<-\EOF &&
>  	diff --git a/frotz b/frotz
> +	diff --git a/nitfol b/nitfol
>  	EOF
> +	sleep 3 &&
> +	rm -f frotz &&
> +	echo xyzzy >nitfol3 &&
> +	mv nitfol3 nitfol &&
>  	ln -s xyzzy frotz &&
>  	git diff-index -M -p $tree >current &&
> +	compare_diff_patch expected current &&
> +
> +	>expected &&
> +	git diff-index -M -p -w $tree >current &&
>  	compare_diff_patch expected current
>  '

I find the last bit of the commit message rather confusing.  You appear
to be using -w here to diff the stat-dirty worktree nitfol 'xyzzy\n'
against the $tree:nitfol which is also 'xyzzy\n'.

If that analysis is correct, then

  we do not show any "diff --git" header for blobs whose true contents
  are different but compares the same when whitespaces are ignored

is not what is going on here; the blobs have exactly the same content.
The difference is that

* without -w, the code "knows" from the lstat() data that the files are
  different, prints a header, and then fails to find any differences;

* with -w, the code correctly holds off on printing anything since it
  will invariably have to inspect the contents beforehand.

So perhaps you can say

  Illustrate this current behaviour.  Also demonstrate that with the
  "-w" option, we (correctly) hold off showing a "diff --git" header
  until actual differences have been found.  This also suppresses the
  header for merely stat-dirty files, which is inconsistent.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
