From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] hooks--update: new, required, config variable: hooks.envelopesender,
Date: Fri, 23 Mar 2007 14:29:06 +0100
Message-ID: <87wt186qcd.fsf@rho.meyering.net>
References: <874poc88ix.fsf@rho.meyering.net>
	<200703231258.34339.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 14:29:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUjpQ-0002aP-MP
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 14:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422883AbXCWN3J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 09:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422881AbXCWN3J
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 09:29:09 -0400
Received: from mx.meyering.net ([82.230.74.64]:50440 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422883AbXCWN3I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 09:29:08 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id DED436BDF; Fri, 23 Mar 2007 14:29:06 +0100 (CET)
In-Reply-To: <200703231258.34339.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 23 Mar 2007 12:58:31 +0000")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42929>

Andy Parkins <andyparkins@gmail.com> wrote:
> On Friday 2007 March 23 12:11, Jim Meyering wrote:
>> This change adds a new, required, config variable: hooks.envelopesender,
>> and use that with sendmail's -f option.  This is important in order
>> to avoid relying on sendmail's "guess" at an appropriate envelope
>> sender address.  Without this, and in the presence of strict servers,
>> it is far too easy not ever to be notified, or (more insidious) never
>> to receive bounce email.
>
> Won't work.

Thanks for the quick feedback.

It works for me using the sendmail from sendmail, and I have tested
this with the one from postfix, too.

>>From "man sendmail" (although my sendmail is actually exim)
...
> The hook scripts run under the identity of the user doing the push; so "-f"
> won't have an effect.

It has a dramatic effect for me.
With it, mail is sent, without, it's not.

> I'm not sure why you would even need it; as the above quote says, the sender
> is set up as the user who ran the command.

Part of the problem was that sendmail used a mangled hostname.
Without -f, it would use user@foo.domain.com.domain.com.

But IMHO, relying on the current behavior (using envelope sender same as
the From: address) is not an option.  It must be configurable.  I want
the envelope sender to be the same admin address for all outgoing mail,
since that's where reports of delivery problems are sent.  Besides, the
users in question don't even have "real" shell or email access on the server
system, so receiving systems would not be able to authenticate them.

In fact, some of the "users" in question are fake accounts used solely
for write access (via git-server) to the shared git repository, so the
user name exists only on the server system.

If we can't do this portably via the sendmail program, then
perhaps it's a good time to switch to using a module like Net::SMTP.
