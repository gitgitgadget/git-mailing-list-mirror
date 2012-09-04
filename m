From: Mark Plomer <mark.plomer@boerse-go.de>
Subject: GIT-SVN: Corrupted commits when using --preserve-empty-dirs
Date: Tue, 4 Sep 2012 13:11:05 +0000
Message-ID: <2086BD14B0971B4492C5AA17E9604CB02173C9C1@AMSPRD0610MB350.eurprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 04 15:12:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8svF-0005Bc-1y
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 15:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757066Ab2IDNL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 09:11:58 -0400
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:59568
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757012Ab2IDNL5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Sep 2012 09:11:57 -0400
Received: from mail83-co1-R.bigfish.com (10.243.78.228) by
 CO1EHSOBE008.bigfish.com (10.243.66.71) with Microsoft SMTP Server id
 14.1.225.23; Tue, 4 Sep 2012 13:11:57 +0000
Received: from mail83-co1 (localhost [127.0.0.1])	by mail83-co1-R.bigfish.com
 (Postfix) with ESMTP id 0698BC801BC	for <git@vger.kernel.org>; Tue,  4 Sep
 2012 13:11:57 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:157.56.248.85;KIP:(null);UIP:(null);IPV:NLI;H:AMSPRD0610HT003.eurprd06.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: 0
X-BigFish: PS0(zzzz1202hzzz31h2a8h668h839h944hd25hf0ah107ah1220h1155h)
Received-SPF: softfail (mail83-co1: transitioning domain of boerse-go.de does not designate 157.56.248.85 as permitted sender) client-ip=157.56.248.85; envelope-from=mark.plomer@boerse-go.de; helo=AMSPRD0610HT003.eurprd06.prod.outlook.com ;.outlook.com ;
Received: from mail83-co1 (localhost.localdomain [127.0.0.1]) by mail83-co1
 (MessageSwitch) id 1346764314591251_32581; Tue,  4 Sep 2012 13:11:54 +0000
 (UTC)
Received: from CO1EHSMHS018.bigfish.com (unknown [10.243.78.239])	by
 mail83-co1.bigfish.com (Postfix) with ESMTP id 8DF595001E7	for
 <git@vger.kernel.org>; Tue,  4 Sep 2012 13:11:54 +0000 (UTC)
Received: from AMSPRD0610HT003.eurprd06.prod.outlook.com (157.56.248.85) by
 CO1EHSMHS018.bigfish.com (10.243.66.28) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Tue, 4 Sep 2012 13:11:50 +0000
Received: from AMSPRD0610MB350.eurprd06.prod.outlook.com ([169.254.6.25]) by
 AMSPRD0610HT003.eurprd06.prod.outlook.com ([10.255.43.38]) with mapi id
 14.16.0190.008; Tue, 4 Sep 2012 13:11:09 +0000
Thread-Topic: GIT-SVN: Corrupted commits when using --preserve-empty-dirs
Thread-Index: Ac2KnjnUGWLbVf2rSc2VZAmjBHIy5w==
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [80.190.141.50]
X-OriginatorOrg: boerse-go.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204744>

Hi,
if I clone a SVN repository with --preserve-empty-dirs it terminates at some point with i.e. following error:
folder/subfolder was not found in commit 2dcb008c220f5f6fe33700c9e7deb0c8fa2b8607 (r4)

I tracked things down to the following problem:
- r1: Create a directory with subdirectory with a file
- r2: Remove the file (so it generates a virtual .gitignore)
- r3: Rename subdirectory
- r4: Add a symlink named like the old subdirectory

-> In GIT the symlink is actually not a symlink but a folder with the ".gitignore" file ... which break things later when changing symlink


# Simple reproduce script:
svnadmin create test-svn-repo
svn co file://`pwd`/test-svn-repo test-svn-wc

mkdir -p test-svn-wc/folder/subfolder
touch test-svn-wc/folder/subfolder/file.txt
svn add test-svn-wc/*
svn ci -m 'Initial commit' test-svn-wc

svn rm test-svn-wc/folder/subfolder/file.txt
svn ci -m 'Removed file.txt' test-svn-wc

svn up test-svn-wc
svn mv test-svn-wc/folder/subfolder test-svn-wc/folder/subfolder2
svn ci -m 'Renamed subfolder' test-svn-wc

svn up test-svn-wc
ln -s subfolder2 test-svn-wc/folder/subfolder
svn add test-svn-wc/folder/subfolder
svn ci -m 'Added subfolder symlink' test-svn-wc

rm -f test-svn-wc/folder/subfolder
ln -s changedlink test-svn-wc/folder/subfolder
svn ci -m 'Changed symlink' test-svn-wc


git svn clone --preserve-empty-dirs file://`pwd`/test-svn-repo test-git
# this throws error: folder/subfolder was not found in commit 2dcb008c220f5f6fe33700c9e7deb0c8fa2b8607 (r4)


Tested with git 1.7.12, svn 1.6.12 (debian)

Greets Mark
