From: Karl Moskowski <kmoskowski@me.com>
Subject: Bug: Branch Deletion Doesn't Clean Up
Date: Thu, 07 Jan 2016 14:24:41 -0500
Message-ID: <4AC354E1-9E78-42A8-9828-BF1C084A6CBB@me.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 21:25:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHH7B-0000DJ-QC
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 21:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbcAGUYv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2016 15:24:51 -0500
Received: from st11p02im-asmtp002.me.com ([17.172.220.114]:47797 "EHLO
	st11p02im-asmtp002.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbcAGUYt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2016 15:24:49 -0500
X-Greylist: delayed 3605 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jan 2016 15:24:49 EST
Received: from [10.0.1.4] (75-98-201-206.beanfield.net [75.98.201.206])
 by st11p02im-asmtp002.me.com
 (Oracle Communications Messaging Server 7.0.5.36.0 64bit (built Sep  8 2015))
 with ESMTPSA id <0O0L003DGKL3CR40@st11p02im-asmtp002.me.com> for
 git@vger.kernel.org; Thu, 07 Jan 2016 19:24:40 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2016-01-07_05:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=1 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1510270003 definitions=main-1601070334
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283504>

Apologies if this is a known issue; I was unable to find anything simil=
ar in the archive.

The problem is, deleting a branch whose name contains slashes doesn=E2=80=
=99t delete the directories in .git/refs/heads/.

I=E2=80=99ve tried both git 2.5.4 and 2.6.4 on OS X 10.11 with HFS+ (ca=
se-insensitive, case-preserving). Here=E2=80=99s the sequence of comman=
ds:

% mkdir Foobar
% cd Foobar/
% git init
% git checkout -b master
% touch file.txt
% git add file.txt
% git commit -m "add a file"
% git checkout -b another/branch

At this point, there's file .git/refs/heads/another/branch

% git checkout master
% git branch -d another/branch

At this point, there's an empty directory .git/refs/heads/another/. Onl=
y the =E2=80=9Cleaf=E2=80=9D file noted above is deleted, not the direc=
tory above it.

% git checkout -b Another/branch

At this point, the file .git/refs/heads/another/branch is re-created. N=
ote the case of its enclosing directory.

% git status
On branch Another/branch
nothing to commit, working directory clean

% git branch -l
  another/branch
  master

Note the difference in case between the last two commands' output. In a=
ddition, there's no asterisk next to another/branch indicating it's cur=
rent.

Because the first branch deletion didn't also delete the enclosing dire=
ctory tree below .git/refs/heads/, the new branch gets created beneath =
it. However, there's inconsistent info between the file system and the =
git database.

It seems like git branch -d ascend the hierarchy (up to .git/refs/heads=
/), deleting any empty directories.

----
Karl Moskowski <kmoskowski@me.com>
<https://about.me/kolpanic>
