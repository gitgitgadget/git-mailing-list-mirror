From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6] t1500: avoid setting environment variables outside
 of tests
Date: Tue, 10 May 2016 14:39:55 -0400
Message-ID: <20160510183955.GA16211@sigill.intra.peff.net>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
 <20160510052055.32924-6-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 10 20:40:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0CZh-0007Wx-JE
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 20:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbcEJSkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 14:40:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:37163 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751473AbcEJSj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 14:39:59 -0400
Received: (qmail 20843 invoked by uid 102); 10 May 2016 18:39:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 May 2016 14:39:58 -0400
Received: (qmail 32548 invoked by uid 107); 10 May 2016 18:40:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 May 2016 14:40:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 May 2016 14:39:55 -0400
Content-Disposition: inline
In-Reply-To: <20160510052055.32924-6-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294172>

On Tue, May 10, 2016 at 01:20:54AM -0400, Eric Sunshine wrote:

> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> index c058aa4..525e6d3 100755
> --- a/t/t1500-rev-parse.sh
> +++ b/t/t1500-rev-parse.sh
> @@ -7,11 +7,13 @@ test_description='test git rev-parse'
>  test_rev_parse () {
>  	dir=
>  	bare=
> +	env=
>  	while :
>  	do
>  		case "$1" in
>  		-C) dir="-C $2"; shift; shift ;;
>  		-b) bare="$2"; shift; shift ;;
> +		-g) env="GIT_DIR=$2; export GIT_DIR"; shift; shift ;;

This will expand $2 inside $env, which is later eval'd. So funny things
happen if there are spaces or metacharacters. It looks like you only use
it with short relative paths ("../repo.git", etc), which is OK, but this
would probably break badly if we ever used absolute paths.

I don't know if it's worth worrying about or not. The usual solution is
something like:

  env_git_dir=$2
  env='GIT_DIR=$env_git_dir; export GIT_DIR'
  ...
  eval "$env"

> @@ -36,6 +38,8 @@ test_rev_parse () {
>  	do
>  		expect="$1"
>  		test_expect_success "$name: $o" '
> +			test_when_finished "sane_unset GIT_DIR" &&
> +			eval $env &&

I was surprised not to see quoting around $env here, but it probably
doesn't matter (I think it may affect how some whitespace is treated,
but the contents of $env are pretty tame).

This will set up the sane_unset regardless of whether $env does
anything. Would it make more sense to stick the test_when_finished
inside $env? You could use regular unset then, too, since you know the
variable would be set.

-Peff
