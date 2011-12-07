From: Joshua Redstone <joshua.redstone@fb.com>
Subject: Re: Debugging git-commit slowness on a large repo
Date: Wed, 7 Dec 2011 22:48:22 +0000
Message-ID: <CB051EFC.2C795%joshua.redstone@fb.com>
References: <CACsJy8Dbd+v+8FzvQS9a4C8DQSxQGgqQNGaLhL1cHv-yMnaCJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?iso-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Tomas Carnecky <tom@dbservice.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 23:49:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYQJ0-0003Lo-G4
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 23:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758088Ab1LGWte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 17:49:34 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49234 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757465Ab1LGWtd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Dec 2011 17:49:33 -0500
Received: from pps.filterd (m0004060 [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.14.4/8.14.4) with SMTP id pB7MjFhc027129;
	Wed, 7 Dec 2011 14:48:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : cc : subject :
 date : message-id : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=SBpx8MCCtr+5yOJisysBJ7gO1gAdhp7Sf8Jjb/Yn+RM=;
 b=oVzDjSfsaECRVLnsToF8/tMtovqTgs+rjJhOXcVC9afVZvfAuYa6CQ0SLWbvs/hxUwBB
 H5Cp0gdTFeGHfTmL+R9ddKQfiLgeuLHxMjm94NUK25FuErGQXbnCtJWoqlUMDQPvbIH2
 RbCRpE7/v599+hfo2yfjRx3+T30iuUJg9IQ= 
Received: from mail.thefacebook.com (corpout1.snc1.tfbnw.net [66.220.144.38])
	by mx0b-00082601.pphosted.com with ESMTP id 11jgb3r2he-2
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 07 Dec 2011 14:48:27 -0800
Received: from SC-MBX02-5.TheFacebook.com ([fe80::9dc2:cfe6:2745:44cc]) by
 sc-hub03.TheFacebook.com ([192.168.18.198]) with mapi id 14.01.0289.001; Wed,
 7 Dec 2011 14:48:23 -0800
Thread-Topic: Debugging git-commit slowness on a large repo
Thread-Index: AQHMsUiE0jGAmaiuRkyp0eiAE6mrR5XJxzCAgAXbCACAAIurgIAA1D+A
In-Reply-To: <CACsJy8Dbd+v+8FzvQS9a4C8DQSxQGgqQNGaLhL1cHv-yMnaCJQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.13.0.110805
x-originating-ip: [192.168.18.252]
Content-ID: <DE0A96233931B9408410AB39B22AC004@fb.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.5.7110,1.0.211,0.0.0000
 definitions=2011-12-07_07:2011-12-07,2011-12-07,1970-01-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186515>

Hi Duy,
Thanks for the documentation link.

git ls-files shows 100k files, which matches # of files in the working
tree ('find . -type f -print | wc -l').

I added a 'git read-tree HEAD' before the git-add, and a 'git write-tree'
after the add.  With that, the commit time slowed down to 8 seconds per
commit, plus 4 more seconds for the read-tree/add/write-tree ops.  The
read-tree/add/write-tree each took about a second.

As an experiment, I also tried removing the 'git read-tree' and just
having the git-write-tree.  That sped up commits to 0.6 seconds, but the
overall time for add/write-tree/commit was still 3 to 6 seconds.

For comparison, without the read-tree and write-tree, commits take about 1
second and add/commit in total takes about 2 seconds.

It surprises me that the presence of git read-tree or write-tree would
slow things down so much.

Josh

On 12/6/11 6:08 PM, "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> wrote:

>On Wed, Dec 7, 2011 at 8:48 AM, Joshua Redstone <joshua.redstone@fb.com>
>wrote:
>> I tried doing a 'git read-tree HEAD' before each 'git add ; git commit'
>> iteration, and the time for git-commit jumped from about 1 second to
>>about
>> 8 seconds.  That is a pretty dramatic slowdown.  Any idea why?  I wonder
>> if that's related to the overall commit slowness.
>
>How big is your working directory? "git ls-files | wc -l" should show
>it. Try "git read-tree HEAD; git add; git write-tree" and see if the
>write-tree part takes as much time as commit. write-tree is mainly
>about cache-tree generation.
>
>> @Carlos and/or @Junio, can you point me at any docs/code to understand
>> what a tree-cache is and how it differs from the index?  I did a google
>> search for [git tree-cache index], but nothing popped out.
>
>Have a look at Documentation/technical/index-format.txt. Cache tree
>extension is near the end.
>-- 
>Duy
