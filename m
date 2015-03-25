From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 1/2] sha1_file.c: support reading from a loose object
 of unknown type
Date: Thu, 26 Mar 2015 01:52:31 +0530
Message-ID: <55131907.8@gmail.com>
References: <5512618B.2060402@gmail.com>	<1427268105-16901-1-git-send-email-karthik.188@gmail.com> <xmqqvbho27ym.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 21:22:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yarp1-0002lR-V7
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 21:22:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbbCYUWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 16:22:35 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33196 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753214AbbCYUWe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 16:22:34 -0400
Received: by pdnc3 with SMTP id c3so39396497pdn.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 13:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=t3Q1yQ2M0P1HZJNJ3iNiietEWMO+gINokitQXYozXAM=;
        b=rliGcvaAFAjABM8TD7Z9jhbq0hrVhj2M0gZKMlFEk1lezqQyfgp3jfByp94e55l0oj
         /GDjSu2bnfZGgZUqVj9mS/5HOvpykxb/TqWwsK1u/xLW8iAgwjNj+N2d/PKkZpzGC7S2
         tpnpbrttmusl8T0MkGhILohwyzcg6ivryATYmvq46KgUDZlEHEeOdqY+gF3G3CfGFwt/
         jrk0tIvYH1HEOHOXam2idfMUdQrkdzkgByr2NzECFlybMQw2xf1g+k+CMOXHWn9uQ1Qw
         9RBgP7cfbOznS8vdnwe+XPvBJWaVRSeGYpVIjdX7WOVBZK855i01AbRT4bEsaK9uY1MF
         WlMw==
X-Received: by 10.68.110.37 with SMTP id hx5mr20493456pbb.46.1427314954382;
        Wed, 25 Mar 2015 13:22:34 -0700 (PDT)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id oq7sm3330332pac.32.2015.03.25.13.22.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2015 13:22:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqvbho27ym.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266298>



On 03/26/2015 12:57 AM, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
>> +					unsigned long mapsize,
>> +					struct strbuf *header)
>> +{
>> +	unsigned char buffer[32], *cp;
>> +	unsigned long bufsiz = sizeof(buffer);
>> +	int status;
>> +
>> +	status = unpack_sha1_header(stream, map, mapsize, buffer, bufsiz);
>> +
>> +	if (status) {
>> +		strbuf_add(header, buffer, stream->next_out - buffer);
>> +		return status;
>> +	}
>> +
>> +	do {
>> +		status = git_inflate(stream, 0);
>> +		strbuf_add(header, buffer, stream->next_out - buffer);
>> +		for (cp = buffer; cp < stream->next_out; cp++)
>> +			if (!*cp)
>> +				/* Found the NUL at the end of the header */
>> +				return 0;
>> +		stream->next_out = buffer;
>> +		stream->avail_out = bufsiz;
>> +	} while (status == Z_OK);
>> +	return -1;
>
> A caller of unpack_sha1_header() gets the return from git_inflate();
> I wonder if we should be returning "status" here for consistency,
> perhaps?
>
Although the caller only checks for negative values for failure. For 
consistency it would be better to return status as unpack_sha1_header() 
does.
