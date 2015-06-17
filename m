From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] test-lib.sh: fix color support when tput needs ~/.terminfo
Date: Wed, 17 Jun 2015 15:23:49 -0700
Message-ID: <xmqq7fr255ze.fsf@gitster.dls.corp.google.com>
References: <xmqqvbem5bx9.fsf@gitster.dls.corp.google.com>
	<1434575481-24604-1-git-send-email-rhansen@bbn.com>
	<1434575481-24604-3-git-send-email-rhansen@bbn.com>
	<20150617221331.GA26069@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 18 00:24:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5LkS-0000kc-V6
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 00:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbbFQWXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 18:23:52 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37745 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbbFQWXv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 18:23:51 -0400
Received: by igbsb11 with SMTP id sb11so47653625igb.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 15:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=i2fump4RgmuzIszY8LLjZax4koPmnqVqpM9pSSPoujc=;
        b=eZWijAKS084P1aYyQzuxDt/f+Uh2/boRDKr/gvpHGsc1ue6IijNZFscdKnUw6gOpNI
         XS/7fcgQqt6OMRNluDdsA4JMlp5Ozso6+mY17nJrVfFMTvQnF68rGoLPkOE4tNh/izeE
         i6kXccjkoBXXuD12B4iQ5UMkzApZ94XeFNje/Mok6n9hBO0AbOk9Zl8juLHGZwbKij8Y
         8j0P5XhDO4M8DI9rVIDOEWv8qA3c4Kf+VsxiwWKQNkq/wBiugI6OuHec/O8Mf/BHtejw
         kjIfcE+6caRs8M1pdU5JL0hf1r1JxpNVZT8GbEAY5046y+hXskK3VfWhC5pXUQeCzWkv
         SjJg==
X-Received: by 10.50.225.35 with SMTP id rh3mr37964543igc.29.1434579830985;
        Wed, 17 Jun 2015 15:23:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id t7sm12840441ign.8.2015.06.17.15.23.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 15:23:50 -0700 (PDT)
In-Reply-To: <20150617221331.GA26069@peff.net> (Jeff King's message of "Wed,
	17 Jun 2015 18:13:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271922>

Jeff King <peff@peff.net> writes:

> On Wed, Jun 17, 2015 at 05:11:21PM -0400, Richard Hansen wrote:
>
>> +		test -z "$1" && test -n "$quiet" && return
>> +		eval "say_color_color=\$say_color_$1"
>
> Thanks, this looks much simpler.
>
> In the non-quiet case, you will eval $say_color_, even though we know it
> to be bogus.

Yeah, but there is this gem in this patch:

+	...
+	say_color_info=$(tput setaf 6) # cyan
+	say_color_reset=$(tput sgr0)
+	say_color_="" # no formatting for normal text

In other words, the patch handles these two in the same mechanism:

	say_color error "this is my error message"
	say_color "" "ok this is just a regular message"

and treating an empy string just one of the supported "colors",
i.e. "error", "skip", "warn", "pass", "info" "reset" and "" are the
colors.

> I guess we need to make sure say_color_color is blank,
> though. The alternative would be:
>
>   if test -z "$1"; then
>     test -n "$quiet" && return
>     say_color_color=
>   else
>     eval "say_color_color=\$say_color_$1"
>   fi
>
> I dunno if that makes the intent more clear or not. I am OK with it
> either way.

I am OK with it either way, too.
