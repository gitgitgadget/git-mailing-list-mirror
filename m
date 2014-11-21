From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] add: ignore only ignored files
Date: Fri, 21 Nov 2014 13:01:05 -0500
Message-ID: <20141121180105.GB26650@peff.net>
References: <546F5CC7.8060904@drmicha.warpmail.net>
 <b4834f562679d7ccad683463edc61db5ea962d8d.1416585536.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Nov 21 19:01:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrsWB-0005pk-Kb
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 19:01:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbaKUSBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 13:01:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:43300 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750824AbaKUSBH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 13:01:07 -0500
Received: (qmail 15209 invoked by uid 102); 21 Nov 2014 18:01:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Nov 2014 12:01:06 -0600
Received: (qmail 25783 invoked by uid 107); 21 Nov 2014 18:01:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Nov 2014 13:01:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Nov 2014 13:01:05 -0500
Content-Disposition: inline
In-Reply-To: <b4834f562679d7ccad683463edc61db5ea962d8d.1416585536.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 21, 2014 at 05:08:19PM +0100, Michael J Gruber wrote:

> "git add foo bar" adds neither foo nor bar when bar is ignored, but dies
> to let the user recheck their command invocation. This becomes less
> helpful when "git add foo.*" is subject to shell expansion and some of
> the expanded files are ignored.
> 
> "git add --ignore-errors" is supposed to ignore errors when indexing
> some files and adds the others. It does ignore errors from actual
> indexing attempts, but does not ignore the error "file is ignored" as
> outlined above. This is unexpected.
> 
> Change "git add foo bar" to add foo when bar is ignored, but issue
> a warning and return a failure code as before the change.
> 
> That is, in the case of trying to add ignored files we now act the same
> way (with or without "--ignore-errors") in which we act for more
> severe indexing errors when "--ignore-errors" is specified.

Thanks, this looks pretty good to me. I agree with Junio's sense that we
should cook it extra long to give people time to react.

> My sincere thanks go out to Jeff without whom I could not possibly
> have come up with a patch like this :)

:) Sorry if I was being obnoxious before. Sometimes contributors need a
gentle push to keep going, but I should know by now that you are not
such a person.

> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index fe274e2..f7ff1f5 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -91,6 +91,13 @@ test_expect_success 'error out when attempting to add ignored ones without -f' '
>  	! (git ls-files | grep "\\.ig")
>  '
>  
> +test_expect_success 'error out when attempting to add ignored ones but add others' '
> +	touch a.if &&
> +	test_must_fail git add a.?? &&
> +	! (git ls-files | grep "\\.ig") &&
> +	(git ls-files | grep a.if)
> +'

I am somewhat allergic to pipes in our test suite, because they can mask
errors (especially with a negated grep, because we do not know if they
correctly produced any output at all). But I guess this is matching the
surrounding code, and it is quite unlikely for `ls-files` to fail in any
meaningful way here. So I think it's fine.

-Peff
