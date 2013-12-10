From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/2] diff: move no-index detection to builtin/diff.c
Date: Tue, 10 Dec 2013 10:16:55 -0800
Message-ID: <20131210181655.GB2311@google.com>
References: <xmqqwqjdydga.fsf@gitster.dls.corp.google.com>
 <1386697935-18635-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 19:17:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqRrs-00018g-DA
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 19:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126Ab3LJSRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 13:17:03 -0500
Received: from mail-yh0-f51.google.com ([209.85.213.51]:42719 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717Ab3LJSRB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 13:17:01 -0500
Received: by mail-yh0-f51.google.com with SMTP id c41so4115748yho.24
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 10:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=al/d3QUo4uC07NZ5LLebsURh+2naLo61F4yf/TBOENQ=;
        b=AdLdAdyKz4924Cz9/jvVkVHsRH0nKxCptEGRCdbYt0WP4Yw3Se4eQh6C6VKpN3ZOwa
         SAxZ/mQMewWWHw0HzCTGFd4W26yYoX8C8p7s9bT9xvn/saxaeEX8OcYTqn/2PwBZGUE1
         Qs0p2fmn8uRcwqLrv//1qF6P7Ilxe9DRlV2cW8ZgDMgqae3DfWPeutbVQ4c0zibAzPfL
         TqBwYsyQg8CQGV4+usrQs2xGMh6Tcz+htZHfF/J/WjVwSt8kngWR2ATKZK/SAtlQaG6E
         mSzTVbubqEUvLRfzDEnMYQhJKYHERsgsWlYa1flr3OvwinajuY+OCe7eTzzAeqCcNtnC
         NoWg==
X-Received: by 10.236.138.202 with SMTP id a50mr1200810yhj.156.1386699420515;
        Tue, 10 Dec 2013 10:17:00 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id d26sm23712392yhj.25.2013.12.10.10.16.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 10 Dec 2013 10:16:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386697935-18635-1-git-send-email-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239142>

(pruning cc list)
Hi,

Thomas Gummerer wrote:

> Currently the --no-index option is parsed in diff_no_index().  Move the
> detection if a no-index diff should be executed to builtin/diff.c

No functional change intended, I assume?

[...]
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -283,14 +283,53 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
[...]
>  	prefix = setup_git_directory_gently(&nongit);
> +	/*
> +	 * Treat git diff with at least one path outside of the
> +	 * repo the same as if the command would have been executed
> +	 * outside of a git repository.  In this case it behaves
> +	 * the same way as "git diff --no-index <a> <b>", which acts
> +	 * as a colourful "diff" replacement.
> +	 */
> +	nongit |= (argc == i + 2) && !(path_inside_repo(prefix, argv[i]) &&
> +				       path_inside_repo(prefix, argv[i + 1]));

I would find this easier to read as

	if (argc == i + 2 &&
	    (!path_inside_repo(prefix, argv[i]) ||
	     !path_inside_repo(prefix, argv[i + 1])))
		nongit = 1;

Or maybe using a different variable than 'nongit':

 #define DIFF_NO_INDEX_EXPLICIT 1
 #define DIFF_NO_INDEX_IMPLICIT 2

	...
	if (argc == i + 2 && ...)
		no_index = DIFF_NO_INDEX_IMPLICIT;

[...]
>  	gitmodules_config();
>  	git_config(git_diff_ui_config, NULL);
>  
>  	init_revisions(&rev, prefix);
>  
> -	/* If this is a no-index diff, just run it and exit there. */
> -	diff_no_index(&rev, argc, argv, nongit, prefix);
> +	if (no_index || nongit) {
[...]
> +	}

Ok.

[...]
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -181,56 +181,14 @@ static int queue_diff(struct diff_options *o,
>  	}
>  }
>  
> -void diff_no_index(struct rev_info *revs,
> +int diff_no_index(struct rev_info *revs,

Why the change in return type?

Hope that helps,
Jonathan
