From: Siddharth Agarwal <sid0@fb.com>
Subject: WIth git-next, writing bitmaps fails when keep files are present
Date: Wed, 22 Jan 2014 18:38:57 -0800
Message-ID: <52E080C1.4030402@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 23 03:39:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6ACF-0001aO-Ji
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 03:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbaAWCjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 21:39:07 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37679 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751276AbaAWCjG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jan 2014 21:39:06 -0500
Received: from pps.filterd (m0004077 [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id s0N2cxUQ011126
	for <git@vger.kernel.org>; Wed, 22 Jan 2014 18:38:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=message-id : date : from :
 mime-version : to : subject : content-type : content-transfer-encoding;
 s=facebook; bh=GxUfbJPXdAOSlLzlIB38OSWG0QEKoXgHKC1ijkruz4c=;
 b=gXSa5C9Ozprm/egmpx6onhLBgg5hXL4dRE0gKLIXb1HE8NszimAFiiLW4jllko5krXOf
 OC9cy+zYk7C7d5KYUOG5VwkawrzK3nYAwtxspBKQ+r6xEj7bDL/GImi54izGsJ4puvFx
 Xh+Qo6lDC9AHM6BKqZjHdD0iZTlZq/jXk58= 
Received: from mail.thefacebook.com (mailwest.thefacebook.com [173.252.71.148])
	by mx0b-00082601.pphosted.com with ESMTP id 1hjn6f90v8-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
	for <git@vger.kernel.org>; Wed, 22 Jan 2014 18:38:59 -0800
Received: from [172.19.33.75] (192.168.57.29) by mail.thefacebook.com
 (192.168.16.16) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 22 Jan
 2014 18:38:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
X-Originating-IP: [192.168.57.29]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.11.87,1.0.14,0.0.0000
 definitions=2014-01-22_08:2014-01-22,2014-01-22,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 kscore.is_bulkscore=7.41461336772886e-11 kscore.compositescore=0
 circleOfTrustscore=514.84 compositescore=0.999787071573508
 urlsuspect_oldscore=0.999787071573508 suspectscore=13
 recipient_domain_to_sender_totalscore=0 phishscore=0 bulkscore=0
 kscore.is_spamscore=0 recipient_to_sender_totalscore=0
 recipient_domain_to_sender_domain_totalscore=64355
 rbsscore=0.999787071573508 spamscore=0
 recipient_to_sender_domain_totalscore=0 urlsuspectscore=0.9 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=7.0.1-1305240000
 definitions=main-1401220225
X-FB-Internal: deliver
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240898>

Running git-next, writing bitmap indexes fails if a keep file is present 
from an earlier pack.

With git at b139ac2, the following commands demonstrate the problem:

git init test
cd test
touch a
git add a
git commit -m "a"

git repack -ad  # generate a pack file
for f in .git/objects/pack/*.pack; touch ${f/%pack/keep}  # mark it as 
to keep

touch b
git add b
git commit -m "b"
git repack -adb

This fails at the bitmap writing stage with something like:

Counting objects: 2, done.
Delta compression using up to 24 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (2/2), done.
fatal: Failed to write bitmap index. Packfile doesn't have full closure 
(object 7388a015938147155b600eaacc59af6e78c75e5a is missing)

In our case we have .keep files lying around from ages ago (possibly due 
to kill -9s run on the server). It also means that running repack -a 
with bitmap writing enabled on a repo becomes problematic if a fetch is 
run concurrently.

Even if we practice good .keep hygiene, this seems like a bug in git 
that should be fixed.
