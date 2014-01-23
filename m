From: Siddharth Agarwal <sid0@fb.com>
Subject: Re: [PATCH] pack-objects: turn off bitmaps when skipping objects
Date: Thu, 23 Jan 2014 15:53:28 -0800
Message-ID: <52E1AB78.1000504@fb.com>
References: <52E080C1.4030402@fb.com> <20140123225238.GB2567@sigill.intra.peff.net> <52E1A99D.6010809@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 24 00:53:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6U5e-0008ID-Ut
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 00:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbaAWXxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 18:53:38 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48545 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751083AbaAWXxh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jan 2014 18:53:37 -0500
Received: from pps.filterd (m0044012 [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id s0NNlA2T002289;
	Thu, 23 Jan 2014 15:53:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=message-id : date : from :
 mime-version : to : cc : subject : references : in-reply-to : content-type
 : content-transfer-encoding; s=facebook;
 bh=1NuLBDU+gtHR4/WbDEO1nNPescjv9fAHNl1H3kpiNUE=;
 b=kKWur0sYqUYQLjB5BNp9fO36obvLD6A/VHR5UW/+2/SYSmAJrHK+ixWI4KT2hG0opoVF
 wFYocaLEFnQao7NLcRdKli/wvxMATNdYGZmhG4h5dGUL3P+c4R+5U23PzRCZqIQdkzAn
 TSMW6+DJpDl0flDAE1smGgsBEVKr3tYjkvs= 
Received: from mail.thefacebook.com (mailwest.thefacebook.com [173.252.71.148])
	by mx0a-00082601.pphosted.com with ESMTP id 1hk5vfhn2c-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
	Thu, 23 Jan 2014 15:53:30 -0800
Received: from [172.25.68.250] (192.168.57.29) by mail.thefacebook.com
 (192.168.16.16) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 23 Jan
 2014 15:53:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <52E1A99D.6010809@fb.com>
X-Originating-IP: [192.168.57.29]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.11.87,1.0.14,0.0.0000
 definitions=2014-01-23_05:2014-01-23,2014-01-23,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 kscore.is_bulkscore=5.10702591327572e-15 kscore.compositescore=0
 circleOfTrustscore=0 compositescore=0.997600857122248
 urlsuspect_oldscore=0.997600857122248 suspectscore=0
 recipient_domain_to_sender_totalscore=0 phishscore=0 bulkscore=0
 kscore.is_spamscore=0 recipient_to_sender_totalscore=0
 recipient_domain_to_sender_domain_totalscore=64355
 rbsscore=0.997600857122248 spamscore=0
 recipient_to_sender_domain_totalscore=0 urlsuspectscore=0.9 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=7.0.1-1305240000
 definitions=main-1401230173
X-FB-Internal: deliver
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240977>

On 01/23/2014 03:45 PM, Siddharth Agarwal wrote:
>
> The worry is less certain objects not being packed and more the old 
> packs being deleted by git repack, isn't it? From the man page for 
> git-index-pack:

This should probably be "new pack" and not "old packs", I guess. Not 
knowing much about how this actually works, I'm assuming the scenario 
here is something like:

(1) git receive-pack receives a pack P.pack and writes it to disk
(2) git index-pack runs on P.pack
(3) git repack runs separately, finds pack P.pack with no refs pointing 
to it, and deletes it
(4) everything goes wrong

With a keep file, this would be averted because

(1) git receive-pack receives a pack P.pack and writes it to disk
(2) git index-pack writes a keep file for P.pack, called P.keep
(3) git repack runs separately, finds pack P.pack with a keep file, 
doesn't touch it
(4) git index-pack finishes, and something updates refs to point to 
P.pack and deletes P.keep
