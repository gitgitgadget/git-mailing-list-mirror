From: Mark Plomer <mark.plomer@boerse-go.de>
Subject: Re: GIT-SVN: Corrupted commits when using --preserve-empty-dirs
Date: Thu, 6 Sep 2012 23:02:08 +0200
Message-ID: <50490F50.3020208@boerse-go.de>
References: <2086BD14B0971B4492C5AA17E9604CB02173C9C1@AMSPRD0610MB350.eurprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 23:03:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9jEf-00053B-7i
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 23:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933144Ab2IFVDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 17:03:30 -0400
Received: from [216.32.180.187] ([216.32.180.187]:25943 "EHLO
	co1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933123Ab2IFVD2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 17:03:28 -0400
Received: from mail38-co1-R.bigfish.com (10.243.78.254) by
 CO1EHSOBE015.bigfish.com (10.243.66.78) with Microsoft SMTP Server id
 14.1.225.23; Thu, 6 Sep 2012 21:02:17 +0000
Received: from mail38-co1 (localhost [127.0.0.1])	by mail38-co1-R.bigfish.com
 (Postfix) with ESMTP id B3D42A0015A	for <git@vger.kernel.org>; Thu,  6 Sep
 2012 21:02:17 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:157.56.252.53;KIP:(null);UIP:(null);IPV:NLI;H:DB3PRD0610HT002.eurprd06.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: -1
X-BigFish: PS-1(zz1432Izz1202hzzz31h2a8h668h839hd25he5bhf0ah107ah1155h)
Received-SPF: softfail (mail38-co1: transitioning domain of boerse-go.de does not designate 157.56.252.53 as permitted sender) client-ip=157.56.252.53; envelope-from=mark.plomer@boerse-go.de; helo=DB3PRD0610HT002.eurprd06.prod.outlook.com ;.outlook.com ;
Received: from mail38-co1 (localhost.localdomain [127.0.0.1]) by mail38-co1
 (MessageSwitch) id 1346965335303447_22389; Thu,  6 Sep 2012 21:02:15 +0000
 (UTC)
Received: from CO1EHSMHS002.bigfish.com (unknown [10.243.78.238])	by
 mail38-co1.bigfish.com (Postfix) with ESMTP id 46AEC48004C	for
 <git@vger.kernel.org>; Thu,  6 Sep 2012 21:02:15 +0000 (UTC)
Received: from DB3PRD0610HT002.eurprd06.prod.outlook.com (157.56.252.53) by
 CO1EHSMHS002.bigfish.com (10.243.66.12) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Thu, 6 Sep 2012 21:02:13 +0000
Received: from [192.168.1.30] (94.216.92.117) by pod51016.outlook.com
 (10.255.47.37) with Microsoft SMTP Server (TLS) id 14.16.190.9; Thu, 6 Sep
 2012 21:02:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120824 Thunderbird/15.0
In-Reply-To: <2086BD14B0971B4492C5AA17E9604CB02173C9C1@AMSPRD0610MB350.eurprd06.prod.outlook.com>
X-Originating-IP: [94.216.92.117]
X-OriginatorOrg: boerse-go.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204923>

There is a strange workaround for SVN-repos, containing directories that 
were replaced by symlinks in the past, properly cloned into GIT (with 
empty dirs):

You have to import it part-by-part ... i.e. fetch revision 1-3 and then 
fetch 4-5:

git svn clone -r 1:3 --preserve-empty-dirs file://`pwd`/test-svn-repo 
test-git
cd test-git
git svn fetch
# This works fine for the example below

The disadvantage is, that you have to figure out those critical 
revisions manually. Otherwise you may have an inconsistent clone.

Am 04.09.2012 15:11, schrieb Mark Plomer:
> Hi,
> if I clone a SVN repository with --preserve-empty-dirs it terminates at some point with i.e. following error:
> folder/subfolder was not found in commit 2dcb008c220f5f6fe33700c9e7deb0c8fa2b8607 (r4)
>
> I tracked things down to the following problem:
> - r1: Create a directory with subdirectory with a file
> - r2: Remove the file (so it generates a virtual .gitignore)
> - r3: Rename subdirectory
> - r4: Add a symlink named like the old subdirectory
>
> -> In GIT the symlink is actually not a symlink but a folder with the ".gitignore" file ... which break things later when changing symlink
>
>
> # Simple reproduce script:
> svnadmin create test-svn-repo
> svn co file://`pwd`/test-svn-repo test-svn-wc
>
> mkdir -p test-svn-wc/folder/subfolder
> touch test-svn-wc/folder/subfolder/file.txt
> svn add test-svn-wc/*
> svn ci -m 'Initial commit' test-svn-wc
>
> svn rm test-svn-wc/folder/subfolder/file.txt
> svn ci -m 'Removed file.txt' test-svn-wc
>
> svn up test-svn-wc
> svn mv test-svn-wc/folder/subfolder test-svn-wc/folder/subfolder2
> svn ci -m 'Renamed subfolder' test-svn-wc
>
> svn up test-svn-wc
> ln -s subfolder2 test-svn-wc/folder/subfolder
> svn add test-svn-wc/folder/subfolder
> svn ci -m 'Added subfolder symlink' test-svn-wc
>
> rm -f test-svn-wc/folder/subfolder
> ln -s changedlink test-svn-wc/folder/subfolder
> svn ci -m 'Changed symlink' test-svn-wc
>
>
> git svn clone --preserve-empty-dirs file://`pwd`/test-svn-repo test-git
> # this throws error: folder/subfolder was not found in commit 2dcb008c220f5f6fe33700c9e7deb0c8fa2b8607 (r4)
>
>
> Tested with git 1.7.12, svn 1.6.12 (debian)
>
> Greets Mark
