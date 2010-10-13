From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 02/15] mingw: implement syslog
Date: Wed, 13 Oct 2010 15:23:47 -0400
Message-ID: <4CB60743.2030908@sunshineco.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com> <1286833829-5116-3-git-send-email-kusmabite@gmail.com> <20101011221146.GB6277@burratino> <AANLkTinkpTavtw3Rmubfht56tzGnHckHXRc0L-C83daE@mail.gmail.com> <20101011223746.GA6637@burratino> <AANLkTinBvZ_L-fq1u4tPX6rNW6X3jeoOO23-yLpdxSu0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	Mike Pape <dotzenlabs@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Oct 13 21:24:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P66vi-0000L6-1A
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 21:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131Ab0JMTXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 15:23:53 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:34217 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab0JMTXw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 15:23:52 -0400
Received: by qyk5 with SMTP id 5so852170qyk.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 12:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=ddBLIU05Fdgu8XG5hzUdf2rHuZIEilGPlaVbV/4gbm4=;
        b=n1GOQxlQcBInWD02MSvsSZhvxNrecS9BGJ3iHCWhoRW7doS9QPvUX7gSolfCtwPb8k
         6tvH5BczPG0kbTfRyHgIXKX0cYYtDvPd5m5E8hUcFNdbq0ae82vBKgi3uoSfOEF1hVnB
         sjgSMyz/Po9ayH68f230t+bwWGQJkOJ7VbkME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=gGau0N2AKCdaiZKt+RyiZGx9ACVSDEinswKQ1AdJwLpp5vgSx2ayJHoHyHnTxHjjNf
         F7si+22IJ60UYSCJ6Dbt+NdnqX5MY3369lrPnAHZkEBT6zbdh05p1cp9doKlIuinBavo
         H1FSu00v/zQUtGI5AhypDMN/XThyGnnYTGuK4=
Received: by 10.224.187.70 with SMTP id cv6mr7046871qab.314.1286997831945;
        Wed, 13 Oct 2010 12:23:51 -0700 (PDT)
Received: from [192.168.1.1] (user-12l2cil.cable.mindspring.com [69.81.50.85])
        by mx.google.com with ESMTPS id l14sm6346054qck.41.2010.10.13.12.23.49
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 12:23:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.9) Gecko/20100922 Thunderbird/3.1.4
In-Reply-To: <AANLkTinBvZ_L-fq1u4tPX6rNW6X3jeoOO23-yLpdxSu0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158962>

On 10/13/2010 08:36 AM, Erik Faye-Lund wrote:
> On Tue, Oct 12, 2010 at 12:37 AM, Jonathan Nieder<jrnieder@gmail.com>  wrote:
>> Erik Faye-Lund wrote:
>>
>>> The string gets inlined into itself (with a limit of 100 expansions)
>>> leading to string like "foo %1 bar" becoming "foo foo foo ... foo %1
>>> bar bar bar ... bar". With our expansion, it becomes "foo % 1 bar"
>>> instead.
>>
>> Ah, ok.  Sounds like there is no need to worry about requests for "%%1"
>> etc.  Thanks for explaining.
>>
> Actually, %%1 is a bit of a tricky one. It seems that %%1 is used to
> escape %1 on Windows 7, but not on earlier Windows version. I did test
> this on Vista an XP earlier, but I'll re-test again later and report
> back, in case my earlier tests were flawed.

If that worked universally, escaping '%1' to '%%1' certainly would be 
nicer than '% 1'. (More generally, escape '%n' to '%%n', where n is a 
number.) It also would simplify the log message.

> Can %%1 occur in an IPv6 address at all? If not, I'm tempted to not
> handle it (unless it turns out I was wrong about %%1-escaping on Vista
> and XP).

According to sources I have studied, %%1 would be unlikely (or perhaps 
invalid) in IPv6 addresses.

http://en.wikipedia.org/wiki/IPv6_address#Link-local_addresses_and_zone_indices

-- ES
