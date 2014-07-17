From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: git_inetd_server: run git-http-backend using inetd
Date: Thu, 17 Jul 2014 16:38:30 -0700
Message-ID: <8E3CD89B-2E47-4CA8-8F3D-598A9BE2AD9F@gmail.com>
References: <43923BC7-08AF-4900-AC5E-B2F0FE7CD5AC@gmail.com> <20140717221056.GO12427@google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 01:38:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7vG2-0008PT-8A
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 01:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758197AbaGQXie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 19:38:34 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34466 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758044AbaGQXid (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 19:38:33 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so3987853pdj.0
        for <git@vger.kernel.org>; Thu, 17 Jul 2014 16:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=gcY5rgLrM4ZhtyHaXsT2wO1IiO+7NDV56kaxa6PiKyQ=;
        b=fxY6ZU4Xx2o6roydnDB3ttcI+yU5eQuvNp4DC+8G6ZRlmvODDyfcnIYYKbprZ1aFh7
         sDkGKfFXU6qGXQMJq+bmM5Avq/V3zoi1xRrLKCuRQcvH7SWvXl/1hQiEDMPTTXKe42Ai
         1tTqOg3tkj0WoPuzPqvayF76i2ANkmRt2Ctku1OG9UXNCTRlqTuTS6xDwwvE7Dn879rD
         3ZJiKEI4Dw8xgZFqFSBhGHB9ilJjGoGHjuYVrVHuMv60OJaxuHrLipwNrLBYmLdvAqlO
         xTK7J6Cbq26UhlpGClzTfXh/JHJNuVxy2YGZxTPTp6rLRGvpsKUJtCFr0f3vB83Q0H2Z
         N8Dg==
X-Received: by 10.70.123.231 with SMTP id md7mr525032pdb.67.1405640312957;
        Thu, 17 Jul 2014 16:38:32 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id xc1sm15475252pab.39.2014.07.17.16.38.31
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 16:38:32 -0700 (PDT)
In-Reply-To: <20140717221056.GO12427@google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253789>

On Jul 17, 2014, at 15:10, Jonathan Nieder wrote:
> Hi,
>
> Kyle J. McKay wrote:
>
>> When I then try to fetch using a "git://host/..." URL where "host"
>> is an mDNS host name, the 0010 patch causes git to attempt to lookup
>> a DNS SRV record on the non-mDNS regular DNS service (a violation of
>> RFC 6762 [4] section 22) and this is what has to time out before the
>> real fetch can start.
>
> That patch uses res_query from libresolv to do the lookup.  It doesn't
> know what DNS server to use and relies on system libraries to get it
> right.

If I understand the libresolv implementation correctly, it only  
supports DNS and not mDNS.  And as far as I know, the nss plugins only  
support A and AAAA lookups, not SRV lookups.  However, it looks like  
there are some attempts to add mDNS support directly to res_query and  
friends [4].  Maybe that code could serve as a model.

> It was added to respond to a feature request within Debian but it is
> intended to eventually go upstream.  I'm glad you found this issue
> before that could happen. :)

Is there some reason the patch is not opt-in at runtime?  In other  
words the code is there, but not enabled unless you do something like  
'git config --system --bool git.srvlookup true'?  If it's off by  
default it doesn't matter so much that it's standards violating as it  
won't bite you unless you turn it on and then presumably if you do you  
know what you're doing and understand the possible downside.

> Should git automatically disable the SRV lookups when it sees one of
> the six domains named in RFC6762, or is there some system library call
> that can use mDNS when appropriate automatically (or get partway there
> without having to hard-code the domains)?

Sadly I think mDNS support is relegated to an add-on package on  
Linux.  And Avahi [1] is the package that generally provides it  
there.  The recommended interface for C is the avahi-client API (see  
[2]).  However, that is Avahi-only.

If the patch is to go upstream it probably needs to use the dns-sd.h  
header API for maximum compatibility (Avahi provides an avahi-compat- 
libdns_sd interface via the libavahi-compat-libdnssd-dev package).  I  
believe the correct function would be DNSServiceQueryRecord in this  
case.

That said, for the code to work properly it would need to:

1) Get the canonical name of the host.  If "local" is one of the  
search domains or the default domain you could have a mDNS name  
without an explicit .local suffix.  I'm not sure best how to do this.  
The getaddrinfo function has an AI_CANONNAME flag but the call will  
fail if the host does not have an A or AAAA record and in the case of  
redirection-by-SRV it may have neither.  You probably just have to  
loop through the search domains keeping in mind the Security  
Considerations of section 21 of RFC 6762 [3] (a host MUST NOT append  
the search suffix ".local.", if present, to any relative (partially  
qualified) host name containing two or more labels. Appending  
".local." to single-label relative host names is acceptable).  So if a  
host name does not end in .local (or .local.) it can only be an mDNS  
name if it contains no dots ('.') AND "local" is one of the search  
domains or is the default domain.

2) For mDNS either use the #include <dns_sd.h> DNSServiceQueryRecord  
functionality if available or just skip it if not available.

3) For non-mDNS use the same query as it does now.

Even if the choice is to just disable SRV lookups for mDNS hosts at a  
minimum the code will have to determine whether or not the given host  
name is a mDNS name and it can't reliably do that for a host name  
without any dots in it without at least looking at the default domain  
name and possibly the search domain(s) as well.

I think it would be much simpler just to make this opt-in via a config  
option rather than baked in as it's probably going to be rather messy  
without direct mDNS support in the res_query interface.

--Kyle

[1] http://avahi.org/
[2] http://avahi.org/download/doxygen/index.html
[3] http://tools.ietf.org/html/rfc6762#page-52
[4] https://www.mail-archive.com/tech@openbsd.org/msg06100.html
