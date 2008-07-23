From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Respect crlf attribute in "git add" even if core.autocrlf has not been set
Date: Wed, 23 Jul 2008 07:49:20 +0200
Message-ID: <719E03C0-E8C3-4C35-AE9C-9BD5A7BCDF03@zib.de>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <7vy73tihl6.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807230203350.8986@racer> <alpine.DEB.1.00.0807230229410.8986@racer>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Dmitry Potapov <dpotapov@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 07:50:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLXFR-0006q7-9G
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 07:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbYGWFtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 01:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753057AbYGWFtS
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 01:49:18 -0400
Received: from mailer.zib.de ([130.73.108.11]:50110 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753010AbYGWFtS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 01:49:18 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6N5n13P013669;
	Wed, 23 Jul 2008 07:49:06 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db9316e.pool.einsundeins.de [77.185.49.110])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6N5mttf023071
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 23 Jul 2008 07:48:56 +0200 (MEST)
In-Reply-To: <alpine.DEB.1.00.0807230229410.8986@racer>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89602>


On Jul 23, 2008, at 3:31 AM, Johannes Schindelin wrote:

> When a file's crlf attribute is explicitely set, it does not make  
> sense
> to ignore it when adding the file, just because the config variable
> core.autocrlf has not been set.

Your patch is not about core.autocrlf unset, but about  
core.autocrlf=false.
On Unix, the two cases seem to be identical, but on Windows they are  
not.
(see below).


> The alternative would be risking to get CR/LF files into the  
> repository
> just because one user forgot to set core.autocrlf.

Git could help the user *and* the maintainer of the repository if we
chose core.autocrlf=input as the default on Unix.  We would never
let CR/LF enter the repository unless explicitly requested to do so
by core.autocrlf=false.  This setting however would not be recommended
to the average user.

But with Unix' default core.autocrlf=false, it makes sense to let the
maintainer of a repository enforce stripping CR from all files if not
explicitly configured otherwise for specific paths.  Setting  
"crlf=input"
in .gitattribute seems to be the documented way to do so --- although
the documentation in gitattributes.txt is a bit complex to read.


> This patch does not affect the case when the crlf attribute is unset,
> or when checking files out.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	Okay, so I lied and did not go to sleep (but that part comes
> 	now).  Only the wording in the commit message has changed.
>
> convert.c       |    2 +-
> t/t0020-crlf.sh |   10 ++++++++++
> 2 files changed, 11 insertions(+), 1 deletions(-)
>
> diff --git a/convert.c b/convert.c
> index 78efed8..d038d2f 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -126,7 +126,7 @@ static int crlf_to_git(const char *path, const  
> char *src, size_t len,
> 	struct text_stat stats;
> 	char *dst;
>
> -	if ((action == CRLF_BINARY) || !auto_crlf || !len)
> +	if ((action == CRLF_BINARY) || (!auto_crlf && action < 0) || !len)

I think we should strictly follow the documentation, so this should read

+       if ((action == CRLF_BINARY) || (!auto_crlf && action !=  
CRLF_INPUT) || !len)



>
> 		return 0;
>
> 	gather_stats(src, len, &stats);
> diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
> index 1be7446..0bb3e6f 100755
> --- a/t/t0020-crlf.sh
> +++ b/t/t0020-crlf.sh
> @@ -436,4 +436,14 @@ test_expect_success 'invalid .gitattributes  
> (must not crash)' '
>
> '
>
> +test_expect_success 'attribute crlf is heeded even without  
> core.autocrlf' '
> +
> +	echo "allcrlf crlf=input" > .gitattributes &&
> +	git config --unset core.autocrlf &&

You should set core.autocrlf explicitly to false:

    git config core.autocrlf false

Otherwise the test would pick up the user's global default.


>
> +	git add allcrlf &&
> +	git show :allcrlf | append_cr > expect &&
> +	test_cmp allcrlf expect
> +
> +'
> +
> test_done
> -- 
> 1.6.0.rc0.22.gf2096d.dirty


... and we should verify that we only treat crlf=input specially, but  
not "crlf".
The following changes could be applied on top of yours. (Apologies if  
lines are
wrapped.  I am composing this mail with the wrong email client.)


diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index b37059b..e51e810 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -436,7 +436,7 @@ test_expect_success 'invalid .gitattributes (must  
not crash)' '

  '

-test_expect_success 'attribute crlf is heeded even without  
core.autocrlf' '
+test_expect_success 'attribute crlf=input is heeded even with  
core.autocrlf=false' '

         echo "allcrlf crlf=input" > .gitattributes &&
         git config core.autocrlf false &&
@@ -446,4 +446,15 @@ test_expect_success 'attribute crlf is heeded  
even without core.autocrlf' '

  '

+test_expect_success 'attribute crlf is ignored with  
core.autocrlf=false' '
+
+       echo "allcrlf crlf" > .gitattributes &&
+       git config core.autocrlf false &&
+       git read-tree --reset HEAD &&
+       git add allcrlf &&
+       git show :allcrlf > expect &&
+       test_cmp allcrlf expect
+
+'
+
  test_done
