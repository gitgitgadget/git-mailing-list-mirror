From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] diff: don't read index when --no-index is given
Date: Mon, 9 Dec 2013 07:16:09 -0800
Message-ID: <20131209151609.GA14841@google.com>
References: <1386590745-4412-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexey Borzenkov <snaury@gmail.com>,
	Ren?? Scharfe <l.s.r@web.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Tim Henigan <tim.henigan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Bobby Powers <bobbypowers@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 16:16:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq2ZK-0007La-Bk
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 16:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593Ab3LIPQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 10:16:18 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:44143 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932291Ab3LIPQR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 10:16:17 -0500
Received: by mail-yh0-f43.google.com with SMTP id a41so2696377yho.30
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 07:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5R4jLctop+UUsc3AAT1Fna2TGqo90diDh+0OHWuoSzo=;
        b=LfvPMv1uMb5QmjJM92V/r+7D8O1qJZGe7T5ly9DoXnG591muYIc7oFed/3F2Vs3myJ
         zF8PzuIjGgoP/7slvbWA8+XDAP9gcRud/NpDyyh8MUNKdolXNjw2BLs0B7uKE8dpZvV2
         iwOZDTwfRtxnnQrFccwGkJ6PWVqiQlsC4dPCIsqI3rxAVipckQM/1zZx3wtL90VJ5pGj
         DysQsVwaIQoIA0tv8REaCYo4cJyuIHezL9NGCvv2UHijFDSBenJWWWEsM2GFf//pHrtv
         i66X2+Co8h2XiDBTKCKQdPfXDyvPQybyUXS5DTvhwb+PXHMJN6Ep2MWiYvYEMZZ6lnmT
         h37g==
X-Received: by 10.236.83.238 with SMTP id q74mr49675674yhe.9.1386602176597;
        Mon, 09 Dec 2013 07:16:16 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id r98sm16579123yhp.3.2013.12.09.07.16.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 09 Dec 2013 07:16:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386590745-4412-1-git-send-email-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239070>

Thomas Gummerer wrote:

> git diff --no-index ... currently reads the index, during setup, when
> calling gitmodules_config().  In the usual case this gives us some
> performance drawbacks,

Makes sense.

>                        but it's especially annoying if there is a broken
> index file.

Is this really a normal case?  It makes sense that as a side-effect it
is easier to use "git diff --no-index" as a general-purpose tool while
investigating a broken repo, but I would have thought that quickly
learning a repo is broken is a good thing in any case.

A little more information about the context where this came up would
be helpful, I guess.

[...]
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
[...]
> @@ -282,9 +282,18 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  	 *
>  	 * Other cases are errors.
>  	 */
> +	for (i = 1; i < argc; i++) {
> +		if (!strcmp(argv[i], "--"))
> +			break;
> +		if (!strcmp(argv[i], "--no-index")) {
> +			no_index = 1;
> +			break;
> +		}

setup_revisions() uses the same logic that doesn't handle options that
take arguments in their "unstuck" form (e.g., "--word-diff-regex --"),
so this is probably not a regression, though I haven't checked. :)

[...]
>  	prefix = setup_git_directory_gently(&nongit);
> -	gitmodules_config();
> +	if (!no_index)
> +		gitmodules_config();

Perhaps we can improve performance and behavior by skipping the
setup_git_directory_gently() call, too?

That would help with the repairing-broken-repository case by
working even if .git/config or .git/HEAD is broken, and I think
it is more intuitive that the repository-local configuration is
ignored by "git diff --no-index".  It would also help with
performance by avoiding some filesystem access.

[...]
> +test_expect_success 'git diff --no-index with broken index' '
> +	cd repo &&
> +	echo broken >.git/index &&
> +	test_expect_code 0 git diff --no-index a ../non/git/a

Clever.  I wouldn't use "test_expect_code 0", since that's
already implied by including the "git diff --no-index" call
in the && chain.

Thanks and hope that helps,
Jonathan
