From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] i18n: use test_i18ncmp in t2020 (checkout --detach)
Date: Fri, 13 Apr 2012 17:59:01 -0500
Message-ID: <20120413225901.GA13220@burratino>
References: <20110320090111.GA15641@sigill.intra.peff.net>
 <20110320090918.GB15948@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 14 00:59:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIpSz-0002gQ-Ee
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 00:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756116Ab2DMW7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 18:59:12 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54939 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586Ab2DMW7K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 18:59:10 -0400
Received: by iagz16 with SMTP id z16so4867434iag.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 15:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jVBE2xdOKkVel8M4BKlY7W4YTSl0uEqcuIQSILFjl0k=;
        b=y61NqZaqDJ8XEZ64OWtNznraVuQHlXFEDQ8MrK57kk+3vlFbXwGTr+xSRV93dbax3j
         y6g+yhJjyCNN9BBUjtE/J90jZFJubKq19pAdZ8xA6RhJRhQyoFf07f/vimjAMTcOO9Zr
         OzBItuL+pwTmy7BSlECHr/h9vHEBdfDePWwm1qzoDM+kmzWle26NfEMPqNAbHZolPkEs
         td2hUQVkEZJHjAY58czoWgBVP2eK0lDhMT9jS4IAfris3IT2655OBtf9zldpobafzakD
         7/Xig5OIIyNbo82W/svhRLGrKkTGgsKps+dInfkWOYOPol5DXmszPsH943SW+GdXklg5
         Ip3g==
Received: by 10.50.179.104 with SMTP id df8mr4609igc.11.1334357949053;
        Fri, 13 Apr 2012 15:59:09 -0700 (PDT)
Received: from burratino (adsl-99-24-202-99.dsl.chcgil.sbcglobal.net. [99.24.202.99])
        by mx.google.com with ESMTPS id m4sm168732igw.1.2012.04.13.15.59.07
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 15:59:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110320090918.GB15948@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195452>

When v1.7.5-rc0~19^2~1 (checkout: clear commit marks after detached-orphan
check, 2011-03-20) added a check that the human-readable message

	Your branch is behind 'master' by 1 commit, and can be fast-forwarded.

is not suppressed by a previous commit walk, it forgot that the
message might be different when git is configured to write output in
another language.  Skip the output check in that case.

With this patch applied, the test passes with GETTEXT_POISON=true again.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

Jeff King wrote:

> When leaving a detached HEAD, we do a revision walk to make
> sure the commit we are leaving isn't being orphaned.
> However, this leaves crufty marks in the commit objects
> which can confuse later walkers, like the one in
> stat_tracking_info.
>
> Let's clean up after ourselves to prevent this conflict.

Very nice thing to do.  Thanks.

[...]
> --- a/t/t2020-checkout-detach.sh
> +++ b/t/t2020-checkout-detach.sh
> @@ -126,4 +126,17 @@ test_expect_success 'checkout does not warn leaving reachable commit' '
>  	check_no_orphan_warning stderr
>  '
>
> +cat >expect <<'EOF'
> +Your branch is behind 'master' by 1 commit, and can be fast-forwarded.
> +EOF
> +test_expect_success 'tracking count is accurate after orphan check' '
> +	reset &&
> +	git branch child master^ &&
> +	git config branch.child.remote . &&
> +	git config branch.child.merge refs/heads/master &&
> +	git checkout child^ &&
> +	git checkout child >stdout &&
> +	test_cmp expect stdout

Should use test_i18ncmp to handle people who force tests to run in
other locales (like the fake GETTEXT_POISON locale).  Quick patch
follows.

 t/t2020-checkout-detach.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 068fba4c..b37ce25c 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -148,7 +148,7 @@ test_expect_success 'tracking count is accurate after orphan check' '
 	git config branch.child.merge refs/heads/master &&
 	git checkout child^ &&
 	git checkout child >stdout &&
-	test_cmp expect stdout
+	test_i18ncmp expect stdout
 '
 
 test_done
-- 
1.7.10
