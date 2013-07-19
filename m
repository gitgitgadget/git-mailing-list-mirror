From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v6 2/4] config: improve support for http.<url>.* settings
Date: Fri, 19 Jul 2013 16:37:54 -0700
Message-ID: <2544648C-9660-48F0-888A-E78E31477A89@gmail.com>
References: <9a5e7ef2eb19b10b28f154b3d5e03cd@f74d39fa044aa309eaea14b9f57fe79> <2cca0770a1e8495ac1418834c57f23d@f74d39fa044aa309eaea14b9f57fe79> <7vehauuxqo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 01:38:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0KFS-0008JN-Nf
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 01:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021Ab3GSXiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 19:38:00 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:58011 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab3GSXh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 19:37:58 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so4991831pbc.1
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 16:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=7HxGEazufNUrUvE9BHiSSxej1+Q7h3lCYqQDSNlsZpE=;
        b=lvORZjweyBkESGPA5nSTQ02Io0XO2lmbk8UdNwFWvGRRLVTNTPWwkDE/Zg47TP4iAG
         OH1FGprWDTqmOfOY5AX4X9TcHvr1AvDzbyBTW896ewRxoncQxak7i4/VVDKWWx/VxNNr
         wUNutZ3q0bE+Jj/N+IKcB4+EYf2VlxE/jEWU+scImVCqqvvoYh9ipPsU631D2EtHsJNW
         x1r891WMs9xYA3e3nchXMjQNUM45tyT2VAfMM95wdk5MeOI27N7Ov37r6ag6SqVCuVI2
         qwDw1q3S7n3/Zq8oCgtoYYUT44nfPE7xdLWbbx5a6B3sMzF/0hft1WlSLTDaNzt+dcIJ
         Rf4A==
X-Received: by 10.66.145.34 with SMTP id sr2mr20580057pab.94.1374277078175;
        Fri, 19 Jul 2013 16:37:58 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ib9sm21735278pbc.43.2013.07.19.16.37.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 16:37:57 -0700 (PDT)
In-Reply-To: <7vehauuxqo.fsf@alter.siamese.dyndns.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230865>

On Jul 19, 2013, at 12:59, Junio C Hamano wrote:
> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> +#define URL_ALPHA  
>> "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
>> +#define URL_DIGIT "0123456789"
>> +#define URL_HEXDIGIT URL_DIGIT "ABCDEFabcdef"
>> +#define URL_ALPHADIGIT URL_ALPHA URL_DIGIT
>> +#define URL_SCHEME_CHARS URL_ALPHADIGIT "+.-"
>> +#define URL_HOST_CHARS URL_ALPHADIGIT ".-[:]" /* IPv6 literals  
>> need [:] */
>> +#define URL_UNSAFE_CHARS " <>\"%{}|\\^`" /* plus 0x00-0x1F, 
>> 0x7F-0xFF */
>> +#define URL_GEN_RESERVED ":/?#[]@"
>> +#define URL_SUB_RESERVED "!$&'()*+,;="
>> +#define URL_RESERVED URL_GEN_RESERVED URL_SUB_RESERVED /* only  
>> allowed delims */
>> + ...
>> +	while (from_len) {
>> +		int ch = *from++;
>> +		int was_esc = 0;
>> +
>> +		from_len--;
>> +		if (ch == '%') {
>> +			if (from_len < 2 ||
>> +			    !strchr(URL_HEXDIGIT, from[0]) ||
>> +			    !strchr(URL_HEXDIGIT, from[1]))
>
> I actually do like the readability of the approach in this patch,
> but these repeated strchrs() in a loop may want to be optimized,
> using a trick similar to what is used in ctype.c::sane_ctype[].
>
> A small build-time-only program or script gen-http-ctype.perl that
> defines and uses these URL_* cpp macros and generates a C source
> file http-ctype-gen.c that can be #included from http.c, with
> something like this in the Makefile:
>
> 	http-ctype-gen.c: gen-http-ctype.perl
> 		rm -f $@ $@+
>                $(PERL_PATH) gen-http-ctype.perl >$@+
>                mv $@+ $@
> 	http.o: http.c http-ctype-gen.c
>
> would give us both readability and efficiency, perhaps?

Hmmm.  That's a very fast technique.  However something like:

#define IS_HEX_DIGIT(c) \
   (('0'<=(c)&&(c)<='9')||('a'<=(c)&&(c)<='f')||('A'<=(c)&&(c)<='F'))

I would think would be suitably fast without needing any added build  
files.

However, looks like there is a ctype.h isxdigit() function and it  
looks like there's a version of that in git-compat-util.h as well as a  
convenient hexval_table to use for the conversion, so I will alter the  
code to use those instead which will also do away with the  
hex_digit_value() function.

If you mean for all the strchr etc. calls, multiple tables would be  
required since URL_SCHEME_CHARS and URL_HOST_CHARS partially overlap,  
but it could be done.  Is the speed of strchr that much of a concern?   
The code will only be invoked for http.<url>.* option settings in any  
case and I expect the user would have to set an awfully large number  
of those to even begin to notice.
