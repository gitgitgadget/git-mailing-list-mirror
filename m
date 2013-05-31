From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 5/7] add tests for rebasing merged history
Date: Fri, 31 May 2013 14:19:39 +0200
Message-ID: <51A8955B.1040007@kdbg.org>
References: <1369809572-24431-1-git-send-email-martinvonz@gmail.com> <1369982987-18954-1-git-send-email-martinvonz@gmail.com> <1369982987-18954-6-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 31 14:19:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiOJD-0006dw-2C
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 14:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730Ab3EaMTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 08:19:45 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:20923 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752526Ab3EaMTp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 08:19:45 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E424010010;
	Fri, 31 May 2013 14:19:40 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 10DD119F5DE;
	Fri, 31 May 2013 14:19:40 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <1369982987-18954-6-git-send-email-martinvonz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226092>

Am 31.05.2013 08:49, schrieb Martin von Zweigbergk:
> +#       f
> +#      /
> +# a---b---c---g---h
> +#      \
> +#       d---G---i
> +#        \       \
> +#         e-------u
> +#
> +# uppercase = cherry-picked
> +# h = reverted g
...
> +test_expect_success "rebase -p --onto in merged history drops patches in upstream" "
> +	reset_rebase &&
> +	git rebase -p --onto f h u &&
> +	test_cmp_rev f HEAD~3 &&
> +	test_revision_subjects 'd i e u' HEAD~2 HEAD^2 HEAD^ HEAD
> +"
> +
> +test_expect_success "rebase -p --onto in merged history does not drop patches in onto" "
> +	reset_rebase &&
> +	git rebase -p --onto h f u &&
> +	test_cmp_rev h HEAD~3 &&
> +	test_revision_subjects 'd G i e u' HEAD~2 HEAD^2^ HEAD^2 HEAD^ HEAD
> +"

I noticed one new aspect:

The interdiff between v2 and v3 looks like this:

-test_expect_failure "rebase -p --onto in merged history does not lose patches in upstream" "
+test_expect_success "rebase -p --onto in merged history drops patches in upstream" "
 	reset_rebase &&
 	git rebase -p --onto f h u &&
 	test_cmp_rev f HEAD~3 &&
-	test_revision_subjects 'd G i e u' HEAD~2 HEAD^2^ HEAD^2 HEAD^ HEAD
+	test_revision_subjects 'd i e u' HEAD~2 HEAD^2 HEAD^ HEAD
 "
 
-test_expect_success "rebase -p --onto in merged history drops patches in onto" "
+test_expect_success "rebase -p --onto in merged history does not drop patches in onto" "
 	reset_rebase &&
 	git rebase -p --onto h f u &&
 	test_cmp_rev h HEAD~3 &&
-	test_revision_subjects 'd i e u' HEAD~2 HEAD^2 HEAD^ HEAD
+	test_revision_subjects 'd G i e u' HEAD~2 HEAD^2^ HEAD^2 HEAD^ HEAD

The expectations that these two tests check changed from v2 to v3.
Notice that former test goes from expect_failure to expect_success,
as it should, but the latter does not change. Strange, isn't it?

The reason is that this check is incomplete:

	test_revision_subjects 'd i e u' HEAD~2 HEAD^2 HEAD^ HEAD

and allowed the latter test in the v2 form to pass.

It should be

	test_revision_subjects 'd i d e u' HEAD^2^ HEAD^2 HEAD~2 HEAD^ HEAD

The check of the latter test should be:

	test_revision_subjects 'd G i d e u' HEAD^2~2 HEAD^2^ HEAD^2 HEAD~2 HEAD^ HEAD

i.e. check all the way back to the mergebase via both branches. This
can be extrapolated to all tests that reconstruct mergy history (not
just these two cases).

-- Hannes
