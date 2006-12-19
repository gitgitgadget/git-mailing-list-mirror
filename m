X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Possible optimization for gitweb
Date: Tue, 19 Dec 2006 22:45:32 +0100
Organization: At home
Message-ID: <em9mcs$moo$1@sea.gmane.org>
References: <20061219205422.GA17864@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 19 Dec 2006 21:43:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 97
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34854>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwmkH-00034D-T4 for gcvg-git@gmane.org; Tue, 19 Dec
 2006 22:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932949AbWLSVnb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 16:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932959AbWLSVnb
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 16:43:31 -0500
Received: from main.gmane.org ([80.91.229.2]:60458 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932949AbWLSVna
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 16:43:30 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gwmk2-0001gt-PS for git@vger.kernel.org; Tue, 19 Dec 2006 22:43:18 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 19 Dec 2006 22:43:18 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 19 Dec 2006
 22:43:18 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

[Please send replies Cc: git mailing list]

Robert Fitzsimons wrote:

> While looking at the gitweb source yesterday, I noticed a number of
> similar expensive workflows used by a number of actions (summary,
> shortlog, log, rss, atom, and history).
> 
> The current workflows are:
>       get ~100 sha1's using rev-list
>       foreach sha1
>               get/parse 1 commit using rev-list
>               output commit
> 
> The new workflows I'm proposing would be:
>       get/parse ~100 commit's using rev-list
>       foreach commit
>               output commit

I have tried this approach too. Take a look at

  http://repo.or.cz/w/git/jnareb-git.git?a=log;h=Attic/gitweb/parse_rev_list

or at discussion started with
  Message-Id: <200609061504.40725.jnareb@gmail.com>
  http://mid.gmane.org/200609061504.40725.jnareb@gmail.com

> The following simplified commands gives an idea of the git only overhead
> between these two workflows.
> 
> time \
> for r in `git-rev-list --max-count=100 HEAD --` ; \
> do git-rev-list --header --parents --max-count=1 $r -- ; \
> done > /dev/null
> 
> real    0m0.490s
> user    0m0.224s
> sys     0m0.228s
> 
> time \
> git-rev-list --header --parents --max-count=100 HEAD -- > /dev/null
> 
> real    0m0.058s
> user    0m0.008s
> sys     0m0.004s
> 
> There would seems to be a benefit from making the proposed change to
> these workflows, when run on my machine against a clone of Linus's tree.

The problem is that it works only for "log" and "shortlog" views, but
it doesn't work for "history" view. Now both share the same infrastructure.
The problem is that when there is path limiter (be it file or directory)
the history is simplified, and parents are _rewritten_ according to
simplified history. And this happen depending on strange combination
of --header, --parents and --full-history. Should be somewhere in archives.

And we don't want to use parents from commit object, because there might
be grafts, or it might be shallow clone.

On the other hand, we don't really need parents for log, shortlog and
history...

> One issue with this change is that, gitweb is page orientated.  Page 0
> shows the first 100 items from a given hash, page 1 uses the same given
> hash but show 100 to 199 items, etc.  Using 'git-rev-list --header
> --parents' and then throwing away most of the result is very wasteful.
> 
> So I'm suggesting we add a new option to git-rev-list which will only
> start show results once its has iterated past a given number of items.
> Using a caret or tilde doesn't seem to return the same result.
> 
> I've attached a discussion patch which adds a new option --start-count
> to git-rev-list and changed the summary and showlog actions of gitweb to
> use this new option.

Very nice idea.
 
> I'm sure there are many improvements to this patch, comments?

Perhaps this patch should be split in two? (Usually either second mail is
reply to first mail, or both are replies to introductory letter, usually
with table of contents and diffstat of series).

[...]

Documentation (of --start-count / --skip option), please?


P.S. Thanks for the patches.

P.P.S. Do you have any comments to latest "[RFC] gitweb wishlist and TODO
list" series?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

