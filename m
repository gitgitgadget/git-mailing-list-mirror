From: Ben Maurer <bmaurer@fb.com>
Subject: RE: [PATCH] [RFC] Making use of bitmaps for thin objects
Date: Sun, 22 Dec 2013 21:55:23 +0000
Message-ID: <5CDDBDF2D36D9F43B9F5E99003F6A0D43B67C0DA@PRN-MBX02-1.TheFacebook.com>
References: <1387741654-14890-1-git-send-email-bmaurer@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "peff@peff.net" <peff@peff.net>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 22 22:55:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vuqzk-0000hI-H9
	for gcvg-git-2@plane.gmane.org; Sun, 22 Dec 2013 22:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756571Ab3LVVz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Dec 2013 16:55:28 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38816 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755718Ab3LVVz1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Dec 2013 16:55:27 -0500
Received: from pps.filterd (m0044012 [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id rBMLkrE3023575;
	Sun, 22 Dec 2013 13:55:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : cc : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Dl+sT/ccrSevuff/qNam8eCmYCHd1RLprEtLXqpl5oc=;
 b=I7Di0P+PJHFQJ38h30XKwzz//GfQ9pLDSHTH2QTn2tgb44DlABOiMOWh2ZLAbzGBtm2N
 /s1poZGGD+dvR3Gr8ko/jZKNV2b7b/zgUOvApFcJCgkbzseo/cP23gly+vHZflCadeXR
 vDbGkIKA8hxEDQsD8XZ1OtxKB1jeoQjj9oU= 
Received: from mail.thefacebook.com (prn1-cmdf-dc01-fw1-nat.corp.tfbnw.net [173.252.71.129] (may be forged))
	by mx0a-00082601.pphosted.com with ESMTP id 1gvg7bq2fd-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
	Sun, 22 Dec 2013 13:55:26 -0800
Received: from PRN-MBX02-1.TheFacebook.com ([169.254.1.64]) by
 PRN-CHUB13.TheFacebook.com ([fe80::8c35:7ba8:bb32:ee09%12]) with mapi id
 14.03.0174.001; Sun, 22 Dec 2013 13:55:25 -0800
Thread-Topic: [PATCH] [RFC] Making use of bitmaps for thin objects
Thread-Index: AQHO/06wG06Z2WW/kESY1GiAdQ1uTppgwIzT
In-Reply-To: <1387741654-14890-1-git-send-email-bmaurer@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.16.4]
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.11.87,1.0.14,0.0.0000
 definitions=2013-12-22_02:2013-12-20,2013-12-22,1970-01-01 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239648>

One issue with this approach is that it seems git-pack-index doesn't perform as well with thin packs. git-index-pack uses a multi-threaded approach to resolving the deltas. However, the multithreading only works on deltas that are exclusively in the pack. After the multi-threaded phase, it incrementally brings in objects from external packs, but in single threaded manner. Many objects in the pack have some dependency on an external object, therefore, defeating the multithreading.

What's the use case for a pack file with a SHA1 reference living inside the pack file (why not just use an offset?) Would it make sense to assume that all such files are external and bring them in in the first phase.