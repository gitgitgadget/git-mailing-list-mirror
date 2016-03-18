From: Durham Goode <durham@fb.com>
Subject: Re: [PATCH 3/2] dir.c: fix dir re-inclusion rules with "NODIR" and
 "MUSTBEDIR"
Date: Thu, 17 Mar 2016 21:51:45 -0700
Message-ID: <56EB8961.70302@fb.com>
References: <1458218744-15810-2-git-send-email-pclouds@gmail.com>
 <1458219254-16343-1-git-send-email-pclouds@gmail.com>
 <xmqqfuvoy89q.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <mitrandir@fb.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 05:51:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agmOD-0008Jx-W8
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 05:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbcCREvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 00:51:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35567 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752691AbcCREvw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2016 00:51:52 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u2I4pXZw004690;
	Thu, 17 Mar 2016 21:51:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=subject : to : references
 : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=facebook;
 bh=lEhS26ODtRV6DveHK72NfU5pjYRrddTP5q6tOkl/vmo=;
 b=k2kTnCvsFQu3TqyXvQLTOzFA2khmfaouv2f0VXuEP3Fczw6wOX3Ina5yiMTkebGRVaEe
 RDfF03GjWgPgdubXz+x3iqiQuVekr/y0vvbFPLhMSU84DVD1PfGnKlfVrc5TsbQThTs0
 kw5dk97QeGS8+EQOxQI21/hGdZ3C+hpnF7Y= 
Received: from mail.thefacebook.com ([199.201.64.23])
	by mx0a-00082601.pphosted.com with ESMTP id 21r68j0vvx-1
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 17 Mar 2016 21:51:48 -0700
Received: from durham-mbp1.local (192.168.52.123) by mail.thefacebook.com
 (192.168.16.15) with Microsoft SMTP Server (TLS) id 14.3.248.2; Thu, 17 Mar
 2016 21:51:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <xmqqfuvoy89q.fsf@gitster.mtv.corp.google.com>
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2016-03-18_03:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289185>

On 3/17/16 4:49 PM, Junio C Hamano wrote:
> Thanks for these 5 patches, two of which need to be discarded ;-).
> I think you can pick either one of 1/2, pick the one that says
> "non-NULL" (as opposed to "something") in the log message for 2/2.
>
> Durham, does it fix your issues if you apply the 1/2 and 2/2 (but
> not 3/2) on top of 2.8-rc?
>
> Duy, how comfortable are you with the idea of including this two in
> 2.8 final?  We have long passed the final -rc, and while it is
> probably OK to prolong the cycle and do another -rc, we cannot keep
> going like "oops, there is another thing discovered by somebod new"
> forever.
>
> Thanks.
Patches 1+2 fix the repro steps in the report, yes.  But I've found 
another case that produces different results in 2.8 than in 2.7:

Given a repo with files:

dir1/dir2/show/file
dir1/dir2/hide/file

and a sparse-checkout of

/*
/dir1/dir2/show
!/dir1/dir2/

the working copy still contains dir1/dir2/hide/file when run from 
2.8.0-rc2. In git 2.6 and 2.7.3 it does not show up (which is the 
expected behavior, from what I understand of the docs).  Repro script is 
below.  Notice, the 'dir2/' part of the paths is important.  If I drop 
that directory, the issue doesn't repro.


#!/bin/bash

set -x
rm -rf sparse-test
GIT=git
$GIT init sparse-test
cd sparse-test
$GIT config --add core.sparsecheckout true

mkdir -p dir1/dir2/show dir1/dir2/hide
touch dir1/dir2/show/file1
touch dir1/dir2/hide/file2

$GIT add .
$GIT commit -m "initial commit"
$GIT read-tree --reset -u HEAD

mkdir .git/info
cat > .git/info/sparse-checkout <<EOF
/*
/dir1/dir2/show
!/dir1/dir2/
EOF
$GIT read-tree --reset -u HEAD

ls -R dir1/dir2
set +x
echo
echo expected: see only "dir1/dir2/show/file"
echo actual: see "dir1/dir2/hide/file" as well
