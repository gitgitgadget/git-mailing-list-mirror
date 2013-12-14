From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 1/2] diff: move no-index detection to builtin/diff.c
Date: Fri, 13 Dec 2013 16:43:47 -0800
Message-ID: <20131214004347.GZ2311@google.com>
References: <20131210181655.GB2311@google.com>
 <1386755923-22132-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 14 01:44:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrdKo-0001OJ-DQ
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 01:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372Ab3LNAny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Dec 2013 19:43:54 -0500
Received: from mail-yh0-f52.google.com ([209.85.213.52]:36097 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3LNAnx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Dec 2013 19:43:53 -0500
Received: by mail-yh0-f52.google.com with SMTP id i7so2098315yha.39
        for <git@vger.kernel.org>; Fri, 13 Dec 2013 16:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DbVmcC4CuwDXi8fwxp+hhBP/TTAgk3SzwNICPI1WpbI=;
        b=Qe2lD7JpWtkLzBCHE/gZ+Eglk5sckUk5zjPlySB5dG8eIFHQB6qAL2h6g1Np5BT8SW
         2HDPJNDHefJfgJFc/tk5xBmcGlkn6uuCshIWjCWEd4kxoTNio98ESjq0Lc1E8ImFmZKG
         Zbdm3bLUdfKi3KUYpS/qXKMPj9Lu4fndZfcV76IRJrheGfkYECucjPuPBHmCTGNnV7/f
         t4V7F2she5X/vxesz2Zz60F3BL/XpHAhiOeWUBEiZh/dd2iy8JlCdS2r27+Y8H737qQX
         PHtxcfH0M8ngmGp0Wao0IjGnnfJ+Tg/8kmsxZSz7ox7FHBEWkqVMYmHxWnlcG4K4oSy6
         m7RA==
X-Received: by 10.236.171.40 with SMTP id q28mr4565160yhl.37.1386981831021;
        Fri, 13 Dec 2013 16:43:51 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id f78sm5948809yhp.12.2013.12.13.16.43.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 13 Dec 2013 16:43:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386755923-22132-1-git-send-email-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239269>

Hi,

Thomas Gummerer wrote:

> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>

Thanks, and sorry for the slow follow-up.

[...]
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -16,6 +16,9 @@
[...]
> @@ -283,14 +286,57 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  	 * Other cases are errors.
>  	 */
>  
> +	/* Were we asked to do --no-index explicitly? */
> +	for (i = 1; i < argc; i++) {
> +		if (!strcmp(argv[i], "--")) {
> +			i++;
> +			break;
> +		}
> +		if (!strcmp(argv[i], "--no-index"))
> +			no_index = DIFF_NO_INDEX_EXPLICIT;

Neat.

[...]
> +	/*
> +	 * Treat git diff with at least one path outside of the
> +	 * repo the same as if the command would have been executed
> +	 * outside of a git repository.  In this case it behaves
> +	 * the same way as "git diff --no-index <a> <b>", which acts
> +	 * as a colourful "diff" replacement.
> +	 */
> +	if (nongit || ((argc == i + 2) &&
> +		       (!path_inside_repo(prefix, argv[i]) ||
> +			!path_inside_repo(prefix, argv[i + 1]))))
> +		no_index = DIFF_NO_INDEX_IMPLICIT;

What happens if I run 'git diff --no-index /tmp git.c git.c' from
within a git repository?  With this, I fear I will get

	Not a git repository
	To compare two paths outside a working tree:
	usage: git diff [--no-index] <path> <path>

instead of the expected

	usage: git diff --no-index <path> <path>

Something like

	if (no_index)
		;
	else if (nongit)
		no_index = DIFF_NO_INDEX_IMPLICIT;
	else if (argc != i + 2)
		;
	else if (!path_inside_repo(prefix, argv[i]) ||
		 !path_inside_repo(prefix, argv[i + 1]))
		no_index = DIFF_NO_INDEX_IMPLICIT;

should work.  Or:

	if (!no_index) {
		/*
		 * Treat git diff with ...
		 */
		if (nongit || ...)
			no_index = DIFF_NO_INDEX_IMPLICIT;
	}

Or the '!no_index &&' condition inserted some other way.

> -	/* If this is a no-index diff, just run it and exit there. */
> -	diff_no_index(&rev, argc, argv, nongit, prefix);
> +	if (no_index) {
> +		if (argc != i + 2) {
[...]
> +			/* Give the usage message for non-repository usage and exit. */
> +			usagef("git diff %s <path> <path>",
> +			       no_index == DIFF_NO_INDEX_EXPLICIT ?
> +					"--no-index" : "[--no-index]");
> +
> +		}
> +		/* If this is a no-index diff, just run it and exit there. */
> +		diff_no_index(&rev, argc, argv, prefix);
> +	}

Perhaps, to avoid some nesting:

	/* A no-index diff takes exactly two path arguments. */
	if (no_index && argc != i + 2) {
		...
		usagef(...);
	}

	if (no_index)
		/* Just run the diff and exit. */
		diff_no_index(...);

Jonathan
