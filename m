From: Joshua Redstone <joshua.redstone@fb.com>
Subject: Re: Debugging git-commit slowness on a large repo
Date: Fri, 9 Dec 2011 00:09:52 +0000
Message-ID: <CB069000.2C9C6%joshua.redstone@fb.com>
References: <CACsJy8DiWWr7eo86gzb-XcqfDv4_ENkqWxswTNb-k84xO18c=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?iso-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Tomas Carnecky <tom@dbservice.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 01:10:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYo3G-0001WP-QE
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 01:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259Ab1LIAKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 19:10:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38801 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751156Ab1LIAKw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Dec 2011 19:10:52 -0500
Received: from pps.filterd (m0004346 [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.14.4/8.14.4) with SMTP id pB909swA010287;
	Thu, 8 Dec 2011 16:09:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : cc : subject :
 date : message-id : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=tSEceTZccJdggQCxGqGdG2ogHsrh3L8453s58e886rs=;
 b=gVhFM3/FqM++0QiUl/2qhGk4VI9txSmFSycwqZgTU3tlQgsq7rsTUIKzXI3KesxIIFYX
 NaV8qplcVpWv3JNUNjkWCuvAWkFfrTEgYQZafeo0ePotnMhe53PMol0021iE9MJiYrGE
 BZdByq0ZrJt0Jpe5NI71sKwGu4RZX7Xr8KE= 
Received: from mail.thefacebook.com (corpout1.snc1.tfbnw.net [66.220.144.38])
	by mx0a-00082601.pphosted.com with ESMTP id 11k52a85qj-2
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 08 Dec 2011 16:09:54 -0800
Received: from SC-MBX02-5.TheFacebook.com ([fe80::9dc2:cfe6:2745:44cc]) by
 sc-hub04.TheFacebook.com ([192.168.18.212]) with mapi id 14.01.0289.001; Thu,
 8 Dec 2011 16:09:53 -0800
Thread-Topic: Debugging git-commit slowness on a large repo
Thread-Index: AQHMsUiE0jGAmaiuRkyp0eiAE6mrR5XJxzCAgAXbCACAAIurgIAA1D+AgAC14ACAAPMrAA==
In-Reply-To: <CACsJy8DiWWr7eo86gzb-XcqfDv4_ENkqWxswTNb-k84xO18c=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.13.0.110805
x-originating-ip: [192.168.18.252]
Content-ID: <47B08860F6564746A65B099D5440DEBF@fb.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.5.7110,1.0.211,0.0.0000
 definitions=2011-12-08_09:2011-12-08,2011-12-08,1970-01-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186602>

On 12/7/11 5:39 PM, "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> wrote:

>On Thu, Dec 8, 2011 at 5:48 AM, Joshua Redstone <joshua.redstone@fb.com>
>wrote:
>> Hi Duy,
>> Thanks for the documentation link.
>>
>> git ls-files shows 100k files, which matches # of files in the working
>> tree ('find . -type f -print | wc -l').
>
>Any chance you can split it into smaller repositories, or remove files
>from working directory (e.g. if you store logs, you don't have to keep
>logs from all time in working directory, they can be retrieved from
>history).

It's not really feasible to split it into smaller repositories.  In fact,
we're expecting it to grow between 3x and 5x in number of files and number
of commits.

>
>> I added a 'git read-tree HEAD' before the git-add, and a 'git
>>write-tree'
>> after the add.  With that, the commit time slowed down to 8 seconds per
>> commit, plus 4 more seconds for the read-tree/add/write-tree ops.  The
>> read-tree/add/write-tree each took about a second.
>
>read-tree destroys stat info in index, refreshing 100k entries in
>index in this case may take some time. Try this to see if commit time
>reduces and how much time update-index takes
>
>read-tree HEAD
>update-index --refresh
>add ....
>write-tree
>commit -q

I added the "update-index --refresh" and the time for commit became more
like 0.6 seconds.
In this setup: read-tree takes ~2 seconds, update-index takes ~8 seconds,
git-add takes 1 to 4 seconds, and write-tree takes less than 1 second.

>
>> As an experiment, I also tried removing the 'git read-tree' and just
>> having the git-write-tree.  That sped up commits to 0.6 seconds, but the
>> overall time for add/write-tree/commit was still 3 to 6 seconds.
>
>overall time is not really important because we duplicate work here
>(write-tree is done as part of commit again). What I'm trying to do is
>to determine how much time each operation in commit may take.
>-- 
>Duy
