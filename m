From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/10] parse-options: never suppress arghelp if
 LITERAL_ARGHELP is set
Date: Fri, 3 Dec 2010 03:40:20 -0600
Message-ID: <20101203094020.GA11910@burratino>
References: <20101201232728.GA31815@burratino>
 <20101201233136.GG31815@burratino>
 <4CF8B55F.8020203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 10:40:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POS8B-0001ap-Ek
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 10:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756484Ab0LCJkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 04:40:37 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40413 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755694Ab0LCJkg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 04:40:36 -0500
Received: by ywl5 with SMTP id 5so4656976ywl.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 01:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=aVXkwdBQ8/i+MpcvucBbDCsBkAMRG4Di4fIfwOfd4nc=;
        b=MYa7VeSE/DenodN99VZgEUAzpOP/KuywA+aL4b6dWBiiTLkTIE+K6+Uohgd3EYE32K
         liWv8CkqLVbzhYJsvh9ZZqUSFzUUFoLPjdKS1lqwzXBCA/GXFwgTb5RAiWqCe2vsoWoi
         7GgbOQnY0cZeUarCiUioV6Bm+vttpLmyeXbTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lsEL2qF6XLtqb/ZKsJXqjeoVPLROLvKTMseTlmTZ5Xe9Jpe+vkJu5nmlT7Y564z4WM
         ARu9ml/MQywrLadsJclJAfzNqQLyxxotAP8eRX4dgpbxBG8ZW9aCHQ5/XVrvOhvi17d1
         xZB7ko7FiDstnES2mDBspupsG1ccjooCT8uc4=
Received: by 10.151.7.10 with SMTP id k10mr3321374ybi.433.1291369235471;
        Fri, 03 Dec 2010 01:40:35 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id f23sm387993ybh.10.2010.12.03.01.40.33
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 01:40:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CF8B55F.8020203@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162782>

Stephen Boyd wrote:
> On 12/01/10 15:31, Jonathan Nieder wrote:

>> The motivation is to allow update-index to correctly advertise
>> 
>> 	--cacheinfo <mode> <object> <path>
>> 	                      add the specified entry to the index
>> 
>> while abusing PARSE_OPT_NOARG to disallow the "sticked form"
>> 
>> 	--cacheinfo=<mode> <object> <path>
[...]
> parse-options should accept both forms of --cacheinfo above if the
> option isn't marked PARSE_OPT_NOARG. Marking it NOARG to get rid of the
> equals sign in the usage seems wrong when both the equals sign and no
> equals sign can be accepted.

Just to clarify: the NOARG was not meant to affect the usage message
but the actual accepted usage.  The idea was that

	git update-index --cacheinfo=100644 87a8767c87b file.c

should be rejected, because if it is accepted that would tempt people
to try

	git update-index --cacheinfo=100644 -q 87a8767c87b file.c

which fails.  That is, the argument to --cacheinfo is not <mode>,
since --cacheinfo takes _three_ arguments and therefore the sticked
form sends a wrong message.

> I know this is a bit more code, but it also means that we don't have
> this approach bite someone else down the line when they make assumptions
> about options marked as NOARG not taking arguments.
>
> We should probably add another check like "if argh is set and
> PARSE_OPT_NOARG is true error out" so this can't be done.

I agree with your conclusion.  Let's drop this patch, and I'll look
into adding the check and a PARSE_OPT_NOSTICKED flag.
