From: Johan Herland <johan@herland.net>
Subject: Re: how to reduce disk usage for large .git dirs?
Date: Thu, 13 Nov 2014 17:08:19 +0100
Message-ID: <CALKQrgeZYs9A-GZLuRczwzRWWapmfrjFvcvR8GN+YNKxajjDRw@mail.gmail.com>
References: <20141113111444.GA15503@aepfle.de>
	<20141113154457.GA31624@aepfle.de>
	<20141113160325.GA24351@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Olaf Hering <olaf@aepfle.de>,
	Git mailing list <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 17:08:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xowwn-00007t-3V
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 17:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040AbaKMQIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 11:08:30 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:41326 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938AbaKMQI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 11:08:29 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1Xowwc-0007Yn-PI
	for git@vger.kernel.org; Thu, 13 Nov 2014 17:08:26 +0100
Received: from mail-pa0-f41.google.com ([209.85.220.41])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Xowwc-000DLM-CH
	for git@vger.kernel.org; Thu, 13 Nov 2014 17:08:26 +0100
Received: by mail-pa0-f41.google.com with SMTP id rd3so974893pab.28
        for <git@vger.kernel.org>; Thu, 13 Nov 2014 08:08:19 -0800 (PST)
X-Received: by 10.67.30.194 with SMTP id kg2mr3853599pad.8.1415894899297; Thu,
 13 Nov 2014 08:08:19 -0800 (PST)
Received: by 10.70.68.3 with HTTP; Thu, 13 Nov 2014 08:08:19 -0800 (PST)
In-Reply-To: <20141113160325.GA24351@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 5:03 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> Thanks for sharing your notes! A few comments:
>
> On Thu, Nov 13, 2014 at 04:44:57PM +0100, Olaf Hering wrote:
>> First clone the remote repository as usual. Then create a local branch for
>> each remote branch that is supposed to be worked on:
>> # git clone git://host/repo.git repo-master
>> # cd repo-master
>> # git checkout -b branchA origin/branchA
>> # git checkout -b branchB origin/branchB
>> # cd -
>>
>> Now clone each work branch into its own directory. The work dir references the
>> master repo. All changes come from and go into this repo, instead of the
>> remote repo.
>> # git clone -l -b branchA repo-master repo-branchA
>> # git clone -l -b branchB repo-master repo-branchB
>>
>> To make changs in a work dir, commit as usual. The changes will be pushed from
>> the work copy into the local master repo. Its required to have some other
>> branch than branchA active in repo-master, or push from work copy to
>> repo-master will fail.
>
> That's one of the reason it's not recommended to push into a non-bare
> repository. You should clone your repo-master with the --bare option to
> avoid having a work dir there.
>
>> To publish the outstanding changes its required to do this from the master
>> repo. First checkout the work branch, then pull the local changes and finally
>> push them to the remote repo.
>> # cd repo-master
>> # git checkout branchA
>> # git pull
>> # git push origin branchA
>> # cd -
>
> It's not. You could just add your remote repository as a remote to each
> of your clones of your master repo and push directly from them. It
> would be much simplier and it would allow you to directly fetch changes
> from your remote into your branches as well.
>
> (however, I'm not sure but I think, that this will slowly increase the
> difference between your repositories when you develop. So that they
> won't change any new data since to local clone was made).

Can you not do this much simpler with --reference? Like this:

  $ git clone --bare git://host/repo.git repo-master
  $ git clone -b branchA --reference repo-master git://host/repo.git
repo-branchA
  $ git clone -b branchB --reference repo-master git://host/repo.git
repo-branchB

All three repos now push/pull directly to/from git://host/repo.git,
but repo-branchA and repo-branchB reference objects from within the
bare repo-master. You have to make use to never delete objects from
repo-master (if those objects happen to be referenced from
repo-branchA|B). If you want to prevent the repos growing in size, you
must devise a way to add new objects into repo-master before
repo-branchA|B. (e.g. a nightly cron-job in repo-master that fetches
from origin), so that when repo-branchA|B pulls, they will find most
objects are already present in repo-master.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
