From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: enforcing DB immutability
Date: Fri, 22 Apr 2005 12:10:41 -0400
Message-ID: <42692201.2000300@tmr.com>
References: <20050420084115.2699.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu
X-From: git-owner@vger.kernel.org Fri Apr 22 18:01:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP0Zs-0000GD-6w
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 18:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVDVQEJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 12:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVDVQEJ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 12:04:09 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:58242 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262047AbVDVQDZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 12:03:25 -0400
Received: from [127.0.0.1] (oddball.prodigy.com [127.0.0.1])
	by oddball.prodigy.com (8.11.6/8.11.6) with ESMTP id j3MGAhV14841;
	Fri, 22 Apr 2005 12:10:52 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
Newsgroups: mail.linux-kernel
To: linux@horizon.com
In-Reply-To: <20050420084115.2699.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

linux@horizon.com wrote:
> [A discussion on the git list about how to provide a hardlinked file
> that *cannot* me modified by an editor, but must be replaced by
> a new copy.]
> 
> mingo@elte.hu wrote all of:
> 
>>>>perhaps having a new 'immutable hardlink' feature in the Linux VFS 
>>>>would help? I.e. a hardlink that can only be readonly followed, and 
>>>>can be removed, but cannot be chmod-ed to a writeable hardlink. That i 
>>>>think would be a large enough barrier for editors/build-tools not to 
>>>>play the tricks they already do that makes 'readonly' files virtually 
>>>>meaningless.
>>>
>>>immutable hardlinks have the following advantage: a hardlink by design 
>>>hides the information where the link comes from. So even if an editor 
>>>wanted to play stupid games and override the immutability - it doesnt 
>>>know where the DB object is. (sure, it could find it if it wants to, 
>>>but that needs real messing around - editors wont do _that_)
>>
>>so the only sensible thing the editor/tool can do when it wants to 
>>change the file is precisely what we want: it will copy the hardlinked 
>>files's contents to a new file, and will replace the old file with the 
>>new file - a copy on write. No accidental corruption of the DB's 
>>contents.
> 
> 
> This is not a horrible idea, but it touches on another sore point I've
> worried about for a while.
> 
> The obvious way to do the above *without* changing anything is just to
> remove all write permission to the file.  But because I'm the owner, some
> piece of software running with my permissions can just deicde to change
> the permissions back and modify the file anyway.  Good old 7th edition
> let you give files away, which could have addressed that (chmod a-w; chown
> phantom_user), but BSD took that ability away to make accounting work.
> 
> The upshot is that, while separate users keeps malware from harming the
> *system*, if I run a piece of malware, it can blow away every file I
> own and make me unhappy.  When (notice I'm not saying "if") commercial
> spyware for Linux becomes common, it can also read every file I own.
> 
> Unless I have root access, Linux is no safer *for me* than Redmondware!
> 
> Since I *do* have root access, I often set up sandbox users and try
> commercial binaries in that environment, but it's a pain and laziness
> often wins.  I want a feature that I can wrap in a script, so that I
> can run a commercial binary in a nicely restricted enviromment.
> 
> Or maybe I even want to set up a "personal root" level, and run
> my normal interactive shells in a slightly restricted enviroment
> (within which I could make a more-restricted world to run untrusted
> binaries).  Then I could solve the immutable DB issue by having a
> "setuid" binary that would make checked-in files unwriteable at my
> normal permission level.
> 
> Obviously, a fundamental change to the Unix permissions model won't
> be available to solve short-term problems, but I thought I'd raise
> the issue to get people thinking about longer-term solutions.

chattr +i file

But the real problem is that you expect your editor to be smart enough 
to diddle permissions (some aren't) or create a new file (some aren't 
that either).

It sounds as if you're kind of using the wrong tool here, frankly.

You also don't understand hard links, they don't hide anything, the 
inode number is there, which is exactly as much information as is in the 
original link. And they are lots safer, since you can't wind up with 
them pointing to a non-existent file, get them in circular loops, etc. 
Okay, YOU probably wouldn't, but believe me semi-competent users 
regularly these things.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
