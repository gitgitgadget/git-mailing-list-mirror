From: Siddharth Agarwal <sid0@fb.com>
Subject: Re: [PATCH/RFC 0/6] reuse deltas found by bitmaps
Date: Wed, 26 Mar 2014 15:40:47 -0700
Message-ID: <5333576F.1050603@fb.com>
References: <20140326072215.GA31739@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ben Maurer <bmaurer@fb.com>
To: Jeff King <peff@peff.net>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 23:40:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSwVE-00038j-0J
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 23:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756506AbaCZWkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 18:40:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39569 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756223AbaCZWkv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2014 18:40:51 -0400
Received: from pps.filterd (m0044010 [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id s2QMdstN031669;
	Wed, 26 Mar 2014 15:40:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=message-id : date : from :
 mime-version : to : cc : subject : references : in-reply-to : content-type
 : content-transfer-encoding; s=facebook;
 bh=gkd3+p4ORRD99WZjxU/WhQdD8HnyI9KS9rQ+GffMbAo=;
 b=N9G4Z1/lN6s3mLR8Eduu+H96YNQJcdhgyaxoHcuVwsJ5h+HsvXbE/1TK6MiwUohJ4d3w
 V7ZiBOtWBJkCDOW9e7EGvvE38JiQR6urszWYWNnXCWuEEoEhlqoMU4NL4Aaq0QsQp/VI
 cM8VJm0OFZUWj6rvDmru+0jPYd39xvQcvYA= 
Received: from mail.thefacebook.com (mailwest.thefacebook.com [173.252.71.148])
	by mx0a-00082601.pphosted.com with ESMTP id 1jv7t3g0nv-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
	Wed, 26 Mar 2014 15:40:49 -0700
Received: from [172.25.69.14] (192.168.16.4) by mail.TheFacebook.com
 (192.168.16.17) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 26 Mar
 2014 15:40:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140326072215.GA31739@sigill.intra.peff.net>
X-Originating-IP: [192.168.16.4]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.11.87,1.0.14,0.0.0000
 definitions=2014-03-26_05:2014-03-26,2014-03-26,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 kscore.is_bulkscore=1.74343872672011e-12 kscore.compositescore=0
 circleOfTrustscore=0 compositescore=0.997600857122248
 urlsuspect_oldscore=0.997600857122248 suspectscore=0
 recipient_domain_to_sender_totalscore=0 phishscore=0 bulkscore=0
 kscore.is_spamscore=0 recipient_to_sender_totalscore=0
 recipient_domain_to_sender_domain_totalscore=64355
 rbsscore=0.997600857122248 spamscore=0
 recipient_to_sender_domain_totalscore=0 urlsuspectscore=0.9 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=7.0.1-1402240000
 definitions=main-1403260136
X-FB-Internal: deliver
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245251>

On 03/26/2014 12:22 AM, Jeff King wrote:
> [tl;dr the patch is the same as before, but there is a script to measure
>         its effects; please try it out on your repos]

Here are results from one of our repos:

Test                         origin HEAD
-------------------------------------------------------------------------
5311.3: server   (1 days)    1.77(2.49+0.15)     0.76(0.65+0.12) -57.1%
5311.4: size     (1 days)               7.8M                3.1M -60.2%
5311.5: client   (1 days)    0.56(0.48+0.03)     1.18(0.97+0.05) +110.7%
5311.7: server   (2 days)    2.79(3.68+0.25)     0.77(0.65+0.14) -72.4%
5311.8: size     (2 days)              24.2M                6.8M -71.8%
5311.9: client   (2 days)    1.14(0.95+0.10)     2.72(2.33+0.13) +138.6%
5311.11: server   (4 days)   3.70(4.76+0.28)     0.84(0.72+0.14) -77.3%
5311.12: size     (4 days)             51.2M               18.9M -63.0%
5311.13: client   (4 days)   2.29(2.02+0.29)     4.58(3.91+0.30) +100.0%
5311.15: server   (8 days)   5.16(7.48+0.38)     1.20(1.18+0.21) -76.7%
5311.16: size     (8 days)             78.3M               42.6M -45.5%
5311.17: client   (8 days)   3.73(3.67+0.40)     6.59(5.95+0.51) +76.7%
5311.19: server  (16 days)   6.48(10.27+0.52)    1.60(1.85+0.27) -75.3%
5311.20: size    (16 days)             97.5M               64.0M -34.4%
5311.21: client  (16 days)   5.31(5.76+0.57)     8.99(8.61+0.68) +69.3%
5311.23: server  (32 days)   8.56(14.00+0.67)    2.31(2.91+0.37) -73.0%
5311.24: size    (32 days)            124.7M               92.0M -26.2%
5311.25: client  (32 days)   7.69(9.20+0.76)     12.80(13.07+0.91) +66.4%
5311.27: server  (64 days)   37.47(45.48+1.55)   29.75(29.58+0.96) -20.6%
5311.28: size    (64 days)            245.5M              207.1M -15.6%
5311.29: client  (64 days)   15.11(18.26+1.58)   25.02(25.90+2.03) +65.6%
5311.31: server (128 days)   43.85(57.02+2.57)   29.88(29.54+1.35) -31.9%
5311.32: size   (128 days)            507.3M              461.6M -9.0%
5311.33: client (128 days)   27.13(31.54+3.32)   37.76(39.49+3.16) +39.2%

I'm currently running tests on a much larger repo than that. The full 
perf run will take several hours on that, so the soonest I can likely 
publish results for that is tomorrow.
