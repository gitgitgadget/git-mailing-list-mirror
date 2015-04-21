From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 1/4] sha1_file.c: support reading from a loose object
 of unknown type
Date: Tue, 21 Apr 2015 16:56:08 +0530
Message-ID: <553633D0.9020804@gmail.com>
References: <552E9816.6040502@gmail.com> <1429117143-4882-1-git-send-email-karthik.188@gmail.com> <xmqqmw29jg78.fsf@gitster.dls.corp.google.com> <20150415221824.GB27566@peff.net> <20150417142310.GA12479@peff.net> <xmqqd232hgj8.fsf@gitster.dls.corp.google.com> <20150417205125.GA7067@peff.net> <xmqq4moepijp.fsf@gitster.dls.corp.google.com> <553548D2.7010904@gmail.com> <20150420185122.GA13718@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 21 13:26:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkWJm-0007dS-Ng
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 13:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbbDUL0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 07:26:13 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35481 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbbDUL0M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 07:26:12 -0400
Received: by pabtp1 with SMTP id tp1so238294209pab.2
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 04:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Qz94yEpGa0R0MqRrGoCKs7T4Q51aBxogGfVQOp0ENKI=;
        b=bJT4Td/cpprBpZyi+wMWfJBendMO7ttELp38FmSs6F2oybfQ+LT3s2HBknCXgnd7Ub
         1IJmmWrYL0sc9QAnCSoQgejB1PYp5hBWhUbnsj6oC+P+XF1wp+Va/VtqRNEBJgkX7LbC
         8ggJj2PnYkP7WGIInalLnN652uzE8NupBCKh4Uo+V7acR5+wXQ8LbgP+Q65ToPajI3RE
         GoMb4+pqQV8WjX7Ef1Hmlgs0ZYcN41Qc+D2GHXAghqBxlSkSFWNRrexcomdIT2Rz/d0q
         /3B008EUQI50s55yZA95D48pZf9TVXGkU72XPtK+wZkAsnI1YBokia8G9vzpC0N8/eAD
         4xXQ==
X-Received: by 10.66.119.161 with SMTP id kv1mr4265362pab.78.1429615572246;
        Tue, 21 Apr 2015 04:26:12 -0700 (PDT)
Received: from [192.168.0.103] ([103.227.98.178])
        by mx.google.com with ESMTPSA id l14sm1770269pdn.96.2015.04.21.04.26.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2015 04:26:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <20150420185122.GA13718@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267524>



On 04/21/2015 12:21 AM, Jeff King wrote:
> On Tue, Apr 21, 2015 at 12:13:30AM +0530, karthik nayak wrote:
>
>> +static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char
>> *map,
>> +                                       unsigned long mapsize, void *buffer,
>> +                                       unsigned long bufsiz, struct strbuf
>> *header)
>> +{
>> +       unsigned char *cp;
>> +       int status;
>> +       int i = 0;
>> +
>> +       status = unpack_sha1_header(stream, map, mapsize, buffer, bufsiz);
>
> I wonder if we would feel comfortable just running this NUL-check as
> part of unpack_sha1_header (i.e., in all code paths). It _shouldn't_
> trigger in normal use, but I wonder if there would be any downsides
> (e.g., maliciously crafted objects getting us to allocate memory or
> something; I think it is fairly easy to convince git to allocate memory,
> though).
>
But why would we want it to be a part of unpack_sha1_header?

>> +       for (cp = buffer; cp < stream->next_out; cp++)
>> +               if (!*cp) {
>> +                       /* Found the NUL at the end of the header */
>> +                       return 0;
>> +               }
>
> I think we can spell this as:
>
>    if (memchr(buffer, '\0', stream->next_out - buffer))
> 	return 0;
>
> which is shorter and possibly more efficient.
Noted. Thanks :)
>
> In theory we could also just start trying to parse the type/size header,
> and notice there when we don't find the NUL. That's probably not worth
> doing, though. The parsing is separated from the unpacking here, so it
> would require combining those two operations in a single function. And
> the extra NUL search here is likely not very expensive.
>
Yes, even I though about doing that, but wasn't keen on combining those 
two functions, they're meant to do two different things.
> -Peff
>
