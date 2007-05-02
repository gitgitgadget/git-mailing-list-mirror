From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] http-fetch: Disable use of curl multi support for libcurl < 7.16.
Date: Wed, 02 May 2007 21:47:19 +0200
Message-ID: <87647bros8.fsf@wine.dyndns.org>
References: <87slafs7y4.fsf@wine.dyndns.org>
	<7vfy6f3w3w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 02 21:47:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjKnh-0008WA-NA
	for gcvg-git@gmane.org; Wed, 02 May 2007 21:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766831AbXEBTr3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 15:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766833AbXEBTr3
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 15:47:29 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:44445 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766831AbXEBTr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 15:47:28 -0400
Received: from adsl-84-227-166-186.adslplus.ch ([84.227.166.186] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HjKnP-00077K-3K; Wed, 02 May 2007 14:47:27 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 90BA04F68D; Wed,  2 May 2007 21:47:19 +0200 (CEST)
In-Reply-To: <7vfy6f3w3w.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed\, 02 May 2007 11\:42\:59 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46047>

Junio C Hamano <junkio@cox.net> writes:

> Alexandre Julliard <julliard@winehq.org> writes:
>
>> curl_multi_remove_handle() is broken in libcurl < 7.16, in that it
>> doesn't correctly update the active handles count when a request is
>> aborted. This causes the transfer to hang forever waiting for the
>> handle count to become less than the number of active requests.
>
> Is there a changelog entry for release 7.16 that you can point
> at in your commit log message?

The changelog for curl 7.16.0 contains this under Bugfixes:

* the 'running_handles' counter wasn't always updated properly when
  curl_multi_remove_handle() was used

The corresponding fix in the curl CVS is in lib/multi.c rev 1.97:

----------------------------
revision 1.97
date: 2006-08-25 15:53:22 +0200;  author: bagder;  state: Exp;  lines: +5 -1;  commitid: owXRUkUb5VvSmeKr;
Armel Asselin reported that the 'running_handles' counter wasn't updated
properly if you removed a "live" handle from a multi handle with
curl_multi_remove_handle().
----------------------------

The problem is relatively easy to reproduce (though it's not
systematic, depends on network timings) by cloning the Wine repository
at http://source.winehq.org/git/wine.git. The symptoms are that it
hangs after printing 'walk 4eea356e2d39f1a958afb4d8f5b54381e8972ecf'.

It was reported by a Wine developer who couldn't clone the tree with
http; he confirmed that upgrading to curl 7.16 fixed it for him. I'm
also able to clone it successfully with a http-fetch built without
multi support.

-- 
Alexandre Julliard
julliard@winehq.org
