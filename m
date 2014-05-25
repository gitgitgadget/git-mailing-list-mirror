From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v2] commit: support commit.verbose and --no-verbose
Date: Sun, 25 May 2014 00:02:10 -0700
Message-ID: <20140525070210.GA18539@hudson.localdomain>
References: <20140525062427.GA94219@sirius.att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Thompson <cjaysson@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 25 09:06:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WoSVu-0001zi-Cx
	for gcvg-git-2@plane.gmane.org; Sun, 25 May 2014 09:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbaEYHCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2014 03:02:15 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:55846 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbaEYHCP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2014 03:02:15 -0400
Received: by mail-pa0-f52.google.com with SMTP id fa1so6090377pad.11
        for <git@vger.kernel.org>; Sun, 25 May 2014 00:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=crvYsgmy8BU8SerSpvXyO0Bz9iO9hf9+mFNIEHlm/eM=;
        b=RwUckLH/dHUG7VPZbKFafvIlgfyBG8qfqOF2ax7KIejHx58UpLnnnwhNBhmehOJwNP
         7IobiJK3nVEj1jQ0B6SpiX9idln7ooDblj3BI8Y7NRJhNv0G+Y9O/Sgbi5/mdFi9s+gp
         1R7WbUnm5whcR8EJ4S47d+xaZX1+RSc2C2xQ9rSGZPaK7oIiEQK+2HQkCj7cDRBqbNWV
         Y95BrEosmg5wJNHIzEYC2pYG6WBhBR8272HxCLllLPrHw045zK+DhAZ4ZTvS58LltSuk
         UxbVGCGQhwy/izFdSgH9COEk4CauKFmbmd60TM67kUHpN4mDX4BJuWLzCwfjixg9s7g8
         q8Yw==
X-Received: by 10.66.253.170 with SMTP id ab10mr18841679pad.53.1401001334693;
        Sun, 25 May 2014 00:02:14 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id mt1sm12275748pbb.31.2014.05.25.00.02.11
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 25 May 2014 00:02:13 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sun, 25 May 2014 00:02:10 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Caleb Thompson <cjaysson@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140525062427.GA94219@sirius.att.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250080>

On Sun, May 25, 2014 at 01:24:27AM -0500, Caleb Thompson wrote:
...
>  	would be committed at the bottom of the commit message
>  	template.  Note that this diff output doesn't have its
> -	lines prefixed with '#'.
> +	lines prefixed with '#'.  The `commit.verbose` configuration
> +	variable can be set to true to implicitly send this option.
> +
> +--no-verbose::
> +	Do not show the unified diff  at the bottom of the commit message
> +	template.  This is the default behavior, but can be used to override
> +	the`commit.verbose` configuration variable.
> 
Why is there two spaces between "diff  at"?
Needs a space between "the`comm" -> "the `comm".

> +cat >check-for-no-diff <<EOF
> +#!$SHELL_PATH
> +exec grep -v '^diff --git' "\$1"
> +EOF
> +chmod +x check-for-no-diff
> +
Me personally, I would leave it like that for now, since that is
the style being used nearby.  We'll see what others have to say.

I certainly wouldn't convert all the other cases to use
test_expect_success.  Leave that for another patch.

> 
> @@ -48,6 +54,21 @@ test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
>  	check_message message
>  '
> 
> +test_expect_success 'commit shows verbose diff with set commit.verbose' '
> +	echo morecontent >file &&
> +	git add file &&
> +	test_config commit.verbose true &&
> +	check_message message
> +'
> +
> +test_expect_success 'commit does not show verbose diff with --no-verbose' '
> +	echo morecontent >file &&
> +	git add file &&
> +	test_config commit.verbose true &&
> +	test_set_editor "$PWD/check-for-no-diff" &&
> +	git commit --amend --no-verbose
> +'
> +
I like those better with 'test_config' instead of 'git config', good.

Keep working on it, it is looking better :-)

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
