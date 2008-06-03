From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: git-fetch vs ipv6 routing issues
Date: Tue, 3 Jun 2008 22:50:16 +0200 (CEST)
Message-ID: <alpine.LRH.1.10.0806032242050.10782@yvahk3.pbagnpgbe.fr>
References: <m38wxq1hou.fsf@eagle.jhcloos.com> <alpine.LRH.1.10.0806010924340.27605@yvahk3.pbagnpgbe.fr> <m3wsl6guqg.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: James Cloos <cloos@jhcloos.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 22:52:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3dTb-0002DV-Jd
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 22:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757179AbYFCUuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 16:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbYFCUuZ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 16:50:25 -0400
Received: from kluster1.contactor.se ([91.191.140.11]:60485 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756072AbYFCUuX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 16:50:23 -0400
Received: from linux3.contactor.se (linux3.contactor.se [91.191.140.23])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id m53KoGFV004852;
	Tue, 3 Jun 2008 22:50:16 +0200
X-X-Sender: dast@linux3.contactor.se
In-Reply-To: <m3wsl6guqg.fsf@lugabout.jhcloos.org>
User-Agent: Alpine 1.10 (LRH 962 2008-03-14)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83708>

On Tue, 3 Jun 2008, James Cloos wrote:

> But git could be smarter about it.  libcurl has CURLOPT_IPRESOLVE which can 
> be set to any of CURL_IPRESOLVE_WHATEVER, CURL_IPRESOLVE_V4 or 
> CURL_IPRESOLVE_V6.  Git could at least allow setting that via a config 
> option and/or an env var, just like it does for libcurl options like 
> CURLOPT_LOW_SPEED_LIMIT.

Perhaps, but I thought the git protocol behavior was to dynamicly back off a 
failed connect attempt to try the next? That wouldn't be solvable with any 
preset option. It needs code added to/changed in libcurl.

> Even better would be to set CURLOPT_CONNECT_ONLY and then try with 
> CURL_IPRESOLVE_WHATEVER, CURL_IPRESOLVE_V6 and CURL_IPRESOLVE_V4 in turn 
> until it gets a connection, and then use CURLINFO_LASTSOCKET and the full 
> URL to do the GET.

Eeek. I really disagree with this suggestion. CURLOPT_CONNECT_ONLY means you 
only (TCP or over proxy) connect and nothing more. That would force git to 
implement a lot of HTTP details that libcurl already provides.

If you really really insist on letting git do it and not bring this feature to 
libcurl, then I'd suggest that you first resolve the host, verify it by any 
means you see fit, and then pass the IP to libcurl like in the URL as 
"HTTP://12.23.45.67/blabla" with the correct host name in a custom-provided 
host: header. It'd let you do the resolving magic and let libcurl do the HTTP 
magic. But I wouldn't recommend that either...

-- 

  / daniel.haxx.se - primary libcurl author
