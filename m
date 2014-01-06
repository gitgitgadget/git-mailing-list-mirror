From: Ben Maurer <bmaurer@fb.com>
Subject: RE: [PATCH] [RFC] Making use of bitmaps for thin objects
Date: Mon, 6 Jan 2014 21:15:04 +0000
Message-ID: <5CDDBDF2D36D9F43B9F5E99003F6A0D4466883DF@PRN-MBX02-1.TheFacebook.com>
References: <1387741654-14890-1-git-send-email-bmaurer@fb.com>,<20140106145723.GA15489@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 22:15:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0HW2-0002lR-HL
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 22:15:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756297AbaAFVPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 16:15:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21984 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756304AbaAFVPI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 16:15:08 -0500
Received: from pps.filterd (m0044010 [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id s06LDsOO008676;
	Mon, 6 Jan 2014 13:15:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : cc : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=jPESNLj8qkgid2cezUYMPiNInfo0e0v7PPX6RNMwLZI=;
 b=DrWoaOsmG9DKBI9pYdQ4QDFCkH6OUXLiw5B3m6efdqGvFdDsRMayJbISmBte1rf6TaH2
 /OmPkblpA8chEbsIjazSOfM3xTnF9EWZ8Rm5xPsCPbreAakJR9701DLsgBmi8grLoiuE
 do61rcDczujUtdve43hXP2jwiRmqxdVUndk= 
Received: from mail.thefacebook.com (mailwest.thefacebook.com [173.252.71.148])
	by mx0a-00082601.pphosted.com with ESMTP id 1h82rjgdfk-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
	Mon, 06 Jan 2014 13:15:07 -0800
Received: from PRN-MBX02-1.TheFacebook.com ([169.254.1.64]) by
 PRN-CHUB02.TheFacebook.com ([fe80::5de8:34:5a87:6990%12]) with mapi id
 14.03.0174.001; Mon, 6 Jan 2014 13:15:04 -0800
Thread-Topic: [PATCH] [RFC] Making use of bitmaps for thin objects
Thread-Index: AQHO/06wG06Z2WW/kESY1GiAdQ1uTpp4ZrUA//+vgJY=
In-Reply-To: <20140106145723.GA15489@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.16.4]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.11.87,1.0.14,0.0.0000
 definitions=2014-01-06_04:2014-01-06,2014-01-06,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 kscore.is_bulkscore=5.51525491943039e-12 kscore.compositescore=0
 circleOfTrustscore=0 compositescore=0.997600857122248
 urlsuspect_oldscore=0.997600857122248 suspectscore=0
 recipient_domain_to_sender_totalscore=0 phishscore=0 bulkscore=0
 kscore.is_spamscore=0 recipient_to_sender_totalscore=0
 recipient_domain_to_sender_domain_totalscore=64355
 rbsscore=0.997600857122248 spamscore=0
 recipient_to_sender_domain_totalscore=0 urlsuspectscore=0.9 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=7.0.1-1305240000
 definitions=main-1401060146
X-FB-Internal: deliver
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240065>

> Sorry for the slow reply; I've been on vacation.

No worries.

> When you build your bitmaps, do you set the pack.writeBitmapHashCache
> option? We found that it makes a significant difference during the
> compression phase, as otherwise git attempts deltas between random files
> based on size. Here are some numbers for a simulated fetch from
> torvalds/linux, representing about 7 weeks of history. Running:

Yeah, I enabled this option. I don't have timings for generating the bitmap index without this option unfortunately (this is a pretty large repo, doing the full repack that I needed to do to generate the first version took 15+ minutes)

> Having been confused by it myself before, I think the magic keyword is
> "preferred base". Once you know that, the code makes more sense. :)

Ah, nice! That was pretty confusing :-)

> Let me know how this patch does for you. My testing has been fairly
> limited so far.

This patch looks like a much cleaner version :-). Works well for me, but my test setup may not be great since I didn't get any errors from completely ignoring the haves bitmap :-). 