From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH] t9501: Skip testing load if we can't detect it
Date: Sat, 6 Feb 2010 08:46:00 -0500
Message-ID: <0CD6B283-3181-4FAB-A6B2-13AFF9E5071C@gernhardtsoftware.com>
References: <1265432440-52146-1-git-send-email-brian@gernhardtsoftware.com> <m3eikya9tn.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 14:46:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdkzH-0002I8-T3
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 14:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755752Ab0BFNqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 08:46:10 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:38083 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755625Ab0BFNqI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2010 08:46:08 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 835BB1FFC1CE; Sat,  6 Feb 2010 13:46:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-67-240-172-169.rochester.res.rr.com [67.240.172.169])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id BD7A71FFC06B;
	Sat,  6 Feb 2010 13:45:59 +0000 (UTC)
In-Reply-To: <m3eikya9tn.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139166>


On Feb 6, 2010, at 6:22 AM, Jakub Narebski wrote:

> Brian Gernhardt <brian@gernhardtsoftware.com> writes:
> 
>> Currently gitweb only knows how to check for load using /proc/loadavg,
>> which isn't available on all systems.  We shouldn't fail the test just
>> because we don't know how to check the system load.
>> 
>> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> 
> NAK.  It is not necessary, and it would be hindrance (one more place
> to update) if we are to extend get_loadavg() in gitweb to work without
> /proc/loadavg, e.g. via BSD::loadavg module.

Without this patch, the test fails on my OS X machine (which doesn't have /proc).  So _something_ is necessary.  Skipping the test because we can't use the feature on the host machine seemed more in line with what the other tests do with things like symlinks and file modes.  And if get_loadavg() is updated to use BSD::loadavg, the test should still be skipped if the module isn't installed.

Furthermore, tests should always be updated when a feature is changed.

> Let me explain how it currently works without /proc/loadavg.  

I did check the code.

> Third, the test (as you can see below in context line in quoted diff
> below) forces gitweb to go over maximum load by setting $maxload to 0.
> This means that regardless of true load, and regardless whether gitweb
> can detect system load (remember that if it cant get system load it
> returns 0 instead) gitweb would be in "load too high" situation.

I did check the code.  Skipping the test seemed more in line with other tests.

sub get_loadavg {
    if( -e '/proc/loadavg' ){}
    return 0;
}

if (defined $maxload && get_loadavg() > $maxload) {
}

Setting $maxload to 0 does _not_ trigger failure because zero is not greater than 0.  Setting $maxload to -1 might work though.  I'll try it and test it in a little bit.  While I disagree that it's a good way to handle the situation, I will see if it works.

~~ Brian