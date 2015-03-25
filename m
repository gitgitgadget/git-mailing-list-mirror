From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 1/2] sha1_file.c: support reading from a loose object
 of unknown type
Date: Thu, 26 Mar 2015 01:50:21 +0530
Message-ID: <55131885.5000706@gmail.com>
References: <5512618B.2060402@gmail.com>	<1427268105-16901-1-git-send-email-karthik.188@gmail.com> <xmqqzj7028mn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 21:20:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yarmz-00016K-K5
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 21:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbbCYUU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 16:20:29 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33755 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbbCYUUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 16:20:25 -0400
Received: by pabxg6 with SMTP id xg6so39883723pab.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=i5GECyfZqpfCTdJZ86XQWefm6HljXqcz5jDJfamYrGw=;
        b=ouJDzloyWeXqfQpttP1iR6vtLvRZEi7Pue8D9+wzI2GisfjyWkRr7uxJaxSY47x3L8
         UNyF6heVXs4xiq7nO/FICGohNRn2hlweSo0GZV8zbU0TULDOgEQypFZODa7NFsDWYm1s
         OLuYu+XRO4omW3D8zKVDPiKiW1R4eZ5Gep0Ay3kbL22wrmpxSBVCRDqjlGtGF0kKeLYT
         wABFIT03lB/VC0MlmdDLNwuPzKBG6ZL2aZIC5qHwISC3JVFH5wSqy2YI73Pm4mSJog3A
         rav6Lrn4ZAZWX6C6aeuPK+kXFMrYtnfXdqX4BkwvaspWi18mUkzJ/usnTFcdeWiHJDcv
         ayUw==
X-Received: by 10.68.171.65 with SMTP id as1mr20204606pbc.33.1427314824534;
        Wed, 25 Mar 2015 13:20:24 -0700 (PDT)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id gm3sm3271798pbb.83.2015.03.25.13.20.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2015 13:20:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqzj7028mn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266297>



On 03/26/2015 12:43 AM, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +	if ((flags & LOOKUP_LITERALLY)) {
>> +		if (unpack_sha1_header_to_strbuf(&stream, map, mapsize, &hdrbuf) < 0)
>> +			status = error("unable to unpack %s header with --literally",
>> +				       sha1_to_hex(sha1));
>> +		else if ((status = parse_sha1_header_extended(hdrbuf.buf, oi, flags)) < 0)
>> +			status = error("unable to parse %s header", sha1_to_hex(sha1));
>> +	} else {
>> +		if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
>> +			status = error("unable to unpack %s header",
>> +				       sha1_to_hex(sha1));
>> +		else if ((status = parse_sha1_header_extended(hdr, oi, flags)) < 0)
>> +			status = error("unable to parse %s header", sha1_to_hex(sha1));
>> +	}
>
> I wonder if you can further reduce an unnecessary duplication in the
> two "else if" clauses in the above, and if the result becomes easier
> to read and maintain.  Perhaps
>
> 	if (((flags & LOOKUP_LITERALLY)
>               ? unpack_sha1_header_to_strbuf(...)
>               : unpack_sha1_header(...)) < 0)
> 		status = error(...);
> 	else if ((status = parse_sha1_header_extended(...)) < 0)
>          	status = error(...);
>
> or even
>
> 	status = 0;
> 	if (flags & LOOKUP_LITERALLY) {
> 		if (unpack_sha1_header_to_strbuf(...) < 0)
> 			status = error(...);
> 	} else {
> 		if (unpack_sha1_header(...) < 0)
> 			status = error(...);
> 	}
>          if (!status) {
>          	if (status = parse(...)) < 0)
> 	        	status = error(...);
> 	}
>
> although I think the latter might be a bit harder to read.
>

I hope you meant the former. The latter to me seems simpler as its a 
simple if else statement whereas the former has a ternary operator with 
function calls. I did think about this when writing the code, the 
problem is when flag == LOOKUP_LITERALLY, parse_sha1_header_extended() 
takes 'hdrbuf.buf' as first argument where as when flag != 
LOOKUP_LITERALLY, it takes 'hdr' as an argument. We could do this

status = 0;
char * hdrp;
if (flags & LOOKUP_LITERALLY) {
	if (unpack_sha1_header_to_strbuf(...) < 0)
		status = error(...);
	hdrp = hdrbuf.buf;
} else {
	if (unpack_sha1_header(...) < 0)
		status = error(...);
	hdrp = hdr;
}
if (!status)
	if (status = parse(hdrp, ...)) < 0)
		status = error(...);
}

But I think it just introduces another variable to keep track of, which 
I rather not have.
