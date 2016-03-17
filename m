From: Durham Goode <durham@fb.com>
Subject: Re: bug: sparse config interpretation incorrectness in 2.8.0-rc2
Date: Wed, 16 Mar 2016 23:49:28 -0700
Message-ID: <56EA5378.4070001@fb.com>
References: <56E9F5B3.6030903@fb.com>
 <20160317005632.GA17778@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Mateusz Kwapich <mitrandir@fb.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 07:49:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agRke-0002FL-Bv
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 07:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbcCQGtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 02:49:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26178 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752728AbcCQGte (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 02:49:34 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.16.0.11/8.16.0.11) with SMTP id u2H6mo8Q022711;
	Wed, 16 Mar 2016 23:49:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=subject : to : references
 : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=facebook;
 bh=GyAp/Z1c5C4CUiQsGdrQuLYW1XeI/tlM+2JDDqpEFig=;
 b=ZaKjRUq8zFBee2SgSZunGzRVoDVibaxduhoq0B7bsoLuu32kCEWRagvKXnGY+xneHTcJ
 ysViNPNWW2pBsQdND3AR0dQBYtoz+jEfeSFkmt6wpp0u4jSIGU2lImJ2dZiuFDVfMwIJ
 ss0/pyM/2uDIzJzNrgVfdAzcnN/zx08oeFc= 
Received: from mail.thefacebook.com ([199.201.64.23])
	by m0001303.ppops.net with ESMTP id 21puy7f6jt-1
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 16 Mar 2016 23:49:32 -0700
Received: from durham-mbp1.local (192.168.52.123) by mail.thefacebook.com
 (192.168.16.21) with Microsoft SMTP Server (TLS) id 14.3.248.2; Wed, 16 Mar
 2016 23:49:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <20160317005632.GA17778@duynguyen-vnpc.dek-tpc.internal>
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2016-03-17_02:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289079>

On 3/16/16 5:56 PM, Duy Nguyen wrote:
> On Wed, Mar 16, 2016 at 05:09:23PM -0700, Durham Goode wrote:
>> Using git 2.8.0-rc2, given a repo with the following files:
>>
>> - one/hideme
>> - one/donthide
>> - two/foo
>>
>> A sparse config of:
>>
>> cat > .git/info/sparse-checkout <<EOF
>> /*
>> !one/hideme
>> EOF
>>
>> Results in a repository that only has `one/donthide` in it.  I would
>> expect `two/foo`to be present as well.  This worked in 2.6, and
>> bisecting it points to d589a67eceacd1cc171bbe94906ca7c9a0edd8c5
>> "dir.c: don't exclude whole dir prematurely" (author cc'd).
> Thank you. This should fix it. I think I understand why it goes
> wrong. I'm going to run some more tests and post a proper patch later.
>
> -- 8< --
> diff --git a/dir.c b/dir.c
> index 69e0be6..77f38a5 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1027,7 +1027,6 @@ static struct exclude *last_exclude_matching_from_list(const char *pathname,
>   				exc = x;
>   				break;
>   			}
> -			continue;
>   		}
>   
>   		if (x->flags & EXC_FLAG_MUSTBEDIR) {
> -- 8< --
> --
> Duy
To provide some perspective on the severity of this bug: all of our 
users who were using sparse checkouts had their working copy mostly 
deleted when they did a checkout after we upgraded to 2.8.0-rc2.  So I'd 
think this is a fix that should get in to 2.8.
