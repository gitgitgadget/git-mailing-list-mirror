From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] utf8.c: print warning about iconv errors
Date: Mon, 17 Aug 2015 12:49:05 -0700
Message-ID: <xmqqbne5d7bi.fsf@gitster.dls.corp.google.com>
References: <1433624551-20730-1-git-send-email-max@max630.net>
	<1439589334-32318-1-git-send-email-max@max630.net>
	<xmqqvbchfqgh.fsf@gitster.dls.corp.google.com>
	<20150817190238.GA3594@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:49:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRQPE-0006xl-6h
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 21:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbbHQTtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 15:49:10 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36299 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbbHQTtH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 15:49:07 -0400
Received: by pawq9 with SMTP id q9so17352409paw.3
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 12:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gfLGzWxx+Tj5DaYcCLgjLiW0gry/EweYneakqExt7jM=;
        b=yMpQTeHbMKB+4G9ozBIvd3895sAKTSuKjMPTYR5FdZ1dMQIBBpsZjbf+X6KqMKhZyb
         W3jjZFCIfKlAJvbg5HjrSjAes71znWxp4kwann19MawelHpszWg9tt9BN7Ew1dgaoF/r
         o78o1Af40Qgwlj+evvhRUC0dQA9bfspoNerZn35e6gq8EmRSxUUe/S87m/WeCST3Bby9
         bqFgAU0SsGdxmC97X+0czXLxSJH9DUDFmDB5YO6Z8xfWAk6m3iuqR89OWGc4nIapNmgu
         /FLZSpj6GwDOFLurDkruin1ZWi2SobA3uTINWyh2LKSg0Sr28TnRwyGAGdCGa8akMBMq
         /U/w==
X-Received: by 10.68.181.34 with SMTP id dt2mr5597273pbc.7.1439840946612;
        Mon, 17 Aug 2015 12:49:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id fy3sm15681893pac.37.2015.08.17.12.49.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 12:49:05 -0700 (PDT)
In-Reply-To: <20150817190238.GA3594@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 17 Aug 2015 15:02:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276084>

Jeff King <peff@peff.net> writes:

> On Fri, Aug 14, 2015 at 03:35:58PM -0700, Junio C Hamano wrote:
>
>> Max Kirillov <max@max630.net> writes:
>> 
>> > * do not limit number of warnings - does not worth complicating the code
>> 
>> Unless the warning leads to a quick "die()", wouldn't this make Git
>> unusable by spewing a "falling back to verbatim copy" for each and
>> every line of the message of a commit that has 'encoding' element in
>> its header in the "git log" output, no?
>
> We only do the reencode once per commit. So it would be once per commit
> rather than once per line. Which still sounds kind of annoying, if you
> are using "git log --oneline" or similar.
>
> I think I'd favor a single warning in general, along the lines of
> "some encodings could not be converted". But of course if you are trying
> to figure out _which_ encodings your system doesn't have, that's not
> very helpful. Maybe we could have an advice.encodingFailure config flag
> with a tristate:
>
>   - false: don't spew any warnings
>
>   - true: give a generic warning once per program
>
>   - all: give a specific warning for each case, like "unable to convert
>     EUC-JP to UTF-8: iconv_open: Invalid argument". (Sadly EINVAL is
>     what iconv_open seems to return when you it doesn't know about a
>     particular encoding; it may be nicer to translate to something more
>     reasonable than what strerror() provides).

Sounds sensible.

>> > +char *reencode_string_len(const char *in, int insz,
>> > +			  const char *out_encoding, const char *in_encoding,
>> > +			  int *outsz)
>> > +{
>> > +	if (!same_encoding(in_encoding, out_encoding))
>> > + warning("Iconv support is disabled at compile time. It is likely
>> > that\nincorrect data will be printed or stored in
>> > repository.\nConsider using other build for this task.");
>> > +	return NULL;
>> > +}
>> 
>> Hmmm, I suspect this may be seen as regression by those who build
>> Git without ICONV for performance, knowing that there is nothing in
>> their data that requires character set conversion.
>
> I don't think it matters that much.

Yeah, I think I agree.  Thanks.
