From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-remote: better handling of multiple remote
	HEADs
Date: Sat, 14 Feb 2009 12:54:20 -0500
Message-ID: <20090214175420.GA3457@coredump.intra.peff.net>
References: <20090214034345.GB24545@coredump.intra.peff.net> <1234607430-5403-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, barkalow@iabervon.org,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 18:56:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYOkH-0007Hm-DG
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 18:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbZBNRyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 12:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbZBNRyX
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 12:54:23 -0500
Received: from peff.net ([208.65.91.99]:34918 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728AbZBNRyW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 12:54:22 -0500
Received: (qmail 1045 invoked by uid 107); 14 Feb 2009 17:54:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 14 Feb 2009 12:54:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Feb 2009 12:54:20 -0500
Content-Disposition: inline
In-Reply-To: <1234607430-5403-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109887>

On Sat, Feb 14, 2009 at 05:30:30AM -0500, Jay Soffian wrote:

> In this situation, git remote set-head --auto should not try to guess
> which HEAD the user wants. This patch causes set-head to provide a
> useful error instead:
> 
> $ git remote set-head origin --auto
> error: Multiple remote HEAD branches. Please choose one explicitly with:
>   git remote set-head origin another
>   git remote set-head origin master

Thanks. The patch looks good to me, with two comments and one style nit:

> +		else if (states.heads.nr == 1)
> +			printf("  HEAD branch: %s\n",
> +				states.heads.items[0].string);
> +		else
> +			show_list("  HEAD branch%s:", &states.heads, "");

I was happy to see the common case of "we unambiguously determined HEAD"
falls back to nicer output (though I admit I did a double-take seeing
both show_list and the states.heads.nr check, I see it is because
show_list always insists on a newline).

That should help current users with simple setups, but also support
unambiguous HEAD reporting in the future (and based on what Daniel said
earlier, http should just need a client patch to pass the information
up the callstack).

> +		if (opt_a)
> +			printf("%s/HEAD set to %s\n", argv[0], head_name);

This was a surprise based on reading the commit message, but I think it
is a sensible enhancement.

> +cat > test/expect <<EOF
> +origin/HEAD set to master
> +EOF
> +
> +test_expect_success 'set-head --auto' '
> +	(cd test &&
> +	 git remote set-head --auto origin > output &&
> +	 git symbolic-ref refs/remotes/origin/HEAD &&
> +	test_cmp expect output)
> +'

I had to read this test a few times to convince myself it was right,
since you throw away the output of symbolic-ref. I think it makes more
sense to just test the post-command state, which is what you actually
care about (and then you are also not dependent on the human-readable
output of "remote set-head"). I.e.:

cat > test/expect <<EOF
refs/remotes/origin/master
EOF

test_expect_success 'set-head --auto' '
	(cd test &&
	 git remote set-head --auto origin &&
	 git symbolic-ref refs/remotes/origin/HEAD > output &&
	test_cmp expect output)
'

-Peff
