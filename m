From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-rebase: Teach rebase "-" shorthand.
Date: Wed, 19 Mar 2014 10:53:01 -0700
Message-ID: <xmqqob123wjm.fsf@gitster.dls.corp.google.com>
References: <xmqq61nb8fap.fsf@gitster.dls.corp.google.com>
	<1395226935-53044-1-git-send-email-modocache@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Tim Chase <git@tim.thechases.com>
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 18:53:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQKfx-0007H0-TD
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 18:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbaCSRxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 13:53:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61886 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152AbaCSRxF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 13:53:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAB9B750E1;
	Wed, 19 Mar 2014 13:53:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=opGOTI466aHLAzRCxrBCSP0p3Mg=; b=vnbGO8
	Q5kM/+1Abq96y00p1mgf2ymQqaO2qqHAIteeC1nAnAJYuN8VqqKyfu4mtvTM2tkF
	ftQhg6wp7yCsnIjFLnp7tN4fNo1aI4IRZnqB/KPVO7bmcO7M0bAEhJxphkPv7wDp
	6LTrWD6siqXPZjBmH13CFtWgSyGrVu9RnMAGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z3LchvZnmVjLSyDYXFbJauTnhHYie6Bc
	UPb2jqLM1qF9eUHOSJyY+FkaMNo88lJ6vxuraptRC5TNOXzDiBopoPvYYK4AJ8c4
	l7pOZdkXVdOQfoDUUltdOb7DmHgT3ujSj2h0tDRuof41kd08+GhW9cttGAo9gNtm
	9Ta6319VedQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5536750DF;
	Wed, 19 Mar 2014 13:53:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 164C7750DE;
	Wed, 19 Mar 2014 13:53:04 -0400 (EDT)
In-Reply-To: <1395226935-53044-1-git-send-email-modocache@gmail.com> (Brian
	Gesiak's message of "Wed, 19 Mar 2014 20:02:15 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 51EE343A-AF8F-11E3-A132-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244470>

Brian Gesiak <modocache@gmail.com> writes:

> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 6d94b1f..6176754 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -88,6 +88,17 @@ test_expect_success 'rebase from ambiguous branch name' '
>  	git rebase master
>  '
>  
> +test_expect_success 'rebase using shorthand' '
> +	git checkout master &&
> +	git checkout -b shorthand HEAD^ &&
> +	git rebase - 1>shorthand.stdout &&
> +	git checkout master &&
> +	git branch -D shorthand &&
> +	git checkout -b shorthand HEAD^ &&
> +	git rebase @{-1} 1>without_shorthand.stdout &&
> +	test_i18ncmp without_shorthand.stdout shorthand.stdout
> +'

A handful of issues here:

 * "1>target" looks unconventional and wastes readers' time, forcing
   them to wonder if there is anything special going on, only to
   realize there isn't anything noteworthy.  Saying ">target" like
   everybody else does avoids attracting unnecessary attention.

 * "rebase using shorthand" is somewhat a myopic title; it assumes
   that the only short-hand relevant to rebase will be that a "-"
   stands for "@{-1}" to specify the branch we rebase the current
   branch off of.

 * The usual filename for the output from the command being tested
   is 'actual', and the usual filename for the expected output is
   'expect'.  In this case, you are verifying that the output from
   "rebase -" is the same as the output from "rebase @{-1}", so it
   is more conventional to call the former 'actual' and the latter
   'expect'.

 * Is the eye-candy output to the standard output what is the most
   interesting during the execution of a rebase?  Wouldn't we be
   more interested to make sure that we did transplant the history
   on the same commit between two cases?

   "rebase -" with your change still says something like this:

        First, rewinding head to replay your work on top of it...
        Fast-forwarded HEAD to @{-1}.

   instead of "Fast-forwarded HEAD to -".  Somebody may later want
   to "fix" this, making these two eye-candy output to be different
   from each other, and what your test expects will no longer hold
   (not that I think it is better to say "-" instead of @{-1}
   there).


I'll tentatively queue it with a minor tweak (see below).

Thanks.

-- >8 --
From: Brian Gesiak <modocache@gmail.com>
Date: Wed, 19 Mar 2014 20:02:15 +0900
Subject: [PATCH] rebase: allow "-" short-hand for the previous branch

Teach rebase the same shorthand as checkout and merge to name the
branch to rebase the current branch on; that is, that "-" means "the
branch we were previously on".

Requested-by: Tim Chase <git@tim.thechases.com>
Signed-off-by: Brian Gesiak <modocache@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase.sh     |  4 ++++
 t/t3400-rebase.sh | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index 8a3efa2..658c003 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -449,6 +449,10 @@ then
 		test "$fork_point" = auto && fork_point=t
 		;;
 	*)	upstream_name="$1"
+		if test "$upstream_name" = "-"
+		then
+			upstream_name="@{-1}"
+		fi
 		shift
 		;;
 	esac
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 6d94b1f..80e0a95 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -88,6 +88,23 @@ test_expect_success 'rebase from ambiguous branch name' '
 	git rebase master
 '
 
+test_expect_success 'rebase off of the previous branch using "-"' '
+	git checkout master &&
+	git checkout HEAD^ &&
+	git rebase @{-1} >expect.messages &&
+	git merge-base master HEAD >expect.forkpoint &&
+
+	git checkout master &&
+	git checkout HEAD^ &&
+	git rebase - >actual.messages &&
+	git merge-base master HEAD >actual.forkpoint &&
+
+	test_cmp expect.forkpoint actual.forkpoint &&
+	# the next one is dubious---we may want to say "-",
+	# instead of @{-1}, in the message
+	test_i18ncmp expect.messages actual.messages
+'
+
 test_expect_success 'rebase a single mode change' '
 	git checkout master &&
 	git branch -D topic &&
-- 
1.9.1-423-g4596e3a
