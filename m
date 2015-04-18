From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 1/4] sha1_file.c: support reading from a loose object
 of unknown type
Date: Sat, 18 Apr 2015 14:33:06 +0530
Message-ID: <55321DCA.8030801@gmail.com>
References: <552E9816.6040502@gmail.com>	<1429117143-4882-1-git-send-email-karthik.188@gmail.com> <CAPig+cSiYsF6ioi+-P_BP=1bs-EAtNdAGjSqw6KmZyE39rKWBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 11:03:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjOej-0006UZ-JE
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 11:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbbDRJDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2015 05:03:13 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35861 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbbDRJDL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 05:03:11 -0400
Received: by pdea3 with SMTP id a3so152557354pde.3
        for <git@vger.kernel.org>; Sat, 18 Apr 2015 02:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=KguOAdQhX0NEr2QDRu/K3Exp+TzZwaWqYGQ0q7G/IkQ=;
        b=VMtHbzQm9CMO7Ok2qSMr2i64Lc7Lgp6wEnZi5VWnkd0fZX9zxpVxwlYrs7nD5xjbSl
         Q2Llddz/JraaK+XglbpdRszLl4daHB9dkqoKim7Oqj3gbf8W3Sw32Lil2yXTj0XZ/y0s
         pxwO8cCqOXnerolYmV6h5YEbJK5sOMpspGBvm70tE98i0GCZjOCyt/0F0wXPHF4/IXde
         uvCi96Gm8Y0aMnW3qXEvzMv/XnMnQZcw5yPvOBh7cckYEg8iSfM7Keo+SOjTRk6gTLgk
         iIBizfNdGLG5WdRkLy9rMq+O+pBZvbMOMXgXN7LtYpVUkfAvUVUcLgBXlJRXmCu+nvM7
         6sgQ==
X-Received: by 10.68.132.169 with SMTP id ov9mr12074556pbb.109.1429347791273;
        Sat, 18 Apr 2015 02:03:11 -0700 (PDT)
Received: from [192.168.0.100] ([103.227.98.178])
        by mx.google.com with ESMTPSA id w6sm12298653pbt.60.2015.04.18.02.03.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Apr 2015 02:03:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAPig+cSiYsF6ioi+-P_BP=1bs-EAtNdAGjSqw6KmZyE39rKWBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267412>



On 04/18/2015 05:01 AM, Eric Sunshine wrote:
> On Wed, Apr 15, 2015 at 12:59 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Update sha1_loose_object_info() to optionally allow it to read
>> from a loose object file of unknown/bogus type; as the function
>> usually returns the type of the object it read in the form of enum
>> for known types, add an optional "typename" field to receive the
>> name of the type in textual form and a flag to indicate the reading
>> of a loose object file of unknown/bogus type.
>> [...]
>> ---
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 980ce6b..267399d 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -2522,13 +2575,15 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
>>   }
>>
>>   static int sha1_loose_object_info(const unsigned char *sha1,
>> -                                 struct object_info *oi)
>> +                                 struct object_info *oi,
>> +                                 int flags)
>>   {
>> -       int status;
>> -       unsigned long mapsize, size;
>> +       int status = 0;
>> +       unsigned long mapsize;
>>          void *map;
>>          git_zstream stream;
>>          char hdr[32];
>> +       struct strbuf hdrbuf = STRBUF_INIT;
>>
>>          if (oi->delta_base_sha1)
>>                  hashclr(oi->delta_base_sha1);
>> @@ -2555,17 +2610,26 @@ static int sha1_loose_object_info(const unsigned char *sha1,
>>                  return -1;
>>          if (oi->disk_sizep)
>>                  *oi->disk_sizep = mapsize;
>> -       if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
>> -               status = error("unable to unpack %s header",
>> -                              sha1_to_hex(sha1));
>> -       else if ((status = parse_sha1_header(hdr, &size)) < 0)
>> -               status = error("unable to parse %s header", sha1_to_hex(sha1));
>> -       else if (oi->sizep)
>> -               *oi->sizep = size;
>> +       if ((flags & LOOKUP_LITERALLY)) {
>> +               if (unpack_sha1_header_to_strbuf(&stream, map, mapsize, &hdrbuf) < 0)
>> +                       status = error("unable to unpack %s header with --literally",
>> +                                      sha1_to_hex(sha1));
>> +               else if ((status = parse_sha1_header_extended(hdrbuf.buf, oi, flags)) < 0)
>> +                       status = error("unable to parse %s header with --literally",
>> +                                      sha1_to_hex(sha1));
>> +       } else {
>> +               if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
>> +                       status = error("unable to unpack %s header",
>> +                                      sha1_to_hex(sha1));
>> +               else if ((status = parse_sha1_header_extended(hdr, oi, flags)) < 0)
>> +                       status = error("unable to parse %s header", sha1_to_hex(sha1));
>> +       }
>>          git_inflate_end(&stream);
>>          munmap(map, mapsize);
>> -       if (oi->typep)
>> +       if (status && oi->typep)
>>                  *oi->typep = status;
>> +       if (hdrbuf.buf)
>> +               strbuf_release(&hdrbuf);
>
> Why is strbuf_release() protected by a conditional rather than being
> called unconditionally? Am I missing something obvious?
No, you're right.
>
>>          return 0;
>>   }
>>
