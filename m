From: <hackerp@suddenlink.net>
Subject: Re: git lock files (Was: GIT for Microsoft Access projects)
Date: Tue, 9 Jun 2015 13:21:44 -0500
Message-ID: <20150609132144.ANWJW.73271.root@txifep04>
References: <1433870383-7631-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: kostix+git@007spb.ru, sitaramc@gmail.com
To: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 20:21:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2O9m-0001aE-Kw
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 20:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbbFISVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 14:21:46 -0400
Received: from txofep01.suddenlink.net ([208.180.40.71]:58611 "EHLO
	txofep01.suddenlink.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041AbbFISVp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 14:21:45 -0400
Received: from txifep04 ([10.126.0.194]) by txofep01.suddenlink.net
          (InterMail vM.8.04.03.20 201-2389-100-164-20150330) with ESMTP
          id <20150609182144.UCKK20036.txofep01.suddenlink.net@txifep04>;
          Tue, 9 Jun 2015 13:21:44 -0500
In-Reply-To: <1433870383-7631-1-git-send-email-sbeller@google.com>
X-Priority: 3 (Normal)
Sensitivity: Normal
X-Cloudmark-Analysis: v=2.1 cv=PoYdbm83 c=1 sm=0 tr=0 a=-FnFX_vXfH4A:10 a=IkcTkHD0fZMA:10 a=8LaAqv5HAAAA:8 a=XAFQembCKUMA:10 a=1XWaLZrsAAAA:8 a=1mfAh9p9YNOobra9JagA:9 a=QEXdDO2ut3YA:10 a=Z7h1qpoMLS4A:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271215>

Thanks folks, I am digesting all you have said.

Now the command line I can do (I'm a programmer) but the secretary here I doubt.

So is there at GUI interface for this? Does it work on Windows systems?

Thanks,

Paul
---- Stefan Beller <sbeller@google.com> wrote: 
> Just because Git allows distributed workflows, doesn't mean we
> should only focus on being distributed IMHO.
> 
> The question for content not being mergable easily pops up all
> the time. (Game/Graphics designers, documents, all this binary
> stuff, where there is no good merge driver).
> 
> I could imagine a "git lock" command which looks like this:
> 
>     git config lock.centralServer origin
>     git config lock.defaultBranch master
> 
>     git lock add [branch]  [--] <path/to/file>
>     git lock remove [branch] [--] <path/to/file>
>     git lock ls [<branch>]
> 
> And the way this is implemented is roughly (unoptimized, just showing
> how you would achieve this with todays command set):
> 
>     git fetch --depth=1 $(git config --get lock.centralServer) refs/locks/$(git config --get lock.defaultBranch)
>     git checkout refs/locks/$(git config --get lock.centralServer)/$(git config --get lock.defaultBranch)
>     switch(option) {
>     case add:
>         if exist <path/to/file>
>             return -1
>         else
>             echo $(git config --get user.name) $(date) > <path/to/file>
>             git add <path/to/file> && git commit "add new lock"
>         fi
>     case remove:
>         if exist <path/to/file>
>             # todo: check if the same user locked it before
>             rm  <path/to/file>
>         else
>             return -1
>         fi
>     case ls:
>         ls -R .
>     }
>     git push $(git config --get lock.centralServer) refs/locks/$(git config --get lock.defaultBranch)
>     git <restore working tree, branch>
> 
> That said you could just manipulate the git objects directly, no need
> to check out to the working dir.
> 
> The server would only need to allow pushes to a refs/locks directory and be done.
> the client side would need to have a plumbing command, so you could easily integrate
> a git locking to your application if you don't want to provide a merge driver.
> 
> Thanks,
> Stefan
> 
