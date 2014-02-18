From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [BUG?] git http connection reuse
Date: Tue, 18 Feb 2014 10:09:29 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1402181001540.15465@tvnag.unkk.fr>
References: <20140216040538.GA4754@sigill.intra.peff.net> <377DF3F4-1F9B-4CB0-A9BF-658E561F4349@gmail.com> <alpine.DEB.2.00.1402161307160.10435@tvnag.unkk.fr> <20140217235625.GB20499@sigill.intra.peff.net> <alpine.DEB.2.00.1402180806070.15465@tvnag.unkk.fr>
 <20140218075534.GB29804@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 18 10:09:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFggV-00051J-Pu
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 10:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594AbaBRJJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 04:09:41 -0500
Received: from giant.haxx.se ([80.67.6.50]:58097 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754468AbaBRJJj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 04:09:39 -0500
Received: from giant.haxx.se (dast@localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-4.1) with ESMTP id s1I99TxW007598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2014 10:09:29 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id s1I99Tww007593;
	Tue, 18 Feb 2014 10:09:29 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20140218075534.GB29804@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242287>

On Tue, 18 Feb 2014, Jeff King wrote:

> I'm not clear whether you mean by this that it is _expected_ in my test 
> program for curl not to reuse the connection. Or that curl may simply have 
> to do a little more work, and it is still a bug that the connection is not 
> reused.

Okey, I checked this closer now and this is the full explanation to what 
happens. It seems to work as intended:

It's all about where the connection cache is held by libcurl. When you create 
a multi handle, it will create a connection cache that will automatically be 
shared by all easy handles that are added to it.

If you create an easy handle and make a curl_easy_perform() on that, it will 
create its own connection cache and keep it associated with this easy handle.

When first using an easy handle within a multi handle it will use the shared 
connection cache in there as long as it is in that multi handle family, but as 
soon as you remove it from there it will be detached from that connection 
cache.

Then, when doing a fresh request with easy_perform using the handle that was 
detached from the multi handle, it will create and use its own private cache 
as it can't re-use the previous connection that is cached within the multi 
handle.

> We can certainly teach git to use the multi interface, even when doing a 
> single blocking request.

For connection re-use purposes, that may make a lot of sense.

-- 

  / daniel.haxx.se
