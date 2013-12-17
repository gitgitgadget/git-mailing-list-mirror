From: Lorenzo Keller <lkeller@marvell.com>
Subject: git fetch doesn't ignore funny refs
Date: Tue, 17 Dec 2013 13:35:33 +0100
Message-ID: <52B04515.8020609@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 17 13:35:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VstsO-0003vD-HR
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 13:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317Ab3LQMfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 07:35:48 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:57683 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753282Ab3LQMfr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Dec 2013 07:35:47 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.14.5/8.14.5) with SMTP id rBHCZlsb028801
	for <git@vger.kernel.org>; Tue, 17 Dec 2013 04:35:47 -0800
Received: from sc-owa02.marvell.com ([199.233.58.137])
	by mx0a-0016f401.pphosted.com with ESMTP id 1gth1f0v7t-11
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 17 Dec 2013 04:35:47 -0800
Received: from maili.marvell.com (10.93.76.43) by sc-owa02.marvell.com
 (10.93.76.22) with Microsoft SMTP Server id 8.3.327.1; Tue, 17 Dec 2013
 04:35:46 -0800
Received: from [10.10.130.158] (unknown [10.10.130.158])	by maili.marvell.com
 (Postfix) with ESMTP id 66C211CCD9C	for <git@vger.kernel.org>; Tue, 17 Dec
 2013 04:35:46 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
X-Enigmail-Version: 1.5.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.11.87,1.0.14,0.0.0000
 definitions=2013-12-17_01:2013-12-17,2013-12-17,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=13
 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=7.0.1-1305240000 definitions=main-1312170048
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239381>

Hello,

I'm trying to maintain a mirror of a repo that is published with gerrit.
The repo contains
a "funny ref" with name 'refs/tags/xyz/...' .

When I clone the repo the ref is correctly ignored:

> git clone --mirror ssh://server:29418/repo

Cloning into bare repository 'repo.git'...
error: * Ignoring funny ref 'refs/tags/xyz/...' locally
remote: Counting objects: 58263, done
remote: Finding sources: 100% (58263/58263)
remote: Total 58263 (delta 40882), reused 58131 (delta 40882)
Receiving objects: 100% (58263/58263), 16.10 MiB | 163.00 KiB/s, done.
Resolving deltas: 100% (40882/40882), done.
Checking connectivity... done.

When I try to update the mirror, however, the command fails:

> git remote update

Fetching origin
error: * Ignoring funny ref refs/tags/xyz/...' locally
From ssh://server:29418/repo
 ! [new tag]         xyz/... -> xyz/...  (unable to update local ref)
error: Could not fetch origin

Doing a fetch also fails:

> git fetch --all

Fetching origin
error: * Ignoring funny ref 'refs/tags/xyz/...' locally
From ssh://server:29418/repo
 ! [new tag]         xyz/... -> xyz/...  (unable to update local ref)
error: Could not fetch origin

If I force not to update the tags, then the command is successful:

> git fetch --all -n

Fetching origin
error: * Ignoring funny ref 'refs/tags/xyz/...' locally

I believe the problem is due to the fact that in function
find_non_local_tags() in file builtins/fetch.c
the refs are directly obtained from the transport and not filtered for
funny entries.

A check as this one:

if (check_refname_format(ref->name, 0))
   continue;

fixes the problem for me.

I report here bug and fix in the hope it can be reviewed and integrated
in future git releases.

Best regards,
Lorenzo Keller
