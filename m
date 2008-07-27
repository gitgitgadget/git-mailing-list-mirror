From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH v2] merge-base: teach "git merge-base" to accept more
 than 2 arguments
Date: Sun, 27 Jul 2008 16:38:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807271631470.5526@eeepc-johanness>
References: <20080727053324.b54fe48e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Jul 27 16:38:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KN7Nu-0001BJ-6a
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 16:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbYG0OhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 10:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbYG0OhF
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 10:37:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:44597 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751522AbYG0OhD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 10:37:03 -0400
Received: (qmail invoked by alias); 27 Jul 2008 14:37:01 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp032) with SMTP; 27 Jul 2008 16:37:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+iRIZFEOWiFNf6IHuNK7GWVM/wZeSOzWzNTQDqAE
	zccKoKCiEgZK3u
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080727053324.b54fe48e.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90338>

Hi,

On Sun, 27 Jul 2008, Christian Couder wrote:

> diff --git a/builtin-merge-base.c b/builtin-merge-base.c
> index 1cb2925..f2c9756 100644
> --- a/builtin-merge-base.c
> +++ b/builtin-merge-base.c
> @@ -38,15 +48,22 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
>  			usage(merge_base_usage);
>  		argc--; argv++;
>  	}
> -	if (argc != 3)
> +	if (argc < 3)
>  		usage(merge_base_usage);
> -	if (get_sha1(argv[1], rev1key))
> -		die("Not a valid object name %s", argv[1]);
> -	if (get_sha1(argv[2], rev2key))
> -		die("Not a valid object name %s", argv[2]);
> -	rev1 = lookup_commit_reference(rev1key);
> -	rev2 = lookup_commit_reference(rev2key);
> -	if (!rev1 || !rev2)
> +
> +	rev1 = get_commit_reference(argv[1]);
> +	if (!rev1)
>  		return 1;

Why do you special case rev1?  Is it so special?  Just handle it together 
with all of the other arguments!

IOW have one commit array, and do not call it "prev".

> -	return show_merge_base(rev1, rev2, show_all);
> +	argc--; argv++;
> +
> +	do {
> +		struct commit *rev2 = get_commit_reference(argv[1]);
> +		if (!rev2)
> +			return 1;
> +		ALLOC_GROW(prev2, prev2_nr + 1, prev2_alloc);
> +		prev2[prev2_nr++] = rev2;
> +		argc--; argv++;
> +	} while (argc > 1);

Now, this is ugly.  You know beforehand the _exact_ number of arguments, 
and yet you dynamically grow the array?  Also, why do you use a do { } 
while(), when a for () would be much, much clearer?

BTW I seem to recall that get_merge_bases_many() was _not_ the same as 
get_merge_octopus().  Could you please remind me what _many() does?

Ciao,
Dscho
