From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Rename handling
Date: Mon, 19 Mar 2007 11:14:51 -0700
Message-ID: <45FED31B.8070307@midwinter.com>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 19:17:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTMPn-0002Bh-7v
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 19:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030515AbXCSSO7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 14:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030505AbXCSSO7
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 14:14:59 -0400
Received: from tater.midwinter.com ([216.32.86.90]:49339 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030510AbXCSSOs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 14:14:48 -0400
Received: (qmail 3876 invoked from network); 19 Mar 2007 18:14:48 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.129?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 19 Mar 2007 18:14:47 -0000
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42650>

John Goerzen wrote:
> 2) For me, a rename is a logical change to the source tree that I want
>    to be recorded with absolute certainty, not guessed about later.
>    Sometimes I may make API changes and it is useful to see how module
>    names changed, with complete precision, later.  I do not want to be
>    victim to an incorrect guess, which could be possible.
>   

If you commit your renames separately from your content changes, it'll 
be unambiguous and you won't have to worry about it. That's what I 
usually do when this is a concern and it has yet to break for me.

On the other hand, I agree with your general point; I really don't like 
being uncertain about whether renames are going to come out correctly or 
not ("it has always worked before" and "it is by design unable to fail" 
are two very different things.) In particular, I strongly disagree with 
the "names are just syntactic sugar, it's the content we're tracking" 
philosophy. Here's a simple example of why:

#include <xyz.h>

That simple statement is an intermingling of content and namespace. The 
presence of something like that actually breaks the "commit the rename 
separately" approach -- if you rename xyz.h to something else and commit 
just that rename, that revision won't compile, and I *really* don't like 
intentionally committing broken revisions.

Okay, so you say, rename xyz.h and update the references to it, but 
don't actually modify it. Fine, that works in this case. Now how about 
this one:

public abstract class Foo {
    private static Logger logger = Logger.getLogger(Foo.class.getName());
}

The references to the name "Foo.java" in that case are within the file 
itself (assuming you're using a Java compiler that requires the filename 
and class name to match, which the common ones do.) You can't change 
just the references without changing the file you're renaming. And, 
depending on how many self-references there are in this file, it's 
anyone's guess whether the content-based rename detection will consider 
the renamed file to be close enough to the old one to be a probable rename.

Combine renames with major code refactoring where the content changes 
substantially, and all bets are off.

Now, having said all that, I'll argue in favor of the content-based 
rename support for a moment. It is extremely cool that git will actually 
detect renames in third-party packages where you've just untarred a new 
release into your git repository and committed it, but have given git no 
hints at all about the nature of the content changes. I'm not aware of 
any other version control system that'll do that, and I've taken 
advantage of that feature in the past. So by no stretch am I saying that 
content-based rename detection is worthless.

But I would sure rest a lot easier if "git mv" would record a "the user 
renamed this file" entry in some log somewhere and the merge code would 
see that entry and say, "aha, no need to guess at it, file X got renamed 
to Y." Bonus points if that record could apply to directories too, so 
you don't have the "I created a new file in a directory you renamed, and 
after git-pull my file is still sitting by itself in the old directory" 
bug. If no such record exists, then the current rename code should still 
be invoked to work its considerable magic.

So to answer your question, in my opinion if 100% guaranteed renames are 
high on your priority list, then Mercurial might be the better option 
for now. In practice, I've found that git's 99+% rename detection has 
yet to fail on me aside from the above directory renaming case, but at 
the end of the day it *is* guessing at your renames after the fact.

Okay, git gurus, show me no mercy. :)

-Steve
