From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv2 2/2] receive-pack: Add receive.objectCountLimit to refuse
 push with too many objects
Date: Sat, 14 May 2011 15:17:45 +0200
Message-ID: <201105141517.45324.johan@herland.net>
References: <201105131854.31540.johan@herland.net>
 <201105140403.09981.johan@herland.net>
 <BANLkTik_taBK+=nh+0WEUjp3AV_fC7e_dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 14 15:18:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLEk5-0000SW-8D
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 15:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609Ab1ENNRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 09:17:50 -0400
Received: from smtp.getmail.no ([84.208.15.66]:58854 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752496Ab1ENNRt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 09:17:49 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL600JGGSXNHA10@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 14 May 2011 15:17:47 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 590621EF06D5_DCE80FAB	for <git@vger.kernel.org>; Sat,
 14 May 2011 13:17:46 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 380C21EF0CFF_DCE80FAF	for <git@vger.kernel.org>; Sat,
 14 May 2011 13:17:46 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL6001O1SXMCY10@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Sat, 14 May 2011 15:17:46 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <BANLkTik_taBK+=nh+0WEUjp3AV_fC7e_dg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173582>

On Saturday 14 May 2011, Shawn Pearce wrote:
> I wonder... should we instead export the objectCountLimit as part of
> the advertisement to the client, and teach send-pack to look at this
> and pass it down to pack-objects? If pack-objects winds up with more
> than this limit, it aborts and the client doesn't even transmit data.
> Newer clients would abort cleanly with a nice error.

Good idea (although it grows the scope from the quick-fix I initially 
intended it to be...)

I'm planning to add a new capability collection/namespace, called "limit-*", 
where the server can communicate capabilities to the client, like so:

  limit-object-count_100000
  limit-commit-count_1000
  limit-pack-size_500000000

(I'd prefer to s/_/=/ or s/_/:/, but according to pack-protocol.txt, a 
capability may not contain "=" or ":")

However, you say:

> For older clients that don't know this new advertised capability, they
> should fail hard and not transfer all of this data.

AFAICS this is not the case. If a client does not understand a capability, 
it simply ignores it, and carries on doing its usual thing.

IINM there are only two ways to prevent an older client from transferring 
all the data:

1. Change the pack protocol in an incompatible way, that causes older client 
to abort with a pack format error prior to transmitting the pack.

2. (as in initial patch) Abort receive-pack when the server detects a limit 
violation, leaving the client with a broken pipe. I haven't read the pack 
protocol closely, but I wouldn't be surprised if this behavior is strictly 
in violation of the protocol.

> In my experience
> when a user gets these strange errors from his Git client, he contacts
> his server administrator with the screen output. At which point the
> administrator can see the Counting objects line, check the repository
> configuration, and tell the user what the problem is... and encourage
> them to upgrade their client to a newer version.

Hmm... Not ideal, but I guess we can live with that. At least we should warn 
the server administrator of this in the documentation of the config 
variable(s).


Otherwise, I agree with everything you wrote.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
