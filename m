From: Junio C Hamano <gitster@pobox.com>
Subject: Re: resumable git-clone?
Date: Wed, 08 Aug 2007 12:09:51 -0700
Message-ID: <7vlkcl4zcw.fsf@assigned-by-dhcp.cox.net>
References: <fcaeb9bf0708070623p24f1cae2q2af959a89738c4e8@mail.gmail.com>
	<20070808035946.GP9527@spearce.org>
	<Pine.LNX.4.64.0708081012110.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 08 21:10:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIqv3-0001rm-S1
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 21:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932964AbXHHTJ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 15:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764672AbXHHTJ5
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 15:09:57 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:62511 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932926AbXHHTJz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 15:09:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070808190952.QJDP26965.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 8 Aug 2007 15:09:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZX9r1X00G1kojtg0000000; Wed, 08 Aug 2007 15:09:52 -0400
In-Reply-To: <Pine.LNX.4.64.0708081012110.14781@racer.site> (Johannes
	Schindelin's message of "Wed, 8 Aug 2007 10:14:28 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55338>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Now here is a thought: after an interrupted fetch, you could do a 
> (possibly expensive) analysis what commits are dangling, but do not 
> contain broken links in their _complete_ history.  Then mark them as 
> (temporary) refs.

That's all too elaborate and sounds fairly expensive.

I think another practical solution is to reduce the need to
resume git-clone, and I foresee a nice side effect.

Let's talk a bit about the side effect first.  Often I see
people wondering...

 - I am forking off of somebody's big project;

 - I want to publish the result of _my_ part of the work;

 - I cannot afford the diskspace nor the bandwidth at the
   hosting service to offer the whole project, but my own work
   on top of the upstream is small enough;

So I've been thinking about teaching the server side, when
responding to a fetch request, to be able to say something like
"Sorry but this repository is for fetching by people who have at
least these commits from that other project I am a fork of."
We make that "at least these from that other project" part
machine readable, and git-fetch request git-clone makes can
redirect itself to fill the prerequisites before attempting to
go there again.

And one way of doing that "at least these commits" part could be
a pre-built, well known bundle.  The bulk of the older history
of a repository insanely large for your bandwidth requirements
could be made to a single bundle [*1*], and distributed from
other places like mirrored HTTP servers, or even from torrent
network.  The pre-built bundle does not have to be built too
often.  Probably after every other big release would do.

Once we have such a support, cloning from a regular full
repository ove an unreliable connection could fall back on
getting a bundle (a regular repository does not have to refuse
to serve downloaders that do not have the prerequisites, but
it could still suggest that as an alternate method to fall back
on.


[Footnote]

*1* Sheesh.  While I was writing this I noticed that the current
    'git bundle' is suitable only for incremental sneakernet but
    not for this particular use case.

    $ git bundle create 2612.bndl v2.6.12

    does not work, although

    $ git bundle create 2612-2613.bndl v2.6.12..v2.6.13

    does.  We need to fix this.
