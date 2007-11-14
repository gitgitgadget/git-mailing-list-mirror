From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improved and extended t5404
Date: Wed, 14 Nov 2007 13:52:19 -0800
Message-ID: <7vbq9wfqb0.fsf@gitster.siamese.dyndns.org>
References: <20071112213823.GB2918@steel.home>
	<20071112213938.GC2918@steel.home>
	<20071113075240.GA21799@sigill.intra.peff.net>
	<20071113194731.GC3268@steel.home> <20071113194909.GD3268@steel.home>
	<20071113230234.GI3268@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 22:53:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsQAi-00021F-5O
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 22:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825AbXKNVwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 16:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756197AbXKNVwc
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 16:52:32 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47336 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509AbXKNVwb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 16:52:31 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id BE4CF2F2;
	Wed, 14 Nov 2007 16:52:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9B4B895A4A;
	Wed, 14 Nov 2007 16:52:47 -0500 (EST)
In-Reply-To: <20071113230234.GI3268@steel.home> (Alex Riesen's message of
	"Wed, 14 Nov 2007 00:02:34 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65017>

Alex Riesen <raa.lkml@gmail.com> writes:

> Ignore exit code of git push in t5404, as it is not relevant for the
> test: it already checks whether the references updated correctly.

I think the Subject: goes a lot better with a description like this:

	Add test that checks the case where X does Y and make
	sure Z happens.

	Because we haven't settled on what the exit status from
	"git push" command itself should be in such a partial
	failure case, do not check the exit status from it for
	now.

> diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
> index 20718d4..a51bbdc 100755
> --- a/t/t5404-tracking-branches.sh
> +++ b/t/t5404-tracking-branches.sh
> @@ -10,6 +10,7 @@ test_expect_success 'setup' '
>  	git commit -m 1 &&
>  	git branch b1 &&
>  	git branch b2 &&
> +	git branch b3 &&
>  	git clone . aa &&
>  	git checkout b1 &&
> ...

So it makes another ref "b3" point at the initial commit,... 

> ...
>  test_expect_success 'check tracking branches updated correctly after push' '
>  	cd aa &&
>  	b1=$(git rev-parse origin/b1) &&
>  	b2=$(git rev-parse origin/b2) &&
> +	b3=$(git rev-parse origin/b3) &&
>  	git checkout -b b1 origin/b1 &&
>  	echo aa-b1 >>file &&
>  	git commit -a -m aa-b1 &&

... then records what was cloned,...

> @@ -32,9 +36,28 @@ test_expect_success 'check tracking branches updated correctly after push' '
>  	git checkout master &&
>  	echo aa-master >>file &&
>  	git commit -a -m aa-master &&
> +	{
> +		git push
> +		test "$(git rev-parse origin/b1)" = "$b1" &&
> +		test "$(git rev-parse origin/b2)" = "$b2" &&
> +		test "$(git rev-parse origin/b3)" = "$b3" &&
> +		test "$(git rev-parse origin/master)" = \
> +		"$(git rev-parse master)"
> +	}
> +'

... and checks that untouched "b3" stays the same (iow, tests
up-to-date case).

> +
> +test_expect_success 'delete remote branch' '
> +	git push origin :refs/heads/b3
> +	{
> +		git rev-parse origin/b3
> +		test $? != 0 || \
> +		say "Hmm... Maybe tracking ref should be deleted?"
> +        } &&

Ah, you meant that tracking should be deleted so this should be
fixed in the code but the test is disabled for now.  Let's be a
bit more explicit about such a temporary disabled test, like
this:

	git push origin :refs/heads/b3

	# The remote-tracking branch origin/b3 should be deleted;
        # we need to update the code and enable this test.
        : git rev-parse --verify origin/b3 &&

> +	cd "$start_dir" &&
> +	{
> +		git rev-parse refs/heads/b3
> +		test $? != 0
> +        }
>  '
