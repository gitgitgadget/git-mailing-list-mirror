From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: combined diff does not detect binary files and ignores -diff
 attribute
Date: Tue, 24 May 2011 09:19:43 +0200
Message-ID: <4DDB5C0F.1080102@drmicha.warpmail.net>
References: <BANLkTi=FtkiUjwAa7e3KAC5FF3GNxWzd3Q@mail.gmail.com> <4DDA618E.4030604@drmicha.warpmail.net> <BANLkTinu3AbTmtswn6DLQKAWdLL=gBvAqA@mail.gmail.com> <20110523181147.GA26035@sigill.intra.peff.net> <20110523201529.GA6281@sigill.intra.peff.net> <BANLkTikvPjO=bbhAoPCftdXzGSYtryNvzw@mail.gmail.com> <20110523234131.GB10488@sigill.intra.peff.net> <7v39k4aeos.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 24 09:19:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOluB-00028p-Ak
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 09:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245Ab1EXHTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 03:19:46 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:57403 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752499Ab1EXHTq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2011 03:19:46 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 540122091B;
	Tue, 24 May 2011 03:19:45 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 24 May 2011 03:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=5qIqEBYv6TS4GP4fJW9VufzHn+g=; b=AZCAjsv4AkGs5R5Sr629n4qwxgHDzpQAG6rxpQBl9FmF667w1R6a5bJTtR7U6LKHyW7USldIwb6vI7i0bPX5j9q2UpS4M+JdmVh2rF1D5V6gJ2qJaBmDTtHNXF/IUMLknLSVo0xt23LB1b3RviL1IILlY4pNZ90qeKOrDdlLcu8=
X-Sasl-enc: GvRN9sIJCwV4S+mnUxdeLI3Bif8zvmJybPaDQaDmbS+C 1306221584
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 75B2B447C3C;
	Tue, 24 May 2011 03:19:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <7v39k4aeos.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174315>

First of all:

Jeff, thanks a bunch for taking this up again! That's a great
improvement. (I'm not sure I can devote enough time to reviewing, but
I'll see.)

Junio C Hamano venit, vidit, dixit 24.05.2011 06:46:
> Jeff King <peff@peff.net> writes:
> 
>>> However, custom diff drivers (still) don't work. :-)
>>
>> Yeah, I didn't add any support for that. I'm not sure what it should do;
>> custom diff drivers don't know how to handle combined diff, do they?
>>
>> If you write me a test case that explains what _should_ happen, I'll see
>> what I can do. :)
> 
> I do not think it is sensible to expect anybody to come up with a sane
> semantics for combined diff to work with GIT_EXTERNAL_DIFF (and external
> diff driver that can be specified via the attributes mechanism) in any
> meaningful way.
> 
> The whole point of the external diff mechanism is that an external command
> can take _two_ files and represent the change between them in a way that
> is more suited for the need of the user than the patch form. The output
> from such an external command does not have any obligation to even follow
> the convention used by the patch output, namely:
> 
>   @@ from here to there things have changed @@
>    this is common
>   -this was the removed content
>   +this is the new content
> 
> as the _whole_ point of the external diff mechanism is to give something
> that is _different_ from the patch form, in the hope that it is in a more
> appropriate form for whoever consumes the output.
> 
> On the other hand, combined diff is all about combining multiple patches
> show them side-by-side in a combined fashion. Without the above four kinds
> of cues, there is no way to even _align_ the change outputs from two
> parents, let alone _combining_ them.
> 
> Anybody interested can check "compare-cooking.perl" in the todo branch,
> which is used as an external diff driver to view the differences between
> "What's cooking" postings via these:
> 
>     [diff "whatscooking"]
>             xfuncname = "^\\[(.*)\\]$"
>             command = ./compare-cooking.perl
> 
> in the .git/config file, together with
> 
>     whats-cooking.txt diff=whatscooking
> 
> in the .gitattributes file. Running
> 
>     $ git log -p --ext-diff todo -- whats-cooking.txt
> 
> would give a sample output.
> 
> It is conceivable that we _could_ newly define a "combined external diff
> driver" that would take 3 or more files, and compute and show the combined
> result by itself, but that will certainly not go through the codepath you
> touched with the textconv patch. Calling out to such a new type of
> external diff driver would have to happen at the level where we have 1+N
> blob object names for a N-parent commit, namely, at the beginning of
> show_patch_diff(), bypassing the entire contents of that function and
> instead letting the new n-way external diff driver do everything.
> 
> I however highly doubt that such an interface would make sense. For
> example, what would be the desirable format to compare three versions of
> "What's cooking" postings, and how would the updated compare-cooking.perl
> script would look like?

Yeah, currently --cc with external makes no sense, but there are several
external tools which could present a 3-way diff in a useful way (or even
n-way with n>3), e.g. vimdiff, kdiff3, meld.

When the --cc/textconv issue came up I looked into this, and maybe
difftool is a place where one could plug this in first in the sense of
refactoring that even more and providing a diff3tool or such to view a
merge commit (or compare any 3 versions), or/and provide "git diff3 A B
C" which creates a fake merge (A+B -> C). Now, imagine we also have
INDEX and WORKTREE pseudorevs and can do

git diff3[tool] HEAD INDEX WORKTREE

:)

Michael
