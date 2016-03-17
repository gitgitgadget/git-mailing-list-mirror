From: Durham Goode <durham@fb.com>
Subject: bug: sparse config interpretation incorrectness in 2.8.0-rc2
Date: Wed, 16 Mar 2016 17:09:23 -0700
Message-ID: <56E9F5B3.6030903@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <pclouds@gmail.com>, Mateusz Kwapich <mitrandir@fb.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 17 01:09:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agLVi-0005GN-WE
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 01:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbcCQAJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 20:09:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32801 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756024AbcCQAJ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2016 20:09:28 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u2H09Kkw030287;
	Wed, 16 Mar 2016 17:09:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=to : from : subject : cc :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=W+YSPnlXWKOPNPw4C5IyRxHpw/OHin+Uiy1rYHFH3nY=;
 b=TEe/9hre8btJxq3gzEV41zUvhqfoN0/ExtQXnzLY5ckDqG+sBKdMWgn99yo983P/cSgB
 Fhnm0UERG+KGd0oFLH6hY2FNZMxDj18jACneJ9MzMGph8cyTd5NXek6wVZDWJbf5FWi6
 ctiC/OVq04c8XwQZihtkmJeYE1zFkqd/buw= 
Received: from mail.thefacebook.com ([199.201.64.23])
	by mx0b-00082601.pphosted.com with ESMTP id 21qbmnhhqw-1
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 16 Mar 2016 17:09:25 -0700
Received: from durham-mbp1.dhcp.thefacebook.com (192.168.52.123) by
 mail.thefacebook.com (192.168.16.12) with Microsoft SMTP Server (TLS) id
 14.3.248.2; Wed, 16 Mar 2016 17:09:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2016-03-16_05:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289063>

Using git 2.8.0-rc2, given a repo with the following files:

- one/hideme
- one/donthide
- two/foo

A sparse config of:

cat > .git/info/sparse-checkout <<EOF
/*
!one/hideme
EOF

Results in a repository that only has `one/donthide` in it.  I would 
expect `two/foo`to be present as well.  This worked in 2.6, and 
bisecting it points to d589a67eceacd1cc171bbe94906ca7c9a0edd8c5 "dir.c: 
don't exclude whole dir prematurely" (author cc'd).

The script I used to repro and for bisecting is pasted below:





#!/bin/bash

set -x
rm -rf sparse-test
GIT=git

$GIT init sparse-test
cd sparse-test
$GIT config --add core.sparsecheckout true

mkdir one two
touch one/hideme
touch one/donthide
touch two/foo

$GIT add .
$GIT commit -m "initial commit"
$GIT read-tree --reset -u HEAD

mkdir .git/info
cat > .git/info/sparse-checkout <<EOF
/*
!one/hideme
EOF
$GIT read-tree --reset -u HEAD

ls -R one two
set +x
echo
echo expected: see one/donthide and two/foo
echo actual: see only one/donthide

[ -d two ] && exit 0
exit 1
