From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Kill bashizm in t/t3200-branch.sh and t/t7201-co.sh.
Date: Thu, 10 Apr 2008 01:34:25 -0700
Message-ID: <7v63uqxg4u.fsf@gitster.siamese.dyndns.org>
References: <20080410072500.GA10188@mysza.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Golebiowski <adamg@pld-linux.org>
X-From: git-owner@vger.kernel.org Thu Apr 10 10:35:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjsFb-0004mY-1B
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 10:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbYDJIef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 04:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbYDJIee
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 04:34:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55496 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbYDJIee (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 04:34:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C57F41C3C;
	Thu, 10 Apr 2008 04:34:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0C1E41C3B; Thu, 10 Apr 2008 04:34:29 -0400 (EDT)
In-Reply-To: <20080410072500.GA10188@mysza.eu.org> (Adam Golebiowski's
 message of "Thu, 10 Apr 2008 09:25:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79195>

Adam Golebiowski <adamg@pld-linux.org> writes:

> On systems with /bin/sh being different than /bin/bash, make test fails due
> to some bash-specific constructs. This patch makes it possible to run the
> test-suite systems with on /bin/sh pointing to /bin/ksh.
>
> Signed-off-by: Adam Golebiowski <adamg@pld-linux.org>
> ---
>  t/t3200-branch.sh |    2 +-
>  t/t7201-co.sh     |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index cb5f7a4..e8ff82f 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -200,7 +200,7 @@ test_expect_success \
>  
>  test_expect_success \
>      'branch from non-branch HEAD w/--track causes failure' \
> -    '!(git branch --track my10 HEAD^)'
> +    '! git branch --track my10 HEAD^'

I do not think you need a subshell for this particular test, so your
change would not be making anything worse, but I do not see a point.

It is a plain vanilla POSIX shell construct; "! ( compound_list )" is not a
bash-ism at all.

http://www.opengroup.org/onlinepubs/000095399/utilities/xcu_chap02.html#tag_02_10

> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 3111baa..51a9928 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -335,6 +335,6 @@ test_expect_success \
>      git checkout -b delete-me master &&
>      rm .git/refs/heads/delete-me &&
>      test refs/heads/delete-me = "$(git symbolic-ref HEAD)" &&
> -    !(git checkout --track -b track)'
> +    ! git checkout --track -b track'

Same comments apply.

Having said that, as both of these tests are trying to make sure that the
command fails gracefully (iow, say "failure" and refuse, instead of
barfing and dumping core), they could probably use test_must_fail, like
this:

     git checkout -b delete-me master &&
     rm .git/refs/heads/delete-me &&
     test refs/heads/delete-me = "$(git symbolic-ref HEAD)" &&
-    !(git checkout --track -b track)'
+    test_must_fail git checkout --track -b track'
