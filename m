From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: gitignore: how to exclude a directory tree from being ignored
Date: Thu, 01 Oct 2009 17:25:15 +0200
Message-ID: <4AC4C9DB.2090907@viscovery.net>
References: <4AC48D5F.6060401@mycircuit.org> <4AC4A310.8000507@viscovery.net> <4AC4A7EF.9030002@mycircuit.org> <4AC4AD25.5010708@viscovery.net> <4AC4C125.10609@mycircuit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter <vmail@mycircuit.org>
X-From: git-owner@vger.kernel.org Thu Oct 01 17:25:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtNX4-0007GD-O8
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 17:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090AbZJAPZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 11:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753998AbZJAPZP
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 11:25:15 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:36313 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549AbZJAPZO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 11:25:14 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MtNWt-000347-OF; Thu, 01 Oct 2009 17:25:16 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 773749614; Thu,  1 Oct 2009 17:25:15 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AC4C125.10609@mycircuit.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129397>

Peter schrieb:
>>> 1) I can't have just one .gitignore file in the root dir, if I want to
>>> _recursively_ inverse the exclude pattern for a sub dir tree.
>>>     
>>
>> No, it's not the inversion of the pattern, but the slash (if it is not at
>> the end) that makes the pattern non-recursive.
>>
>>   
> from the gitignore manpage:
>>> If the pattern ends with a slash, it is removed for the purpose of
> the following description, but it would only find a match with a
> directory. In other words, foo/ will match a directory foo and paths
> underneath it, but will not match a regular file or a symbolic link foo
> (this is consistent with the way how pathspec works in general in git). <<
> 
> Doesn't this mean, that if I say:
> vendor/
> matches the directory and ( recursively ) the paths underneath it.?

The paragraph you are citing is talking about *what* the pattern matches,
but it says nothing about *where* the pattern matches.

When I was saying "recursively", then I was refering to the "where"
aspect, not the "what" aspect.

If you have directories

   src/bar/vendor/
   src/foo/bar/vendor/
   src/vendor/

and you have the file src/.gitignore with the single pattern

   vendor/

then it applies to recursively ("where") these directories:

   src/bar/vendor/
   src/foo/bar/vendor/
   src/vendor/

and everything ("what") below them.

But if the same src/.gitignore has only this pattern:

   bar/vendor/

then it will not match ("where") recursively and only apply to

   src/bar/vendor/

and everything ("what") below it, but will not apply to

   src/foo/bar/vendor/

> And, consequently:
> !vendor/
> inverse the exclusion for vendor ( that is: include ) and everything
> that is contained in it ? ( This is obviously not the case, but this is
> what I would expect )

You should update your expectations. ;-)

You think that git starts with the .gitignore files, and somehow applies
the rules that it finds to all files (perhaps recursively).

But it does not work like this; rather it is in the oppsite direction: git
starts with a file name, and then checks the rules in the .gitignore files
that it has available.

For example, take the path "src/vendor/foo.exe". git finds the file
src/.gitignore and there it sees the pattern "*.exe". The pattern matches,
and so git obeys the rule (ignores the file). But the pattern "!vendor/"
does not match (because the path ends with "foo.exe", not "vendor").

Before git had seen the path "src/vendor/foo.exe", it had already seen
"src/vendor". This time the pattern "!vendor/" did match (because the name
is identical *and* it is a directory, as per the cited paragraph) and git
obeyed the rule (which was not to ignore the directory).

-- Hannes
