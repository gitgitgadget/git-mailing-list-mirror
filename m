From: Deskin Miller <deskinm@umich.edu>
Subject: Re: Challenge of setting up git server (repository). Please help!
Date: Thu, 20 Nov 2008 18:08:59 -0500
Message-ID: <20081120230859.GA13683@euler>
References: <20081120221321.GA6349@euler> <146002.93100.qm@web37908.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gary Yang <garyyang6@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 00:10:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3IfZ-0003kf-Fa
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 00:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709AbYKTXJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 18:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754649AbYKTXJQ
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 18:09:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:51120 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174AbYKTXJP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 18:09:15 -0500
Received: by ug-out-1314.google.com with SMTP id 39so434300ugf.37
        for <git@vger.kernel.org>; Thu, 20 Nov 2008 15:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=4wCnMrhiWLGrvJFQshSBBzp95u45gy9fbSJNITyj0/Y=;
        b=okcKNbzQF3U0Ug4apnicgwODe1x4NCnfWXLZYHrCRKB/ymUYj/hVJDyrPknYBc63P6
         IPRo6eviW6ajr0/VXkBBSA4bdTroRHiuiHv9ZuGSLVW39BT01bNpKLRCdu/kNRN3hMNe
         ay+KV+UEblMNdaE7Y7y6a2OoTYO5aS9qtKGKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=WKQV8wjnLrlaz/cq7f78h8wVF2wRH7o772mInUAo7EhjYTlUWPQE0OZtg0R5VH+3+s
         kQW95i1SO6HgUpor+3p/EwE2oIZLm5/tUkrjHxfJC2wlmAQziGSU2n07ICNNwYm4+nTW
         3SgZkJ6CmLNklkRhgtSCjPvtT+kd6b06Cd8qE=
Received: by 10.67.19.13 with SMTP id w13mr3906790ugi.12.1227222552814;
        Thu, 20 Nov 2008 15:09:12 -0800 (PST)
Received: from euler ([68.40.49.130])
        by mx.google.com with ESMTPS id s1sm73737uge.27.2008.11.20.15.09.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Nov 2008 15:09:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <146002.93100.qm@web37908.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101477>

On Thu, Nov 20, 2008 at 02:43:30PM -0800, Gary Yang wrote:
> Many thanks for your explanation. I hope I understand what you said. I deleted /etc/xinetd.d/git-daemon. Then, I tried to git pull. But, I got connection refused. git uses port 9418. Should I request IT Admin to open the port 9418 for me?

You'll need port 9418 open, yes; but since it's an unprivileged port (1024 or
higher), you can use it as a regular user and don't need IT intervention unless you have some firewall set up which they need to override for you.

> git pull git://git.mycompany.com/pub/git/u-boot.git HEAD
> git.mycompany.com[0: 10.66.4.168]: errno=Connection refused
> fatal: unable to connect a socket (Connection refused)

It's possible, and likely simpler, to use git-daemon directly, instead of
having it be managed by inetd; especially for initial debugging, I'd recommend
getting that working before trying to determine if you're having issues with
inetd configuration: to do so, just run git-daemon with all the same arguments
except for --inetd.

You said you deleted the xinetd config, but that's only relevant if your
machine actually uses inetd as its super-server.  You should do 'ps -A | grep
inetd' (which will match either inetd or xinetd), and see which one is running.
If it's inetd, you should be all set, and the issue doesn't look like inetd
(assuming you sent it a signal to reload its config file).  If on the other
hand xinetd is running, you need to use the xinetd config file, and fix the
server_args to look like the arguments which exist in the inetd file.  Again,
you need to signal xinetd at this point to reload its configuration.

Based on the linux kernel version you're reporting, I'm guessing you have some
sort of Red Hat based system, which uses xinetd to the best of my knowledge.

> Another question, I got no output of "netstat | grep 9418". It means no program runs at port 9418 at the public repository machine. Is it correct?
> 
> netstat | grep 9418

netstat translates IP addresses to dns names, and ports to service names by
default; so, given the line listed in /etc/services, this will show
'0.0.0.0:git' or something.  Also, it lists established connections, not
listening sockets, by default.  I'd recommend spending some time with the man
page if you're going to use it to debug your setup.

Deskin Miller
