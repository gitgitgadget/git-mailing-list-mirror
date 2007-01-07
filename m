From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Moving initialization of log_all_ref_updates
Date: Sun, 7 Jan 2007 04:37:26 -0500
Message-ID: <20070107093725.GB10351@spearce.org>
References: <7vbqlb2nqe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 10:37:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3UT8-0002m7-4a
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 10:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbXAGJhb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 04:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbXAGJhb
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 04:37:31 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52610 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932459AbXAGJha (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 04:37:30 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H3UTM-0001aA-JN; Sun, 07 Jan 2007 04:37:48 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9E63C20FB65; Sun,  7 Jan 2007 04:37:26 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqlb2nqe.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36144>

Junio C Hamano <junkio@cox.net> wrote:
> The patches to prevent Porcelainish that require working tree
> from doing any damage in a bare repository make a lot of sense,
> and I want to make the is_bare_git_dir() function more reliable.
> 
> In order to allow the repository owner override the heuristic
> implemented in is_bare_git_dir() if/when it misidentifies a
> particular repository, it would make sense to introduce a new
> configuration variable "[core] bare = true/false", and make
> is_bare_git_dir() notice it.

Yes, this is an excellent idea.
 
> The scripts would do a 'repo-config --bool --get core.bare' and
> iff the command fails (i.e. there is no such variable in the
> configuration file), it would do the heuristic you implemented
> in your RFC patch [*1*].

Which will come up right most of the time.  And when it doesn't,
core.bare is there to bail the user out.  I like it.

Do we want to consider having init-db/clone set core.bare based on
what they are being asked to do?

> However, setup_git_env() which is called a lot earlier than we
> even read from the repository configuration currently makes a
> call to is_bare_git_dir(), in order to change the default
> setting for log_all_ref_updates.  It somehow feels that this is
> a hack, and I am considering the following patch.  What do you
> think?

Ack'd.  There's little we can do here then to change the order things
get invoked.  That's harder and uglier to change than to just declare
"we don't know what this right now" and guess later.  I'd go with
the patch you have now.  Maybe post 1.5.0 we can cleanup some of the
init order to get the config file parsing for at least some really
very core properties to occur at the same time as setup_git_env().

One thing I don't like about the config file parsing is that
applications can easily skip doing the core.* property setup.
With my sp/mmap changes this means core.packedGit{Limit,WindowSize}
may not be changed away from their defaults, and yet the application
will perform pack file access.  IMHO core.* is core; if you are
going after pack files or loose objects you better also recognize
and honor what core.* says!
 
> By the way, [*1*] is another thing I hate about the current
> config mechanism.  "git-repo-config --get" does not know what
> the possible configuration variables are, let alone what the
> default values for them are.  It allows us not to maintain a
> centralized configuration table, which makes it easy to
> introduce ad-hoc variables and gives a warm fuzzy feeling of
> being modular, but my feeling is that it is turning out to be a
> rather high price to pay for scripts.

I was thinking the other day (after reading an earlier email from
you stating the exact same thing) that perhaps we should do a
config registry within the repository.  E.g. if you want to access
a property in the config file you should also load its documentation
into a file like config.desc:

  $ cat .git/config.desc
  [core "bare"]
    default = 
    package = core-git
    documentation = "Indicates ...."

  [gui "fontdiff"]
    default = -family VT100 -size 9 -weight normal
    package = git-gui
    documentation = "The font for display of a file diff."

I'm not entirely happy with the above format; its just an example.

Obviously we can't change the current repo-config behavior, but
we could add a new "--declared" option which requires that the
property being get/set is also described in .git/config.desc,
failing if it isn't.

-- 
Shawn.
