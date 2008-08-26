From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Git-aware HTTP transport
Date: Tue, 26 Aug 2008 09:33:00 -0700
Message-ID: <48B4303C.3080409@zytor.com>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 18:34:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY1Un-00046Z-17
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 18:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754322AbYHZQdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 12:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753716AbYHZQdM
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 12:33:12 -0400
Received: from terminus.zytor.com ([198.137.202.10]:57887 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbYHZQdM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 12:33:12 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7QGX7o0018523
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Aug 2008 09:33:07 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7QGX7jm009345;
	Tue, 26 Aug 2008 09:33:07 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7QGX01Z000468;
	Tue, 26 Aug 2008 09:33:01 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080826145857.GF26523@spearce.org>
X-Virus-Scanned: ClamAV 0.93.3/8091/Tue Aug 26 08:26:20 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93758>

Shawn O. Pearce wrote:
> 
> Hmm.  I'm actually thinking the exact opposite here.  My rationale
> for putting the response as a standard HTTP 302/303 style redirect
> is to permit hardware load balancers or Apache mod_rewrite rules
> to implement simple load balancing with a HTTP redirect.
> 
> If we embed the redirect URL into the payload then configuring that
> will become a lot more complex.  At the minimum you may have to
> make up a dummy file for each server (holding the response payload)
> then then let mod_rewrite rewrite the request internally to make
> Apache serve that file.  Ugly.
> 

No, you're thinking backwards.  What you want is the standard HTTP 
redirect load balancing to take effect *before* the initial request is 
serviced.  The front-end load balancer will take effect on the initial 
request, and then redirect the request to a node (via a 302 reply.)  The 
target node then sends a self-referencing URL to keep the service local, 
if that is desired -- otherwise it doesn't.

Again, the 300-class redirect is treated as a part of the HTTP transport 
in this case; it doesn't have to be visible to the RPC layer.  However, 
in order to maintain the integrity of an interchange, we do need an 
additional level of redirection visible to the RPC layer.

> If we embed the redirect URL into the payload then configuring that
> will become a lot more complex.  At the minimum you may have to
> make up a dummy file for each server (holding the response payload)
> then then let mod_rewrite rewrite the request internally to make
> Apache serve that file.  Ugly.

A very simple CGI/PHP script will do this, and it's really very very 
trivial to set up.

Please keep in mind I'm not talking hypotheticals at all.  What you have 
proposed is actually a lot uglier for kernel.org to implement, simply 
because we try to stay with strict IP-based vhosting

	-hpa
