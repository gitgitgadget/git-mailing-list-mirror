From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] diff: avoid stack-buffer-read-overrun for very long name
Date: Fri, 27 Apr 2012 14:55:10 +0200
Message-ID: <4F9A972E.7050401@op5.se>
References: <87ty0jbt5p.fsf@rho.meyering.net> <20120416222713.GA2396@moj> <87397t862o.fsf@rho.meyering.net> <xmqq1unbd2m5.fsf@junio.mtv.corp.google.com> <87d36uxzfw.fsf@rho.meyering.net> <xmqq62cma2uo.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jim Meyering <jim@meyering.net>, Marcus Karlsson <mk@acc.umu.se>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 14:55:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNkho-0007bv-6I
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 14:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758969Ab2D0MzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 08:55:18 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:43790 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758539Ab2D0MzQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Apr 2012 08:55:16 -0400
Received: by lahj13 with SMTP id j13so461017lah.19
        for <git@vger.kernel.org>; Fri, 27 Apr 2012 05:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=UHDyikAnOKYP4Ska6frXtJiFDZYXdG9gcYr6loGa7Fc=;
        b=Rfonmd7CiwnbiajASuyb3gCxFWCttJjO6TGGmuPeHjJAQfK89Fsoxh+0QxLY1b7y+H
         W95bY+X4jXKH+Rezby7ChHllL2d/VdGcliSnAc9h6JPtuoHsj74k2R0gw2vrT6Qn3Tb2
         Nqjubd5Gj6TG15VH+yJak6K40bve6Qy0NnQYKX5GJ0RkkhOU+ijEPpiBGhBwDGv626+y
         9TpQUP8WENvq/CkiCMxFK0EusPrLYJWmxaLFYNfHN7aS7QW+FcQWTivx7vBgcmim81dh
         oeaN6huYDBCJbUDOCd4VS72cBGjx4ywz0T4Es9Je3nAcm5VqEXl18sHpYZu8T/DKs4lH
         hQgQ==
Received: by 10.112.85.200 with SMTP id j8mr5241086lbz.80.1335531312749;
        Fri, 27 Apr 2012 05:55:12 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id gw17sm6453589lab.11.2012.04.27.05.55.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Apr 2012 05:55:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <xmqq62cma2uo.fsf@junio.mtv.corp.google.com>
X-Gm-Message-State: ALoCoQkDl0s0YeG79WNBWaJ/iTDa9kj7frhARqalW2Ms313DunNENcjx5WkT8Ap7gRMODYSHCWBR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196468>

On 04/26/2012 06:13 PM, Junio C Hamano wrote:
> Jim Meyering<jim@meyering.net>  writes:
> 
>> What do you think about replacing those two append-if-needed two-liners:
>>
>>      if (buffer2.len&&  buffer2.buf[buffer2.len - 1] != '/')
>>              strbuf_addch(&buffer2, '/');
>>
>> by something that readably encapsulates the idiom:
>>
>>      strbuf_append_if_absent (&buffer2, '/');
>>
>> (though the name isn't particularly apt, because you might
>> take "absent" to mean "not anywhere in the string," so maybe
>>    strbuf_append_if_not_already_at_end (ugly) or
>>    strbuf_append_uniq
>> )
> 
> I am not good at names, but strbuf_terminate_with(&buffer2, '/')
> perhaps?
> 

"terminate" sounds pretty final though. How about strbuf_ensure_suffixch()?
It embeds the 'ch', marking it as a char argument and provides natural names
for
  strbuf_ensure_suffix(buf, char *str);
  strbuf_ensure_prefix(buf, char *str);
  strbuf_ensure_prefixch(buf, char c);
if those are ever needed.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
