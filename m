From: Kevin Ballard <kevin@sb.org>
Subject: Re: gitignore: negating path patterns
Date: Fri, 23 May 2008 15:44:02 -0700
Message-ID: <ADCBC87D-27A7-4C3F-B11E-8AE217F8AF91@sb.org>
References: <g11cvn$ndr$1@ger.gmane.org> <5BBB5607-DF95-4C06-BE6C-C3D7AF475FBF@sb.org> <g15t3j$eoa$1@ger.gmane.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Sat May 24 00:45:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzg0V-0007ZR-GS
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 00:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbYEWWoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 18:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752967AbYEWWoF
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 18:44:05 -0400
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:51370 "EHLO
	randymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753210AbYEWWoE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 May 2008 18:44:04 -0400
Received: from [10.100.18.156] (dsl092-049-214.sfo4.dsl.speakeasy.net [66.92.49.214])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a1.g.dreamhost.com (Postfix) with ESMTP id D2DE518DB65;
	Fri, 23 May 2008 15:44:02 -0700 (PDT)
In-Reply-To: <g15t3j$eoa$1@ger.gmane.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82766>

On May 23, 2008, at 12:52 AM, Michael J Gruber wrote:

> Kevin Ballard venit, vidit, dixit 23.05.2008 02:23:
>> On May 21, 2008, at 7:52 AM, Michael J Gruber wrote:
>>> Hi there
>>>
>>> It seems that negating path patterns in gitignore doesn't work, or I
>>> don't understand it (or both). With the attached script, git status
>>> (1.5.5.1) reports "dir/a" as new and "dir/b" as untracked. I would
>>> rather expect it to report "dir/c" as untracked also.
>>>
>>> It seems that "!b" matches to include "dir/b" (reverting the  
>>> exclusion
>>> "*" as expected), whereas "!dir/" does not match to include "dir/c".
>>>
>>> What's going on here?
>> "dir/" will not match anything, because paths are compared without   
>> trailing slashes. Try "!dir".
>
> I am sorry, but this is plain wrong, at least if "man gitignore" is  
> right (see below). "!dir" would match files whose name (pathname  
> without leading directory name) matches "dir" (i.e.: is dir) and  
> exclude those from exclusion (include them).
>
> Also, replacing "!dir/" by "!dir" in my test script does not change  
> the result. In fact, for "!dir" the result is as expected and  
> documented, just for "!dir/" I would expect something else.
>
> So, thanks for trying to help, although reading the manual or  
> testing your advice before would be appreciated even more. ;)
>
> Michael
>
> From man gitignore:
>
> If the pattern ends with a slash, it is removed for the purpose of  
> the following description, but it would only find a match with a  
> directory. In other words, foo/ will match a directory foo and paths  
> underneath it, but will not match a regular file or a symbolic link  
> foo (this is consistent with the way how pathspec works in general  
> in git).

Ahh, the behavior changed in 1.5.5. Pre-1.5.5, if a path ended in a  
slash, it would never match anything.

In any case, the problem is the * pattern. Here's what happens:

At /, the * is evaluated and ignores everything. The !dir/ is  
evaluated and unignores dir. The !b is evaluated and matches nothing.
AT /dir, the * is evaluated and ignores everything. The !dir/ is  
evaluated and matches nothing. The !b is evaluated and unignores b.

So the problem is the * is recursively applying to the subdirectories.  
To fix this, use /* as the pattern.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
