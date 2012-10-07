From: John Whitney <jjw@emsoftware.com>
Subject: Re: Bug report
Date: Sat, 06 Oct 2012 21:23:59 -0500
Message-ID: <5070E7BF.8040102@emsoftware.com>
References: <506D122E.2050404@emsoftware.com> <CABURp0rhHTSqQFiXEb12iKLAAjMW3+Jn-ubMy-9jNWc5068toA@mail.gmail.com> <506DB500.4010803@emsoftware.com> <20121006133146.GD11712@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 07 04:24:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKgXW-00024W-Ev
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 04:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524Ab2JGCYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 22:24:07 -0400
Received: from mail.emsoftware.com ([76.75.201.49]:58233 "EHLO emsoftware.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751343Ab2JGCYG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 22:24:06 -0400
Received: from Johns-MacBook-Pro.local (ppp-70-253-75-224.dsl.austtx.swbell.net [70.253.75.224])
	by emsoftware.com (Postfix) with ESMTP id 09C7B1AF7E6D;
	Sat,  6 Oct 2012 22:27:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <20121006133146.GD11712@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207174>

On 10/6/12 8:31 AM, Jeff King wrote:
> On Thu, Oct 04, 2012 at 11:10:40AM -0500, John Whitney wrote:
>
>> Thank you for your response. I do see the dilemma, but having
>> no possible "unmodified" state is extremely inconvenient and,
>> as shown, breaks basic git operations.
> But you have asked for an impossible state. You have said "this file
> cannot have CR when you check it in, because we erase them". And yet the
> version of the file in HEAD has CRs in it. So it must appear modified
> with respect to HEAD.  And the solution is to make a commit with the
> normalized content.
I guess I'd really like to see git ignore all line endings of text files 
in the repository. Text files would then never be marked as "modified" 
for this reason and there would be no need to "fix" the line endings. I 
think that should be the default, but just having the option would be nice.

> You said in your test script:
>
>    # Committing test.txt or clearing .gitattributes does clear
>    # the "modified" status, but those options are undesirable
>
> Why is the commit undesirable? You have decided that CRs will no longer
> be tolerated in your repository (by setting .gitattributes). Now you
> need to record that change in history with a commit that strips out the
> CRs.
In some cases it's undesirable. In my example, all I want to do is merge 
in the change that deletes the file, so I don't want to have to add that 
extra commit when I'm just going to delete the file anyway. It's also 
very inconvenient to have to deal with this issue when you're in the 
middle of a complex rebase operation.

>> I guess my thought is that if git doesn't allow CRs to be checked
>> in, then it should strip the CRs when checking the file out, and
>> consider that form (or both forms) as "unmodified". It just
>> doesn't make sense to me that files are considered modified
>> immediately after checkout.
> It is not about having CRs in the working tree file. Those are now
> considered uninteresting and stripped by git when comparing to the HEAD.
> The problem is that what's in your _repository_ has CRs.
Yes, but does that really have to be an issue? Is there any technical or 
practical reason you can think of that the repository shouldn't ignore 
those CRs?

> I wonder if this is a fundamental misunderstanding of how the CRLF
> handling in git works. It is not "magically make me not care about line
> endings anymore". It is "the canonical version in the repo is LF-only.
> Strip anything coming into the repository to match that, and
> (optionally) add CR to anything going out to the filesystem for my
> convenience". But you need a flag day to update the in-repository
> versions to the new scheme.
>
> -Peff
You're right, we can't magically avoid all the line ending issues that 
people will run into. In this case, though, I think git can sidestep a 
fairly obnoxious problem. My example was simple, but when you've got 
multiple branches that need to be rebased/merged, it can get pretty 
hairy. The repository will never be truly "clean" unless you rewrite the 
whole thing (using filter-branch, for instance).

Maybe my above suggestion is more of a feature request than a bug, but 
there is the obvious bug that after changing .gitattributes, git still 
doesn't notice that files are "modified" until you modify them again in 
some way (touch works). I only noticed the CRs in our own repository 
after I tried to rebase a branch and got strange errors. To make git 
notice all the files, I had to "find . -type f -exec touch {} \;".
