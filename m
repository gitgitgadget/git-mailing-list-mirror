X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Sun, 26 Nov 2006 02:39:42 -0500
Message-ID: <20061126073942.GA30518@spearce.org>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net> <ekafpm$fs7$1@sea.gmane.org> <20061126033433.GD29394@spearce.org> <7vvel2yi2u.fsf@assigned-by-dhcp.cox.net> <20061126042311.GB30001@spearce.org> <7vk61iyeq4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 07:40:00 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vk61iyeq4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32332>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoEcH-0002ih-GZ for gcvg-git@gmane.org; Sun, 26 Nov
 2006 08:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967324AbWKZHjr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 02:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967328AbWKZHjr
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 02:39:47 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35480 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S967324AbWKZHjq
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 02:39:46 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GoEc3-0006Tm-1x; Sun, 26 Nov 2006 02:39:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 69BEF20FB09; Sun, 26 Nov 2006 02:39:42 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> > So now we're at a point of:
> >
> >  * how do we get this branch information from the remote?
> >  * how does the remote store this branch information?
> 
> For the former, I was hoping that we could do a new action
> against remote repository that is "get remote information".

Yes, that is completely sane.  :)
 
> As an implementation detail, I think it is one possibility to
> store this information in the config of the repository being
> cloned from.  We should be able to use repo-config to
> parse that file in config-like syntax to extract what we would
> want, so we do not have to come up with a new syntax nor a new
> parser, which is a big plus.

Also quite sane.  Nobody wants to write new code if we don't really
have to. :)

> 	Side note: repo-config, especially the updating side of
> 	it, is one of the programs I find the most brittle in
> 	the whole system, and it always makes me hesitate when
> 	somebody proposes to use config file in any important
> 	way read-write for this reason.  But this "reading out
> 	per-branch information from the file" is read-only so I
> 	would not worry too much about it.

Now you tell me.  git-gui uses repo-config for all of its option
data.  It writes back to the config file to save user configured
options, including window layout at quit.  It also uses both the
user global and the local repository config files. :)

We can safely update the index, symrefs and refs.  Why can't we
also safely update the config file?  The biggest problem is its
also a hand-modified file complete with support for comments,
so users expect the file to stay intact during edits.  Aside from
that little issue its really a fairly simple format...

> Strictly speaking, however, the config file is a wrong place to
> store it.  For one thing it has core.sharedrepository and
> receive.denynonfastforwards that are true configuration to
> control the behaviour of git _at_ _the_ _repository_ the
> configuration is at.  The new "branch property" are primarily to
> help the other end, and the "filtering rewinding ones" we want
> at the clone/fetch side wants that information only and not
> interested in the true configuration information at that
> repository.

Yes, of course.  I never suggested copy the entire configuration
as is.  What we really want to do is take the branch data from the
remote and rewrite it for every branch we fetched into a ref, e.g.:

  remote:
    [branch "master"]
        rewinds = false
        description = blah blah

  local:
    [branch "remotes/origin/master"]
        rewinds = false
        description = blah blah

while skipping other configuration sections and options that have
no meaning for the local repository.  core.sharedrepository is just
one of *many* configuration options that the local repository should
not inherit.  remote.<name>.url is another...  etc.

> So my preference is:
> 
>  * store it in a fixed filename under $GIT_DIR/$something, in a
>    format that is similar to the true config file.

At which point you might as well put it into $GIT_DIR/config.
People are going to use git-repo-config to edit that file, even if
you say its brittle and maybe shouldn't be used for heavy editing.
Its just damn handy.
 
Besides of which, lets not forget that something like:

  [branch "master"]
      rewinds = false
  [branch "pu"]
      rewinds = true

is not only data for the client to examine.  It can be useful in
say git-receive-pack as a much more fine-grained alternative to
receive.denynonfastforwards.  If the server's policy is to not
rewind a branch then receive-pack shouldn't let a remote user
rewind it.  At which point its useful to have that branch data
in $GIT_DIR/config.  :-)

-- 
