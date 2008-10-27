From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add support for uintmax_t type on FreeBSD 4.9
Date: Sun, 26 Oct 2008 23:17:45 -0700
Message-ID: <7v1vy2imt2.fsf@gitster.siamese.dyndns.org>
References: <1225021957-11880-1-git-send-email-david.syzdek@acsalaska.net>
 <7vy70aip06.fsf@gitster.siamese.dyndns.org>
 <9a0027270810262239r311074m51d382bdd95fd0dc@mail.gmail.com>
 <9a0027270810262246i56cf5515l5fa0875f91d90a7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David Syzdek" <syzdek@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 07:19:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuLRc-0002Nr-4Q
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 07:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbYJ0GSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 02:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbYJ0GSA
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 02:18:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbYJ0GR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 02:17:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 43F6074D94;
	Mon, 27 Oct 2008 02:17:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D9EC174D92; Mon, 27 Oct 2008 02:17:53 -0400 (EDT)
In-Reply-To: <9a0027270810262246i56cf5515l5fa0875f91d90a7a@mail.gmail.com>
 (David Syzdek's message of "Sun, 26 Oct 2008 21:46:20 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FFF2956A-A3EE-11DD-BAB5-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99208>

"David Syzdek" <syzdek@gmail.com> writes:

> On Sun, Oct 26, 2008 at 9:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> I have a stupid question.
>>
>> Would it be a more appropriate improvement to do it like this:
>>
>>        ifdef USE_THIS_AS_UINTMAX_T
>>            BASIC_CFLAGS += -Duintmax_t="$(USE_THIS_AS_UINTMAX_T)"
>>        endif
>>
>> and then add a section for FreeBSD 4.9-SECURITY like this:
>>
>>        ifeq ($(uname_R),4.9-SECURITY)
>>                USE_THIS_AS_UINTMAX_T = uint32_t
>>        endif
>>
>> That way, an oddball 64-bit machine can use uint64_t here if it wants to,
>> possibly including FreeBSD 4.9-SECURITY backported to 64-bit ;-).
>>
>
> Your suggestion provides more flexibility for other environments. I
> was making the assumption that 64-bit systems would define uintmax_t,
> however in retrospect that would be unwise.
> Would you like me to resubmit the patches with your modifications?

Actually there was a reason why I said this was a "stupid" question.  I
think your assumption on 64-bit platforms would hold in practice, and my
suggestion could be an unnecessary overengineering.  If nobody knows of a
system that would benefit from such a generalization, your original patch
would be better, partly because I think:

 (1) USE_THIS_AS_UINTMAX_T is just for demonstration of concept and is a
     terrible name we cannot possibly use in our Makefile.  We have to
     spend brain cycles to come up with a better name; and

 (2) It may be tricky to come up with autoconf macros to determine what to
     set USE_THIS_AS_UINTMAX_T to.

As a slightly unrelated aside, I find it somewhat unfortunate that the
conditional says "4.9-SECURITY", which is a bit too explicit and specific.
to my taste.  I do not know how FreeBSD versioning scheme works, but
wouldn't your change work equally well for 4.9-RELEASE or 4.11-RELEASE?

I suspect that you would want to say "$(uname_R) that begins with '4.' or
smaller needs this workaround", as strtoul(3) manual page seems to appear
first in FreeBSD 5.0-RELEASE (but not found in FreeBSD 4.11-RELEASE).
