From: =?UTF-8?Q?Stefan_Fr=c3=bchwirth?= <stefan.fruehwirth@uni-graz.at>
Subject: malloc memory corruption on merge-tree with leading newline
Date: Mon, 15 Feb 2016 22:39:39 +0100
Message-ID: <56C2459B.5060805@uni-graz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 15 22:45:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVQxI-0003vh-Ae
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbcBOVpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:45:11 -0500
Received: from EX07HTCA01.UNI-GRAZ.AT ([143.50.13.79]:7180 "EHLO
	ex07htca01.uni-graz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbcBOVpK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 16:45:10 -0500
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Feb 2016 16:45:09 EST
Received: from EX13MS01.pers.ad.uni-graz.at (2002:8f32:dbf::8f32:dbf) by
 ex07htca01.pers.ad.uni-graz.at (2002:8f32:d4f::8f32:d4f) with Microsoft SMTP
 Server (TLS) id 8.3.406.0; Mon, 15 Feb 2016 22:39:39 +0100
Received: from [143.50.232.174] (143.50.232.174) by
 EX13MS01.pers.ad.uni-graz.at (2002:8f32:dbf::8f32:dbf) with Microsoft SMTP
 Server (TLS) id 15.0.1076.9; Mon, 15 Feb 2016 22:39:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
X-ClientProxiedBy: EX13MS03.pers.ad.uni-graz.at (2002:8f32:dc1::8f32:dc1) To
 EX13MS01.pers.ad.uni-graz.at (2002:8f32:dbf::8f32:dbf)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286252>

Hi,

in one specific circumstance, git-merge-tree exits with a segfault 
caused by "*** Error in `git': malloc(): memory corruption (fast)":

There has to be at least one commit first (as far as I can tell it 
doesn't matter what content). Then create a tree containing a file with 
a leading newline character (\n) followed by some random string, and 
another tree with a file containing a string without leading newline. 
Now merge trees: Segmentation fault.

There is a test case[1] kindly provided by chrisrossi, which he crafted 
after I discovered the problem[2] in the context of Pylons/acidfs.

Best,
Stefan

[1] https://gist.github.com/chrisrossi/f09c8bed70b364f9f12e
[2] https://github.com/Pylons/acidfs/issues/3

For in-line reference, here's the test case:

git init bug
cd bug
echo b > a
git add a
git commit -m "first commit"
echo > b
echo -n a >> b
git add b
git commit -m "second commit, first branch"
git checkout HEAD~1
git checkout -b other
echo -n a > b
git add b
git commit -m "second commit, second branch"
git merge-tree HEAD~1 master other
cd ..
rm -rf bug
