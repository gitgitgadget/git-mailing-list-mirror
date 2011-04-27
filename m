From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 4/6] Add config variable for specifying default --dirstat
 behavior
Date: Wed, 27 Apr 2011 04:02:17 +0200
Message-ID: <201104270402.17685.johan@herland.net>
References: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
 <1303776102-9085-5-git-send-email-johan@herland.net>
 <7vtydlezfj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 04:02:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEu5E-0006MQ-KG
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 04:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279Ab1D0CCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 22:02:20 -0400
Received: from smtp.getmail.no ([84.208.15.66]:39683 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756158Ab1D0CCT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 22:02:19 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKA00AAKGBUMS50@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Apr 2011 04:02:18 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 462821EEEF60_DB7792AB	for <git@vger.kernel.org>; Wed,
 27 Apr 2011 02:02:18 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 2C8EA1EEEF52_DB7792AF	for <git@vger.kernel.org>; Wed,
 27 Apr 2011 02:02:18 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKA002LMGBUY610@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Apr 2011 04:02:18 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.2; x86_64; ; )
In-reply-to: <7vtydlezfj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172147>

On Tuesday 26 April 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > +static void init_default_diff_options()
> > +{
> > +	static int initialized = 0;
> > +	if (initialized)
> > +		return;
> > +
> > +	default_diff_options.dirstat_percent = 3;
> > +
> > +	initialized = 1;
> > +}
> 
> This smells fishy on two counts.
> 
>  . The rest of the diff machinery is designed to be callable multiple
>    times by calling diff_setup(), and there should be no place for any
>    call-once function like this one.

True. I needed it because the hardcoded "options->dirstat_percent = 3" in 
diff_setup() would overwrite the "diff.dirstat=10" stored in 
default_diff_options.dirstat_percent. Instead, I needed the fallback "3" to 
be stored in default_diff_options.dirstat_percent before "diff.dirstat" was 
parsed.

>  . Why is dirstat-percent _so_ special that it is the only one that has
>    to be initialized this way, when the function name implies that this
>    is the central place to control the initialization of all diff
>    related options?

Once I added init_default_diff_options(), I did in fact try to move the 
other hardcoded diff options from diff_setup(). However, I ended up with a 
lot of test failures, so I quickly gave up on that.

In the upcoming re-roll, I have solved the problem in a different way (using 
a static variable to store the default dirstat percentage).

> > +static void dirstat_opt_args(struct diff_options *options, const char
> > *args) +{
> > +	const char *p = args;
> > +	while (*p) {
> > +		if (!prefixcmp(p, "changes")) {
> > + ...
> > +		}
> > +	}
> > +}
> 
> Please move this part to the previous patch in your reroll.  This helper
> is what the previous patch should have been written with.

Will do.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
