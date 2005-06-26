From: Junio C Hamano <junkio@cox.net>
Subject: Re: kernel.org and GIT tree rebuilding
Date: Sun, 26 Jun 2005 12:45:29 -0700
Message-ID: <7vll4wq4va.fsf@assigned-by-dhcp.cox.net>
References: <20050624.212009.92584730.davem@davemloft.net>
	<42BCE026.8050405@pobox.com>
	<Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org>
	<42BCF02B.5090706@pobox.com>
	<Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
	<Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org>
	<7vzmtdq7wy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506261206170.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David S. Miller" <davem@davemloft.net>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>, Chris Mason <mason@suse.com>
X-From: git-owner@vger.kernel.org Sun Jun 26 21:44:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dmd34-0006Rz-L7
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 21:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVFZTtM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 15:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVFZTtM
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 15:49:12 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:61946 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261631AbVFZTpb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2005 15:45:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050626194531.LROI12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 26 Jun 2005 15:45:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506261206170.19755@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 26 Jun 2005 12:19:07 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Sun, 26 Jun 2005, Junio C Hamano wrote:
>> 
>> My preference is to do things in this order:
>> 
>> (0) concatenate pack and idx files;

LT> So let's just keep the index/data files separate.

Fair enough.  Having thought about it a bit more, if people
agree, I think it would make more sense to rip out "delta"
object support first before doing read_sha1_file() and friends
that uses .git/objects/pack.

My "preferred order" now look like this:

 (1) have people with deltified repositories convert them back
     to undeltified (I think git-pack-objects would barf on such
     repository);

 (2) drop "delta" objects from GIT_OBJECT_DIRECTORY; this means
     that git-deltafy-script and git-mkdelta have to go.

 (3) teach read_sha1_file() to read from packed GIT in
     .git/objects/pack;

 (4) teach fsck-cache about packed GIT;

 (5) tell git-*-pull about packed GIT;
