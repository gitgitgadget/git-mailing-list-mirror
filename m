X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach receive-pack how to keep pack files when unpacklooseobjects = 0.
Date: Mon, 30 Oct 2006 15:23:00 -0800
Message-ID: <7vlkmxtmln.fsf@assigned-by-dhcp.cox.net>
References: <20061030223615.GH5775@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 23:23:20 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061030223615.GH5775@spearce.org> (Shawn Pearce's message of
	"Mon, 30 Oct 2006 17:36:15 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30552>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GegTE-0004dX-3f for gcvg-git@gmane.org; Tue, 31 Oct
 2006 00:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161373AbWJ3XXD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 18:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161449AbWJ3XXD
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 18:23:03 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:24814 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1161373AbWJ3XXB
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 18:23:01 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061030232300.SQOK18180.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 18:23:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gnNh1V0081kojtg0000000 Mon, 30 Oct 2006
 18:22:41 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Since keeping a pushed pack or exploding it into loose objects should
> be a local repository decision this teaches receive-pack to decide
> if it should call unpack-objects or index-pack --stdin --fix-thin
> based on the setting of receive.unpackLooseObjects.

One thing you can cheaply do is to tell the number of new
commits that is coming to receive-pack from send-pack when it
sends the old..new pairs before it sends the packfile payload.
It would be just a single internal rev-list call inside
send-pack, which is reasonably cheap.

If the receiving end knows how to process that new information
(invent a "send-count" protocol extension and send it just like
we already send "report-status" request), send one extra packet
after flushing the list of old..new from send-pack to
receive-pack, to tell what the number of commits are, and make a
matching change in receive-pack.

Then, instead of receive.unpackLooseObjects being a boolean, you
can have it as a ceiling to decide if you have more than 100
commits you would keep it packed and otherwise you would
explode.  That would be very specific to the projects' size
(width of the tree) and style (huge commits vs lots of small
changes).

