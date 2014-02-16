From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [BUG?] git http connection reuse
Date: Sun, 16 Feb 2014 13:18:52 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1402161307160.10435@tvnag.unkk.fr>
References: <20140216040538.GA4754@sigill.intra.peff.net> <377DF3F4-1F9B-4CB0-A9BF-658E561F4349@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 16 13:26:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WF0no-00016f-Bx
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 13:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbaBPM01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 07:26:27 -0500
Received: from giant.haxx.se ([80.67.6.50]:50784 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751724AbaBPM0X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 07:26:23 -0500
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Feb 2014 07:26:22 EST
Received: from giant.haxx.se (dast@localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-4.1) with ESMTP id s1GCIqFi012823
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Feb 2014 13:18:52 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id s1GCIqRN012819;
	Sun, 16 Feb 2014 13:18:52 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <377DF3F4-1F9B-4CB0-A9BF-658E561F4349@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242221>

On Sat, 15 Feb 2014, Kyle J. McKay wrote:

> If pipelining is off (the default) and total connections is not 1 it sounds 
> to me from the description above that the requests will be executed on 
> separate connections until the maximum number of connections is in use and 
> then there might be some reuse.

Not exactly. When about to do a request, libcurl will always try to find an 
existing idle but open connection in its connection pool to re-use. With the 
multi interface you can of course easily start N requests at once to the same 
host and then they'll only re-use connections to the extent there are 
connections to pick, otherwise it'll create new connections.

>> Daniel Stenberg (7 Jan 2014)
>> - ConnectionExists: fix NTLM check for new connection

> Looks like you're just lucky as that above change first appears in 7.35.0. 
> But it seems there are some patches for older versions so they might be 
> affected as well [2].

Right, the problem is there to make sure that a NTLM-auth connection with 
different credentials aren't re-used. NTLM with its connection-oriented 
authentication breaks the traditional HTTP paradigms and before this change 
there was a risk that libcurl would wrongly re-use a NTLM connection that was 
done with different credentials!

I suspect we introduced a regression here with that fix. I'll dig into this.

-- 

  / daniel.haxx.se
