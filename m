From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-p4: use "p4 fstat" to interpret View setting
Date: Fri, 2 Aug 2013 17:53:59 -0400
Message-ID: <20130802215359.GB9142@padd.com>
References: <CACGba4yGZDnr-1R-6k-sZoh4P=fu9M0bsmH3uoqj3tXUPsZRYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kazuki saitoh <ksaitoh560@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 02 23:54:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5NIW-0001q1-TW
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 23:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896Ab3HBVyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 17:54:04 -0400
Received: from honk.padd.com ([74.3.171.149]:53441 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994Ab3HBVyD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 17:54:03 -0400
Received: from arf.padd.com (unknown [50.105.10.190])
	by honk.padd.com (Postfix) with ESMTPSA id 06F9A2B8F;
	Fri,  2 Aug 2013 14:54:02 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8F0C827321; Fri,  2 Aug 2013 17:53:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CACGba4yGZDnr-1R-6k-sZoh4P=fu9M0bsmH3uoqj3tXUPsZRYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231538>

ksaitoh560@gmail.com wrote on Fri, 02 Aug 2013 17:02 +0900:
> I trying clone Perforce project and I found git-p4. It's a great tool!
> 
> And I don't know how to exclude special extension file in a directory?
> (Practically, I want to exclude Excel files at git p4 clone/sync.)
> 
> In Perforce, View setting of p4 client can describe
>   -//depot/project/files/*.xls //client/project/files/*.xls
> to exclude Excel files.
> But "git p4 --use-client-spec" cannot support '*'.
> 
> In git-p4.py, "map_in_client" method analyzes View setting and return
> client file path.
> So I modify the method to just use p4 command, "p4 fstat -T clientFile".
> 
> I'd like to know your opinions about that and what you think about the
> suggestion.

This is either incredibly brilliant or fundamentally broken.  I'm
hoping for the former.  :)

Your theory is:  there is a client spec, and p4 knows how to
interpret these things, so instead of figuring out and
implementing the algorithms for %% and * and ... in git-p4, just
ask p4 directly.

Let me play with this for a bit.  I wonder about the performance
aspects of doing a "p4 fstat" for every file.  Would it be
possible to do one or a few batch queries higher up somewhere?

A few nit-picky questions below, just on the test bits, while I
play with your code.

> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> index 2098b9b..fbda1ad 100644
> --- a/t/lib-git-p4.sh
> +++ b/t/lib-git-p4.sh
> @@ -48,6 +48,9 @@ P4DPORT=$((10669 + ($testid - $git_p4_test_start)))
>  P4PORT=localhost:$P4DPORT
>  P4CLIENT=client
>  P4EDITOR=:
> +P4USER=""
> +P4PASS=""
> +P4CHARSET=""

Why do you need these?

> diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
> index 2bf142d..b97bdda 100755
> --- a/t/t9801-git-p4-branch.sh
> +++ b/t/t9801-git-p4-branch.sh
> @@ -480,6 +480,7 @@ test_expect_success 'use-client-spec detect-branches
> skips branches setup' '
>  test_expect_success 'use-client-spec detect-branches skips branches' '
>   client_view "//depot/usecs/... //client/..." \
>      "-//depot/usecs/b3/... //client/b3/..." &&
> +    ( p4 sync ) &&
>   test_when_finished cleanup_git &&

How does the p4 sync help here?

> +test_expect_success 'view wildcard *' '
> + client_view "//depot/... //client/..." \
> + "-//depot/dir1/*.junk //client/dir1/*.junk" \
> + "-//depot/dir2/*.junk //client/dir2/*.junk" &&
> + (p4 sync ) &&
> + files="dir1/file11 dir1/file12 dir2/file21 dir2/file22" &&
> + client_verify $files &&
> + git p4 clone --use-client-spec --dest="$git" //depot &&
> + git_verify $files
> +'

It works!  Cool.

		-- Pete
