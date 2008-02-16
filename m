From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] mailinfo: support rfc3676 (format=flowed) text/plain
 messages
Date: Fri, 15 Feb 2008 22:57:50 -0800
Message-ID: <7vodahcrrl.fsf@gitster.siamese.dyndns.org>
References: <1203042077-11385-1-git-send-email-jaysoffian@gmail.com>
 <7vr6fei1s4.fsf@gitster.siamese.dyndns.org>
 <76718490802151037m87995c2gacf29667259eae41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 07:58:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQH0h-0006Qt-Ki
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 07:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbYBPG6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 01:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbYBPG6P
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 01:58:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59787 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbYBPG6N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 01:58:13 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 33F1A2E02;
	Sat, 16 Feb 2008 01:58:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 A96952DF2; Sat, 16 Feb 2008 01:58:03 -0500 (EST)
In-Reply-To: <76718490802151037m87995c2gacf29667259eae41@mail.gmail.com> (Jay
 Soffian's message of "Fri, 15 Feb 2008 13:37:49 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74020>

"Jay Soffian" <jaysoffian@gmail.com> writes:

> On Fri, Feb 15, 2008 at 12:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I really do not like this.
>
>>  format=flowed instructs the receivers MUA that it is Ok to
>>  reflow the text when the message is presented to the user.
>
> No, it indicates that the MUA sender mangled the message, but did so in
> a way that it can be unmanged* as long as the receiving MUA implements
> RFC 3676.
>
> * Trailing whitespace removed by the MUA before sending is the one
>   exception that cannot be unmangled; I'll address this further below.

There is no way for you to address this other than brushing it
aside, saying "it does not matter".  The information lost is
information lost.

> Existing code generally shouldn't have trailing whitespace nor
> whitespace only lines. ...

Says who?

We and the kernel folks are probably one of the more whitespace
strict projects, but I am sure both of us get our fair share of
patches that fix whitespace breakages while updating the
surrounding area.  There are existing breakages, and also there
are lines that have deliberate trailing whitespaces.

Also, remember that this is not May 2005.  git is not about the
kernel and git itself.  We passed that point long time ago.
Other communities have different whitespace policies.

> ... However, let's say that it does and that the
> patch refers to one of these lines (either as context or a subtraction).
> In this case that hunk will fail to apply, unless we teach git-apply to
> be lenient if the only difference between the line in the patch and the
> existing code is trailing whitespace.

Failing to apply is not something I am worried about.

Silently applying bogosity is much more problematic, because it
would be _silent_, and "git am" is often used to apply hundreds
of patches in one go.  We need to be able to trust the tool and
the tool should error out when there is any ambiguity.

> In the case of an addition, the patch *shouldn't* contain trailing
> whitespace anyway. If it did, git-apply would in its default
> configuration flag it as a whitespace error.

It just "warns".  It does not strip by default.  It should be a
conscious user decision (done with "am --whitespace=fix") and
the project policy.

>>  So just reject the patch when somebody sends you format=flowed
>>  and ask them to re-send without =flowed, and the world will be
>>  a much better place.
>
> I don't get it. Why not accommodate fascist RFC 3676 MUAs if we can for
> the same reasons we accommodate QP, BASE64, and attachments instead of
> inline?

I need to ask people listening from the sidelines on the list
here.  Was my explanation why MIME attachments and QP/BASE64 are
_fundamentally different_ from format=flowed insufficient?

The point is, format=flowed is _not_ meant for precise transfer
of the content matter.  The design objective of format=flowed
lies elsewhere.  It achieves nicer looking line-wrapping by
sacrificing the precise transfer of the content.  It probably
does a very good job, allowing you to communicate with pals on
text-email enabled phones, although I do not have one so I
cannot judge ;-).

Attachments, QP and BASE64 are all about getting the contents as
intact as possible.  Because they tend to make reviews harder,
git and the kernel community frown upon them.  But our tools
tolerate them, because attachment is a fine or even preferred
way to transfer the patches in other circles.

But format=flowed is different.  It loses information.  Not just
one space at the end of the original line, but if you have very
long line that has more than one spaces at an unfortunate place,
the sending MUA can cut the line there and leave a single
trailing space for the receiving end to reflow.

RFC3676 may be a good text communication medium.  It is just not
suitable for patch transfer.  Just don't use it.
