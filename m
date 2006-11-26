X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Sat, 25 Nov 2006 21:11:15 -0800
Message-ID: <7vk61iyeq4.fsf@assigned-by-dhcp.cox.net>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net>
	<ekafpm$fs7$1@sea.gmane.org> <20061126033433.GD29394@spearce.org>
	<7vvel2yi2u.fsf@assigned-by-dhcp.cox.net>
	<20061126042311.GB30001@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 05:11:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061126042311.GB30001@spearce.org> (Shawn Pearce's message of
	"Sat, 25 Nov 2006 23:23:11 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32329>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoCIZ-0000ha-0g for gcvg-git@gmane.org; Sun, 26 Nov
 2006 06:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967295AbWKZFLR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 00:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935239AbWKZFLR
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 00:11:17 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:21409 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S935238AbWKZFLQ
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 00:11:16 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061126051116.LPSR5465.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Sun, 26
 Nov 2006 00:11:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id rHAl1V0041kojtg0000000; Sun, 26 Nov 2006
 00:10:45 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> So now we're at a point of:
>
>  * how do we get this branch information from the remote?
>  * how does the remote store this branch information?
>
> I'm leaning towards the repo config for the latter, with say:
>
> 	[branch "pu"]
> 		rewinds = true
> 		description = This branch contains some proposed updates to git.\n\
> 	It rewinds often, as different updates are proposed or merged into 'next'.
>
> but looking at that think its rather horrible looking.  :-)
>
> However for the former it may be useful if the client can download
> the repo config from the remote repository, such as to fetch
> the branch description data.

For the former, I was hoping that we could do a new action
against remote repository that is "get remote information". Just
like we have "ls-remote" as a protocol neutral front-end to get
what git native protocol would give "peek-remote", git native
protocol would have get-repository-info action to transfer this
information, and http and dumb transports do a file download
from a known file, just like they download files prepared with
update-server-info.  Most likely, that get-repository-info is
just a glorified single file transfer and nothing more.

As an implementation detail, I think it is one possibility to
store this information in the config of the repository being
cloned from.  We should be able to use repo-config to
parse that file in config-like syntax to extract what we would
want, so we do not have to come up with a new syntax nor a new
parser, which is a big plus.

	Side note: repo-config, especially the updating side of
	it, is one of the programs I find the most brittle in
	the whole system, and it always makes me hesitate when
	somebody proposes to use config file in any important
	way read-write for this reason.  But this "reading out
	per-branch information from the file" is read-only so I
	would not worry too much about it.

Strictly speaking, however, the config file is a wrong place to
store it.  For one thing it has core.sharedrepository and
receive.denynonfastforwards that are true configuration to
control the behaviour of git _at_ _the_ _repository_ the
configuration is at.  The new "branch property" are primarily to
help the other end, and the "filtering rewinding ones" we want
at the clone/fetch side wants that information only and not
interested in the true configuration information at that
repository.

So my preference is:

 * store it in a fixed filename under $GIT_DIR/$something, in a
   format that is similar to the true config file.

 * Dumb transports would just do a file transfer, and we add a
   new command (like "upload-pack", "upload-archive") for git
   native transport to read that file.  We might want to have a
   protocol neutral wrapper (just like "ls-remote").

 * Cloners and fetchers would do the file transfer and use
   repo-config to read from that transferred file to find out
   which are rewinding branches.




