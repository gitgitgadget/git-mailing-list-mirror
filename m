From: Joshua Redstone <joshua.redstone@fb.com>
Subject: Re: Debugging git-commit slowness on a large repo
Date: Tue, 20 Dec 2011 01:40:47 +0000
Message-ID: <CB152498.2D6DB%joshua.redstone@fb.com>
References: <7vehw0kphc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?iso-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Tomas Carnecky <tom@dbservice.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 02:41:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcoiH-0001Ep-3V
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 02:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898Ab1LTBls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 20:41:48 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48270 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753229Ab1LTBlr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 20:41:47 -0500
Received: from pps.filterd (m0004346 [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.14.4/8.14.4) with SMTP id pBK1dEhe025817;
	Mon, 19 Dec 2011 17:40:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : cc : subject :
 date : message-id : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=D+uId1mJdk4HAuvpgsII3Op/oNeseYvaX1SMmE/TMB0=;
 b=grh3kLMbTKinZZgVJNWfw5a6aEC0Ul+0z+vpX19aZJ8OKKhBMdke3TIaYgU0KZ1AjSif
 0dn+BC6pcQcg10odGKVWemEiERBjZcQavMkaU9GLqSKvCAlF2mok51fv7fALrSL0fddZ
 Xc4C1xc6EUwjQbEef7mxT8H5ZXvzJgg/6x0= 
Received: from mail.thefacebook.com (corpout1.snc1.tfbnw.net [66.220.144.38])
	by mx0a-00082601.pphosted.com with ESMTP id 11tgbxr16w-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 19 Dec 2011 17:40:50 -0800
Received: from SC-MBX02-5.TheFacebook.com ([fe80::9dc2:cfe6:2745:44cc]) by
 sc-hub03.TheFacebook.com ([192.168.18.198]) with mapi id 14.01.0355.002; Mon,
 19 Dec 2011 17:40:48 -0800
Thread-Topic: Debugging git-commit slowness on a large repo
Thread-Index: AQHMsUiE0jGAmaiuRkyp0eiAE6mrR5XJxzCAgAXbCACAAIurgIAA1D+AgAC14ACAAPMrAIAAAj6AgAZIqACACwpvAIAACD+SgAAFl4A=
In-Reply-To: <7vehw0kphc.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.13.0.110805
x-originating-ip: [192.168.18.252]
Content-ID: <5311C50EDAFFAB469F5C97DBC174B672@fb.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.5.7110,1.0.211,0.0.0000
 definitions=2011-12-19_08:2011-12-19,2011-12-19,1970-01-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187493>

You're right, more than optimizations, they are modifications that reduce
safety checks and make assumptions about the way one is using git (e.g.,
you always remember to add each file you want to commit).  I focused on
them because:

  1. In our installation, we don't use commit hooks that change what's
being committed, so it's good to know that in principle, there's a big
perf benefit to be had by leveraging that fact.

  2. At an abstract level, it seems like the cost of doing a commit should
be proportional to the amount of the repository touched by the commit, not
by the size of the repository.  These experiments are demonstrations of
one direction that a set of optimizations would need to go to get commit
performance more along those lines.

  3. We're also exploring storage systems that support more efficient ways
to query what's changed than stat'ing every file.

I forgot to mention, the times I quoted where with --no-verify and
--no-status.  Adding '-q' didn't speed up performance at all.


As a bonus, I've also profiled git-add on the 1-million file repo, and it
looks like, as you might expect, the time is dominated by reading and
writing the index.  The time for git-add is a couple of seconds.

Josh


On 12/19/11 5:21 PM, "Junio C Hamano" <gitster@pobox.com> wrote:

>Joshua Redstone <joshua.redstone@fb.com> writes:
>
>> I've managed to speed up git-commit on large repos by 4x by removing
>>some
>> safeguards that caused git to stat every file in the repo on commits
>>that
>> touch a small number of files.  The diff, for illustrative purposes
>>only,
>> is at:
>>
>>     https://gist.github.com/1499621
>>
>>
>> With a repo with 1 million files (but few commits), the diff drops the
>> commit time down from 7.3 seconds to 1.8 seconds, a 75% decrease. The
>> optimizations are:
>
>I do not know if these kind of changes are called "optimizations" or
>merely making the command record a random tree object that may have some
>resemblance to what you wanted to commit but is subtly incorrect. I didn't
>fetch your safety removal, though.
>
>Wouldn't you get a similar speed-up without being unsafe if you simply ran
>"git commit" without any parameter (i.e. write out the current index as a
>tree and make a commit), combined with "--no-status" and perhaps "-q" to
>avoid running the comparison between the resulting commit and the working
>tree state after the commit?
