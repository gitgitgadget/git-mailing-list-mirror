From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Use File::Find::find in git_get_projects_list
Date: Thu, 14 Sep 2006 00:37:17 -0700
Message-ID: <7v8xkm6gr6.fsf@assigned-by-dhcp.cox.net>
References: <200609140839.56181.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 09:37:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNlmm-0005JG-97
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 09:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWINHhU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 03:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWINHhU
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 03:37:20 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:55454 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751426AbWINHhS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 03:37:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060914073718.NPAV6711.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 Sep 2006 03:37:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id N7d61V00K1kojtg0000000
	Thu, 14 Sep 2006 03:37:07 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200609140839.56181.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 14 Sep 2006 08:39:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26991>

Jakub Narebski <jnareb@gmail.com> writes:

> +		sub wanted {
> +			# skip dot files (hidden files), check only directories
> +			#return if (/^\./);

Leftover comment?

> +			my $subdir = substr($File::Find::name, $pfxlen + 1);
> +			# we check related file in $projectroot
> +			if (-e "$projectroot/$subdir/HEAD") {
> +				push @list, { path => $subdir };
> +				$File::Find::prune = 1;

We might want to do an extra cheap check to make what we found
is sane, to prevent us getting confused by a random file whose
name happens to be HEAD.

For example, it is a regular file whose contents is a single
line and begins with "ref: refs/heads/" (16 bytes) or it is a
symlink and readlink result begins with "refs/heads/" (11
bytes).

If you feel opening and reading the file is an added overhead,
checking for $project/$subdir/{objects,refs}/ directories might
be a good alternative.

> +		File::Find::find({
> +			no_chdir => 1, # do not change directory
> +			follow_fast => 1, # follow symbolic links

What is the reason behind choosing follow_fast?  By saying
follow_anything, you choose to care about cases where there are
symlinks under projectroot to point at various projects.  If
that is the case, don't you want to make sure you include the
same project only once?

> +			#follow_skip => 2, # ignore duplicated files and directories

Leftover comment?

About these two leftover comments, if you decided you did not
want them, please do not leave them behind.

If on the other hand you wanted to hint others that you are not
sure about your decision, it would probably be better to say
that honestly in the comment, perhaps mark the message as RFC,
and describe what the issues are, like so:

	sub wanted {
		# We might want to also ignore dot files, by
                # saying "return if /^\./;" here, but there is
                # no inherent reason for us to forbid a repository
                # name from starting with a dot.

                # We check only if a directory looks like a git
                # repo and do not care about non directories.
                # Note that this cannot be done with "-d _"
                # because we are using follow_fast and the last
                # stat was done with lstat(); we want to catch a
                # symlink that points at a directory.
                return unless -d $_;
                ...
