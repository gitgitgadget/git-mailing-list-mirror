From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [BUG?] git http connection reuse
Date: Tue, 18 Feb 2014 08:13:16 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1402180806070.15465@tvnag.unkk.fr>
References: <20140216040538.GA4754@sigill.intra.peff.net> <377DF3F4-1F9B-4CB0-A9BF-658E561F4349@gmail.com> <alpine.DEB.2.00.1402161307160.10435@tvnag.unkk.fr> <20140217235625.GB20499@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 18 08:13:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFesI-0006Zm-Eg
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 08:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009AbaBRHNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 02:13:43 -0500
Received: from giant.haxx.se ([80.67.6.50]:46803 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754162AbaBRHN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 02:13:27 -0500
Received: from giant.haxx.se (dast@localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-4.1) with ESMTP id s1I7DGX7009528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2014 08:13:16 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id s1I7DGJL009522;
	Tue, 18 Feb 2014 08:13:16 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20140217235625.GB20499@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242276>

On Mon, 17 Feb 2014, Jeff King wrote:

> Right; I'd expect multiple connections for parallel requests, but in this 
> case we are completing the first and removing the handle before starting the 
> second. Digging further, I was able to reproduce the behavior with a simple 
> program:

Yeah, given your description I had no problems to repeat it either. Turns out 
we had no decent test case that checked for this so in our eagerness to fix a 
security problem involving "over-reuse" we broke this simpler reuse case. Two 
steps forward, one step backward... :-/

> The manpage for curl_multi_add_handle does say:
>
>  When an easy handle has been added to a multi stack, you can not
>  and you must not use curl_easy_perform(3) on that handle!
>
> Does that apply to the handle after it has finished its transaction and been 
> removed from the multi object (in which case git is Doing It Wrong)?

No it doesn't. The man page should probably be clarified to express that 
slightly better. It just means that _while_ a handle is added to a multi 
handle it cannot be used with curl_easy_perform().

So yes, you can remove indeed it from the handle and then do 
curl_easy_perform(). It works just fine!

Several internal caches are kept in the multi handle when that's used though, 
so when getting the easy handle out after having used it with the multi 
interface and then using it with the easy interface may cause libcurl to do a 
little more work than if you would be able to re-add it to the same multi 
handle do to the operation with that...

-- 

  / daniel.haxx.se
