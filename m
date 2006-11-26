X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Sun, 26 Nov 2006 01:13:28 -0800
Message-ID: <7v1wnqwoxz.fsf@assigned-by-dhcp.cox.net>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net>
	<ekafpm$fs7$1@sea.gmane.org> <20061126033433.GD29394@spearce.org>
	<7vvel2yi2u.fsf@assigned-by-dhcp.cox.net>
	<20061126042311.GB30001@spearce.org>
	<7vk61iyeq4.fsf@assigned-by-dhcp.cox.net>
	<20061126073942.GA30518@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 09:13:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32335>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoG51-0004I0-3l for gcvg-git@gmane.org; Sun, 26 Nov
 2006 10:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934343AbWKZJNb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 04:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935244AbWKZJNb
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 04:13:31 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:10424 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S934343AbWKZJNa
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 04:13:30 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061126091329.UQON4817.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Sun, 26
 Nov 2006 04:13:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id rMDd1V0091kojtg0000000; Sun, 26 Nov 2006
 04:13:38 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

>> Strictly speaking, however, the config file is a wrong place to
>> store it.  For one thing it has core.sharedrepository and
>> receive.denynonfastforwards that are true configuration to
>> control the behaviour of git _at_ _the_ _repository_ the
>> configuration is at.  The new "branch property" are primarily to
>> help the other end, and the "filtering rewinding ones" we want
>> at the clone/fetch side wants that information only and not
>> interested in the true configuration information at that
>> repository.
>
> Yes, of course.  I never suggested copy the entire configuration
> as is.

I never misunderstood your plan as such.  I was more worried
about a case where you clone from a not-so-public repository and
the config file has some information of sensitive nature.
Currently we do not have any such variable, so I am probably
being a bit paranoid here, but using the config for the purpose
of what we are discussing right now closes the door to store
sensitive information and declare that the config file at the
remote is "none of the cloner's business".

However,...

> Besides of which, lets not forget that something like:
>
>   [branch "master"]
>       rewinds = false
>   [branch "pu"]
>       rewinds = true
>
> is not only data for the client to examine.  It can be useful in
> say git-receive-pack as a much more fine-grained alternative to
> receive.denynonfastforwards.  If the server's policy is to not
> rewind a branch then receive-pack shouldn't let a remote user
> rewind it.  At which point its useful to have that branch data
> in $GIT_DIR/config.  :-)

This is a good point.  If we want to ever have a 'not to be
leaked' configuration per repository, we can have a separate,
private, configuration file to store that, so I probably should
not worry too much about this at this point.  I'm Ok with having
this in the usual config -- the convenience outweighs the
purity.

To summarize:

 * A repository can have branch."foo".rewinds configuration to
   mark the "foo" branch to be subject to rewinding.  This
   configuration variable defaults to false.

 * Receive.denynonfastforwards is currently a boolean but a new
   value, "per-branch", is also allowed.  When it is set to
   "per-branch", non fast-forward update is allowed only when
   branch."foo".rewinds is true for the branch.

 * A cloner creates "Pull: refs/heads/*:refs/remotes/origin/*"
   (or config equivalent) upon cloning.  When it clones, it
   downloads the config from the remote in order to see which
   are marked as "rewinds".  It makes tracking branches for only
   the ones that are not marked as "rewinds" by default.  We
   might have an option to do '+' variant glob, and clone all
   branches.

 * Subsequent fetch, when the glob is not '+' variant, would
   download the config from the remote in order to see which are
   marked as "rewinds", and ignores the branches that are marked
   as such.

I am a bit unhappy that subsequent fetches have to re-read the
remote config every time.  I can sort-of-see we can cram the
"this is expected to be rewound" information as part of
peek-remote exchange to avoid the overhead, but I do not think
it is easily doable for dumb transports without breaking the
backward compatibility.

To avoid this, we need to remember what remote branches we have
seen but decided not to track, perhaps because they were marked
as "rewinds".  Subsequent fetches first learn what are on the
remote side, and only when it sees a branch that we do not track
and we have not seen, it needs to re-read the remote config to
see if that is to be tracked (in which case we would create a
new tracking branch) or ignored (in which case we would remember
that we will ignore this branch in the future fetches).
