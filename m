From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 1/4] sha1_file.c: support reading from a loose object
 of unknown type
Date: Tue, 21 Apr 2015 00:13:30 +0530
Message-ID: <553548D2.7010904@gmail.com>
References: <552E9816.6040502@gmail.com>	<1429117143-4882-1-git-send-email-karthik.188@gmail.com>	<xmqqmw29jg78.fsf@gitster.dls.corp.google.com>	<20150415221824.GB27566@peff.net> <20150417142310.GA12479@peff.net>	<xmqqd232hgj8.fsf@gitster.dls.corp.google.com>	<20150417205125.GA7067@peff.net> <xmqq4moepijp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 20 20:43:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkGfU-00039B-HT
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 20:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbbDTSng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 14:43:36 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35693 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbbDTSnf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 14:43:35 -0400
Received: by pabtp1 with SMTP id tp1so214877668pab.2
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 11:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=rVkLQUAoJjwTtP4BtZUYpkibMaIVnKQK/5Y4dbTVeSU=;
        b=vPrQJrt9V68HeCiEq2ldg7YFYKCy1Zp2cTyBZ9MmlZQacxcCa356Uk90S+sCjzMygG
         FxrrUQoKwETA154LXtPs3wtPJHi8oJNbZnpFoifCHO6qc8kwHY7IKusAdfbWIEE4Yn3d
         x4yq7jy7VdxOuvflRmdhk4pkFzV2Mo/UhAxBQ9AYVBrtrIbg6MGT1EbMVxnQOMvbwsEj
         T9Ur31Qy6PmJ6SyA/LRrURTgK3hubdfB7CJNuDbMPbVOefwVUYAZ0aANOPCNlDkhf2K/
         d5UK3MxyRUzWGB0GSD7O8KY0iQ5+TBYW3EAgGiJduWPjCEPOR08JH4Q+3DwHnBmgpAz7
         Jrrw==
X-Received: by 10.70.18.68 with SMTP id u4mr30765529pdd.38.1429555414592;
        Mon, 20 Apr 2015 11:43:34 -0700 (PDT)
Received: from [192.168.0.103] ([103.227.98.178])
        by mx.google.com with ESMTPSA id he9sm18872179pbc.7.2015.04.20.11.43.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2015 11:43:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqq4moepijp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267484>



On 04/18/2015 02:40 AM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Fri, Apr 17, 2015 at 09:21:31AM -0700, Junio C Hamano wrote:
>>
>>> Jeff King <peff@peff.net> writes:
>>>
>>>> If there _is_ a performance implication to worry about here, I think it
>>>> would be that we are doing an extra malloc/free.
>>>
>>> Thanks for reminding me; yes, that also worried me.
>>
>> As an aside, I worried about the extra allocation for reading the header
>> in the first place. But it looks like we only do this on the --literally
>> code path (and otherwise use the normal unpack_sha1_header).  Still, I
>> wonder if we could make this work automagically.  That is, speculatively
>> unpack the first N bytes, assuming we hit the end-of-header. If not,
>> then go to a strbuf as the slow path. Then it would be fine to cover all
>> cases; the normal ones would be fast, and only ridiculous things would
>> incur the extra allocation.
>
> Yes, that was what I was hoping to see eventually ;-)
>

Sorry for the delay, So after reading what Jeff said I tried to 
implement it, this might not be a final version of the change, more of a 
RFC version. What do you'll think?

@@ -1564,6 +1564,36 @@ int unpack_sha1_header(git_zstream *stream, 
unsigned char *map, unsigned long ma
         return git_inflate(stream, 0);
  }

+static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned 
char *map,
+                                       unsigned long mapsize, void *buffer,
+                                       unsigned long bufsiz, struct 
strbuf *header)
+{
+       unsigned char *cp;
+       int status;
+       int i = 0;
+
+       status = unpack_sha1_header(stream, map, mapsize, buffer, bufsiz);
+
+       for (cp = buffer; cp < stream->next_out; cp++)
+               if (!*cp) {
+                       /* Found the NUL at the end of the header */
+                       return 0;
+               }
+
+       strbuf_add(header, buffer, stream->next_out - (unsigned char 
*)buffer);
+       do {
+               status = git_inflate(stream, 0);
+               strbuf_add(header, buffer, stream->next_out - (unsigned 
char *)buffer);
+               for (cp = buffer; cp < stream->next_out; cp++)
+                       if (!*cp)
+                               /* Found the NUL at the end of the header */
+                               return 0;
+               stream->next_out = buffer;
+               stream->avail_out = bufsiz;
+       } while (status != Z_STREAM_END);
+       return -1;
+}
+


@@ -2555,17 +2610,24 @@ static int sha1_loose_object_info(const unsigned 
char *sha1,
                 return -1;
         if (oi->disk_sizep)
                 *oi->disk_sizep = mapsize;
-       if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
+       if ((flags & LOOKUP_LITERALLY)) {
+               if (unpack_sha1_header_to_strbuf(&stream, map, mapsize, 
hdr, sizeof(hdr), &hdrbuf) < 0)
+                       status = error("unable to unpack %s header with 
--literally",
+                                      sha1_to_hex(sha1));
+       } else if (unpack_sha1_header(&stream, map, mapsize, hdr, 
sizeof(hdr)) < 0)
                 status = error("unable to unpack %s header",
                                sha1_to_hex(sha1));
-       else if ((status = parse_sha1_header(hdr, &size)) < 0)
+       if (hdrbuf.len) {
+               if ((status = parse_sha1_header_extended(hdrbuf.buf, oi, 
flags)) < 0)
+                       status = error("unable to parse %s header with 
--literally",
+                                      sha1_to_hex(sha1));
+       } else if ((status = parse_sha1_header_extended(hdr, oi, flags)) 
< 0)
                 status = error("unable to parse %s header", 
sha1_to_hex(sha1));


and
