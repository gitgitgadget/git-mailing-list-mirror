From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] parse-options: allow git commands to invent new
 option types
Date: Sun, 28 Nov 2010 22:03:54 -0600
Message-ID: <20101129040354.GA30187@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
 <20101022064258.GB6081@burratino>
 <7v8w1qnkr1.fsf@alter.siamese.dyndns.org>
 <20101024072032.GA23455@burratino>
 <20101024081316.GA29630@burratino>
 <20101024081507.GB29630@burratino>
 <4CC55C67.8080908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 05:19:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMvD1-00043Y-V3
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 05:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778Ab0K2ETS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 23:19:18 -0500
Received: from mail-yw0-f66.google.com ([209.85.213.66]:59293 "EHLO
	mail-yw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730Ab0K2ETR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 23:19:17 -0500
Received: by ywi6 with SMTP id 6so3867577ywi.1
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 20:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=l0RTMXfnCtl9YHf+9lPyGWKchf2s2f99W2yIAwsaIzM=;
        b=NbwFpygUBWHck0goGszFLqTFx19k6CUnuUkjLwp1Hs3EkhNQwfl0ObAFl3fzKHXyo0
         6yb83KCWCQGMY0hMED5hnk74x448kCWLiJrR+UNevZdlUGVFZaZey49TDlrweEmL61UW
         PnZ5YO9xpubUh3V+KEWKsPDniOG3IU69PbLEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PAG1y9eeya+YvdL+3aj/aH/+meRKyQKiayefcG324yXYxiQMkiZOVt21ql942itW8q
         vJENzhTJzwKysq/rlKV1GcXbh3vzW4KMf1k4s04n/FY6i0xIo+wiKL/VPJYqmj3JIgIr
         Cqg75aBpCPELwo7a+9s673VS9wPcoOQUTD2MU=
Received: by 10.150.144.16 with SMTP id r16mr9456903ybd.204.1291003442936;
        Sun, 28 Nov 2010 20:04:02 -0800 (PST)
Received: from burratino ([68.255.109.73])
        by mx.google.com with ESMTPS id f2sm3527260ybh.17.2010.11.28.20.04.00
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 20:04:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CC55C67.8080908@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162374>

Stephen Boyd wrote:

> Is there an actual use case where someone needs to completely override
> get_value()? If you move this into the case statement then we get the
> generic error checking of get_value() with the benefits of being able to
> modify the context within a callback.

Yes, I like this idea.

> We could also probably use the
> return value of the low level callback to indicate whether or not to
> take some action after parsing the option. Perhaps something like
> quiting the option parsing loop when encountering such an option?

I'd rather not, since that would involve anticipating needs in advance.
This is meant to be a back door for ugly and unusual option types that
the mainstream API does not take care of yet.  It seems best to allow
arbitrary effects.

[...]
>> -#define OPT_SHORT 1
>> -#define OPT_UNSET 2
[...]
>> +++ b/parse-options.h
>> @@ -40,8 +41,16 @@ enum parse_opt_option_flags {
>>  	PARSE_OPT_SHELL_EVAL = 256
>>  };
>>  
>> +enum parse_opt_ll_flags {
>> +	OPT_SHORT = 1,
>> +	OPT_UNSET = 2
>> +};
>> +
>
> I hope this isn't necessary.

Because of namespace or something else?

> This reminds me, we can probably simplify that "takes no value" error
> path in get_value() (see below).

Nice.

Thanks,
Jonathan
