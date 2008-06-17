From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] gitweb: return correct HTTP status codes
Date: Wed, 18 Jun 2008 01:47:43 +0200
Message-ID: <48584D1F.5070000@gmail.com>
References: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com> <200806171633.26864.jnareb@gmail.com> <48583A73.7020508@gmail.com> <200806180054.33490.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 01:48:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8kux-0007CB-VY
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 01:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758728AbYFQXr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 19:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753693AbYFQXr4
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 19:47:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:29576 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbYFQXrz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 19:47:55 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3700639fgg.17
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 16:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=9WHiSZ4qWllsekbFF3/1MfYD0q5UUmkhvCjqpah9yRI=;
        b=ZtuBpfVCKnNJaqp7LbH6uIjsVSIg7O9Tbf6vLoQmusux7pKYbz95/kEWJpXXAWpIV/
         Ke+pEHmNnS8BT9W+Cdd4J7hfvAB5IbJmhjBkFZ+vLPmaERh6pavZCkMTcmKBbMo9kVaL
         0ccVxiHLFRJzEQukCItQHm+MurMmNDiJmcmkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=dDO5WDKLNAVU11bncCmjESGh94BEPIMJdUjxjWXWfIZVnAYZ4dqMDvOg3DrHWLesCN
         HiSAGJwc4p4l1G33g64lr7ua0C5YtR9BD5CQNV90Mf6bqq1SeTpGPaQAEP7SfAxDRtsT
         M92PHculWI02bnIoM2IRY7GqHVUeThOamJZRE=
Received: by 10.86.72.3 with SMTP id u3mr9603696fga.35.1213746473745;
        Tue, 17 Jun 2008 16:47:53 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.241.48])
        by mx.google.com with ESMTPS id 4sm12392679fge.5.2008.06.17.16.47.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 16:47:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200806180054.33490.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85345>

Jakub Narebski wrote:
> But what are arguments for "check params; run command" vs "run command;
> check params if error" proposed by Junio?  Why do you want to check
> parameters upfront?

It's actually not checking, it's resolving.  Instead of ...

get_commit($symbol)

... (with $symbol = 'HEAD' for instance), you do (pseudocode):

$hash = get_hash($symbol, 'commit'); # 'commit' to resolve tags
check that $hash is defined
get_commit($hash)

(And get_commit won't even accept anything but 40-byte hashes.)  This is 
for two reasons:

1. Caching: Resolving symbols first gives you some (very few) cache 
entries that need to be expired (namely, get_hash results for symbols 
that are not SHA1 hashes already), but most cache entries (like the 
get_commit) are infinitely valid.

2. Besides being a little more straightforward to implement, it ensures 
that you have well-defined failure points.  IOW, first you resolve the 
symbols you're getting from the user and check them for existence (and 
correct type).  From then on, any hashes you pass around are guaranteed 
to be valid, so failures indicate that something serious went wrong. 
Apart from making things easier for the developer by reminding them of 
the points where they *need* to check for errors, it means that you can 
very easily check the error-handling code for completeness (by only 
reading the first few lines that resolve symbols).

> By the way, would you be sending your current WIP for review?

Will do in the next 2 days after some cleanup.

> [is] adding object oriented interface (wrapper) to git repositories
> really  needed for implementing gitweb caching?

It makes things better to read for sure, and it means that you can have 
a plain API without caching, and implement the caching layer as a 
subclass (which overrides the methods with cacheable results).

-- Lea
