From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] Clean up work-tree handling
Date: Sat, 28 Jul 2007 04:15:50 -0700
Message-ID: <7vd4ycsrrt.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
	<Pine.LNX.4.64.0707271956420.14781@racer.site>
	<7vk5sly3h9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707280115370.14781@racer.site>
	<7vejitwe8m.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707280152120.14781@racer.site>
	<7vlkd1umwf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707280956510.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, matled@gmx.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 28 13:15:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEkH7-0008HP-0a
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 13:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248AbXG1LPx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 07:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755232AbXG1LPx
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 07:15:53 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:53998 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908AbXG1LPv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 07:15:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070728111552.RLFX1393.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Jul 2007 07:15:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id UzFq1X00B1kojtg0000000; Sat, 28 Jul 2007 07:15:51 -0400
In-Reply-To: <Pine.LNX.4.64.0707280956510.14781@racer.site> (Johannes
	Schindelin's message of "Sat, 28 Jul 2007 10:01:08 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54024>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Now, I think it is fair to say that if your worktree is somewhere 
>> totally unrelated to your cwd, no amount of going up will take you to 
>> the top.  IOW, you have to come down after going up some levels.  In 
>> such a case, it is easier to code the implementation of --show-cdup to 
>> give an absolute path.
>> 
>> But in that case you are not even in the working tree to begin
>> with, aren't you?  Does git need to support that?
>
> I'd say yes.
>
> It is utterly _inconvenient_ to have to cd to the working tree when you 
> just want to check the status, for example.  And git already knows about 
> the work-tree!

That is a bit different issue. In such a case, I would agree it
would still be sensible for "git diff" to show the whole tree
diff, for example.  In other words, my "does git need to support
that" is not about "even when the location of a worktree is
known, operations that require a work tree should fail when
invoked from outside of it".

Think about what the sensible thing to do is for "git diff ."
Within a work tree, it instructs git to behave as if the user
issued the command from the toplevel with prefix as the
argument.  And scripts that want to mimick that behaviour would
use --show-prefix to obtain the prefix string, and --show-cdup
to obtain how to move to the toplevel.

Outside of a work tree, I think the only two semi-sensible
behaviours exist.  Either tell the user that we cannot
understand what "." should mean in that context and error out
(IOW, "Not inside a work tree"), or assume that the user meant
"from the top".  So in such a case, if we do not want to error
out to make things more "convenient", one possibility would be:

 * give empty as prefix;

 * give absolute or cwd relative path to the work tree for cdup
   (it would not be a sequence of ../ anyway in this case).

I think this is in line with the traditional behaviour when
GIT_DIR is explicitly given.  We assume the cwd is the toplevel,
and return empty prefix and empty cdup.

Having said that, I am not convinced that "assume toplevel
outside of a work tree" is a win for the end users.  If the
command errors out with a message telling the user that relative
path does not make sense from outside a work tree, the user
would understand.  If the command does not error out but always
works relative to the toplevel without explanation, it might
confuse the user more until the he realizes "assume toplevel
outside of a work tree" is the rule that is applying to his
case.
