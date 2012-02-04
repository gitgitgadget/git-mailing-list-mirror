From: Joshua Redstone <joshua.redstone@fb.com>
Subject: RE: Git performance results on a large repository
Date: Sat, 4 Feb 2012 20:05:11 +0000
Message-ID: <243C23AF01622E49BEA3F28617DBF0AD5912CC95@SC-MBX02-5.TheFacebook.com>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com>,<CACsJy8DkLCK0ZUKNz_PJazsxjsRbWVVZwjAU5n2EAjJfCYtpoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 21:05:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtlrP-0002pQ-QU
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 21:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353Ab2BDUFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 15:05:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47481 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754175Ab2BDUFN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 15:05:13 -0500
Received: from pps.filterd (m0004346 [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.14.4/8.14.4) with SMTP id q14K3n1A011581;
	Sat, 4 Feb 2012 12:05:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : cc : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=T6LvLfGz+LfaKZ7wAivrp/hDbvdZK792zoXr4xBrevQ=;
 b=H/FMfpp9hyxYfHjS7BQpZrbVe0QuTh6I+ouTBJiGFO8Is6zfW+4nIg5A/19UnEK3JgaL
 Op9PIPbbIfD5+sdpZ7Tiiv+IefdAGZ9o956gsTWGya4bWPCAA+0WX5/84f53C80dPyfe
 xlXVl2biWaf4x4dt1NpW08K6Puo4x4D68Aw= 
Received: from mail.thefacebook.com (corpout1.snc1.tfbnw.net [66.220.144.38])
	by mx0a-00082601.pphosted.com with ESMTP id 12s75j07ws-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 04 Feb 2012 12:05:12 -0800
Received: from SC-MBX02-5.TheFacebook.com ([fe80::9dc2:cfe6:2745:44cc]) by
 sc-hub03.TheFacebook.com ([192.168.18.198]) with mapi id 14.01.0355.002; Sat,
 4 Feb 2012 12:05:11 -0800
Thread-Topic: Git performance results on a large repository
Thread-Index: AQHM4n7tcAztB0vzgUq1FZmN2PdUJJYs1JqAgABTwQs=
In-Reply-To: <CACsJy8DkLCK0ZUKNz_PJazsxjsRbWVVZwjAU5n2EAjJfCYtpoQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.18.252]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.6.7361,1.0.260,0.0.0000
 definitions=2012-02-04_05:2012-02-03,2012-02-04,1970-01-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189900>

One more follow-on thought.  I imagine that most consumers of git are nowhere near the scale of the test repo that I described.  They may still enjoy benefit from efforts to improve git support for large repos.  A few possible reasons:

1. The performance improvements should speed things up for smaller repos as well.
2. They may find their repos growing to a 'large scale' at some point in the future.
3. Any code cleanup as part of an effort to support git scalability is good for code base health and e.g., would facilitate future modifications that may more directly affect them.

Cheers,
Josh
________________________________________
From: Nguyen Thai Ngoc Duy [pclouds@gmail.com]
Sent: Friday, February 03, 2012 10:53 PM
To: Joshua Redstone
Cc: git@vger.kernel.org
Subject: Re: Git performance results on a large repository

On Fri, Feb 3, 2012 at 9:20 PM, Joshua Redstone <joshua.redstone@fb.com> wrote:
> I timed a few common operations with both a warm OS file cache and a cold
> cache.  i.e., I did a 'echo 3 | tee /proc/sys/vm/drop_caches' and then did
> the operation in question a few times (first timing is the cold timing,
> the next few are the warm timings).  The following results are on a server
> with average hard drive (I.e., not flash)  and > 10GB of ram.
>
> 'git status' :   39 minutes cold, and 24 seconds warm.
>
> 'git blame':   44 minutes cold, 11 minutes warm.
>
> 'git add' (appending a few chars to the end of a file and adding it):   7
> seconds cold and 5 seconds warm.
>
> 'git commit -m "foo bar3" --no-verify --untracked-files=no --quiet
> --no-status':  41 minutes cold, 20 seconds warm.  I also hacked a version
> of git to remove the three or four places where 'git commit' stats every
> file in the repo, and this dropped the times to 30 minutes cold and 8
> seconds warm.

Have you tried "git update-index --assume-unchaged"? That should
reduce mass lstat() and hopefully improve the above numbers. The
interface is not exactly easy-to-use, but if it has significant gain,
then we can try to improve UI.

On the index size issue, ideally we should make minimum writes to
index instead of rewriting 191 MB index. An improvement we could do
now is to compress it, reduce disk footprint, thus disk I/O. If you
compress the index with gzip, how big is it?
--
Duy
