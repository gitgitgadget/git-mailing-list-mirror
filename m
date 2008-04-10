From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Corporate firewall braindamage
Date: Thu, 10 Apr 2008 14:11:19 -0700
Message-ID: <47FE8277.8070503@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: ftpadmin <ftpadmin@kernel.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 10 23:12:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jk447-0006vh-AH
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 23:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757575AbYDJVLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 17:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757568AbYDJVLa
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 17:11:30 -0400
Received: from terminus.zytor.com ([198.137.202.10]:56819 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756559AbYDJVL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 17:11:29 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m3ALBJdF021645
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Apr 2008 14:11:20 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m3ALBJwL013923;
	Thu, 10 Apr 2008 14:11:19 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m3ALBJ56013801;
	Thu, 10 Apr 2008 14:11:19 -0700
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
X-Virus-Scanned: ClamAV 0.92.1/6005/Tue Feb 26 14:01:21 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79249>

The apparent commonality of corporate firewall braindamage, and the 
resulting "need" of people to pull over dumb (http) transport, is an 
ongoing problem on kernel.org.

I have thought some about what can be done to improve the situation, and 
I have come up with the following list of possibilities, pretty much 
listed in order from easiest and least generic to hardest and most generic.

It would be very interesting if people who have familiarity with this 
particular class of braindamaged firewalls could comment on how many 
users would be helped by which ones of these solutions.


1. git protocol via CONNECT http proxy

    Connect to http proxy, and use a CONNECT method to establish a link
    to the git server, using the normal git protocol.

    Minor change to TCP connection setup, but no other changes needed.
    No changes on the server side.


2. git protocol over SSL via CONNECT http proxy

    Same as #1, but encapsulate the data stream in an SSL connection.
    If the git server is run on port 443, then the fact that the data
    on the SSL connection isn't actually HTTP should be invisible to the
    proxy, and thus this *should* work anywhere which allows https://
    traffic.

    Requires the git server to speak SSL.


3. git protocol encapsulated in HTTP POST transaction

    git protocol is already fundamentally a RPC protocol, where the
    client sends a query and the server responds.  Furthermore, it
    tries to minimize the number of round trips (RPC calls), which is
    of course desirable.

    Each such RPC transaction could be formulated as an HTTP POST
    transaction.

    This requires modifications to both the client and the server;
    furthermore, the server can no longer rely on the invariant "one TCP
    connection == one session"; a proxy might break a single session
    into arbitrarily many TCP connections.

Thoughts?

	-hpa
