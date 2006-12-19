X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 2/2] git reflog expire
Date: Tue, 19 Dec 2006 04:08:51 -0500
Message-ID: <20061219090851.GH2511@spearce.org>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net> <7vr6uxzgjb.fsf@assigned-by-dhcp.cox.net> <20061218140813.GA32446@spearce.org> <7vy7p4u1au.fsf@assigned-by-dhcp.cox.net> <7v64c8thr4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 09:09:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v64c8thr4.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34803>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwayD-0000kR-3n for gcvg-git@gmane.org; Tue, 19 Dec
 2006 10:09:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932700AbWLSJJF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 04:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbWLSJJF
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 04:09:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59215 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932700AbWLSJJD (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 04:09:03 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gway0-0000Cy-Tg; Tue, 19 Dec 2006 04:08:57 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 660BF20FB65; Tue, 19 Dec 2006 04:08:52 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> This prepares a place to collect reflog management subcommands,
> and implements "expire" action.
> 
> 	$ git reflog expire --dry-run \
> 		--expire=4.weeks \
> 		--expire-lost=1.week \
> 		refs/heads/master
> 
> The expiration uses two timestamps: --expire and --expire-lost.
> Entries older than expire time (defaults to 90 days), and
> entries older than expire-lost time (defaults to 30 days) and
> talk about a commit that has been rewound and made unreachable
> from the current tip of the ref are removed from the reflog.
> 
> The parameter handling is still rough, but I think the
> core logic for expiration is already sound.

I agree, this looked pretty good to me.

I disagree with the option name '--expire-lost'.  The way I
initially read that was:

    --expire-lost: ok, if the object was already pruned out of
    the ODB and the reflog entry is older than 1 week, remove it;
    otherwise keep it in case the user could manually recover the
    object from another ODB.

Of course that's not what the code does, because if either the
old or the new object is no longer in the ODB you are pruning away
the log entry.  I cannot however come up with a better name than
--expire-lost.  :-(

Perhaps --expire-lost should default to just be 1/3 of the time of
--expire, whatever --expire is: 90 day default or command line value?


I'm thinking that we may want the 'expire' subcommand to simply be
implied by '--expire' instead.  Basically my rational here is I want
to be able to do 'git reflog HEAD' to view the reflog associated with
my current branch, effectively seeing the Git operational history
of this branch.  Or 'git reflog a b' to see the operational history
of two branches with their reflogs interleaved based on entry time.

Needing a subcommand like 'git reflog show HEAD' is just a lot
of typing[*1*].

I would also say maybe we want to make --dry-run the default, with
a final message which tells the user that if they really want to
make it possible to throw away the commits printed above then
restart the expire operation, e.g.:

  $ git reflog --expire=4.weeks --expire-lost=1.week master
  would expire ...
  would expire ...
  would expire ...

  Restart with '--prune' to expire the above log entries and commits.
  $ git reflog --expire=4.weeks --expire-lost=1.week master --prune

?


I'd like to take a stab at the log display code for the reflog
command, but I'd also really like to port forward (aka rewrite)
that mmap window code I keep saying I'll work on, but never quite
seem to do...


*1* Yes, I know, I'll do bash completion for this command too.  ;-)

-- 
