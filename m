From: Junio C Hamano <junkio@cox.net>
Subject: Re: maybe breakage with latest git-pull and http protocol
Date: Sat, 15 Oct 2005 09:22:25 -0700
Message-ID: <7v1x2mpx6m.fsf@assigned-by-dhcp.cox.net>
References: <867jciz18w.fsf@blue.stonehenge.com>
	<864q7kqsa4.fsf@blue.stonehenge.com>
	<7vhdbkt8ad.fsf@assigned-by-dhcp.cox.net>
	<86achcoyvz.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0510141543030.23242@iabervon.org>
	<863bn3lypn.fsf@blue.stonehenge.com>
	<7vd5m6py11.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: merlyn@stonehenge.com (Randal L. Schwartz), git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 18:23:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQoo8-0006IJ-Ub
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 18:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVJOQW2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 12:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbVJOQW1
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 12:22:27 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:42174 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751181AbVJOQW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 12:22:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051015162212.UWAM4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Oct 2005 12:22:12 -0400
To: Nick Hengeveld <nickh@reactrix.com>
cc: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <7vd5m6py11.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 15 Oct 2005 09:04:10 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10134>

Junio C Hamano <junkio@cox.net> writes:

> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>
>> OK, it happened this morning.  While syncing to update from
>> yesterday's version, I got:
>
> Thanks.
>
>>     localhost:~/MIRROR/git-GIT % git-pull
>>     Fetching refs/heads/master from http://www.kernel.org/pub/scm/git/git.git using http
>>     Getting alternates list
>>     got 4546738b58a0134eef154231b07d60fc174d56e3
>>     walk 4546738b58a0134eef154231b07d60fc174d56e3
>>     got d402d5566fdf226697a386dfb9858e5d954e9b91
>>     got 873d8e5652c06c3891278f33546c437efc209c2d
>>     walk d402d5566fdf226697a386dfb9858e5d954e9b91
>>     error: 
>>     Getting pack list
>>     got 0207ab18a3876249a928e7539d8f594a4f6921f1

More interesting is this "error:" without error message.
"Getting pack list" is a signal that we fell back to
fetch_pack(), so this is coming from fetch_object().

I see this line could emit an empty error message, if errorstr
is empty.

	if (request->curl_result != CURLE_OK && request->http_code != 416) {
		ret = error("%s", request->errorstr);
		release_request(request);
		return ret;
	}

So if that is the case maybe my previous speculation that we
sometimes forget to issue a necessary request was wrong.  We
asked for that object and got an error from cURL library...

BTW, I do not think this is related to git.git repository
problem, but I wonder why we do not do fetch_object() against
each altbase in http-fetch.c::fetch(); nobody said you cannot
borrow unpacked object from your neighbour.
