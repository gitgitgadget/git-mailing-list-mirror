From: =?iso-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH] Allow any HTTP authentication scheme, not only basic
Date: Wed, 1 Apr 2009 18:06:48 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0904011750260.5901@localhost.localdomain>
References: <1238520686-546-1-git-send-email-martin@martin.st>
 <1238525665-10776-1-git-send-email-martin@martin.st>
 <alpine.DEB.1.00.0903312104010.6676@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 17:09:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp23I-0000fW-0j
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 17:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764442AbZDAPGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 11:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764028AbZDAPGx
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 11:06:53 -0400
Received: from smtp2.abo.fi ([130.232.213.77]:43102 "EHLO smtp2.abo.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763554AbZDAPGw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 11:06:52 -0400
Received: from albin.abo.fi (albin.abo.fi [130.232.81.192])
	by smtp2.abo.fi (8.14.3/8.12.9) with ESMTP id n31F6mqZ020907;
	Wed, 1 Apr 2009 18:06:48 +0300
X-X-Sender: mstorsjo@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0903312104010.6676@intel-tinevez-2-302>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (smtp2.abo.fi [130.232.213.77]); Wed, 01 Apr 2009 18:06:49 +0300 (EEST)
X-Virus-Scanned: by foxy.abo.fi (foxy.abo.fi: Wed Apr  1 18:06:49 2009)
X-Scanned-By: MIMEDefang 2.64 on 130.232.213.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115393>

Hi,

My patch doesn't seem to come completely without troubles, though.

I still find this a potentially valuable scenario; e.g. for a public repo 
with push access only over HTTP, but using secure digest authentication 
instead of sending the credentials in plaintext.

One downside is that it causes a lot more HTTP requests, since libcurl 
initially tries without any authentication for (almost?) every request, 
doubling the number of requests made.


Fetching works just fine, but pushing may fail on auth problems in some 
cases where it wouldn't fail otherwise, if only basic authentication was 
used and libcurl automatically used that without probing what 
authentication scheme the server uses.

Things generally seem to work fine with Apache, but with Lighttpd, 
retrying with proper credentials may fail due to CURLE_SEND_FAIL_REWIND /* 
65 - Sending the data requires a rewind that failed */. This issue can be 
fixed by another patch (that I'll send soon).

Even after fixing that, there still seems to be some issues on some older 
curl versions; in particular, 7.16.3, shipped in OS X Leopard, returns 
error code CURLE_HTTP_RETURNED_ERROR instead of retrying properly with 
authentication.

// Martin
