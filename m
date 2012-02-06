From: Joshua Redstone <joshua.redstone@fb.com>
Subject: Re: [PATCH 0/3] On compresing large index
Date: Mon, 6 Feb 2012 15:54:39 +0000
Message-ID: <CB555FF2.40859%joshua.redstone@fb.com>
References: <CACsJy8AnGg11PeCGFs_BxOM3wAjwzs2tOCWJV31_2_KMFTxhDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 06 16:55:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuQuC-0003Pe-SP
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 16:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755420Ab2BFPy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 10:54:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48870 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755298Ab2BFPyz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 10:54:55 -0500
Received: from pps.filterd (m0004077 [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.14.4/8.14.4) with SMTP id q16Fsjtu032733;
	Mon, 6 Feb 2012 07:54:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : cc : subject :
 date : message-id : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=1015QI3LErEAUpXW4a8mcmkE01JDzeM0CjUmW+/c5/g=;
 b=A7ieUUjs8cq8rosINTSjvxPd36O5NL99UytmsxY0qLQM/D/dZNgZv72y0hJU9KakSq6Q
 sWQs5MZaB/4xDZDsrEHzj6O2rgU3H5rGymNBMNtZ8cr6I9ikEiqOGQUVAa1ug5Q4zNSM
 7p5E3ALbKlIrg5pVhCbsX2rKXIolYpVuUGc= 
Received: from mail.thefacebook.com (corpout1.snc1.tfbnw.net [66.220.144.38])
	by mx0b-00082601.pphosted.com with ESMTP id 12tfex85qx-10
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 06 Feb 2012 07:54:49 -0800
Received: from SC-MBX02-5.TheFacebook.com ([fe80::9dc2:cfe6:2745:44cc]) by
 sc-hub04.TheFacebook.com ([192.168.18.212]) with mapi id 14.01.0355.002; Mon,
 6 Feb 2012 07:54:39 -0800
Thread-Topic: [PATCH 0/3] On compresing large index
Thread-Index: AQHM4+B8xXWKchb0XkmT+As50QBOVpYu1LJjgADI4ICAAJxVgA==
In-Reply-To: <CACsJy8AnGg11PeCGFs_BxOM3wAjwzs2tOCWJV31_2_KMFTxhDA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.14.0.111121
x-originating-ip: [192.168.18.252]
Content-ID: <91E5695F14BAFD408B88BB89BBA4324C@fb.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.6.7361,1.0.260,0.0.0000
 definitions=2012-02-06_03:2012-02-06,2012-02-06,1970-01-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190074>

Fwiw, specifically related to 'git ls-files', since it is a relatively
rare operation, it's probably ok if it's a bit slow.  I know you chose it
as a good benchmark of index reading performance.  I just mention it
because, in some hypothetical wild-and-crazy world in which we had a
git-aware file system layer, one could imagine doing away with most of the
index file and querying the file system for info on what's changed, SHA1
of subtrees, etc.

Do you have a sense of which operations on the index are high-value pain
points for large repositories?  I can imagine things like 'git-add' and
'git-commit', but I'm not super familiar with other common operations it
has a role in.

Josh


On 2/5/12 8:35 PM, "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> wrote:

>2012/2/6 Thomas Rast <trast@inf.ethz.ch>:
>>> We need to figure out what git uses 4s user time for.
>>
>> When I worked on the cache-tree stuff, my observation (based on
>> profiling, so I had actual data :-) was that computing SHA1s absolutely
>> dominates everything in such operations.  It does that when writing the
>> index to write the trailing checksum, and also when loading it to verify
>> that the index is valid.
>
>You're right. This is on another machine but with same index (2M
>files), without SHA1 checksum:
>
>$ time ~/w/git/git ls-files --stage|head > /dev/null
>real    0m1.533s
>user    0m1.228s
>sys     0m0.306s
>
>and with SHA-1 checksum:
>
>$ time git ls-files --stage|head > /dev/null
>real     0m7.525s
>user    0m7.257s
>sys     0m0.268s
>
>I guess we could fall back to cheaper digests for such a large index.
>Still more than one second for doing nothing but reading index is too
>slow to me.
>
>> ls-files shouldn't be so slow though.  A quick run with callgrind in a
>> linux-2.6.git tells me it spends about 45% of its time on SHA1s and a
>> whopping 25% in quote_c_style().  I wonder what's so hard about
>> quoting...
>
>That's why I put "| head" there, to cut output processing overhead
>(hopefully).
>-- 
>Duy
