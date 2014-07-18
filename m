From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git_inetd_server: run git-http-backend using inetd
Date: Thu, 17 Jul 2014 19:22:08 -0700
Message-ID: <20140718022208.GQ12427@google.com>
References: <43923BC7-08AF-4900-AC5E-B2F0FE7CD5AC@gmail.com>
 <20140717221056.GO12427@google.com>
 <8E3CD89B-2E47-4CA8-8F3D-598A9BE2AD9F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 04:22:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7xoS-0007qH-LH
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 04:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759522AbaGRCWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 22:22:14 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:42314 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758770AbaGRCWL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 22:22:11 -0400
Received: by mail-pd0-f175.google.com with SMTP id r10so2667269pdi.20
        for <git@vger.kernel.org>; Thu, 17 Jul 2014 19:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fWlpNLw1Qui4ZwjedLd9rCpD22pW4NSxo2nYXcNiUWw=;
        b=jYYBb+06yA6NTEtimBKAjNB0qAtIOeEK/KF6LGKPcrgJwux4usr2N7pL2ZQvIK/HdG
         s+j10iPU+1ixfCCnYb5mpkqXio9gsfTUJMCZu4zD5c6NCWm11QM8gDc4YCso1U3y01tA
         sz1umXiNy3K3iW21EUWwKtKEj/AOMQ/AkGPxqj5nV8lDk/o9ydWVS0QUHNEJp/UK2vjr
         G4feGMNTCA6GyRMCpXcxJU+cl+3NC+lqRVJ8uIwscXc7tIrhT/w4IHnf7gu0X4DV85Uy
         nwsLQZIAFeHKzHbvF/Of1WIrhIWwnxaA9igCEGha2hfsQjHedGZfw4Yb+lBD0tOBeSMu
         dDTQ==
X-Received: by 10.70.48.8 with SMTP id h8mr1299136pdn.142.1405650130899;
        Thu, 17 Jul 2014 19:22:10 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:2ddc:e64:e8c9:79e3])
        by mx.google.com with ESMTPSA id y2sm16796058pas.45.2014.07.17.19.22.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 19:22:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8E3CD89B-2E47-4CA8-8F3D-598A9BE2AD9F@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253791>

Kyle J. McKay wrote:
> On Jul 17, 2014, at 15:10, Jonathan Nieder wrote:

>> It was added to respond to a feature request within Debian but it is
>> intended to eventually go upstream.  I'm glad you found this issue
>> before that could happen. :)
>
> Is there some reason the patch is not opt-in at runtime?

Yes, it's a feature for server admins to control where clients
connect, to control where the load goes.  If the client has to enable
it explicitly, that defeats the purpose.

I'd much rather fix it than turn it off completely.

[...]
>> Should git automatically disable the SRV lookups when it sees one of
>> the six domains named in RFC6762, or is there some system library call
>> that can use mDNS when appropriate automatically (or get partway there
>> without having to hard-code the domains)?
>
> Sadly I think mDNS support is relegated to an add-on package on
> Linux.  And Avahi [1] is the package that generally provides it
> there.  The recommended interface for C is the avahi-client API (see
> [2]).  However, that is Avahi-only.
[...]
> Even if the choice is to just disable SRV lookups for mDNS hosts at
> a minimum the code will have to determine whether or not the given
> host name is a mDNS name and it can't reliably do that for a host
> name without any dots in it without at least looking at the default
> domain name and possibly the search domain(s) as well.
>
> I think it would be much simpler just to make this opt-in via a
> config option

Thanks for these details.  I'll file a bug and mull it over some more.

RFC 6762 makes it clear that what the package is currently doing is
wrong.  Given that Debian's libc knows nothing about mdns on its own,
I think I'll need to parse resolv.conf (that's what libc-ares does).

Jonathan
