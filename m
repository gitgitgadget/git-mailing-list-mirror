From: Steffen Ullrich <Steffen_Ullrich@genua.de>
Subject: Re: git send-email doesn't work with IPv6 and STARTTLS
Date: Thu, 1 May 2014 22:48:14 +0200
Message-ID: <20140501204814.GA31294@genua.de>
References: <53615259.90200@mirix.org>
 <20140501180546.GA9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias-Christian Ott <ott@mirix.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 23:00:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfy5g-0002RG-11
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 23:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbaEAVAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 17:00:20 -0400
Received: from gg-0.genua.de ([80.154.94.10]:22978 "EHLO gg.genua.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbaEAVAT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 17:00:19 -0400
X-Greylist: delayed 719 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 May 2014 17:00:19 EDT
Received: from gg.genua.de (localhost.genua.de [127.0.0.1])
	by gg.genua.de (8.14.6/8.14.6) with ESMTP id s41KmHN3004274
	for <git@vger.kernel.org>; Thu, 1 May 2014 22:48:17 +0200 (CEST)
Received: (from localhost) by gg.genua.de (MSCAN) id 5/gg.genua.de/smtp-gw/mscan; Thu May  1 22:48:17 2014
Content-Disposition: inline
In-Reply-To: <20140501180546.GA9218@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247882>


Hi,

Net::SMTP does neither supports SSL nor IPv6.

git-send-mail does not use Net::SMTP directly for SSL support, but:
- for direct connections (port 465) it uses Net::SMTP::SSL which just
  replaces the superclass if Net::SMTP with IO::Socket::SSL and thus
  implicitly supports IPv6 (because IO::Socket::SSL does)
- for plain connections with SSL upgrade git-send-mail uses Net::SMTP for
  the initial connect and then does Net::SMTP::SSL->start_SSL (e.g.
  inherited from IO::Socket::SSL) to upgrade the socket to SSL.

The problem here is that Net::SMTP does not support IPv6, but this
should be solvable by using Net::INETGlue::INET_is_INET6 before loading
Net::SMTP.

But all these tricks are just workarounds for missing IPv6 and SSL support
directly in the Net::SMTP, Net::FTP and Net::POP3.
I therefore repeat my proposal from RT#93823 (no response yet) to add
transparent support for IPv6 and SSL into these modules. By transparent I
mean that the features are available if the necessary modules are installed
(e.g. IO::Socket::SSL for SSL and IO::Socket::INET6 or IO::Socket::IP for
IPv6), but that it works like before if they are not installed.

I don't have these patches yet, but most of the necessary code is already
there in Net::SSLGlue and Net::INET6Glue.
Would you accept and incorporate such patches?

Regards,
Steffen

On Thu, May 01, 2014 at 11:05:46AM -0700, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
> 
> Matthias-Christian Ott wrote[1]:
> 
> > git send-email uses Net::SMTP connections that use STARTTLS. Net::SMTP
> > does not support IPv6. I patched Net:SMTP to use IO::Socket::INET6 and
> > it worked.
> 
> Thanks for reporting.
> 
>  1. What version of Net::SMTP do you use?
> 
>  2. Would you be willing to contribute your patch to Net::SMTP upstream,
>     for example by mailing it to bug-libnet@rt.cpan.org with
>     the string "[rt.cpan.org #93823]" somewhere in the subject line[2]?
> 
> Hope that helps,
> Jonathan
> 
> [1] http://thread.gmane.org/gmane.comp.version-control.git/247769
> [2] https://rt.cpan.org/Public/Bug/Display.html?id=93823
> https://rt.cpan.org/NoAuth/RT/CPAN/Usage.html

-- 
genua
Gesellschaft fuer Netzwerk- und Unix-Administration mbH
Domagkstrasse 7, 85551 Kirchheim bei Muenchen
tel +49 89 991950-0, fax -999, www.genua.de
Geschaeftsfuehrer: Dr. Magnus Harlander, Dr. Michaela Harlander,
Bernhard Schneck. Amtsgericht Muenchen HRB 98238
