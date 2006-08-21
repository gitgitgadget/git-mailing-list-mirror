From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] branch as a builtin (again)
Date: Mon, 21 Aug 2006 16:41:10 -0400
Message-ID: <20060821204110.GA24465@spearce.org>
References: <59ad55d30608201422h4a6d40f7y7782212637380438@mail.gmail.com> <20060821101346.GA527@diku.dk> <59ad55d30608211312u51a4657eyd52311314a6ee03c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 22:42:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFGaf-0002cq-LK
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 22:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWHUUl2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 16:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWHUUl0
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 16:41:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:11142 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751003AbWHUUlV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 16:41:21 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GFGa0-0002ZI-VF; Mon, 21 Aug 2006 16:41:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 06A5F20FB7D; Mon, 21 Aug 2006 16:41:10 -0400 (EDT)
To: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@bitplanet.net>
Content-Disposition: inline
In-Reply-To: <59ad55d30608211312u51a4657eyd52311314a6ee03c@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25816>

Kristian H?gsberg <krh@bitplanet.net> wrote:
> +static void delete_branches(int argc, const char **argv, int force)
[snip]
> +		name = git_path("refs/heads/%s", argv[i]);
> +		if (!resolve_ref(name, sha1, 1))
> +			die("Branch '%s' not found.", argv[i]);
[snip]
> +		unlink(name);
> +
> +		/* Unlink reflog if it exists. */
> +		reflog = git_path("logs/refs/heads/%s", argv[i]);
> +		unlink(reflog);

Hmm.  So git-branch.sh doesn't deal with symrefs, eh?  I guess this
is OK but I'm wondering why not put this code into refs.c to lock
the ref (refs.c:lock_ref_sha1) then instead of unlocking it delete
it and its log (add new function to do this).

The downside of this is that we'll chase a symref, which means that
if refs/heads/FOO is a symref to refs/heads/master and the user calls
`git-branch -D FOO` we'll kill refs/heads/master.  Maybe that's not
what the the user would want to have happen.  :-)

> +static void create_reflog(struct ref_lock *lock)
> +{
> +	struct stat stbuf;
> +	int fd;
> +
> +	if (!stat(lock->log_file, &stbuf) && S_ISREG(stbuf.st_mode))
> +		return;
> +	if (safe_create_leading_directories(lock->log_file) < 0)
> +		die("Unable to create directory for %s.", lock->log_file);
> +	fd = open(lock->log_file, O_CREAT | O_TRUNC | O_WRONLY, 0666);
> +	if (fd < 0)
> +		die("Unable to create ref log %s: %s.",
> +		    lock->log_file, strerror(errno));
> +	close(fd);
> +}

This probably should move into refs.c.  Look at log_ref_write,
specifically around the if (log_all_ref_updates).  If this took
an additional parameter to force creation of the log even if the log
isn't present and OR'd against log_all_ref_updates then it would
be possible to have the refs.c code create the log for you in the
"library" part of GIT.

Or maybe it is better to add this as a flag to the struct ref_lock,
defaulting to false and letting the caller set it to true before
invoking write_ref_sha1.  I only suggest this because of the number
of parameters already in play here.

> +static void create_branch(const char *name, const char *start,
> +			  int force, int reflog)

This all looked correct to me, at least as far as dealing with
the reflog.  :-)
