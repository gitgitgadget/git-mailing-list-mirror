From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Visualizing merge conflicts after the fact (using kdiff3)
Date: Tue, 16 Jun 2015 11:43:02 +0200
Organization: gmx
Message-ID: <87b840d8c73fd7e4e7597e2fd835c703@www.dscho.org>
References: <557F791D.3080003@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 11:43:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4nOm-0000G6-K6
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 11:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbbFPJnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 05:43:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:51240 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754711AbbFPJnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 05:43:09 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LbuCq-1ZTuvi45Rc-00jJgU; Tue, 16 Jun 2015 11:43:03
 +0200
In-Reply-To: <557F791D.3080003@nextest.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:3vq9J66kldZTEwisKVUevSX9XI+9kmUAkommik4/h3AvXqxcuYN
 OScXs7C2o2M0i2uSzbtBNsCPom0/xE5LZRKYjAeY7NxJ8oIiz4aIlb0g/EZVivHNjoDt5Gq
 9t1r7rM15gtICf4UXTy9ik/tS3gzMrq/krUom5i+8j0U3xHVkEDutEuPrUeazqVjvzqOubC
 j7pYZ3DyEuslsHJ4Vfrxw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271745>

Hi Eric,

On 2015-06-16 03:17, Eric Raible wrote:
> I'm running 1.9.5.msysgit.1, but this is a general git question...
> 
> Upon returning from a vacation, I was looking at what people had been
> up to, and discovered on merge in which a colleague had resolved a merge
> incorrectly.  It turns out that he has pushed *many* merges over the past
> year which had conflicts in my code, and now I don't trust any of them.
> 
> So naturally I want to check each of them for correctness.
> 
> I know about "git log -p -cc SHA -- path", but it really doesn't
> show just the conflicts so there's just too much noise in that output.
> 
> I use kdiff3 to resolve conflicts, so I'm looking for a way to
> visualize these already-resolved conflicts with that tool.
> As I said, there are many merges, so the prospect of checking
> out each sha, doing the merge, and then comparing the results
> is completely untenable.
> 
> Can anyone help?  Surely other people have wanted to review how
> conflicts were resolved w/out looking at the noise of unconflicted
> changes, right?

If I was walking in your shoes, I would essentially recreate the merge conflicts and then use "git diff <merge-commit>" with the resolved merge in your current history.

Something like this:

```bash
mergecommit=$1

# probably should verify that the working directory is clean, yadda yadda

# recreate merge conflicts on an unnamed branch (Git speak: detached HEAD)
git checkout $mergecommit^
git merge $mergecommit^2 ||
die "This merge did not have any problem!"

# compare to the actual resolution as per the merge commit
git diff $mergecommit
```

To list all the merge commits in the current branch, I would use the command-line:

```bash
git rev-list --author="My Colleague" --parents HEAD |
sed -n 's/ .* .*//p'
```

(i.e. listing all the commits with their parents, then filtering just the ones having more than one parent, which would include octopus merges if your history has them.)

Hopefully this gives you good ideas how to proceed.

Ciao,
Johannes
