From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack file format"
Date: Tue, 11 Jul 2006 14:47:46 -0700
Message-ID: <7vlkqz3jb1.fsf@assigned-by-dhcp.cox.net>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0607101623230.5623@g5.osdl.org>
	<20060711145527.GA32468@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0607111004360.5623@g5.osdl.org>
	<Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
	<Pine.LNX.4.63.0607112031150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0607111153170.5623@g5.osdl.org>
	<Pine.LNX.4.63.0607112116270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0607111241460.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Carl Baldwin <cnb@fc.hp.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 11 23:48:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0Q59-0008Fu-DW
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 23:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWGKVrs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 17:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWGKVrs
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 17:47:48 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:17883 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932132AbWGKVrr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 17:47:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060711214747.GNCX554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Jul 2006 17:47:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607111241460.5623@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 11 Jul 2006 12:48:08 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23739>

Linus Torvalds <torvalds@osdl.org> writes:

> Here's a newer verson of [2/3], with these issues fixed. It actually fixes 
> things twice: (a) by parsing the binary version first (which makes sense 
> for a totally independent reason - if that is going to be the "default" 
> version in the long run, we should just test it first anyway) and (b) by 
> making the ASCII version parser stricter too.

Wait a minute.

 read-sha1-file maps sha1-file-internal (for unpacked one), and then
 calls unpack-sha1-file.

 unpack-sha1-file calls unpack-sha1-header to start inflation,
 lets parse-sha1-header to read the header in the inflated
 buffer, and calls unpack-sha1-rest to inflate the rest.

But in packs, we have binary header not deflated, followed by
deflated payload.  If we want to copy things from loose objects
into pack without changing the packfile format, this change
would not help, I suspect.

At least, your updated unpack_sha1_file() needs to check for
binary header first (starting from "map"), and if that starts
with binary header, start inflating after the header to extract
the payload.  Otherwise you would do the traditional.
