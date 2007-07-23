From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] describe: add option --dirty
Date: Mon, 23 Jul 2007 02:59:12 -0400
Message-ID: <20070723065912.GG32566@spearce.org>
References: <87odi3mxtl.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yasushi SHOJI <yashi@atmark-techno.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 09:00:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICru1-00075w-J1
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 09:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764366AbXGWG7V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 02:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765636AbXGWG7T
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 02:59:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44504 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765635AbXGWG7R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 02:59:17 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ICrsv-0004Ta-IF; Mon, 23 Jul 2007 02:59:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 735C420FBAE; Mon, 23 Jul 2007 02:59:12 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <87odi3mxtl.wl@mail2.atmark-techno.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53399>

Yasushi SHOJI <yashi@atmark-techno.com> wrote:
> when --dirty is given, git describe will check the working tree and
> append "-dirty" to describe string if the tree is dirty.
> ---
> I'm not sure this is good idea or the current way (using diff-index in
> shell script) is more prefered.

Yea, I'm actually torn on this.  A lot of people like the output of
git-describe for versions (where a lot is at least me!) and yet I
also always tack in the -dirty if the directory is dirty according
to diff-index.  So having this built right into git-describe is
actually quite handy.  It simplifies a little bit of build rule
logic.

> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
> @@ -53,6 +53,9 @@ OPTIONS
>  	being employed to standard error.  The tag name will still
>  	be printed to standard out.
>  
> +--dirty::
> +	Append "-dirty" to describe string if working tree is dirty.
> +

It requires a working directory.  Running this in a bare repository
with --dirty won't work.  You might want to discuss that in the
documentation.

> diff --git a/builtin-describe.c b/builtin-describe.c
> @@ -229,12 +231,23 @@ static void describe(const char *arg, int last_one)
>  				sha1_to_hex(gave_up_on->object.sha1));
>  		}
>  	}
> +	if (check_dirty) {
> +		const char **args = xmalloc(5 * sizeof(char*));
> +		args[0] = "diff-index";
> +		args[1] = "--quiet";
> +		args[2] = "--name-only";
> +		args[3] = "HEAD";
> +		args[4] = NULL;
> +		if (cmd_diff_index(4, args, prefix))
> +			dirty_string = "-dirty";
> +	}

So if I describe two different commits at once in the same working
tree you are going to run diff-index twice?  That's not a great idea.
The outcome of diff-index won't change between those two commits.
Better to compute this up front before calling the describe()
function, and instead of passing in prefix pass in dirty_string.
Or just make it a global, like you did to the option flag.

>  	if (abbrev == 0)
> -		printf("%s\n", all_matches[0].name->path );
> +		printf("%s%s\n", all_matches[0].name->path, dirty_string);
>  	else
> -		printf("%s-%d-g%s\n", all_matches[0].name->path,
> +		printf("%s-%d-g%s%s\n", all_matches[0].name->path,
>  		       all_matches[0].depth,
> -		       find_unique_abbrev(cmit->object.sha1, abbrev));
> +		       find_unique_abbrev(cmit->object.sha1, abbrev),
> +		       dirty_string);
>  
>  	if (!last_one)
>  		clear_commit_marks(cmit, -1);

So if HEAD is exactly matching a tag you don't output the -dirty
suffix, even if the working tree is dirty?  That's counter to the
documentation above.  See l.150-154, we break out of the describe
function very quickly if there is a tag on the input commit.

-- 
Shawn.
