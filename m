From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH] t4205: don't rely on en_US.UTF-8 locale existing
Date: Thu, 4 Jul 2013 00:40:24 +0400
Message-ID: <20130703204024.GA6148@dell-note>
References: <f607decdc65b86b1759438e375ddf77fd5b91042.1372882590.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jul 03 22:40:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuTqq-0004Uh-4v
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 22:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933116Ab3GCUk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 16:40:28 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:52404 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933059Ab3GCUk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 16:40:27 -0400
Received: by mail-lb0-f173.google.com with SMTP id v1so598968lbd.18
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 13:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3wGC46Z0yUbCv6Or7q/nGyYDeOyRapncgw7WYg2PRzk=;
        b=dqgJaFZaOKJ9qWnZ/6OzeyqEv8WFHeMYac/tPbVxYvqVCX/xE9VDPR2og/MXFc6hpE
         1We/xQ6nccXMsQJS3rguDqkmqtfIkZrCsayvyPzKkZBT1oFzG3V/O+RkaBHR2DnacKTc
         Yi35reVQv5vK4EXJku8jfjdL61s1SVlP2GzK81GNxfzyBC7IjDdhQJFKsVUiaff1APPq
         Qr2F2V3KQIwu1ngT5mIvuVwJpqz/lpq38BP1VGu9uJxJYxyNOYdEIiDlRyxd1vTzfcYk
         gPab8XigqORd0oPwE2Gxj79U+eKN8fMiDH/wAQ+6HXwTDVPgGd/jIZBEZUAqck6+rPx8
         mbeg==
X-Received: by 10.112.52.97 with SMTP id s1mr2060273lbo.8.1372884026404;
        Wed, 03 Jul 2013 13:40:26 -0700 (PDT)
Received: from localhost (ppp91-77-20-80.pppoe.mtu-net.ru. [91.77.20.80])
        by mx.google.com with ESMTPSA id p10sm11472648lap.8.2013.07.03.13.40.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 13:40:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f607decdc65b86b1759438e375ddf77fd5b91042.1372882590.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229528>

CC this to Johannes Sixt

On Wed, Jul 03, 2013 at 09:18:08PM +0100, John Keeping wrote:
> My system doesn't have the en_US.UTF-8 locale (or plain en_US), which
> causes t4205 to fail by counting bytes instead of UTF-8 codepoints.
> 
> Instead of using sed for this, use Perl which behaves predictably
> whatever locale is in use.
> 
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
> This patch is on top of 'as/log-output-encoding-in-user-format'.
> 
>  t/t4205-log-pretty-formats.sh | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index 3cfb744..5864f5b 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -20,9 +20,7 @@ commit_msg () {
>  		# cut string, replace cut part with two dots
>  		# $2 - chars count from the beginning of the string
>  		# $3 - "trailing" chars
> -		# LC_ALL is set to make `sed` interpret "." as a UTF-8 char not a byte
> -		# as it does with C locale
> -		msg=$(echo $msg | LC_ALL=en_US.UTF-8 sed -e "s/^\(.\{$2\}\)$3/\1../")
> +		msg=$(echo $msg | "$PERL_PATH" -CIO -pe "s/^(.{$2})$3/\1../")
>  	fi
>  	echo $msg
>  }
> @@ -205,7 +203,7 @@ test_expect_success 'left alignment formatting with ltrunc' "
>  ..sage two
>  ..sage one
>  add bar  Z
> -$(commit_msg "" "0" ".\{11\}")
> +$(commit_msg "" "0" ".{11}")
>  EOF
>  	test_cmp expected actual
>  "
> @@ -218,7 +216,7 @@ test_expect_success 'left alignment formatting with mtrunc' "
>  mess.. two
>  mess.. one
>  add bar  Z
> -$(commit_msg "" "4" ".\{11\}")
> +$(commit_msg "" "4" ".{11}")
>  EOF
>  	test_cmp expected actual
>  "
> -- 
> 1.8.3.1.747.g77f7d3a
> 
