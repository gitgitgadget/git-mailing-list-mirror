From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] commit -c/-C/--amend: reset timestamp and authorship to committer with --reset-author
Date: Wed, 04 Nov 2009 07:38:22 +0900
Message-ID: <20091104073822.6117@nanako3.lavabit.com>
References: <1257282551-9999-1-git-send-email-erick.mattos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 23:40:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5S3b-00017b-SU
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 23:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755105AbZKCWko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 17:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754711AbZKCWko
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 17:40:44 -0500
Received: from karen.lavabit.com ([72.249.41.33]:38300 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754524AbZKCWkn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 17:40:43 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 46B7111B7BF;
	Tue,  3 Nov 2009 16:40:49 -0600 (CST)
Received: from 5889.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id FV6KN80Y0BX2; Tue, 03 Nov 2009 16:40:49 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=qfTIZJ2uGPLXaQmRMWXT4IK4Bw0B1NM6TCiO/tOzI55InVPLc8S0v7UTFV1YbwJkiBu2EShVCrujH2bRihQ1MuimZ+t9mkxv6+4cA2CBIDR0/b6AQ8t/NQBnJ1JXD6XcOSGlEZ+Izj1/8y9Qp4ttrWXjNjyhuN12aEMlAhnhW2Q=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1257282551-9999-1-git-send-email-erick.mattos@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132006>

Quoting Erick Mattos <erick.mattos@gmail.com>

> When we use one of the options above we are normally trying to do mainly
> two things: using the source as a template or recreating a commit with
> corrections.
>
> When they are used, the authorship and timestamp recorded in the newly
> created commit are always taken from the original commit.  And they
> should not when we are using it as a template or when our change to the
> code is so significant that we should take over the authorship (with the
> blame for bugs we introduce, of course).
>
> The new --reset-author option is meant to solve this need by
> regenerating the timestamp and setting as the new author the committer
> or the one specified by --author option.
>
> Signed-off-by: Erick Mattos <erick.mattos@gmail.com>
> ---

If you are sending an update to a previous patch (I am comparing
this patch with the "show by example" patch Junio sent on 11/02 
http://article.gmane.org/gmane.comp.version-control.git/131893), 
it is a common courtesy to summarize what you changed relative 
to the base version after the three dashes line, so that people 
will know which part can be skipped while reviewing your patch.

I was originally puzzled by Junio's "mine" because I thought 
"what does taking over the authorship have to do with digging 
diamonds out of earth?". "reset-author" makes it very clear,
and I think it is a much better name for the option.

Your first paragraph mentions "one of the options", but subject 
mentions four (-c, -C, --amend and --reset-author) and you want 
only the first three of them.

The second paragraph of gmane/131893 says "borrow the commit log 
message" instead of repeating "a template". It has the effect of 
clarifying that only the message part is borrowed but not the 
authorship information.

I think gmane/131893 has much better description than your first 
two paragraphs for the these reasons.

> diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
> new file mode 100755
> index 0000000..7290242
> --- /dev/null
> +++ b/t/t7509-commit.sh

I have to say that the test script is much worse than what 
gmane/131893 had.

The old test made sure that -C copied the message, with or 
without the --mine option. But this test only checks the 
author line (and it doesn't even make sure that "^author" 
matches only in the header). The messages are unchecked, 
and it will let a bug when someone breaks --reset-author 
logic in the future in such a way that it corrupts the 
message by mistake go unnoticed.

Also the old test was much more readable because it used 
shell functions to avoid repeating cat-file and pipe to sed 
script. It also tagged the initial commit, which had a nice 
effect that a failure in any intermediate test will not change 
which earlier commit is reused (eg. yours say "-C HEAD^" but 
old test said "-C Initial").

It looks silly to create an "Initial Commit" in the middle 
of history, too (^_^).

I think it is much better to replace "--mine" in gmane/131893 
with "--reset-author" and make no other change to the test.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
