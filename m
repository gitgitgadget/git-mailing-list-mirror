From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 2/2] sha1_file: refactor sha1_file.c to support 'cat-file
 --literally'
Date: Thu, 19 Mar 2015 01:05:08 +0530
Message-ID: <5509D36C.6000908@gmail.com>
References: <5507B7EE.1070403@gmail.com>	<1426569419-8266-1-git-send-email-karthik.188@gmail.com> <xmqqbnjro05k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 20:35:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYJkP-00055k-Hm
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 20:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211AbbCRTfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 15:35:15 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36407 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755041AbbCRTfM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 15:35:12 -0400
Received: by pdbcz9 with SMTP id cz9so51905085pdb.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 12:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=sJ+xzU6j3KXjiTMQz8Ga5C1j5+uZbjgRnYLJVs0Jr8M=;
        b=p+Tsk3SkwhWVV08hHCMVoNMLcBH1fsupCsGswexBGC0jUAwMcxGPx1PTwyIs27aPHB
         A+USJNR63DEz4b1qwDwmMMDLjWMznKssbarrEXqFt+qDvUgKhy3/0fHtSYo4h8Pr9tcp
         0zkXLB11gPFIPuiaMjrjMZ6M30ODCP3VqjRISCNp/fL1H+wgwcqFrZ/ogjY9NjhdKpyD
         uIZ9TMgVZ3gtl+0SuCeM0vZ+5Tqpbt5dbTKTf/O53qbj5WQ+I51WaYWlmlesuYUociW0
         fOG3qDFoZh7YPJ+m1/5pDIAE22Aphk4HpqCjlDmIQCvZ/6yo6zELbDIYLzRHcj4QWocq
         W3MA==
X-Received: by 10.70.44.100 with SMTP id d4mr165577812pdm.36.1426707311828;
        Wed, 18 Mar 2015 12:35:11 -0700 (PDT)
Received: from [192.168.0.103] ([103.227.98.178])
        by mx.google.com with ESMTPSA id fm3sm10633094pdb.73.2015.03.18.12.35.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 12:35:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqbnjro05k.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265752>



On 03/18/2015 01:40 AM, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Subject: Re: [PATCH v4 2/2] sha1_file: refactor sha1_file.c to support 'cat-file --literally'
>
>> Modify sha1_loose_object_info() to support 'cat-file --literally'
>> by accepting flags and also make changes to copy the type to
>> object_info::typename.
>
> It would be more descriptive to mention the central point on the
> title regarding what it takes to "support cat-file --literally".
>
> For example:
>
>    sha1_file.c: support reading from a loose object of a bogus type
>
>    Update sha1_loose_object_info() to optionally allow it to read
>    from a loose object file of unknown/bogus type; as the function
>    usually returns the type of the object it read in the form of enum
>    for known types, add an optional "typename" field to receive the
>    name of the type in textual form.
>
> By the way, I think your 1/2 would not even compile unless you have
> this change; the patches in these two patch series must be swapped,
> no?
>
Noted. Yes it wouldn't. I thought both would be applied together and 
didn't give it much thought, but yeah, I should pay more attention to that.
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 69a60ec..e31e9e2 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -1564,6 +1564,36 @@ int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long ma
>>   	return git_inflate(stream, 0);
>>   }
>>
>> +static int unpack_sha1_header_literally(git_zstream *stream, unsigned char *map,
>> +					unsigned long mapsize,
>> +					struct strbuf *header)
>> +{
>> +	unsigned char buffer[32], *cp;
>> +	unsigned long bufsiz = sizeof(buffer);
>> +	int status;
>> +
>> +	/* Get the data stream */
>> +	memset(stream, 0, sizeof(*stream));
>> +	stream->next_in = map;
>> +	stream->avail_in = mapsize;
>> +	stream->next_out = buffer;
>> +	stream->avail_out = bufsiz;
>> +
>> +	git_inflate_init(stream);
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
>> +}
>> +
>
> There is nothing "literal" about this function.
>
> The only difference between the original and this one is that this
> uses a strbuf, instead of a buffer of a fixed size allocated by the
> caller, to return the early part of the inflated data.
>
> I wonder if it incurs too much overhead to the existing callers if
> you reimplementated unpack_sha1_header() as a thin wrapper around
> this function, something like
>
> 	int unpack_sha1_header(git_zstream *stream,
> 				unsigned char *map, unsigned long mapsize,
>                                  void *buffer, unsigned long bufsiz)
> 	{
>                  int status;
> 		struct strbuf header = STRBUF_INIT;
>
>                  status = unpack_sha1_header_to_strbuf(stream, map, mapsize, &header);
> 		if (bufsiz < header.len)
>                  	die("object header too long");
> 		memcpy(buffer, header.buf, header.len);
>                  return status;
> 	}
>      			
> Note that I am *not* suggesting to do this blindly.  If there is no
> downside from performance point of view, however, the above would be
> a way to avoid code duplication.
>
> Another way to avoid code duplication may be to implement
> unpack_sha1_header_to_strbuf() in terms of unpack_sha1_header(),
> perhaps like this:
>
> 	static int unpack_sha1_header_to_strbuf(...)
>          {
> 		unsigned char buffer[32], *cp;
>                  unsigned long bufsiz = sizeof(buffer);
>          	int status = unpack_sha1_header(stream, map, mapsize, buffer, bufsiz);
>
> 		if (status)
>                  	return status;
> 		do {
> 			strbuf_add(header, buffer, stream->next_out - buffer);
> 			for (cp = buffer; cp < stream->next_out; cp++)
> 				if (!*cp)
> 					/* Found the NUL at the end of the header */
> 					return 0;
> 			stream->next_out = buffer;
> 			stream->avail_out = bufsiz;
> 		} while (status == Z_OK);
> 		return -1;
> 	}
>
> which may be more in line with how we read data from loose objects.

Agreed there is code duplication with unpack_sha1_header() and 
unpack_sha1_header_extended(). But I thought there would be a 
performance trade off, Any way I could test this?
Also the second suggestion you have given seems to be more practical, As 
there is no performance overhead, if called by existing code.
>
>> +int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
>> +			       int flags)
>
> Unless we are taking advantage of the fact that MSB is special in
> signed integral types, I would prefer to see us use an unsigned type
> to store these bits in a variable of an integral type.  That would
> let the readers assume that they have fewer tricky things possibly
> going on in the code (also see the footnote to $gmane/263751).

Thanks for the link. Will change to unsigned.
>
>> @@ -1652,12 +1674,45 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
>>   			size = size * 10 + c;
>>   		}
>>   	}
>> -	*sizep = size;
>> +
>> +	type = type_from_string_gently(typename.buf, -1, 1);
>
> Doesn't the code know how long the typename is at this point?
Yes, will change.
>
>> +	if (oi->sizep)
>> +		*oi->sizep = size;
>> +	if (oi->typename)
>> +		strbuf_addstr(oi->typename, typename.buf);
>
> Likewise.  Perhaps strbuf_addbuf()?
That also calls strbuf_add(). But does improve readability
>
>> +	if (oi->typep)
>> +		*oi->typep = type;
>
> Do you want to store -1 to *oi->typep when the caller asked to do
> the "literally" thing?  Shouldn't it match what is returned from
> this function?
Yes it should. Will make changes.
>
>> +	return *hdr ? -1 : type;
>> +}
>> +
>> +/*
>> + * We used to just use "sscanf()", but that's actually way
>> + * too permissive for what we want to check. So do an anal
>> + * object header parse by hand. Calls the extended function.
>> + */
>
> The comment "let's do better than sscanf() by parsing ourselves"
> applies to the implementation of _extended() function, not this one,
> no?  It is clear to everybody that it "Calls the extended function",
> so why mention it?
>
>> +int parse_sha1_header(const char *hdr, unsigned long *sizep)
>> +{
>> +	struct object_info oi;
>> +
>> +	oi.sizep = sizep;
>> +	oi.typename = NULL;
>> +	oi.typep = NULL;
>> +	return parse_sha1_header_extended(hdr, &oi, LOOKUP_REPLACE_OBJECT);
>>   }
>
>> @@ -2524,13 +2579,15 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
>>   }
>>
>>   static int sha1_loose_object_info(const unsigned char *sha1,
>> -				  struct object_info *oi)
>> +				  struct object_info *oi,
>> +				  int flags)
>>   {
>> -	int status;
>> +	int status = 0;
>>   	unsigned long mapsize, size;
>>   	void *map;
>>   	git_zstream stream;
>>   	char hdr[32];
>> +	struct strbuf hdrbuf = STRBUF_INIT;
>>
>>   	if (oi->delta_base_sha1)
>>   		hashclr(oi->delta_base_sha1);
>> @@ -2557,17 +2614,29 @@ static int sha1_loose_object_info(const unsigned char *sha1,
>>   		return -1;
>>   	if (oi->disk_sizep)
>>   		*oi->disk_sizep = mapsize;
>> -	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
>> -		status = error("unable to unpack %s header",
>> -			       sha1_to_hex(sha1));
>> -	else if ((status = parse_sha1_header(hdr, &size)) < 0)
>> -		status = error("unable to parse %s header", sha1_to_hex(sha1));
>> -	else if (oi->sizep)
>> +	if ((flags & LOOKUP_LITERALLY)) {
>> +		if (unpack_sha1_header_literally(&stream, map, mapsize, &hdrbuf) < 0)
>> +			status = error("unable to unpack %s header with --literally",
>> +				       sha1_to_hex(sha1));
>> +		else if ((status = parse_sha1_header_extended(hdrbuf.buf, oi, flags)) < 0)
>> +			status = error("unable to parse %s header", sha1_to_hex(sha1));
>> +	} else {
>> +		if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
>> +			status = error("unable to unpack %s header",
>> +				       sha1_to_hex(sha1));
>> +		else if ((status = parse_sha1_header(hdr, &size)) < 0)
>> +			status = error("unable to parse %s header", sha1_to_hex(sha1));
>> +	}
>> +	if (oi->sizep)
>>   		*oi->sizep = size;
>
> Have you considered calling parse_sha1_header_extended() for both
> literally and normal cases?  Then you wouldn't have to do any of the
> "if (oi->blah) *oi->blah = value", no?
>
>>   	git_inflate_end(&stream);
>>   	munmap(map, mapsize);
>>   	if (oi->typep)
>>   		*oi->typep = status;
>
> Likewise.
>
>> +	if (oi->typename && !(oi->typename->len))
>> +		strbuf_addstr(oi->typename, typename(status));
>
> Likewise.
>

No. I have not considered that. will look into this.
Thanks for the suggestions.

Regards
-Karthik
