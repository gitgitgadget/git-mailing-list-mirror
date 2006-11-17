X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 03:29:32 -0800
Message-ID: <7v3b8inwf7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<Pine.LNX.4.64.0611151203450.3349@woody.osdl.org>
	<Pine.LNX.4.64.0611151516360.2591@xanadu.home>
	<Pine.LNX.4.64.0611151226590.3349@woody.osdl.org>
	<87velgs9hx.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611151339500.3349@woody.osdl.org>
	<87psbos4pb.wl%cworth@cworth.org> <20061115230252.GH24861@spearce.org>
	<Pine.LNX.4.64.0611151523290.3349@woody.osdl.org>
	<87fycjs5yg.wl%cworth@cworth.org>
	<f2b55d220611160957s2e68059dk99bbe902e7e1f416@mail.gmail.com>
	<87r6w3b68p.wl%cworth@cworth.org>
	<7vu00ysbwi.fsf@assigned-by-dhcp.cox.net>
	<87ejs2qvmb.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 11:29:54 +0000 (UTC)
Cc: "Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87ejs2qvmb.wl%cworth@cworth.org> (Carl Worth's message of "Fri,
	17 Nov 2006 01:18:36 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31689>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl1ui-000272-PW for gcvg-git@gmane.org; Fri, 17 Nov
 2006 12:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755645AbWKQL3f (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 06:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755693AbWKQL3e
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 06:29:34 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:11174 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1755645AbWKQL3d
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 06:29:33 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061117112933.YKFS97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 06:29:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nnVf1V00E1kojtg0000000; Fri, 17 Nov 2006
 06:29:40 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> writes:

> What I have been doing up to this point is a little script I wrote
> that does git-ls-remote on the repository I want to track and writes a
> .git/remotes file to bring in all their branches. So if I want to see
> what behdad is up to, I first refresh his .git/remotes file with my:
>
> 	cairo-git-setup-remotes behdad
> then:
> 	git fetch behdad
>
> And I end up with a bunch of branch names with "behdad-" prefixes that
> I can explore or blow away if I'm no longer interested, (could have
> used a "behdad/" prefix as well).

I would suggest refs/remotes/behdad.

> So, yes, I'll definitely look into improving this. I think the details
> will involve:
>
> 1. Making clone do the --use-separate-remotes behavior by default
>
> 2. Taking advantage of that consistently for all branches instead of a
>    special master:origin mapping in clone

This already should be the case if you use separate-remote.  I
haven't run "clone --separate-remote" myself for a long time,
but the design was certainly to make it behave that way.
Specifically, map everything in refs/heads/ at remote to
refs/remotes/$origin/ with corresponding names, one-to-one.

I do not see much reason to change the mapping of master:origin
which is done for the traditional layout.  The traditional
layout is not suitable for your workflow anyway, and that is why
you prefer separate-remote layout for your project, and I fully
agree it would suit you better.

> 3. Enhancing git-fetch (or other) to modify .git/remotes, (or was
>    there a desire for some other branch-specific section in the config
>    file?)
>
> 4. Making git-fetch handle the disappearance of a remote branch
>    gracefully
>
> 5. Adding something like git-fetch --all to allow it to pick up all new
>    branches

These three are easily done for separate-remote layout but at
that point you would not want --all but more powerful --mirror
(or --update if you want to use that word), which goes the whole
nine yards of noticing disappearance of remote branch, making
matching deletion of local tracking branch, updating
.git/remotes, etc.  I've muttered something similar in a nearby
thread; see below.

> 6. Adding a "git update" that does a fetch for all appropriately
>    marked remotes.
>
> On this last point, maybe we do something like:
>
> 	update=no|yes|all
>
> in .git/remotes. Then git-clone would set this up with update=all for
> origin so git-update would do a "fetch --all" on the origin
> repository. Then step 3 above would have to provide for setting this
> update option as appropriate.

I would prefer this to be kept in contrib/; it feels like it is
filling rather very narrow need.

> Anyway, something along those lines perhaps. Any feedback?

I muttered something less elaborate in the nearby thread.

	Message-ID: <7vr6w78b4x.fsf@assigned-by-dhcp.cox.net>
	Message-ID: <7v64dev88t.fsf@assigned-by-dhcp.cox.net>

The part that deals with manual configuration (the last point in
the first message, and the second in message its entirety) is
something your workflow would not need nor want to worry about,
but I think it is necessary for different ref namespace layouts
and different workflows.  I think the automatable part (the
first two points in the "sensible thing to do" list in the first
message) is very relevant to what you talked about in your
message.
