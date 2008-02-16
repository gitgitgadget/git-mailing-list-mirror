From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] mailinfo: support rfc3676 (format=flowed) text/plain
 messages
Date: Sat, 16 Feb 2008 01:59:28 -0800
Message-ID: <7vlk5l9q7z.fsf@gitster.siamese.dyndns.org>
References: <1203042077-11385-1-git-send-email-jaysoffian@gmail.com>
 <7vr6fei1s4.fsf@gitster.siamese.dyndns.org>
 <76718490802151037m87995c2gacf29667259eae41@mail.gmail.com>
 <7vodahcrrl.fsf@gitster.siamese.dyndns.org>
 <76718490802152343g6a987c8ay80493187d0a3ccba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 11:00:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQJq7-0007UE-OM
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 11:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbYBPJ7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 04:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752703AbYBPJ7h
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 04:59:37 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40596 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbYBPJ7f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 04:59:35 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DACC43DE;
	Sat, 16 Feb 2008 04:59:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 65D3943DD; Sat, 16 Feb 2008 04:59:30 -0500 (EST)
In-Reply-To: <76718490802152343g6a987c8ay80493187d0a3ccba@mail.gmail.com>
 (Jay Soffian's message of "Sat, 16 Feb 2008 02:43:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74035>

"Jay Soffian" <jaysoffian@gmail.com> writes:

> On Feb 16, 2008 1:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Well, according to the RFC, that shouldn't be the case. The only
> lost information should be trailing whitespace. Embedded
> whitespace should not be altered.

Unfortunately, actual implementations and people's use matter
more.  I usually do not use graphical MUAs but when I tried to
paste long lines to Thunderbird (or was it Evolution, I do not
recall), it behaved as if I was typing the words, folded them at
convenient inter word spaces.  I would not blindly trust what
RFC says.

There also seem to be a strong correlation between people who
allow their MUA to send format=flowed when sending patches and
people who cut and paste their patches to their MUA, corrupting
whitespaces.

>> RFC3676 may be a good text communication medium.  It is just not
>> suitable for patch transfer.  Just don't use it.
>
> Would you consider making this configurable. Something like:
>
> applymail.allowed_flowed = true/false/warn
>
> If you're completely opposed though, we should modify git-am
> (and/or mailinfo) to reject format=flowed messages entirely, no?

I would not even consider applying flowed message these days (my
workflow is to review in MUA, save perhaps worthy ones to a
separate mailbox and after re-reviewing apply), so they will not
hit "git am" and it would not personally affect me.  Honestly, I
do not care very much either way.

But for some projects (perhaps the ones that do not value their
source as much as we do ;-)) accepting a subset of flowed
contents might be reasonable and even useful.  Maybe something
like this would be reasonably safe and still useful?

 - A format=flowed message that actually has a flowed line is
   always rejected;

 - If there is no flowed line (i.e. lines that end with SP) in
   the message, we unstuff the initial space to produce the
   result (there won't be anything else that is funny, will
   there?  In a patch we do not care much about the quotation of
   discussions):
 
   - If apply.whitespace is set to nowarn, we do not warn even
     though we might have lost the trailing whitespaces.

   - If apply.whitespace is set to warn, we warn about the
     flowed message.

   - If apply.whitespace is set to error or fix, we error out,
     but still leaving the result for manual inspection.

I dunno.

By the way, I do not think a solution that only uses
configuration is usable.

When you have to apply many patches, you set your configuration
to the most strict (i.e. apply.whitespace=error), and when the
processing errors out, you then inspect the situation and
manually override with the command line --whitespace=fix (or
"warn") to process that one message.  You need both.

Since mailinfo now has only a very few users (quiltimport and
"am"), we probably could add --whitespace option to mailinfo,
and teach "am" to pass --whitespace command line option it was
given (otherwise the value from apply.whitespace configuration)
when running mailinfo, if we were to do a "safer subset" as
outlined above.
