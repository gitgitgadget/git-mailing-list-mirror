From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: partial checkouts
Date: Sun, 24 May 2009 15:45:12 -0400
Message-ID: <32541b130905241245m7139c766v73f6fe2aeda1fcf9@mail.gmail.com>
References: <200905231401.11651.chanika@gmail.com> <200905240134.53387.johan@herland.net> 
	<200905231726.10361.chanika@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Chani <chanika@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 21:45:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Jdc-0006C5-Tt
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 21:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbZEXTpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 15:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbZEXTpc
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 15:45:32 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:2100 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbZEXTpb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 15:45:31 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1636563yxj.1
        for <git@vger.kernel.org>; Sun, 24 May 2009 12:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=K9nm1yIVEvOxQujyO1Y3a6zL1IrnKXtwl+KtI+zi60Q=;
        b=PbhYN9cAQRWbLcwHDTPJWYHlPQbpDYNuaoszjLjxDQoiWPIJJ7wvwgLIlx3jx3KGsH
         z/U47qCPzcGDDCrfRquHKqJIf0Pf+LuVTuYELP7rhdi8KqO+AUP2blf85mvpjfJe3TPE
         mVP8usFnJcxosA1t8U9hCXjbXcagAyFI5B718=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tvo3WIUF/zUPk7Wlly1OwIv0nFmrUDjQHt6hX9/Pwoiau8b9xgWi2qW0ZT7n9lirHl
         nRsUsedc1H/1Lkx1hBa03nZDp8GZLM9khIUbo761etfad+Qag+Fz5ST9GLCZO2/MkpWV
         r2YZBrnfc5/GTr3wS0UKHAWA2PDqyKM9TqI8g=
Received: by 10.151.125.11 with SMTP id c11mr12534484ybn.237.1243194332223; 
	Sun, 24 May 2009 12:45:32 -0700 (PDT)
In-Reply-To: <200905231726.10361.chanika@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119851>

On Sat, May 23, 2009 at 8:26 PM, Chani <chanika@gmail.com> wrote:
> On May 23, 2009 16:34:53 Johan Herland wrote:
>> On Saturday 23 May 2009, Chani wrote:
>> > I'm kinda wondering if there'd be a way to use git-filter-branch to make
>> > a repo that only tracks the doc/ folder for a module - but I've no idea
>> > whether it'd have to be recreated from scratch every time someone changes
>> > something in the real repo's doc/
>> >
>> > can anyone think of a less ugly solution?
>> > what are the chances of git supporting this kind of partial checkout
>> > someday?
>>
>> Check out git-subtree. It can split out a subdirectory into its own repo,
>> and re-integrate it back into the "parent" repo at a later date.
>> git-subtree has been posted as a patch to this list a couple of times
>> without much response, but it looks like an interesting alternative to
>> submodules: http://alumnit.ca/~apenwarr/log/?m=200904#30
>
> looks interesting. might have been a solution until I heard about this
> requirement to not change workflow at all. :/

Here's something that might work.  Write a script that runs on a
server somewhere.  It checks out *all* of the git-managed KDE
components, including documentation (it's okay to do this from *one*
place, right?).  Then it loops through all the documentation
subdirectories and splits them out into individual projects/branches
with 'git subtree split'.

You could then make a *new* project, kde-docs for example, that pulls
those new doc projects back together into a single project, using 'git
subtree merge'.

People could then checkout the single kde-docs project and get *all*
the docs, then make changes and push them back upstream to you.  As
far as the average person is concerned, this is probably even easier
than svn:externals - they don't have to remember to commit in each
subdirectory separately, as git-subtree rips it all apart later.  Also
note that *end users* never have to operate the git subtree command;
all that happens behind the scenes on your server.

Later, you use 'git subtree split' to rip it apart back into the
individual projects, and 'git subtree merge' those back into their
original git repositories.

Since git-subtree is my own little toy and it's designed for exactly
this kind of workflow, I'd be happy to help you debug a script for
this if you like.  Probably I'll learn something.

Disclaimer: git-subtree hasn't been used by too many people yet and we
may end up finding some bugs.

Have fun,

Avery
