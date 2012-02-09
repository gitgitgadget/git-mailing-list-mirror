From: Joshua Redstone <joshua.redstone@fb.com>
Subject: Re: Git performance results on a large repository
Date: Thu, 9 Feb 2012 21:06:21 +0000
Message-ID: <CB599BA0.42A6B%joshua.redstone@fb.com>
References: <CACsJy8AxOZQ7S42V1g-b0vdBxPpjhFZe6qDkGaALnxQ6LiUssw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 22:06:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvbCP-0006PN-UC
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 22:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758030Ab2BIVGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 16:06:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39390 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753825Ab2BIVGb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 16:06:31 -0500
Received: from pps.filterd (m0004347 [127.0.0.1])
	by m0004347.ppops.net (8.14.4/8.14.4) with SMTP id q19L3rfJ002164;
	Thu, 9 Feb 2012 13:06:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : cc : subject :
 date : message-id : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=RtWC56nh1lCX+f0SXlJtwKum+lLxDl0TXNBaQ6v85MQ=;
 b=qSXbmcaGm8zPtnM8azxe2xpXYBLbJH8jWXEJJAXlnGcJ2YPVxCLbW4Jg8d9H4C1ym1G5
 u9Fidml1BvIfMP42HspK2MM5YkOTDNc6UThY/lKBxlGpp0IrOFJZX4VjMNi3Q2eDRtPS
 X0odNgkHNLOSBZjFQ4Rq1+JQVGr4W8GGgTA= 
Received: from mail.thefacebook.com (corpout1.snc1.tfbnw.net [66.220.144.38])
	by m0004347.ppops.net with ESMTP id 12vhmygby6-4
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 09 Feb 2012 13:06:27 -0800
Received: from SC-MBX02-5.TheFacebook.com ([fe80::9dc2:cfe6:2745:44cc]) by
 sc-hub04.TheFacebook.com ([192.168.18.212]) with mapi id 14.01.0355.002; Thu,
 9 Feb 2012 13:06:22 -0800
Thread-Topic: Git performance results on a large repository
Thread-Index: AQHM4n7tcAztB0vzgUq1FZmN2PdUJJYs1JqA///3O7GAAWcKgIACWZ6AgAFxrQCAA0x6AA==
In-Reply-To: <CACsJy8AxOZQ7S42V1g-b0vdBxPpjhFZe6qDkGaALnxQ6LiUssw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.14.0.111121
x-originating-ip: [192.168.18.252]
Content-ID: <3A64C8B648F25C44ABC8364B870C9082@fb.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.6.7361,1.0.260,0.0.0000
 definitions=2012-02-09_04:2012-02-09,2012-02-09,1970-01-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190322>

Hi Nguyen,
I like the notion of using --assume-unchanged to cut down the set of
things that git considers may have changed.
It seems to me that there may still be situations that require operations
on the order of the # of files in the repo and hence may still be slow.
Following is a list of potential candidates that occur to me.

1. Switching branches, especially if you switch to an old branch.
Sometimes I've seen branch switching taking a long time for what I thought
was close to where HEAD was.

2. Interactive rebase in which you reorder a few commits close to the tip
of the branch (I observed this taking a long time, but haven't profiled it
yet).  I include here other types of cherry-picking of commits.

3. Any working directory operations that fail part-way through and make
you want to do a 'git reset --hard' or at least a full 'git-status'.  That
is, when you have reason to believe that files with 'assume-unchange' may
have accidentally changed.

4. Operations that require rewriting the index - I think git-add is one?

If the working-tree representation is the full set of all files
materialized on disk and it's the same as the representation of files
changed, then I'm not sure how to avoid some of these without playing file
system games or using wrapper scripts.

What do you (or others) think?


Josh


On 2/7/12 8:43 AM, "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> wrote:

>On Mon, Feb 6, 2012 at 10:40 PM, Joey Hess <joey@kitenet.net> wrote:
>>> Someone on HN suggested making assume-unchanged files read-only to
>>> avoid 90% accidentally changing a file without telling git. When
>>> assume-unchanged bit is cleared, the file is made read-write again.
>>
>> That made me think about using assume-unchanged with git-annex since it
>> already has read-only files.
>>
>> But, here's what seems a misfeature...
>
>because, well.. assume-unchanged was designed to avoid stat() and
>nothing else. We are basing a new feature on top of it.
>
>> If an assume-unstaged file has
>> modifications and I git add it, nothing happens. To stage a change, I
>> have to explicitly git update-index --no-assume-unchanged and only then
>> git add, and then I need to remember to reset the assume-unstaged bit
>> when I'm done working on that file for now. Compare with running git mv
>> on the same file, which does stage the move despite assume-unstaged. (So
>> does git rm.)
>
>This is normal in the lock-based "checkout/edit/checkin" model. mv/rm
>operates on directory content, which is not "locked - no edit allowed"
>(in our case --assume-unchanged) in git. But lock-based model does not
>map really well to git anyway. It does not have the index (which may
>make things more complicated). Also at index level, git does not
>really understand directories.
>
>I think we could add a protection layer to index, where any changes
>(including removal) to an index entry are only allowed if the entry is
>"unlocked" (i.e no assume-unchanged bit). Locked entries are read-only
>and have assume-unchanged bit set. "git (un)lock" are introduced as
>new UI. Does that make assume-unchanged friendlier?
>-- 
>Duy
>--
>To unsubscribe from this list: send the line "unsubscribe git" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
