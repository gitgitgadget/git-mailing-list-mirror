From: Dave Borowitz <dborowitz@google.com>
Subject: Thoughts on refactoring the transport (+helper) code
Date: Thu, 13 Aug 2015 11:42:50 -0400
Message-ID: <CAD0k6qR5AgtaDX3HuE1NVHnxsrAnYFnV1TYHWJsCJoD22ABb1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 17:43:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPuey-0005uh-CQ
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 17:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227AbbHMPnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 11:43:12 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:34288 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbbHMPnL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 11:43:11 -0400
Received: by iodb91 with SMTP id b91so55936411iod.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=/eOgQyMQCBZLeDVlBSAuDp8btcxqGY5QD9EN8RvE0i4=;
        b=f3KcfozCkrh9H2l/wMxO3URI2J5kA2YT9OPwVIHoPevQ0PtuenL/7uybPbLXwYs1pY
         Xif+RSa5Ah5hIX6GxC2l9o5cwvChzLQrM2tcwfAQbDTGVeB11VvFg0pLFhngatUkqtyy
         IN4k5n1PqXRu2y4ZoGiNiBt52g78+skpA5Wk/PSK9+Qhaas3qBOfunNPlDNl4zUnppAX
         ysbnSxZqV+v6WFIQd6fWZFO5lFCsjOI9Rbwbhdhjb/9s1dlzYDAU0Ik39T+JJorr3HEC
         TZ82g4A68YE1bkhB20pmCISQHIAInw6OUHcHsLa4xth4ZYDO1iPIT17zNl8v+Ok7GxBB
         bPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=/eOgQyMQCBZLeDVlBSAuDp8btcxqGY5QD9EN8RvE0i4=;
        b=bhJYQoq+Zevi3MLZxhi/ijVM0Yn1lBuawRitmmHVKFMFSVg0xUHtvclFIUwwAvXH1f
         q71rUqjUEszEpsiiU4a4XHo4UaiAe4TuwISdoMHmXJr6dROyLQd7Y+dpD37LlQJ1/L1K
         VtwbxRqJ9m/ZgIkXDbIDByusZum8IBS/CaBqN/+X1MVpbppzwz5ztCWw5v0HBIlKSeIC
         SIX4r6box6jphBWDSKjy/DT0aZy/YwHZ3gsf91Ei82SI5Ry3sUj3uCl3LjZGdS1aFCAU
         SHUAl0uiFjOQfJ3vL1++4yQRLdAmFDZa0rpcn694Mq2+uaFhQkp6YRKprQYE2uSLGdC9
         WJjA==
X-Gm-Message-State: ALoCoQkw+mjbFWD51h91jMbGcdqEFVKEWmhk/fpUw4rHLb+PGF5ooc2N17FJFyaOG4uXqBdnQ0GP
X-Received: by 10.107.11.17 with SMTP id v17mr43684259ioi.184.1439480590143;
 Thu, 13 Aug 2015 08:43:10 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Thu, 13 Aug 2015 08:42:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275850>

I spent a day trying to understand what the heck is going on in the
transport code, with the intent of adding an option like
--sign-if-possible to git push. This has come up twice on the mailing
list in the past couple weeks, and I also think it's important for
$DAY_JOB.

I'm giving up in despair, but I decided to leave some comments that
will hopefully help a future, more enterprising refactorer. Please
don't read this (entirely) as a rant; I understand that the transport
code is old and hairy and grew organically to get to this point. I
really do just hope this makes the next guy's job easier in
understanding the code. (But then again, this hope may be in vain:
it's not like I searched the mailing list myself before diving in :)

One of the biggest issues IMO is that the idea of "options" for
transports is grossly overloaded:

-struct git_transport_options contains mostly boolean options that are
read in fetch.c to enable certain options.

-In push.c, we for the most part ignore the smart_options field in
transport, and instead rely on the flags bitfield. However, some (not
all) flags in this bitfield have seemingly-equivalent fields in
git_transport_options. In some cases (particularly push_cert), the
field in git_transport_options is ignored.

-Similarly, one might think the executable arg to the connect callback
might bear some relation to the uploadpack/receivepack field in
smart_options. It does not.

-Some (but by no means all) options are set via transport_set_option
by passing in one of the TRANS_OPT_* string constants. This a)
switches on these values and populates the appropriate smart_options
field, and b) calls the set_option callback.

-The end result is that the TRANS_OPT_* constants are a mixture of
things that can be set on the command line and things that are
documented in the remote helper protocol. But there are also options
used in the remote helper protocol that are hard-coded and have no
constant, or can't be set on the command line, etc.

-The helper protocol's set_helper_option synchronously sends the
option to the helper process and reads the response. Naturally, the
return code from transport_set_option is almost always ignored.

In my ideal world:
-smart_options would never be NULL, and would instead be called
"options" with a "smart" bit which is unset for dumb protocols.
-Command line option processing code in {fetch,clone,push}.c would set
fields in options (formerly known as smart_options) rather than
passing around string constants.
-TRANS_OPT_* string constants would only be used for remote helper
protocol option names, and no more hard-coding these names.
-The flags arg to the push* callbacks would go away, and callbacks
would respect options instead.
-The helper code would not send options immediately, but instead send
just the relevant options immediately before a particular command
requires them. Hopefully we could then eliminate the set_option
callback entirely. (Two things I ran into that complicated this: 1)
backfill_tags mutates just a couple of options before reusing the
transport, and 2) the handling of push_cas_option is very
special-cased.)

There are other confusing things but I think that would make option
handling in particular less of a head-scratcher.
