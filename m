From: =?UTF-8?B?RmxvcmlhbiBLw7ZiZXJsZQ==?= <FloriansKarten@web.de>
Subject: Re: [JGIT PATCH v2 19/24] Added the class AddRuleListFactory.
Date: Tue, 13 May 2008 13:24:56 +0200
Message-ID: <48297A88.5040508@web.de>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de> <1210623222-24908-20-git-send-email-florianskarten@web.de> <20080513012909.GG29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 13 13:25:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvsdg-0004gi-Sc
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 13:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbYEMLY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 07:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbYEMLY5
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 07:24:57 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:54988 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbYEMLY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 07:24:57 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id BA2DCDC5BE26;
	Tue, 13 May 2008 13:24:55 +0200 (CEST)
Received: from [84.150.119.39] (helo=[192.168.1.50])
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1Jvscp-00072v-00; Tue, 13 May 2008 13:24:55 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <20080513012909.GG29038@spearce.org>
X-Enigmail-Version: 0.95.6
X-Sender: FloriansKarten@web.de
X-Provags-ID: V01U2FsdGVkX1+MqfbaN7A/IYMGNcElba8eOIvhDqsmk3qvCblQ
	RmSic+HiB6o7yYW0hsSEax8eDztvwCtooTIIUJs5DE0TwLHVwB
	9bLBOVsnv+DDJjhP09Wg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82019>

Shawn O. Pearce wrote:
> Florian Koeberle <florianskarten@web.de> wrote:
>> +class AddRuleListFactory {
>> +	/*
>> +	 * The add command of git 1.5.2.5 behaves a little bit stange: "git add
>> +	 * a/\*z" adds the file "a/b/xyz" but "git add a/x\*" does not.
>> +	 * 
>> +	 * The first is parsed as pattern "*z" for whole directory tree "a". The
>> +	 * second is parsed as an path.
>> +	 * 
>> +	 */
> 
> Its not strange.  C Git expands each file path to its _full_ path
> and stores that into a buffer, then runs fnmatch() for each pattern
> on the buffer.  If fnmatch() succeeds the path is added to the index.
> 
> In the case above we are running a match of "a/\*.z" against
> "a/b/xyz" and that passes.  Or we run "a/x\*" on "a/b/xyz" and it
> fails as the sequence of characters "a/x" does not appear in the
> string "a/b".
> 
> You are running into this odd corner case because you are not
> treating the pattern passed as something that matches against the
> entire path.  This is one reason why TreeFilter's use the entire
> path when they process an entry for inclusion or exclusion, and why
> TreeWalk has each AbstractTreeIterator append the current entry name
> onto the end of the current path buffer, so we can always examine
> the full path from the root of the repository/working directory.
> 
> Trying to avoid the full path in classes like ComplexFilePattern
> is why you are running into this corner case here, and must now do
> extra contortions to somewhat match the behavior of C Git.
> 
> At this point I think most of the rules package is overcomplicated
> and overoptimized, and yet doesn't actually quite match the behavior
> of C Git.
> 

Still I think that the behavior of git-add is strange:
For example, if you want to add the following file:
a/b/c/test.txt
Then I can do this with "a/\*.txt" or "a/b\*.txt" but not with 
"a/\*/c/test.txt"

I know that I handle "a/b\*.txt" wrong, and I don't know a nice way to 
implement it in the current rules framework.

I see three options:
1.) Let the jgit add command work in another way then git-add does.
2.) Don't use the rules framework to determine if a file is selected by 
the add command.
3.) Completely drop the patches
[4.) Add some evil hacks to make it working] <- I don't like that version

Please tell me which way to go, so that I don't waste even more time on 
patches which will never make it in.

Best regards,
Florian
