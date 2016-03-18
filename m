From: Durham Goode <durham@fb.com>
Subject: Re: [PATCH 3/2] dir.c: fix dir re-inclusion rules with "NODIR" and
 "MUSTBEDIR"
Date: Thu, 17 Mar 2016 23:21:27 -0700
Message-ID: <56EB9E67.1000306@fb.com>
References: <1458218744-15810-2-git-send-email-pclouds@gmail.com>
 <1458219254-16343-1-git-send-email-pclouds@gmail.com>
 <xmqqfuvoy89q.fsf@gitster.mtv.corp.google.com> <56EB8961.70302@fb.com>
 <CACsJy8A2FKn-8nWtK4QPMHDCDYvTZBrQs1RVMApnuejXQis19g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mateusz Jakub Kwapich <mitrandir@fb.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 07:21:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agnn9-0005N9-1c
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 07:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbcCRGVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 02:21:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56138 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751280AbcCRGVl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2016 02:21:41 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.16.0.11/8.16.0.11) with SMTP id u2I6G9PP019330;
	Thu, 17 Mar 2016 23:21:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=subject : to : references
 : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=facebook;
 bh=rG7gM4BDPxw+VIjkC3u7f7+Mmlkb6dJtodbbRHFX+CA=;
 b=alrLW56IuYljlBueqqq1WTbZBixuxowU0tK6odBrZF1jbkJ11iBkIrAnWsRHt0WxTtYs
 eCpYxEa00FsWGZbI1e/6XY20tuGkUPi5ZX010mNEdDkq1mhYgnfEjvcHaNXf3+7+cDjl
 +fWlae5mv9FiuX6lBIZc1GAbuKJvvQ6LOBA= 
Received: from mail.thefacebook.com ([199.201.64.23])
	by m0089730.ppops.net with ESMTP id 21qbajrga5-1
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 17 Mar 2016 23:21:30 -0700
Received: from durham-mbp1.local (192.168.52.123) by mail.thefacebook.com
 (192.168.16.12) with Microsoft SMTP Server (TLS) id 14.3.248.2; Thu, 17 Mar
 2016 23:21:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <CACsJy8A2FKn-8nWtK4QPMHDCDYvTZBrQs1RVMApnuejXQis19g@mail.gmail.com>
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2016-03-18_04:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289202>



On 3/17/16 10:40 PM, Duy Nguyen wrote:
> On Fri, Mar 18, 2016 at 11:51 AM, Durham Goode <durham@fb.com> wrote:
>> On 3/17/16 4:49 PM, Junio C Hamano wrote:
>>> Thanks for these 5 patches, two of which need to be discarded ;-).
>>> I think you can pick either one of 1/2, pick the one that says
>>> "non-NULL" (as opposed to "something") in the log message for 2/2.
>>>
>>> Durham, does it fix your issues if you apply the 1/2 and 2/2 (but
>>> not 3/2) on top of 2.8-rc?
>>>
>>> Duy, how comfortable are you with the idea of including this two in
>>> 2.8 final?  We have long passed the final -rc, and while it is
>>> probably OK to prolong the cycle and do another -rc, we cannot keep
>>> going like "oops, there is another thing discovered by somebod new"
>>> forever.
>>>
>>> Thanks.
>> Patches 1+2 fix the repro steps in the report, yes.  But I've found another
>> case that produces different results in 2.8 than in 2.7:
>>
>> Given a repo with files:
>>
>> dir1/dir2/show/file
>> dir1/dir2/hide/file
>>
>> and a sparse-checkout of
>>
>> /*
>> /dir1/dir2/show
>> !/dir1/dir2/
> I would say this is "undefined behavior" patterns. The intention of
> "!" pattern is to revert a subset of a matched pattern, e.g.
> !/dir1/dir2/show/something. Combining lines 2 and 3 together,
> "!dir1/dir2/" is not only supposed to revert dir1/dir2/show entirely,
> but extend the reversion outside of it. At least to me that's not
> intended.
After looking at it further, I agree with you.  The new behavior is as 
justifiable as the old. In addition, my description of this secondary 
issue was wrong (I said it left the files around, when in reality it 
resulted in an empty working copy, so git read-tree failed and left the 
files).  So we can ignore that case. Thanks.
>
> Skipping that tricky pair, the pairs "/*" and "!/dir1/dir2/" means
> "exclude everything except dir1/dir2" (in .gitignore sense) or
> "include everything except dir1/dir2" in sparse checkout sense. Which
> results in empty worktree. 1+2 trips when the trailing slash in the
> last rule exists and includes both files in show/hide. Patch 3/2 fixes
> the tripping and exclude both. If the last rule is "!/dir1/dir2" then
> 1+2 results in empty worktree as well.
>
I'm not sure I fully understand.  Here's what I'm seeing, with patch 1, 
2, and 3 applied:  with patterns "/*', "!/dir1/dir2", "/dir1/dir2/show", 
I see the contents of dir1/dir2/show/ (good). If I add a trailing slash 
to the last pattern (so it becomes "/dir1/dir2/show/"), it now results 
in an empty working copy. That seems funky, given that the last rule is 
to include that directory. Am I misunderstanding the trailing slash?

We're pretty far beyond my ability to understand ignore patterns now.  
The patches seem to make the behavior better though, so thanks for that.
