From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [BUG] git clean does not remove certain directories
Date: Tue, 20 Nov 2012 16:05:53 -0800
Message-ID: <933d806a-abce-4baf-8c3b-9b6742cb8ac7@VA3EHSMHS004.ehs.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 21 01:06:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaxpU-0002Fm-2D
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 01:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841Ab2KUAF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 19:05:58 -0500
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:1649 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753822Ab2KUAF5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Nov 2012 19:05:57 -0500
Received: from mail136-va3-R.bigfish.com (10.7.14.245) by
 VA3EHSOBE012.bigfish.com (10.7.40.62) with Microsoft SMTP Server id
 14.1.225.23; Wed, 21 Nov 2012 00:05:56 +0000
Received: from mail136-va3 (localhost [127.0.0.1])	by
 mail136-va3-R.bigfish.com (Postfix) with ESMTP id 660474A0315	for
 <git@vger.kernel.org>; Wed, 21 Nov 2012 00:05:56 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:149.199.60.83;KIP:(null);UIP:(null);IPV:NLI;H:xsj-gw1;RD:unknown-60-83.xilinx.com;EFVD:NLI
X-SpamScore: 0
X-BigFish: VPS0(zzc857h4015Izz1de0h1202h1d1ah1d2ahzzz2fh95h668h839hd24hf0ah119dh1288h12a5h12bdh137ah1441h14ddh1504h1537h153bh162dh1631h906i34h1155h)
Received-SPF: pass (mail136-va3: domain of xilinx.com designates 149.199.60.83 as permitted sender) client-ip=149.199.60.83; envelope-from=soren.brinkmann@xilinx.com; helo=xsj-gw1 ;helo=xsj-gw1 ;
Received: from mail136-va3 (localhost.localdomain [127.0.0.1]) by mail136-va3
 (MessageSwitch) id 1353456354778822_2580; Wed, 21 Nov 2012 00:05:54 +0000
 (UTC)
Received: from VA3EHSMHS004.bigfish.com (unknown [10.7.14.252])	by
 mail136-va3.bigfish.com (Postfix) with ESMTP id B8E4A3A015B	for
 <git@vger.kernel.org>; Wed, 21 Nov 2012 00:05:54 +0000 (UTC)
Received: from xsj-gw1 (149.199.60.83) by VA3EHSMHS004.bigfish.com
 (10.7.99.14) with Microsoft SMTP Server id 14.1.225.23; Wed, 21 Nov 2012
 00:05:54 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
 helo=xsj-smtp1.xilinx.com)	by xsj-gw1 with esmtp (Exim 4.63)	(envelope-from
 <soren.brinkmann@xilinx.com>)	id 1TaxpC-0001Yq-4Y	for git@vger.kernel.org;
 Tue, 20 Nov 2012 16:05:54 -0800
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-RCIS-Action: ALLOW
X-OriginatorOrg: xilinx.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210127>

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline

Hi,

this use case may be a little awkward but this is the behavior I see:

I have a repository which has a couple of untracked directories which can also
include git repositories. No submodules, though.
I used 'git clean -xdf' on the top level of this repo to remove everything
untracked in it - including the git repositories in sub-directories.

Since using git 1.8.0 the clean operation seems to be 'broken', as output
indicates all those questionable sub directories are removed - just as in prior
git versions - but in fact they remain untouched and are _not_ removed.

I attached a shell script creating a hierarchy to reproduce the issue.
Executing the script creates the git repo 'repo.git' with a couple of tracked
and untracked dirs/files and two more git repositories within the first one.

If you cd into repo.git and execute 'git clean -xdf' I see the following output:
	Removing repo2.git/
	Removing untracked_dir/

But the directories remain intact when using git 1.8.0.
With git 1.6.3.2 it works as I expected and removes the directories. I'm pretty
sure the 1.7.x versions did the same, but it's no longer installed here.

I can see that this behavior may partially be intended, but the tool output
should match its actions. So, either the directories should be removed, or the
output should state, that they are not removed for what reason whatsoever, IMHO

	Thanks,
	Soren


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset="utf-8"
Content-Disposition: attachment; filename="reproduce.sh"

#!/bin/sh
mkdir repo.git
cd repo.git
git init
echo foo > tracked_file1
git add tracked_file1
mkdir tracked_dir
echo foo > tracked_dir/tracked_file2
git add tracked_dir/tracked_file2
git commit -m "Adding tracked files"
mkdir repo2.git
echo foo > repo2.git/tracked_file3
mkdir -p untracked_dir/repo3.git
echo foo > untracked_dir/repo3.git/tracked_file4
cd repo2.git
git init
git add tracked_file3
git commit -m "Adding file to subrepo1"
cd ../untracked_dir/repo3.git
git init
git add tracked_file4
git commit -m "Adding file to subrepo2"
cd ../..


--+HP7ph2BbKc20aGI--
