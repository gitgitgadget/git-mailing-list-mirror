From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/8] compat: make gcc bswap an inline function
Date: Wed, 16 Mar 2011 04:31:08 -0500
Message-ID: <20110316093108.GB7886@elie>
References: <20110316024959.GA24932@elie>
 <20110316065256.GA5988@elie>
 <20110316070049.GC5988@elie>
 <4D808126.8070706@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 10:31:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzn4Z-00006R-Rn
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 10:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270Ab1CPJbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 05:31:15 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49935 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab1CPJbN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 05:31:13 -0400
Received: by ywj3 with SMTP id 3so577638ywj.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 02:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=M0B7eON6F408hEWvEFWVqtOeieXdh09o6MecrBXJFcc=;
        b=BLDbakI0wM383vQitnjURGugG1WqRxsb9LbGOjQGt+tHunV4J1B0hU4X3zJO8ASkbk
         Yd+FcYvtYohZ885qsXOG6/ziNJNqdgY0Tzzri9Odv721PFuOFql6nSPNPfzvIuEu08jb
         6R2weXzHYXk77F7z+VrfRBWU4SMLLEk0YwkOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NzD4fjQ31mj7oAEGjezdTsmOysrtKC+aZpbHCg0xNzHp6xR/9RfyZGxzzHjoNLxcB6
         evMbTN/gE05ZXFAa0puxMA2cMFCwfmZ/MpoajlYaouxHEQBsdkCY+UzCJ7z1L0ex8f3G
         HDkJX9yNj9Hls36BzUgslBLsNX9TCt7RjLxmI=
Received: by 10.236.25.194 with SMTP id z42mr447790yhz.312.1300267873172;
        Wed, 16 Mar 2011 02:31:13 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id x37sm501624yhn.3.2011.03.16.02.31.11
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 02:31:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D808126.8070706@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169127>

Johannes Sixt wrote:
> Am 3/16/2011 8:00, schrieb Jonathan Nieder:

>> +static inline uint32_t git_bswap32(uint32_t x)
>> +{
>> +	uint32_t result;
>> +	if (__builtin_constant_p(x))
>
> Can this predicate ever be true? Isn't it false even if the function is
> inlined?

It's true if x is a constant.

$ cat test.c
#if 0
gcc -Wall -W -O -o tryit "$0"
exec ./tryit
#else
#include <stdio.h>
#include <stdint.h>

#ifdef __GNUC__
static inline int constant(uint32_t x)
{
	return __builtin_constant_p(x);
}
#else
static inline int constant(uint32_t x) { return 0; }
#endif

int main(void)
{
	printf("%d\n", constant(3 + 5));
	return 0;
}
#endif
$ ./test.c
1
