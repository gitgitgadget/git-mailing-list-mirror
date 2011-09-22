From: Chris Friesen <chris.friesen@genband.com>
Subject: Re: any way to "re-sync" a bare repository against another bare repository?
Date: Thu, 22 Sep 2011 13:23:30 -0600
Message-ID: <4E7B8B32.3070609@genband.com>
References: <4E7B6EDD.1040106@genband.com> <7142366f54c44cea82542adf8aea5bb9-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 21:24:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6osl-0004B1-DG
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 21:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646Ab1IVTYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 15:24:23 -0400
Received: from exprod7og116.obsmtp.com ([64.18.2.219]:36223 "EHLO
	exprod7og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601Ab1IVTYW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 15:24:22 -0400
Received: from mail.genband.com ([63.149.188.88]) (using TLSv1) by exprod7ob116.postini.com ([64.18.6.12]) with SMTP
	ID DSNKTnuLY3oPIuUdqSbVXtw7NNafu0tlbnrp@postini.com; Thu, 22 Sep 2011 12:24:22 PDT
Received: from gbausmail.genband.com ([172.16.21.62]) by mail.genband.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 22 Sep 2011 14:23:32 -0500
Received: from [1.220.36.114] ([1.220.36.114]) by gbausmail.genband.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 22 Sep 2011 14:23:32 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.22) Gecko/20110906 Fedora/3.1.14-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.14
In-Reply-To: <7142366f54c44cea82542adf8aea5bb9-mfwitten@gmail.com>
X-OriginalArrivalTime: 22 Sep 2011 19:23:32.0290 (UTC) FILETIME=[1DA0D220:01CC795D]
X-TM-AS-Product-Ver: SMEX-8.0.0.4160-6.500.1024-18402.001
X-TM-AS-Result: No--26.990800-5.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181913>

Thanks for that very thorough response.

The rationale for this is somewhat convoluted...I have a vendor-supplied 
build system that expects to be pointed at a bare repository.  For 
performance reasons I want to have a local bare repo on each build 
machine that can be kept in sync with a master repo on a main server.

Chris


On 09/22/2011 12:50 PM, Michael Witten wrote:
> On Thu, 22 Sep 2011 11:22:37 -0600, Chris Friesen wrote:
>
>> Suppose I have a parent bare repository.  I do a "git clone --bare" to
>> create a child repository, and then clone the child to create a
>> grandchild repository.
>
> Firstly, what exactly is the scenario you are trying to achieve? Perhaps
> there is a better way to do what you are trying to do.
>
>> If changes get pushed into the parent repository, is there any way to
>> cause the child to be updated?
>
> The documentation answers your question (but badly, as with much of the
> documentation); from `git help clone':
>
>    --bare
>        Make a bare GIT repository. That is, instead of creating
>        <directory>  and placing the administrative files in
>        <directory>/.git, make the<directory>  itself the $GIT_DIR.
>        This obviously implies the -n because there is nowhere to
>        check out the working tree. Also the branch heads at the
>        remote are copied directly to corresponding local branch
>        heads, without mapping them to refs/remotes/origin/. When
>        this option is used, neither remote-tracking branches nor
>        the related configuration variables are created.
>
> In particular:
>
>                                    Also the branch heads at the
>        remote are copied directly to corresponding local branch
>        heads, without mapping them to refs/remotes/origin/. When
>        this option is used, neither remote-tracking branches nor
>        the related configuration variables are created.
>
> In particular:
>
>                                                             When
>        this option is used, neither remote-tracking branches nor
>        the related configuration variables are created.
>
> Thus, you have to explicitly tell git what you fetched and which
> branch heads should be updated.
>
> Consider this:
>
>    $ git init parent
>    $ git clone        parent child0
>    $ git clone --bare parent child1
>
> Now, look at the config file for the child0 repository:
>
>    $ cat child0/.git/config
>    [core]
>            repositoryformatversion = 0
>            filemode = true
>            bare = false
>            logallrefupdates = true
>    [remote "origin"]
>            fetch = +refs/heads/*:refs/remotes/origin/*
>            url = /path/to/parent
>    [branch "master"]
>            remote = origin
>            merge = refs/heads/master
>
> In particular:
>
>            fetch = +refs/heads/*:refs/remotes/origin/*
>
> That is the default `refspec'; when `git fetch' is not explicitly
> told on the command line what to fetch and which branch head[s] to
> update, then this refspec is used as a default.
>
> Now, look at the config file for the child1 repository:
>
>    $ cat child1/config
>    [core]
>            repositoryformatversion = 0
>            filemode = true
>            bare = true
>    [remote "origin"]
>            url = /path/to/parent
>
> In particular, note that a bare repository doesn't include any
> such default information for `git fetch'. However, you could be
> explicit about it; from within the chidl1 repo:
>
>    $ git fetch origin '+refs/heads/*:refs/remotes/origin/*'
>
>> Just a "git fetch<parent>" doesn't seem to help.  If I set up parent as
>> a remote branch I can fetch it,
>
> Firstly, it doesn't make any sense to say "set up parent as a remote
> branch"; what you mean is "set up `<parent>' as a remote with a default
> refspec that creates any associated remote-tracking branch heads".
>
> Secondly, by setting up `<parent>' as a remote, you are creating the
> missing refspec in your config file:
>
>    [remote "<parent>"]
>            url = /path/to/parent
>            fetch = +refs/heads/*:refs/remotes/<parent>/*
>
> which is why you get this:
>
>> but then it shows all the branches as "<parent>/<branch>" rather
>> than updating the child.
>
> You need a different refspec, namely:
>
>    +refs/heads/*:refs/heads/*
>
> So, either be explicit:
>
>    git fetch '<parent>' '+refs/heads/*:refs/heads/*'
>
> or update your config:
>
>    git config 'remote.<parent>.fetch' '+refs/heads/*:refs/heads/*'
>
> Of course, there is an easier way that does all of this [and more]
> for you:
>
>> I just tried a "git clone --mirror" to create the child and it seems to
>> allow me to pick up changes in the parent via "git fetch".  Is that the
>> proper way to handle this?
>
> The documentation answers your question (but badly, as with much of the
> documentation); from `git help clone':
>
>    --mirror
>        Set up a mirror of the source repository. This implies
>        --bare. Compared to --bare, --mirror not only maps local
>        branches of the source to local branches of the target, it
>        maps all refs (including remote-tracking branches, notes
>        etc.) and sets up a refspec configuration such that all
>        these refs are overwritten by a git remote update in the
>        target repository.
>
> In particular:
>
>                  sets up a refspec configuration such that all
>        these refs are overwritten by a git remote update in the
>        target repository.
>
> Consider this:
>
>    $ git clone --mirror parent child2
>    $ cat child2/config
>    [core]
>            repositoryformatversion = 0
>            filemode = true
>            bare = true
>    [remote "origin"]
>            fetch = +refs/*:refs/*
>            mirror = true
>            url = /path/to/parent
>
> In particular:
>
>            fetch = +refs/*:refs/*
>
> That's a very liberal refspec! It basically says that fetch
> should mirror everything by default.
>
> Sincerely,
> Michael Witten


-- 
Chris Friesen
Software Developer
GENBAND
chris.friesen@genband.com
www.genband.com
