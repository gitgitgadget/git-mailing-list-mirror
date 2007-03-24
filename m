From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] hooks--update: new, required, config variable: hooks.envelopesender,
Date: Sat, 24 Mar 2007 12:27:12 +0100
Message-ID: <87wt1651bj.fsf@rho.meyering.net>
References: <874poc88ix.fsf@rho.meyering.net>
	<200703231412.41591.andyparkins@gmail.com>
	<87lkho6ky8.fsf@rho.meyering.net>
	<200703231615.28350.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 12:27:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV4P0-00037Z-VB
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 12:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbXCXL1P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 07:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbXCXL1P
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 07:27:15 -0400
Received: from mx.meyering.net ([82.230.74.64]:55207 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbXCXL1N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 07:27:13 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 11B3E197C; Sat, 24 Mar 2007 12:27:12 +0100 (CET)
In-Reply-To: <200703231615.28350.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 23 Mar 2007 16:15:26 +0000")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42994>

> On Friday 2007 March 23 15:25, Jim Meyering wrote:
>> Andy Parkins <andyparkins@gmail.com> wrote:
>> > On Friday 2007 March 23 13:29, Jim Meyering wrote:
>> >> It works for me using the sendmail from sendmail, and I have tested
>> >> this with the one from postfix, too.
>> >
>> > Is your user set as a trusted user for sendmail though?
>>
>> No.  There is no need for that.
>>
>> > As a normal user wouldn't be allowed to do it.
>>
>> You mean with exim's sendmail?
>> sendmail -f alt-envelope-sender works just fine when run by a
>> non-privileged user when it's Sendmail's sendmail or the one from Postfix.
>> It's a shame if it doesn't work with exim's implementation.
>
> Okay; I went and found a sendmail manpage:
>
> "-fname       Sets the name of the ``from'' person (i.e., the sender of the
>               mail).  -f can only be used by ``trusted'' users (normally
>               root,  daemon, and network) or if the person you are trying to
>               become is the same as the person you are."
>
> Seems the same as exim to me.  Perhaps your distribution sets it up to allow
> if for anyone?

I suspect that the above is from older documentation.
As you'll see in the excerpts below, the "can only be used"
is replaced with "should...", to permit using -f in cases like mine.

The documentation from sendmail-8.11.7/doc/op/op.me says this:

-f addr   The envelope sender address is set to addr.  This
          address  may  also  be used in the From: header if
          that header is missing during initial  submission.
          The envelope sender address is used as the recipi-
          ent for delivery status notifications and may also
          appear in a Return-Path: header.

Then, in cf/README, they explain the trusted-users file is solely
to avoid a warning:

use_ct_file     Read the file /etc/mail/trusted-users file to get the
                names of users that will be ``trusted'', that is, able to
                set their envelope from address using -f without generating
                a warning message.  The actual filename can be overridden
                by redefining confCT_FILE.

A quick search found lots like this:
  http://www.linuxmanpages.com/man8/sendmail.8.php

    -fname
        Sets the name of the ``from'' person (i.e., the envelope sender of
        the mail). This address may also be used in the From: header if
        that header is missing during initial submission. The envelope
        sender address is used as the recipient for delivery status
        notifications and may also appear in a Return-Path: header. -f
        should only be used by ``trusted'' users (normally root, daemon,
        and network) or if the person you are trying to become is the
        same as the person you are. Otherwise, an X-Authentication-Warning
        header will be added to the message.

So that was classic sendmail (8.11.7).  Here's the description of -f
for postfix's sendmail (man sendmail):

       -f sender
              Set the envelope sender  address.  This  is  the  address  where
              delivery problems are sent to. With Postfix versions before 2.1,
              the  Errors-To:  message  header  overrides  the  error   return
              address.

In addition, I have tested this by sending myself a message
via printf '...' |sendmail -f nobody@nowhere.com -oi -t -v, and
examined the headers in the received messages.  The first I sent
from a system running sendmail-8.11.7, the second from one running
Debian/unstable's Postfix 2.3.8-2.  Both were sent by a "regular" (non-root)
user, and the envelope sender was the requested "nobody@nowhere.com"
in each case.

> So; in short: I don't have a good answer to offer you, and it seems that "-f"
> is working for you.

Yes, it does work for me.  And it would work for anyone with
sendmail or Postfix.  Whether it works for an exim-based
sendmail is a question of policy, and the default in Debian-based
systems is to allow it:

>From /etc/exim4/conf.d/main/02_exim4-config_options:

  .ifndef MAIN_FORCE_SENDER
  local_from_check = false
  local_sender_retain = true
  untrusted_set_sender = *
  .endif

> However, I'm still not convinced that this is the
> correct thing to do in the default hook.  My main gripe is still all
> these "trusted user" paragraphs in the MTA manual pages.

There is a legitimate need for this functionality, and -f does
usually work, so how about a compromise:

  Include support for using sendmail's "-f envelope-sender" option
  in the default hook, but enable it only if/when hooks.envelopesender
  is set in the config file.
