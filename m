From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 7/9] remote-curl: recognize text/plain with a charset parameter
Date: Thu, 22 May 2014 00:27:38 -0700
Message-ID: <21F11C1A-4C69-4633-9DC7-E9134D38856E@gmail.com>
References: <20140521102524.GA30301@sigill.intra.peff.net> <20140521103301.GG30464@sigill.intra.peff.net> <90CE006F-EE74-40D2-8847-507E37021D84@gmail.com> <20140522060516.GB16587@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 22 09:27:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnNPl-000860-Jo
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 09:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbaEVH1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 03:27:41 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:52125 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbaEVH1l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 03:27:41 -0400
Received: by mail-pd0-f176.google.com with SMTP id p10so2203294pdj.21
        for <git@vger.kernel.org>; Thu, 22 May 2014 00:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=clL4UoS+SiMdjIjWqpipcXMXy4W32e0Amo8LcU028Yw=;
        b=YxZ0kwn8976bjQt5+WTowQv9J2VyUA6/+tuNAZm0G8g8f5SQkiM8J06g3Elgw8fDJB
         ictS9um6r4Pysj7q1xJdzO0MsttEvs5lveI/PQ/TpEa3tbVkHrup1b58Z8H295m2WRka
         BHNVreEM6AnkWyLs6gRNLBSitM0RB8qj7B1PUMC+5scfs7uTjQcLL6IjoZjbgnoRXLgB
         lH2NxNMDDu12/TtGk7w83+4PoDd22FjkZHT7nKW6hsU1PyctfjDySiMWF2WJGxcdQzmC
         +Zk28skROS2y8f+4V6Gdz9L8x+/Ta03yh8aXnCD2lkDEJvC0Oc6PqJf1ET6Vk1Apa4ul
         v4aQ==
X-Received: by 10.68.222.196 with SMTP id qo4mr64611281pbc.14.1400743660578;
        Thu, 22 May 2014 00:27:40 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id bu1sm11506854pbb.54.2014.05.22.00.27.39
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 00:27:40 -0700 (PDT)
In-Reply-To: <20140522060516.GB16587@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249880>

On May 21, 2014, at 23:05, Jeff King wrote:

> On Wed, May 21, 2014 at 05:07:38PM -0700, Kyle J. McKay wrote:
>
>>> +	p = skip_prefix(type->buf, "text/plain");
>>> +	if (!p || (*p && *p != ';'))
>>> +		return 0;
>>> +
>>> +	return 1;
>>> +}
>>> +
>>
>> I think that a strict reading of RFC 2616 allows "text/plain ;
>> charset=utf-8" as well as "text/plain;charset=utf-8" and "text/plain;
>> charset=utf-8".  So perhaps this if line instead:
>>
>> +	if (!p || (*p && *p != ';' && *p != ' ' && *p != '\t'))
>>
>> See RFC 2616 section 2.2 for the definition of linear white space  
>> (LWS) and
>> the end of section 2.1 for the "implied *LWS" rule that allows it.
>
> You're right. There are a few exceptions in 3.7:
>
>  Linear white space (LWS) MUST NOT be used between the type and
>  subtype, nor between an attribute and its value.
>
> but it does not include between the subtype and parameter. So the
> "find_parameter" also needs to accept the collapsed whitespace, too, I
> guess.

Yeah I think so too.  It's probably enough though just to just strip  
all " " and "\t" characters at the same time the content type is  
lowercased.  While that would cause invalid content types such as  
"text / plain" to be recognized it would keep the rest of the code  
simpler.  Since a producer of an invalid content type shouldn't really  
be depending on any particular behavior by a receiver of an invalid  
content type it's probably not an issue.

--Kyle
