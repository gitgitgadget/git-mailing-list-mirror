From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] http.c: Use curl_multi_fdset to select on curl fds
 instead of just sleeping
Date: Sat, 29 Oct 2011 22:33:44 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1110292230500.28196@tvnag.unkk.fr>
References: <1319901621-482-1-git-send-email-mika.fischer@zoopnet.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Mika Fischer <mika.fischer@zoopnet.de>
X-From: git-owner@vger.kernel.org Sat Oct 29 22:34:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKFbV-0005BZ-Oz
	for gcvg-git-2@lo.gmane.org; Sat, 29 Oct 2011 22:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183Ab1J2Udt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Oct 2011 16:33:49 -0400
Received: from giant.haxx.se ([80.67.6.50]:42273 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754206Ab1J2Uds (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2011 16:33:48 -0400
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id p9TKXjaW016025
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 29 Oct 2011 22:33:45 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id p9TKXiH6016019;
	Sat, 29 Oct 2011 22:33:44 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <1319901621-482-1-git-send-email-mika.fischer@zoopnet.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184457>

On Sat, 29 Oct 2011, Mika Fischer wrote:

> Previously, when nothing could be read from the connections curl had open, 
> git would just sleep unconditionally for 50ms. This patch changes this 
> behavior and instead obtains the recommended timeout and the actual file 
> descriptors from curl. This should eliminate time spent sleeping when data 
> could actually be read/written on the socket.

It looks fine to me, from a libcurl perspective. I only have one comment about 
this:

> +			curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
> +
> +			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);

At times, curl_multi_fdset() might return -1 in max_fd, as when there's no 
internal socket around to provide to the application to wait for.

Calling select() with max_fd+1 (== 0) will then not be appreciated by all 
implementations of select() so that case should probably also be covered by 
the 50ms sleep approach...

-- 

  / daniel.haxx.se
