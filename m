From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 23:35:22 -0700
Message-ID: <7vk64anc5x.fsf@assigned-by-dhcp.cox.net>
References: <20060910190332.17667.qmail@science.horizon.com>
	<Pine.LNX.4.64.0609101254590.27779@g5.osdl.org>
	<17668.38032.20688.991295@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609101949580.27779@g5.osdl.org>
	<Pine.LNX.4.64.0609102002300.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Sep 11 08:35:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMfNl-0000PF-Cr
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 08:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWIKGeu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 02:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWIKGeu
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 02:34:50 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:21658 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751202AbWIKGet (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 02:34:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060911063448.DVPJ2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Mon, 11 Sep 2006 02:34:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Luan1V00D1kojtg0000000
	Mon, 11 Sep 2006 02:34:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609102002300.27779@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 10 Sep 2006 20:18:49 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26840>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 10 Sep 2006, Linus Torvalds wrote:
>> 
>> If we did the same pack-file approach that we do for objects, the problem 
>> ends up being that _updating_ things is really hard. What we could do (and 
>> might work) is that a "git repack" would create a "packed representation 
>> of the heads too".
>
> To clarify: I'm _not_ suggesting actually using the "pack-file" 
> representation itself for the references.
>
> I'm saying that we could have something like a
>
> 	.git/refs-packed
>
> file, which could be (for example) just a plain linear text-file, of the 
> form
>
> 	19ed368b17abfb9ad5c7467ea74fd8a045d96b43	refs/heads/html
> 	60a6bf5f53635005f4f68d8b8a33172309193623	refs/heads/maint
> 	...
>
> ie it would contain just a linear file with the "<hex></tab><refname>"
> format.  Then, the way to look up a reference would be:
>...
> NOTE! It's important that whatever sceme used gets locking right. The 
> above suggestion gets it right simply because it doesn't really _change_ 
> anything. Any new or modified ref ends up using the old code, and using a 
> ".lock" file and renaming it automatically does the same thing it ever 
> did.

This is all interesting and can be done by somebody interested
in the really core part of the system.

I was just looking at Paul's "new" branch, and realized that
there is something else that somebody _else_ can do in parallel
to make life easier for gitk and gitweb, and it is not on so
bare-metal-core side.  The latest commit in Paul's "new" branch
says:

    We were doing two execs for each tag - one to map the tag ID to a commit
    ID (which git ls-remote was already giving us as refs/tags/foo^{}) and
    one to read the contents of the tag for later display....

I think this is a typical problem any Porcelain layer faces.  To
grab summary information for all refs in a concise form in one
go.

We discussed such a potential command about a month ago with
Jakub, but the suggestion did not go anywhere.

http://thread.gmane.org/gmane.comp.version-control.git/25013/focus=25055

In addition to what I described there, such a command should at
least allow specifying some special formatting for tag objects,
such as dereferencing it once (i.e. what the object name and
type of the referenced object is) and dereferencing it
repeatedly until a non-tag appears (i.e. "$that_tag^{}" along
with its type).

The show-ref command will alleviate the fork+exec problem; the
core side update you suggested for ref handling will improve the
performance of the implementation of such a command and can be
done in parallel.
