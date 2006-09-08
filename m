From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/4] Add git-archive
Date: Thu, 07 Sep 2006 19:35:12 -0700
Message-ID: <7vodtrnl0f.fsf@assigned-by-dhcp.cox.net>
References: <450019C3.4030001@innova-card.com>
	<11576347251776-git-send-email-vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 04:35:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLWCp-0002mK-TU
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 04:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbWIHCe4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 22:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbWIHCe4
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 22:34:56 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:63728 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1752052AbWIHCey (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 22:34:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060908023454.YSTX2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 Sep 2006 22:34:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Keam1V0091kojtg0000000
	Thu, 07 Sep 2006 22:34:46 -0400
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
In-Reply-To: <11576347251776-git-send-email-vagabon.xyz@gmail.com> (Franck
	Bui-Huu's message of "Thu, 7 Sep 2006 15:12:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26673>

Franck Bui-Huu <vagabon.xyz@gmail.com> writes:

> The main reason for making this API is to avoid using
> git-{tar,zip}-tree commands, hence making them useless. Maybe it's
> time for them to die ?

The answer is "not yet" and the above paragraph, at least the
last sentence and half, do not belong to the commit log message.

> It also implements remote operations by defining a very simple
> protocol: it first sends the name of the specific uploader followed
> the repository name (git-upload-tar git://example.org/repo.git).
> Then it sends options. It's done by sending a sequence of one
> argument per packet, with prefix "argument ", followed by a flush.

I haven't looked the existing code closely recently, but my
impression was that if you want to make the protocol operable
with both git-daemon, ssh target, and local pipe, it is easier
to make the request message exactly like you would invoke the
remote command over the ssh connection in the target repository
(see connect.c).  I am not sure how well the above
"git-upload-tar reponame" would work.  I would have expected it
to be "git-upload-archive reponame" with the first on-protocol
parameter being "--fmt=tar".

Does your code work well when you run the remote archive
fetching locally, i.e. "git-archive --remote=../other.git",
I wonder?

... goes on and reads the patch, notices that the protocol
command is git-upload-archive with the archive location.  Which
is GOOD.  It is just the above description is a tad stale.

> diff --git a/archive.h b/archive.h
> new file mode 100644
> index 0000000..f33398e
> --- /dev/null
> +++ b/archive.h
> @@ -0,0 +1,41 @@
> +#ifndef ARCHIVE_H
> +#define ARCHIVE_H
> +
> +#define MAX_EXTRA_ARGS	32
> +#define MAX_ARGS	(MAX_EXTRA_ARGS + 32)
> +
> +struct archiver_args {
> +	const char *base;
> +	struct tree *tree;
> +	const unsigned char *commit_sha1;
> +	time_t time;
> +	const char **pathspec;
> +	void *extra;
> +};
> +
> +typedef int (*write_archive_fn_t)(struct archiver_args *);
> +
> +typedef void *(*parse_extra_args_fn_t)(int argc, const char **argv);
> +
> +struct archiver {
> +	const char *name;
> +	const char *remote;
> +	struct archiver_args args;
> +	write_archive_fn_t write_archive;
> +	parse_extra_args_fn_t parse_extra;
> +};
> +
> +extern struct archiver archivers[];

I thought the reason for archiver_args (and archiver_args.extra)
was because we wanted to avoid storing per invocation parameters
in static variables, which would hamper reentrancy.  If one
process is creating two archives, both format=tar, it might be
reasonable for the code (future archiver enhancement, not your
current implementation of git-archive driver) to parse two sets
of parameters first (to get separate archiver instances) and
call their write_archive, but if archivers[] list has the
per-invocation parameter args then we are back to square one,
aren't we?

Reentrancy may not matter, but in any case the above archiver_args
is not helping enough to improve the situation, I think.

Actually you may be able to get away by returning a copy of
archivers[] element from get_archiver() when we need reentrancy
in the future.  Of course the caller needs to free() it when it
is done with it, since it is a per-invocation handle.

> +void parse_treeish_arg(const char **argv, struct archiver_args *ar_args,
> +		       const char *prefix)
> +{
> +...
> +	//free(tree);
> +	ar_args->tree = tree;
> +	ar_args->commit_sha1 = commit_sha1;
> +	ar_args->time = archive_time;
> +}

Stray comment...

Overall looks good, except you already know your issue #4 ;-).

I haven't had a chance to look at connect.c code but I have a
mild suspicion that full reuse of upload-pack code by moving
everything into connect.c is not possible; at least the initial
handshake to determine if sideband is to be used is specific to
upload-pack protocol which needed to bolt-it-on to an existing
protocol to support older clients and servers, and I do not
think we would want to carry that baggage for this new protocol.

The pipe setup code in upload-pack.c::create_pack_file() is
quite specific to upload-pack.  I am not sure how much of it can
be reused by refactoring, but it may be worth a try.

The part that reads from fd 1 and 2 and to multiplex into the
stream on the uploader side (the main while() loop in the same
create_pack_file() function, and send_client_data() function),
and the code to setup and demultiplex the bands on the
downloader side (setup_sideband() in fetch-clone.c) should be
reusable as-is, I think.  They are defined as static so you
would need to move the code around to make them available from
elsewhere.
