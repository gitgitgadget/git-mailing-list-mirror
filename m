From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 04/18] merge-octopus: Abort if index not clean
Date: Fri, 08 Apr 2016 12:31:35 -0700
Message-ID: <xmqq4mbbx5go.fsf@gitster.mtv.corp.google.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
	<1460098726-5958-5-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 21:31:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoc88-0008Hw-Fk
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 21:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbcDHTbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 15:31:38 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60789 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932099AbcDHTbi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 15:31:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E5A9151F5E;
	Fri,  8 Apr 2016 15:31:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3O/BU/aMzRJ49PYM7Cw4g5OOFgQ=; b=QdNDXS
	WN4f7/gjDuU6mKJ+zoROx8LaVcJCBs//vwP0leHcsfBWuw82lmxQ1bsU/t+ZPaa7
	+RupXjPh8l3Gzd9hCq8MBH3JfvHcRLwsWOt0i+mXGsDwgWh9s3rekOnmmgSg1KXo
	62d6MKhcqMgZDqSzg2kfZsovrFQNNOLPeYiWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C9/QeacWUloUDdRIKoCBlRdnLdyi0sWl
	kLYnVsQHzbcbYQIPo++P8Ga+5Cz7bgfUSp10GDpa8xlZRtkFOWYczrQuZbD//oIX
	77DEQRV4PlluF0Omannv50z4r9KMNTsb0SyCMyFLmZpMWhUA+XwgjjPWqwFQCa4o
	qlM7YzmB1dQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DC67751F5D;
	Fri,  8 Apr 2016 15:31:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4BC7B51F5C;
	Fri,  8 Apr 2016 15:31:36 -0400 (EDT)
In-Reply-To: <1460098726-5958-5-git-send-email-newren@gmail.com> (Elijah
	Newren's message of "Thu, 7 Apr 2016 23:58:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 821E631A-FDC0-11E5-9961-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291057>

Elijah Newren <newren@gmail.com> writes:

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  git-merge-octopus.sh                     |  5 +++++
>  t/t6044-merge-unrelated-index-changes.sh | 21 ++++++---------------
>  2 files changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
> index 8643f74..a1d7702 100755
> --- a/git-merge-octopus.sh
> +++ b/git-merge-octopus.sh
> @@ -44,6 +44,11 @@ esac
>  # MRC is the current "merge reference commit"
>  # MRT is the current "merge result tree"
>  
> +if ! git diff-index --quiet --cached HEAD --; then

Style.

> +    echo "Error: Your local changes to the following files need to be resolved before merge"
> +    git diff-index --cached --name-only HEAD -- | sed -e 's/^/    /'
> +    exit 2
> +fi

Unless they are existing conflicts, the word "resolve" is misleading.

Erroring it out may not strictly be necessary (i.e. as Octopus is
meant to be used only when changes from the branches do not overlap,
it is likely that all of them are small simple changes that do not
touch any path that you currently have local modifications in the
index), but I do not think it is worth the effort to identify safe
cases that can continue, so I agree that this change to abort the
merge is a sensible one.



>  MRC=$(git rev-parse --verify -q $head)
>  MRT=$(git write-tree)
>  NON_FF_MERGE=0
> diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
> index 726c898..4c1dc5a 100755
> --- a/t/t6044-merge-unrelated-index-changes.sh
> +++ b/t/t6044-merge-unrelated-index-changes.sh
> @@ -105,43 +105,34 @@ test_expect_success 'recursive' '
>  	test_must_fail git merge -s recursive C^0
>  '
>  
> -test_expect_failure 'octopus, unrelated file touched' '
> +test_expect_success 'octopus, unrelated file touched' '
>  	git reset --hard &&
>  	git checkout B^0 &&
>  
>  	touch random_file && git add random_file &&
>  
>  	echo "I think the next line should fail, but maybe it was intended..." &&
> -	test_might_fail git merge C^0 D^0 &&
> -
> -	echo "No matter what, random_file should NOT be part of HEAD" &&
> -	test_must_fail git rev-parse HEAD:random_file
> +	test_must_fail git merge C^0 D^0
>  '
>  
> -test_expect_failure 'octopus, related file removed' '
> +test_expect_success 'octopus, related file removed' '
>  	git reset --hard &&
>  	git checkout B^0 &&
>  
>  	git rm b &&
>  
>  	echo "I think the next line should fail, but maybe it was intended..." &&
> -	test_might_fail git merge C^0 D^0 &&
> -
> -	echo "No matter what, b should still be in HEAD" &&
> -	git cat-file -p HEAD:b | grep b$
> +	test_must_fail git merge C^0 D^0
>  '
>  
> -test_expect_failure 'octopus, related file modified' '
> +test_expect_success 'octopus, related file modified' '
>  	git reset --hard &&
>  	git checkout B^0 &&
>  
>  	echo 12 >>a && git add a &&
>  
>  	echo "I think the next line should fail, but maybe it was intended..." &&
> -	test_might_fail git merge C^0 D^0 &&
> -
> -	echo "No matter what, 12 should NOT be in the copy of a from HEAD" &&
> -	git cat-file -p HEAD:a | test_must_fail grep 12
> +	test_must_fail git merge C^0 D^0
>  '
>  
>  test_expect_success 'ours' '
