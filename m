From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 04/23] http-push: send out fetch requests on queue
Date: Fri, 05 Jun 2009 13:44:56 -0700 (PDT)
Message-ID: <m3r5xy5s1n.fsf@localhost.localdomain>
References: <20090606000137.ff05ba37.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 22:45:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCgHg-0007A7-VO
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 22:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbZFEUo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 16:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752395AbZFEUo4
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 16:44:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:20385 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbZFEUoz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 16:44:55 -0400
Received: by fg-out-1718.google.com with SMTP id d23so330070fga.17
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 13:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=5PuICpMNTwIaA2Ha8BzZ+BAML/RYLvjslH4934dDy/o=;
        b=Rdphy+tk3WGyfoKjjHOyijFtfpQcJgmo5nb2GEBsBQF3yQik11y7yEJ0cNIUvSQVU6
         JcwWFZNnlxxWoP4/wtQu4YhSCKGTiRyHXVWoaHSZolLMqA5gX8hPwQRj5J5IGmqQ6zLh
         kYRedmifCaHdi/4YUTbcgdzKomf5Dzljabn0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=fllg5K7Vo+lZTrCPIaznOabG1CnHQD/9Zj0Aq5BjxN2gBfYpFUuAunXQYRTy8IPRH3
         ig0d4sy5xZ6SzyGGome0sagpmYwEn1NRCrUvQgCx6QDwYU0pl3lGjPRUGx0wNJDiexj/
         1qKTDFpemwEj3nCMwhqYLfnhBO20mcJxjbURc=
Received: by 10.86.36.4 with SMTP id j4mr4316533fgj.63.1244234696691;
        Fri, 05 Jun 2009 13:44:56 -0700 (PDT)
Received: from localhost.localdomain (abwo21.neoplus.adsl.tpnet.pl [83.8.238.21])
        by mx.google.com with ESMTPS id 12sm851511fgg.25.2009.06.05.13.44.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 13:44:56 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n55Kis3R024588;
	Fri, 5 Jun 2009 22:44:54 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n55KirH7024585;
	Fri, 5 Jun 2009 22:44:53 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090606000137.ff05ba37.rctay89@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120831>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Previously, requests for remote files were simply added to the queue
> (pointed to by request_queue_head) and no transfer actually took
> place[1], even though code that followed may rely on these remote files
       ^^^
       ^^^--- you have footnote reference, but no footnote

> to be present (eg. the setup_revisions invocation).
> 
> The code that sends out the requests on the request queue is refactored
> into the method run_request_queue.
> 
> After the get_dav_remote_heads invocation (ie. after fetch requests are
> added to the queue), the requests on the queue are sent out through an
> invocation to run_request_queue.
> 
> This invocation to run_request_queue entails adding a fill function
> before pushing checks take place, which may lead to accidental,
> unwanted pushes previously.
> 
> The flag is_running_queue is introduced to prevent this from occurring.
> fill_active_slot is made to check the flag is_running_queue before
> the sending of the requests proceeds.
> 
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
[...]

-- 
Jakub Narebski
Poland
ShadeHawk on #git
