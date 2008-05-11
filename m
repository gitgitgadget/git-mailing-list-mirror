From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] Teach git-svn how to catch up with its tracking branches
Date: Sun, 11 May 2008 01:27:27 -0700
Message-ID: <20080511082727.GB23929@untitled>
References: <20080508013956.GA24956@midwinter.com> <20080508041948.GA1095@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sun May 11 10:28:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv6up-0000f0-Nw
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 10:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbYEKI1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 04:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbYEKI1a
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 04:27:30 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53276 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395AbYEKI13 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 04:27:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 4C8772DC08B;
	Sun, 11 May 2008 01:27:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080508041948.GA1095@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81749>

Steven Grimm <koreth@midwinter.com> wrote:
> In environments where a lot of people are sharing an svn repository using
> git-svn, everyone has identical, but individually maintained, tracking
> branches. If the svn repository is very active, it can take a while to
> run "git svn fetch" (which has to individually construct each revision
> by querying the svn server). It's much faster to run "git fetch" against
> another git-svn repository to grab the exact same git revisions you'd get
> from "git svn fetch". But until now, git-svn was confused by this because
> it didn't know how to incrementally rebuild its map of revision IDs.
> The only choice was to completely remove the map file and rebuild it
> from scratch, possibly a lengthy operation when there's a lot of history.
> 
> With this change, git-svn will try to do an incremental update of its
> revision map if it sees that its tracking branch has svn revisions that
> aren't in the map yet.

Cool.  I agree with this is a useful change for people wanting to save
time and bandwidth although I've never been in a situation to need it
myself.

However, I'm kind of uncomfortable with this being on by default, as it
really means they users have to trust the git repository they're
fetching from to always be configured identically to what they're using
and not change configurations midway through a project.  External things
like authors files would need to be synced, too, etc...

> +sub sync_rev_map_with_commits {
> +	my ($self) = @_;
> +	# If we can't pull metadata out of log messages, there's nothing
> +	# to import.
> +	return if $self->use_svm_props || $self->no_metadata;
> +	# If there isn't a revision DB yet, we'll rebuild it from scratch
> +	# elsewhere, so don't do anything here.
> +	return if ! -e $self->map_path || -z $self->map_path;
> +	# Look at the most recent commit with a git-svn-id line.
> +	my ($log, $ctx) =
> +	    command_output_pipe(qw/rev-list --pretty=raw --no-color /,
> +				'--grep=^ *git-svn-id:',

Even though rev-list outputs the commit message prefixed with spaces,
the --grep itself does not need ' *' to match the leading spaces.
No version of git-svn outputting a space before "git-svn-id: "
in the commit itself.

More importantly I'd also prefer to actually grep for the URL+path of
the ref we're tracking, too.  This can catch mistakes if people somehow
configured their remotes incorrectly.

-- 
Eric Wong
