From: Lars Fenneberg <lf@elemental.net>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Wed, 20 Apr 2005 00:52:32 +0200
Message-ID: <20050419225232.GA8026@gimli.elemental.net>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com> <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <20050419194728.GA24367@kroah.com> <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org> <20050419214009.GA25681@kroah.com> <Pine.LNX.4.58.0504191449270.2274@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Greg KH <greg@kroah.com>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 00:48:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1WG-0007xT-Rz
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVDSWwp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 18:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVDSWwp
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 18:52:45 -0400
Received: from ns.mcs-hh.de ([194.77.146.129]:35281 "EHLO
	mail.hamburg.cityline.net") by vger.kernel.org with ESMTP
	id S261722AbVDSWwf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 18:52:35 -0400
Received: from [194.221.20.30] (helo=legolas.elemental.net)
	by mail.hamburg.cityline.net with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.43)
	id 1DO1a6-0002Ke-JW; Wed, 20 Apr 2005 00:52:34 +0200
Received: from gimli.elemental.net (gimli.elemental.net [194.221.20.130])
	by legolas.elemental.net (8.13.1/8.13.1) with ESMTP id j3JMqXus023281;
	Wed, 20 Apr 2005 00:52:33 +0200
Received: from gimli.elemental.net (localhost.localdomain [127.0.0.1])
	by gimli.elemental.net (8.13.1/8.13.1) with ESMTP id j3JMqX7f009129;
	Wed, 20 Apr 2005 00:52:33 +0200
Received: (from lf@localhost)
	by gimli.elemental.net (8.13.1/8.13.1/Submit) id j3JMqWv2009128;
	Wed, 20 Apr 2005 00:52:32 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504191449270.2274@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-NCC-RegID: de.cityline
X-PGP-Fingerprint-PGP2: 1024R/1A3A7A4D   D1 28 F1 FF 3C 6B C0 27  CC 9C 6C 09 34 0A 55 18
X-PGP-Fingerprint-OpenGPG: 1024D/A11CA902 9B75 F658 368C 366C 7BB3  5AB1 2479 9764 A11C A902
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi all!

Quoting Linus Torvalds (torvalds@osdl.org):

> And even the ones that use domainname tend to not have a fully qualified 
> DNS domain there. You need to use dnsdomainname to get that, and I don't 
> even know how to do it with standard libc.

I don't think getdomainname should be used at all in this case as it is the
domain name used by NIS and it might be different from the DNS domain name
in the FQDN associated with a given host. I just looked into the domainname
manual page and it agrees with me:

 domainname,  nisdomainname,  ypdomainname  will  print the name of the
 system as returned by the getdomainname(2) function.  This is also known as
 the YP/NIS domain name of the system.

That's why it is set to "(none)" (i.e. its not setup at all) on most hosts
because if they're not running NIS it's not really needed.

To get the FQDN which is what we want you'd have to use something like
this:

#include <netdb.h>
#include <unistd.h>

char *getfqdn(void)
{
        static char hostname[HOST_NAME_MAX + 1];
        struct hostent *hp;

        if (gethostname(hostname, sizeof(hostname)) < 0)
        {
                /* error handling */
        }

        if (!(hp = gethostbyname(hostname)))
        {
                /* just return the possibly unqualified hostname */
		return hostname;
        }

        return  hp->h_name;
}

Cheers,
Lars.
-- 
Lars Fenneberg, lf@elemental.net (private), lf@mcs.de (work)
