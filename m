From: Siddharth Agarwal <sid0@fb.com>
Subject: with git-next, git pull --rebase can print out "fatal: No such ref:
 ''" for branches without an upstream
Date: Thu, 16 Jan 2014 17:08:14 -0800
Message-ID: <52D8827E.3060007@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <john@keeping.me.uk>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 17 02:08:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3xv6-0006bQ-Cr
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 02:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbaAQBIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 20:08:21 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61342 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751333AbaAQBIT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jan 2014 20:08:19 -0500
Received: from pps.filterd (m0004077 [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id s0H18Hta021291;
	Thu, 16 Jan 2014 17:08:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=message-id : date : from :
 mime-version : to : cc : subject : content-type :
 content-transfer-encoding; s=facebook;
 bh=semvBgJt8WVu3LUoZRbhLhLR3eqJolc6DWIJEXg6J+c=;
 b=Qgjz3ByFkAJ/f2YibY1Ye/a0bd9XHSCREQk+kktrLRIBIQYvzbUjhg6jMdef6NpErxfa
 znINjwJ4o/kVBh8beIO5sbfqY549sf3QmRAi/deVBqGdDhzkrkko1JqKESq/o9ixY/1C
 4oElh/AveQe02Zb8GnVUcWf9iMWZLft+iAg= 
Received: from mail.thefacebook.com (mailwest.thefacebook.com [173.252.71.148])
	by mx0b-00082601.pphosted.com with ESMTP id 1heqq7rr64-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
	Thu, 16 Jan 2014 17:08:17 -0800
Received: from [172.25.68.250] (192.168.16.4) by mail.thefacebook.com
 (192.168.16.16) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 16 Jan
 2014 17:08:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
X-Originating-IP: [192.168.16.4]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.11.87,1.0.14,0.0.0000
 definitions=2014-01-16_08:2014-01-16,2014-01-16,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 kscore.is_bulkscore=2.98633340278798e-12 kscore.compositescore=0
 circleOfTrustscore=0 compositescore=0.997600857122248
 urlsuspect_oldscore=0.997600857122248 suspectscore=12
 recipient_domain_to_sender_totalscore=0 phishscore=0 bulkscore=0
 kscore.is_spamscore=0 recipient_to_sender_totalscore=0
 recipient_domain_to_sender_domain_totalscore=64355
 rbsscore=0.997600857122248 spamscore=0
 recipient_to_sender_domain_totalscore=0 urlsuspectscore=0.9 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=7.0.1-1305240000
 definitions=main-1401160176
X-FB-Internal: deliver
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240549>

With git-next, where git pull --rebase can print out "fatal: No such 
ref: ''" if git pull --rebase is run on branches without an upstream.

With git at b139ac2589b15d55cd9fa5c6957da44b150d0737, the following 
commands demonstrate the problem:

git init repo1
cd repo1
touch a; git add a; git commit -m "a"
cd ..
git clone repo1 repo2
cd repo2
git config remote.origin.fetch refs/heads/master:refs/remotes/origin/master
git checkout -b test
git pull --rebase

This results in the following output:

fatal: No such ref: ''
Current branch test is up to date.

So the pull --rebase looks like it works, but it prints out a spurious 
fatal error.

I've managed to bisect this down to 
https://github.com/gitster/git/commit/48059e405028ebf8a09c5a9aede89dfb460cce98. 
Looks like get_remote_merge_branch is called without arguments, and it 
returns an empty string. This string is passed as-is to git merge-base, 
which causes the error.
