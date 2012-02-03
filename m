From: Joshua Redstone <joshua.redstone@fb.com>
Subject: Git performance results on a large repository
Date: Fri, 3 Feb 2012 14:20:06 +0000
Message-ID: <CB5074CF.3AD7A%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 03 15:20:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtK0E-0008EZ-Qz
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 15:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756616Ab2BCOUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 09:20:33 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55316 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756634Ab2BCOUL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 09:20:11 -0500
Received: from pps.filterd (m0004347 [127.0.0.1])
	by m0004347.ppops.net (8.14.4/8.14.4) with SMTP id q13EKAon006792
	for <git@vger.kernel.org>; Fri, 3 Feb 2012 06:20:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : subject : date
 : message-id : content-type : content-id : content-transfer-encoding :
 mime-version; s=facebook; bh=8UuPl/V6xKqlPvQABMftbbSgWKxbkP9jaI4nI23kdd0=;
 b=rMNgRn+kKnBR3VdSWNALRNiE/TjMXwezpLz6GwezAyA3QYZwU4bpaMz2WVQBculaBYPR
 7diycJ4tqiG2QrBokpQguZOhsEp6o5E/nV/qDynqfAIrEa7NTnafbRaPwMSx/HA2MWBc
 XjG/iCyfZ4qHCpKWGGi3VvVDDgoF5N9SiD0= 
Received: from mail.thefacebook.com (corpout1.snc1.tfbnw.net [66.220.144.38])
	by m0004347.ppops.net with ESMTP id 12repf060y-2
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Fri, 03 Feb 2012 06:20:10 -0800
Received: from SC-MBX02-5.TheFacebook.com ([fe80::9dc2:cfe6:2745:44cc]) by
 sc-hub03.TheFacebook.com ([192.168.18.198]) with mapi id 14.01.0355.002; Fri,
 3 Feb 2012 06:20:07 -0800
Thread-Topic: Git performance results on a large repository
Thread-Index: AQHM4n7tcAztB0vzgUq1FZmN2PdUJA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.14.0.111121
x-originating-ip: [192.168.18.252]
Content-ID: <83D5E4EEA6CFAD48A9B28C418AA26C88@fb.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.6.7361,1.0.260,0.0.0000
 definitions=2012-02-03_05:2012-02-02,2012-02-03,1970-01-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189776>

Hi Git folks,

We (Facebook) have been investigating source control systems to meet our
growing needs.  We already use git fairly widely, but have noticed it
getting slower as we grow, and we want to make sure we have a good story
going forward.  We're debating how to proceed and would like to solicit
people's thoughts.

To better understand git scalability, I've built up a large, synthetic
repository and measured a few git operations on it.  I summarize the
results here.

The test repo has 4 million commits, linear history and about 1.3 million
files.  The size of the .git directory is about 15GB, and has been
repacked with 'git repack -a -d -f --max-pack-size=10g --depth=100
--window=250'.  This repack took about 2 days on a beefy machine (I.e.,
lots of ram and flash).  The size of the index file is 191 MB. I can share
the script that generated it if people are interested - It basically picks
2-5 files, modifies a line or two and adds a few lines at the end
consisting of random dictionary words, occasionally creates a new file,
commits all the modifications and repeats.

I timed a few common operations with both a warm OS file cache and a cold
cache.  i.e., I did a 'echo 3 | tee /proc/sys/vm/drop_caches' and then did
the operation in question a few times (first timing is the cold timing,
the next few are the warm timings).  The following results are on a server
with average hard drive (I.e., not flash)  and > 10GB of ram.

'git status' :   39 minutes cold, and 24 seconds warm.

'git blame':   44 minutes cold, 11 minutes warm.

'git add' (appending a few chars to the end of a file and adding it):   7
seconds cold and 5 seconds warm.

'git commit -m "foo bar3" --no-verify --untracked-files=no --quiet
--no-status':  41 minutes cold, 20 seconds warm.  I also hacked a version
of git to remove the three or four places where 'git commit' stats every
file in the repo, and this dropped the times to 30 minutes cold and 8
seconds warm.


The git performance we observed here is too slow for our needs.  So the
question becomes, if we want to keep using git going forward, what's the
best way to improve performance.  It seems clear we'll probably need some
specialized servers (e.g., to perform git-blame quickly) and maybe
specialized file system integration to detect what files have changed in a
working tree.

One way to get there is to do some deep code modifications to git
internals, to, for example, create some abstractions and interfaces that
allow plugging in the specialized servers.  Another way is to leave git
internals as they are and develop a layer of wrapper scripts around all
the git commands that do the necessary interfacing.  The wrapper scripts
seem perhaps easier in the short-term, but may lead to increasing
divergence from how git behaves natively and also a layer of complexity.

Thoughts?

Cheers,
Josh
