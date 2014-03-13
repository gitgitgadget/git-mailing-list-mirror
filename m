From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Re: [PATCH] implement submodule config cache for lookup of
 submodule names
Date: Wed, 12 Mar 2014 17:46:05 -0700
Message-ID: <20140313004605.GC15625@google.com>
References: <20140310212412.GA8693@sandbox-ub>
 <20140312022852.GA15625@google.com>
 <20140312235833.GA5300@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>, Jeff King <peff@peff.net>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 01:46:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNtmr-0006DN-2C
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 01:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbaCMAqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 20:46:10 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:39338 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbaCMAqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 20:46:09 -0400
Received: by mail-pd0-f172.google.com with SMTP id p10so296890pdj.3
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 17:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rEiZI/0oi9cLPpmLdVuZTm5AJhujn3/FAtaCxSWVQvg=;
        b=TtbLsJn2xgqXpTct6Zpnzf8WvXdtJGbQLIJ8Nc8oor4lvhfuzx/wQbE4A8OuEl7f6p
         hAwo6vqoYfvvibgFutWlzf/0PVyNyTJyY28P8Txy8Gu4Lj7m1Yua+yzjY9Mkg6aPcApt
         PJeX2bWzOS206XE+CGeXVcc5k5RaVVwZdVfLqcoWM0ahcjAwqPFUjIKla51U9gHzGFU0
         btM/VwPUqavPc9Aib45payooO1+5bOcWQvm6ZQm52pHbTFhdFbXYETfKoGfuBlCciTYm
         tFQsYv2UJBHgyA7fgckY6+X51Au37bYO5sZ5lAaVibl2xYH3/FjQa+daKBT7mARF+1XF
         vUcg==
X-Received: by 10.66.150.69 with SMTP id ug5mr577041pab.55.1394671568865;
        Wed, 12 Mar 2014 17:46:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id cz3sm1149571pbc.9.2014.03.12.17.46.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Mar 2014 17:46:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140312235833.GA5300@sandbox-ub>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244015>

Heiko Voigt wrote:
> On Tue, Mar 11, 2014 at 07:28:52PM -0700, Jonathan Nieder wrote:
>> Heiko Voigt wrote:

>>> +static unsigned int hash_sha1_string(const unsigned char *sha1, const char *string)
>>> +{
>>> +	return memhash(sha1, 20) + strhash(string);
>>> +}
>>
>> Feels a bit unconventional.  I can't find a strong reason to mind.
>
> Well I did not think much about this. I simply thought: hash -> kind of
> random value. Adding the two together is as good as anything (even
> overflow does not matter).
[...]
> I am fine with a switch to something different. We could use classic XOR
> in case that feels better.

Either + or ^ is fine with me (yeah, '^' is what I expected so '+'
forced me to think for a few seconds).  I don't think we have to worry
much about hostile people making repos that force git to spend a long
time dealing with hash collisions, so anything more complicated is
probably overkill. :)

[...]
>> [...]
>>> +static void warn_multiple_config(struct submodule_config *config, const char *option)
>>> +{
>>> +	warning("%s:.gitmodules, multiple configurations found for submodule.%s.%s. "
>>> +			"Skipping second one!", sha1_to_hex(config->gitmodule_sha1),
>>> +			option, config->name.buf);
>>
>> Ah, so gitmodule_sha1 is a commit id?
>
> No, this output is a bug. gitmodule_sha1 is actually the sha1 of the
> .gitmodule blob we read. Thanks for noticing will fix. Should I also add
> a comment to the gitmodule_sha1 field to explain what it is?
[...]
>                                                                   with
> the clarification does the name make sense now?

Yep.  Suggested fixes:

 - call it gitmodules_sha1 instead of gitmodule_sha1 (it's the blob
   name for .gitmodules, not the name of a module)

 - add a comment where the field is declared (this would make it clear
   that it's a blob name instead of e.g. just the SHA-1 of the text)

Thanks for your thoughtfulness.
Jonathan
