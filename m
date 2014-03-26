From: Siddharth Agarwal <sid0@fb.com>
Subject: fetches with bitmaps enabled can cause accesses to already GC'd objects
Date: Tue, 25 Mar 2014 19:22:37 -0700
Message-ID: <533239ED.5040503@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 03:23:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSdUp-0007GQ-7u
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 03:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbaCZCWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 22:22:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8022 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751246AbaCZCWl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2014 22:22:41 -0400
Received: from pps.filterd (m0004003 [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id s2Q2KCCr025203
	for <git@vger.kernel.org>; Tue, 25 Mar 2014 19:22:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=message-id : date : from :
 mime-version : to : subject : content-type : content-transfer-encoding;
 s=facebook; bh=spUeeVoDoocIT7m7zkH30+nSENRB1hDBgJXMJqeABYs=;
 b=WGTeF7U2aue2kOZ5/SuZ7NMp23Qz1R5oGNeTU+TGg7lA02R3X7YRiqA9hrzfxtkXZtO+
 UxXh5vw3TgQN4syeZJTDxbGdR5kIkNZe5+KRCCHIU9E9wfa1acLbtaFnRIWETJphiSJQ
 4mmmRpvkPwUDe3+pTPY/LljFuhZSE3lnntU= 
Received: from mail.thefacebook.com (mailwest.thefacebook.com [173.252.71.148])
	by mx0b-00082601.pphosted.com with ESMTP id 1jujyarh3c-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
	for <git@vger.kernel.org>; Tue, 25 Mar 2014 19:22:39 -0700
Received: from [172.26.1.186] (192.168.57.29) by mail.thefacebook.com
 (192.168.16.21) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 25 Mar
 2014 19:22:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
X-Originating-IP: [192.168.57.29]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.11.87,1.0.14,0.0.0000
 definitions=2014-03-25_07:2014-03-25,2014-03-25,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 kscore.is_bulkscore=2.18693119169444e-10 kscore.compositescore=0
 circleOfTrustscore=514.84 compositescore=0.999787071573508
 urlsuspect_oldscore=0.999787071573508 suspectscore=1
 recipient_domain_to_sender_totalscore=0 phishscore=0 bulkscore=0
 kscore.is_spamscore=0 recipient_to_sender_totalscore=0
 recipient_domain_to_sender_domain_totalscore=64355
 rbsscore=0.999787071573508 spamscore=0
 recipient_to_sender_domain_totalscore=0 urlsuspectscore=0.9 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=7.0.1-1402240000
 definitions=main-1403250164
X-FB-Internal: deliver
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245158>

Hi,

We're still experimenting with bitmaps, and we've have run into issues 
where fetching from a repository with bitmaps enabled can lead to 
objects that used to be present on the server but have since been GC'd 
being accessed, and git pack-objects on the server failing because of that.

I can consistently reproduce this with a particular pair of repos, and 
tip of git master (3f09db0) with no patches on top running on both ends. 
git fetch fails with

remote: error: Could not read be7cbe440a7b9a34f53515af4075e971c811cfb2
remote: fatal: bad tree object be7cbe440a7b9a34f53515af4075e971c811cfb2
error: git upload-pack: git-pack-objects died with error.
fatal: git upload-pack: aborting due to possible repository corruption 
on the remote side.
remote: aborting due to possible repository corruption on the remote side.
fatal: protocol error: bad pack header

Removing the bitmap fixes this.

be7cbe440a7b9a34f53515af4075e971c811cfb2 is a tree object that is 
present on the client but not on the server. It used to be present on 
the server, but the any refs that it was reachable from have been 
removed and the object has since been garbage collected. One ref that 
this object was reachable from and that used to be on the server is 
still present on the client though, under refs/remotes/origin/.

This tree object seems to be reachable from exactly one other tree 
object, and so on, until I reach a commit object. Note that the commit 
and root tree pointing to be7cbe440a7b9a34f53515af4075e971c811cfb2 is 
still present as a loose object in the repo.

I dug into this a bit, and it looks like the bad access is inside 
https://github.com/git/git/blob/3f09db0/pack-bitmap.c#L730, and from 
there inside https://github.com/git/git/blob/3f09db0/pack-bitmap.c#L575. 
This ultimately calls traverse_commit_list at 
https://github.com/git/git/blob/3f09db0/list-objects.c#L195, which adds 
the tree that transitively points to 
be7cbe440a7b9a34f53515af4075e971c811cfb2 as pending. (Note again that 
the commit and root tree objects still exist in the repo as loose 
objects.) Further down in that function, process_tree is called, which 
traverses the tree and ultimately dies at 
https://github.com/git/git/blob/3f09db0/list-objects.c#L85.

Unfortunately, as before, I can't share the repo this is happening in.
