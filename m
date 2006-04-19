From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] get_sha1() shorthands for blob/tree objects
Date: Tue, 18 Apr 2006 18:30:02 -0700
Message-ID: <7vd5fecpyd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org>
	<7vpsjecriu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604181805080.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 03:30:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW1WD-0004f2-FE
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 03:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWDSBaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 21:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWDSBaE
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 21:30:04 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:22501 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750942AbWDSBaD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 21:30:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060419013003.OONH15879.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Apr 2006 21:30:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604181805080.3701@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 18 Apr 2006 18:16:10 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18899>

Linus Torvalds <torvalds@osdl.org> writes:

> Now, the thing that an internal "git diff" could do better is to notice 
> when it gets _one_ blob revision, and one filename, ie we could do
>
> 	git diff v0.99.6:git-commit-script git-commit.sh
>
> which parses as one SHA1 of a blob (put onto the rev.pending_objects 
> list), and one filename (in the rev.prune_data array). We could decide to 
> automatically do the "right thing" for that case too.

The "right thing" is ambiguous, I am afraid.

I think it would be natural to interpret the request as a diff
between the blob from v0.99.6 and a random working tree file, 
which may not even exist in the index.

However I suspect what you are getting at is to act as if the
user said:

	git diff v0.99.6:git-commit-script HEAD:git-commit.sh

Oh, another possibility is to act as if the user said

	git diff v0.99.6:this :git-commit.sh

where "(empty):" would stand for "look up in the index, not in a
tree".

I think these are all valid interpretations and there are useful
use cases (admittably the last one is "diff-cache --cached").

Unfortunatly, I do not think this parses well:

	git diff git-commit.sh v0.99.6:git-commit-script

but you could always say:

	git diff -R v0.99.6:git-commit-script git-commit.sh
