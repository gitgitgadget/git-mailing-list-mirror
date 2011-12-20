From: Joshua Redstone <joshua.redstone@fb.com>
Subject: Re: Debugging git-commit slowness on a large repo
Date: Tue, 20 Dec 2011 19:26:50 +0000
Message-ID: <CB162065.2E009%joshua.redstone@fb.com>
References: <87wr9rk35n.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?iso-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Tomas Carnecky <tom@dbservice.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Dec 20 20:28:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd5MK-0007ck-6c
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 20:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669Ab1LTT2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 14:28:15 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58831 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751348Ab1LTT2P convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 14:28:15 -0500
Received: from pps.filterd (m0004077 [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.14.4/8.14.4) with SMTP id pBKJDejK026863;
	Tue, 20 Dec 2011 11:26:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : cc : subject :
 date : message-id : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=XIdLdbhZgOwHgMIn7BPTih5HGpmjCH04JiaioxNphik=;
 b=OlL5/BgDyyztlQUat3+0NGn44fxM9javRnkRUQvowzRWGBeiATTHdIs+oDDyeWWW3FfP
 GoHR6qX/IoK+2xBWS27TGoM0zsErzHn0y3u4NM8/jAQPajJzcEnN6Y5xw81g/FTJ9S7k
 Jy2J9d0RLLGcE8F2NFOpObRT0z3XxWp8A/I= 
Received: from mail.thefacebook.com (corpout1.snc1.tfbnw.net [66.220.144.38])
	by mx0b-00082601.pphosted.com with ESMTP id 11tyv0024b-2
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 20 Dec 2011 11:26:53 -0800
Received: from SC-MBX02-5.TheFacebook.com ([fe80::9dc2:cfe6:2745:44cc]) by
 sc-hub03.TheFacebook.com ([192.168.18.198]) with mapi id 14.01.0355.002; Tue,
 20 Dec 2011 11:26:50 -0800
Thread-Topic: Debugging git-commit slowness on a large repo
Thread-Index: AQHMsUiE0jGAmaiuRkyp0eiAE6mrR5XJxzCAgAXbCACAAIurgIAA1D+AgAC14ACAAPMrAIAAAj6AgAZIqACACwpvAIAACD+SgAAFl4CAAIEe8IAAqLuA
In-Reply-To: <87wr9rk35n.fsf@thomas.inf.ethz.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.13.0.110805
x-originating-ip: [192.168.18.252]
Content-ID: <871BE47E44B9AA4A8C4FACB53856BABA@fb.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.5.7110,1.0.211,0.0.0000
 definitions=2011-12-20_07:2011-12-20,2011-12-20,1970-01-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187519>

I looked again at my poor-mans-profiling output of git-add.  The Sha1
stuff under ce_write_entry->ce_write_flush  takes a bunch of time.
commit_lock_file->rename takes about the same as well.

Btw, the perf numbers for commit and add are with a warm file cache.  I
expect the benefit of skipping all the stat() calls will increase for cold
cache.

Josh

On 12/20/11 1:23 AM, "Thomas Rast" <trast@student.ethz.ch> wrote:

>Joshua Redstone <joshua.redstone@fb.com> writes:
>> As a bonus, I've also profiled git-add on the 1-million file repo, and
>>it
>> looks like, as you might expect, the time is dominated by reading and
>> writing the index.  The time for git-add is a couple of seconds.
>
>Note that the time to write the index itself is also rather small, but
>the time needed to sha1 the index when loading and then again when
>saving it really hurts.
>
>(I noticed this while working on the commit-tree topic.)
>
>-- 
>Thomas Rast
>trast@{inf,student}.ethz.ch
