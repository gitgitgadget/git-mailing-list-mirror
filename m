From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 1/2] t8005: avoid grep on non-ASCII data
Date: Wed, 24 Feb 2016 10:24:12 +0000
Message-ID: <20160224102411.GO1766@serenity.lan>
References: <20160219193310.GA1299@sigill.intra.peff.net>
 <cover.1456075680.git.john@keeping.me.uk>
 <81ec83acd004ef050a4c8df62fb158b41f0a0a80.1456075680.git.john@keeping.me.uk>
 <CAPig+cQ9n4Eg73Uyeg_g_4wzebuwn8=0R-LMb8F9QLFxanwVVg@mail.gmail.com>
 <20160221231913.GA4094@sigill.intra.peff.net>
 <20160221234135.GA14382@river.lan>
 <xmqqegc3xc88.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 11:24:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYWcX-00072Y-Ci
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 11:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbcBXKYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 05:24:31 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:38352 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbcBXKY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 05:24:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 2B6FFCDA5A6;
	Wed, 24 Feb 2016 10:24:26 +0000 (GMT)
X-Quarantine-ID: <yMgA0EWTO17s>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yMgA0EWTO17s; Wed, 24 Feb 2016 10:24:24 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 78F8DCDA556;
	Wed, 24 Feb 2016 10:24:13 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <xmqqegc3xc88.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287190>

On Tue, Feb 23, 2016 at 03:01:43PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > My original sed version was:
> >
> > 	sed -ne "/^author /p" -e "/^summary /p"
> >
> > which I think will work on all platforms (we already use it in
> > t0000-basic.sh) but then I decided to be too clever :-(
> >
> > I still think sed is simpler than introducing a new function to wrap a
> > perl script.
> 
> Let's do this, before everybody forgets what we discussed.

Thanks, this looks good to me.

> -- >8 --
> From: John Keeping <john@keeping.me.uk>
> Date: Sun, 21 Feb 2016 17:32:21 +0000
> Subject: [PATCH] t8005: avoid grep on non-ASCII data
> 
> GNU grep 2.23 detects the input used in this test as binary data so it
> does not work for extracting lines from a file.  We could add the "-a"
> option to force grep to treat the input as text, but not all
> implementations support that.  Instead, use sed to extract the desired
> lines since it will always treat its input as text.
> 
> While touching these lines, modernize the test style to avoid hiding the
> exit status of "git blame" and remove a space following a redirection
> operator.  Also swap the order of the expected and actual output
> files given to test_cmp; we compare expect and actual to show how
> actual output differs from what is expected.
> 
> Signed-off-by: John Keeping <john@keeping.me.uk>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t8005-blame-i18n.sh | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
> index 847d098..75da219 100755
> --- a/t/t8005-blame-i18n.sh
> +++ b/t/t8005-blame-i18n.sh
> @@ -33,11 +33,15 @@ author $SJIS_NAME
>  summary $SJIS_MSG
>  EOF
>  
> +filter_author_summary () {
> +	sed -n -e '/^author /p' -e '/^summary /p' "$@"
> +}
> +
>  test_expect_success !MINGW \
>  	'blame respects i18n.commitencoding' '
> -	git blame --incremental file | \
> -		egrep "^(author|summary) " > actual &&
> -	test_cmp actual expected
> +	git blame --incremental file >output &&
> +	filter_author_summary output >actual &&
> +	test_cmp expected actual
>  '
>  
>  cat >expected <<EOF
> @@ -52,9 +56,9 @@ EOF
>  test_expect_success !MINGW \
>  	'blame respects i18n.logoutputencoding' '
>  	git config i18n.logoutputencoding eucJP &&
> -	git blame --incremental file | \
> -		egrep "^(author|summary) " > actual &&
> -	test_cmp actual expected
> +	git blame --incremental file >output &&
> +	filter_author_summary output >actual &&
> +	test_cmp expected actual
>  '
>  
>  cat >expected <<EOF
> @@ -68,9 +72,9 @@ EOF
>  
>  test_expect_success !MINGW \
>  	'blame respects --encoding=UTF-8' '
> -	git blame --incremental --encoding=UTF-8 file | \
> -		egrep "^(author|summary) " > actual &&
> -	test_cmp actual expected
> +	git blame --incremental --encoding=UTF-8 file >output &&
> +	filter_author_summary output >actual &&
> +	test_cmp expected actual
>  '
>  
>  cat >expected <<EOF
> @@ -84,9 +88,9 @@ EOF
>  
>  test_expect_success !MINGW \
>  	'blame respects --encoding=none' '
> -	git blame --incremental --encoding=none file | \
> -		egrep "^(author|summary) " > actual &&
> -	test_cmp actual expected
> +	git blame --incremental --encoding=none file >output &&
> +	filter_author_summary output >actual &&
> +	test_cmp expected actual
>  '
>  
>  test_done
> -- 
> 2.7.2-532-g79873b4
