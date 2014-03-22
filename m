From: Siddharth Agarwal <sid0@fb.com>
Subject: with reuse-delta patches, fetching with bitmaps segfaults due to
 possibly incomplete bitmap traverse
Date: Fri, 21 Mar 2014 19:58:55 -0700
Message-ID: <532CFC6F.8000008@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <bmaurer@fb.com>, Jeff King <peff@peff.net>,
	Aaron Kushner <akushner@fb.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 03:59:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRC9s-0000Gh-Aj
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 03:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbaCVC7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 22:59:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30282 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750738AbaCVC7C (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Mar 2014 22:59:02 -0400
Received: from pps.filterd (m0044012 [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id s2M2pvOO029512;
	Fri, 21 Mar 2014 19:59:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=message-id : date : from :
 mime-version : to : cc : subject : content-type :
 content-transfer-encoding; s=facebook;
 bh=R1pefmDzB7H0U2e3peCp4RhfBzy1oyEwcHyyX2JTczE=;
 b=ecfZ2asABv+VhvJUGHolL1FKWwqp2wEPH+W9eON3oBMi9dMwBjfPTU0dIc84BSAMnTPM
 K1AxCzWrUFUn5sHf/cYPiABty5VrnKd/H+Apb7QSHKh3Udx93OK7YnnteSVFbXpUZjpI
 JJef38/H4Y2lvhcAXkasOUmXnVHo7uh2emU= 
Received: from mail.thefacebook.com (mailwest.thefacebook.com [173.252.71.148])
	by mx0a-00082601.pphosted.com with ESMTP id 1js0kk06f8-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
	Fri, 21 Mar 2014 19:59:00 -0700
Received: from [172.20.32.17] (192.168.57.29) by mail.thefacebook.com
 (192.168.16.23) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 21 Mar
 2014 19:58:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
X-Originating-IP: [192.168.57.29]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.11.87,1.0.14,0.0.0000
 definitions=2014-03-21_07:2014-03-21,2014-03-21,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 kscore.is_bulkscore=5.82957337957879e-09 kscore.compositescore=0
 circleOfTrustscore=0 compositescore=0.997600857122248
 urlsuspect_oldscore=0.997600857122248 suspectscore=1
 recipient_domain_to_sender_totalscore=0 phishscore=0 bulkscore=0
 kscore.is_spamscore=0 recipient_to_sender_totalscore=0
 recipient_domain_to_sender_domain_totalscore=64355
 rbsscore=0.997600857122248 spamscore=0
 recipient_to_sender_domain_totalscore=0 urlsuspectscore=0.9 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=7.0.1-1402240000
 definitions=main-1403210171
X-FB-Internal: deliver
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244761>

Hi all,

At Facebook we've found that fetch speed is a bottleneck for our Git 
repos, so we've been looking to deploy bitmaps to speed up fetches. 
We've been trying out git-next with the top two patches from 
https://github.com/peff/git/commits/jk/bitmap-reuse-delta, but the 
following is reproducible with tip of that branch, currently 81cdec2.

We're finding that git fetches with bitmaps enabled are malfunctioning 
under some circumstances. For at least one of our repositories, a 
particular git fetch that an engineer ran segfaulted on the rmeote git 
pack-objects because of writing to an array out of bounds. This is 
consistently reproducible with the particular pair of (remote, local) 
repositories.

The error looks like:

(1) $ git fetch
remote: Counting objects: 201614, done.
remote: Compressing objects: 100% (36262/36262), done.
error: pack-objects died of signal 11
error: git upload-pack: git-pack-objects died with error.
fatal: git upload-pack: aborting due to possible repository corruption 
on the remote side.
remote: aborting due to possible repository corruption on the remote side.
fatal: protocol error: bad pack header

In contrast, when I disable bitmaps by removing the .bitmap file on the 
server while using the same Git binary, I get

(2) $ git fetch
remote: Counting objects: 203466, done.
remote: Compressing objects: 100% (46014/46104), done.
Receiving objects: 100% (203466/203466), 55.52 MiB | 7.45 MiB/s, done.
remote: Total 203466 (delta 169894), reused 187613 (delta 156621)

Note the differences in the "Counting objects" and "Compressing objects" 
figures between (1) and (2). I'm not sure if they're relevant.

As a baseline, if I run the same test with an older git -- version 
1.8.1, I get

(3) $ git fetch
remote: Counting objects: 235298, done.
remote: Compressing objects: 100% (46104/46104), done.
remote: Total 203466 (delta 169894), reused 187613 (delta 156621)
Receiving objects: 100% (203466/203466), 55.52 MiB | 11.15 MiB/s, done.

As a control, I'm using the same version of Git on the client in all 
three cases above -- git 1.8.1. The client Git doesn't matter -- using 
81cdec2 has the same effect. The transport is ssh in all three cases.

I dug into this a bit and it looks like at this point:

https://github.com/peff/git/blob/81cdec28fa24fdc613ab7c3406c1c67975dbf22f/builtin/pack-objects.c#L700

at some object that add_family_to_write_order is called for, wo_end 
exceeds to_pack.nr_objects by over 1000 objects. More precisely, at the 
point it crashes, wo_end is 218081 while to_pack.nr_objects is 201614. 
(This means wo_end overshot to_pack.nr_objects some time ago.)

I bumped up the malloc at 
https://github.com/peff/git/blob/81cdec28fa24fdc613ab7c3406c1c67975dbf22f/builtin/pack-objects.c#L628 
in order to prevent segfaulting, and the remote process dies with:

(4) $ git fetch
remote: Counting objects: 201614, done.
remote: Compressing objects: 100% (36262/36262), done.
remote: fatal: ordered 226227 objects, expected 201614

In contrast, in case (2) above, at the end of compute_pack_order, wo_end 
and to_pack.nr_objects are both 235298. I found it interesting that this 
number is not reflected anywhere in the output of (2) but is the same as 
the output of the "Counting objects" step of (3). I'm not sure if this 
is a red herring or not.

I suspect that the traverse_bitmap_commit_list call at 
https://github.com/peff/git/blob/81cdec28fa24fdc613ab7c3406c1c67975dbf22f/builtin/pack-objects.c#L2476 
is somehow skipping objects.

Other notes:
- I cannot reproduce this with a plain old 'git clone <remote>' with 
bitmaps enabled and used on the remote. There's something particular 
about either thin packs or the client repository that's triggering this.
- There is exactly one pack containing slightly over 3.5 million 
objects, and three loose objects in the remote repo.
- The remote repo is isolated -- there are no concurrent writes going on.
- While generating the bitmap I did not reuse existing any existing 
bitmaps: I removed the existing bitmap and ran git repack -adb.

Unfortunately I do not have a reproducible test case with a repository 
that's open source, or with one that I can share. However, I'm happy to 
provide any other information about the structure of the repository, and 
to set up a debugging session over IRC or other means.
