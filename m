From: Christof =?ISO-8859-1?Q?Kr=FCger?= <git@christof-krueger.de>
Subject: Re: removing files from history but not filesystem
Date: Wed, 29 Jun 2011 08:08:27 +0200
Message-ID: <1309327707.2417.49.camel@oxylap>
References: <CFCCFA00-B4BF-4A88-88A5-2F588630F7BB@uab.edu>
	 <218bf1d3b2bf197a5f56d542c6a91960.squirrel@mail.localhost.li>
	 <D56E9579-BD93-42AC-BA45-E0DC20F4BB48@uab.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Shantanu Pavgi <pavgi@uab.edu>
X-From: git-owner@vger.kernel.org Wed Jun 29 08:08:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbnx4-0001Nt-49
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 08:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842Ab1F2GIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 02:08:36 -0400
Received: from vserver.localhost.li ([85.214.46.152]:39009 "EHLO
	mail.localhost.li" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab1F2GIf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 02:08:35 -0400
Received: from p5794c8fc.dip.t-dialin.net ([87.148.200.252]:48999 helo=[192.168.0.126])
	by mail.localhost.li with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <git@christof-krueger.de>)
	id 1Qbnwr-0006E7-0S; Wed, 29 Jun 2011 08:08:29 +0200
In-Reply-To: <D56E9579-BD93-42AC-BA45-E0DC20F4BB48@uab.edu>
X-Mailer: Evolution 2.30.3 
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176437>

Hi

> Thanks for the reply Chris. It worked for me. I am not following last
>  command "git reset <branch-name>" though. I have used SHA1 commit
>  object names in 'git reset' command, but I am not sure how <commit> is
>  using branch name here. Is  it because branch is a commit pointer in
>  the git history? 
While being on the master branch, issuing "git reset temp" tells git to
"let the master branch point to wherever the symbolic reference temp
points now".  
You did something very similar with git filter-branch already. There you
specified HEAD~1, which is the same as telling git to dereference the
symbolic ref "HEAD" and take its first parent. I don't know any place
where git wouldn't accept symbolic references instead of raw sha1 sums.

> Also, how do I specify rev-list HEAD-1 so that 'git rm' will be run on
>  all commits excepts latest commit? Following didn't work for me, so I
>  guess I am not following syntax here.
>  {{{ $ git filter-branch
>  --index-filter 'git rm --cached --ignore-unmatch apple' HEAD~1
> Which ref do you want to rewrite?
>  }}}
git filter-branch expects a symbolic reference within the rev-list. It
would be pointless to filter the commits without a symbolic reference
being bent over to point to the rewritten branch once done.

What you can do is the following:

git filter-branch --index-filter 'test $GIT_COMMIT =
35644cb5fa34e033593f6f0d27c332443b6867d8 || git rm --cached
--ignore-unmatch foo' HEAD

If "test $GIT_COMMIT = <sha1>" is true, the following git rm command
won't be executed for that commit. 
Choose the hash to be the one you want to skip (HEAD).

Another possible way would be to create a temporary branch to point at
HEAD^, filter-branch it, then add a graft to stitch the remaining commit
on top of it, then filter-branch HEAD and then remove the branch. But
this is a bit advanced for the case where you just want to omit one
commit.

Regards,
  Chris
