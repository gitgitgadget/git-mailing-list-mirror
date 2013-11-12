From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [[PATCH v2]] git-send-email: Added the ability to query the number of smtp password questions
Date: Tue, 12 Nov 2013 13:23:17 -0800
Message-ID: <xmqqbo1pgvqy.fsf@gitster.dls.corp.google.com>
References: <1383992508-2097-1-git-send-email-silvio@port1024.net>
	<1384084613-12260-1-git-send-email-silvio@port1024.net>
	<1384084613-12260-2-git-send-email-silvio@port1024.net>
	<xmqqwqkdh59o.fsf@gitster.dls.corp.google.com>
	<20131112203831.GB23418@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: silvio@port1024.net, git@vger.kernel.org,
	Silvio F <silvio.fricke@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 12 22:23:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgLQk-00071U-Dy
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 22:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627Ab3KLVXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 16:23:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50100 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280Ab3KLVXV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 16:23:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E739252FAF;
	Tue, 12 Nov 2013 16:23:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HFKk3z7Oz8AKSDBo01+Bz0g0qjE=; b=QfRIUM
	P226XT1Zk+FVE34NlnApGS05/o3NY162a2jqQGbA4IQk03PnhWpXvv9f9He5Sx5u
	xwBYenfcws4eXtZ33e7TNi7AV6txr1Urqu2OUZsUJkUELaFBiM8Xgjv+W7QAiCE6
	iOrHe6m/SRhRklV66PqxBMW0boCRSwPIIx8kQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xNnuNDMZ9Y28b8PZOIXHixxqAFLTfsp2
	4DPUyebU334MRu6N5b+mrebyanVFdh6YAJjoDM66JA7DDeDMWG8z3u57MiXlCY0u
	MrvZM9pAFXEZxk9e/y9vPMq/i8e6DOVR1EdJTXKME1vX8LEM8ndXPu8nDzAQTVBq
	jC8etWTOj70=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5F7452FAE;
	Tue, 12 Nov 2013 16:23:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13A3852FAC;
	Tue, 12 Nov 2013 16:23:19 -0500 (EST)
In-Reply-To: <20131112203831.GB23418@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 12 Nov 2013 15:38:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A72F72BE-4BE0-11E3-A923-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237758>

Jeff King <peff@peff.net> writes:

> On Tue, Nov 12, 2013 at 09:57:39AM -0800, Junio C Hamano wrote:
>
>> > With this patch "git-send-mail" ask a configurable number of questions to
>> > input the smtp password. Without this patch we have only one trial.
>> 
>> I wonder if Git::credential (or even the underlying lower level
>> credential_fill() in the helper API) should give hints to the caller
>> if calling it again may yield a different result.  An interactive
>> prompt may allow the user to mistype the password and then a later
>> call may return a correct one, but the .netrc helper will read from
>> the file and will return a fixed result, so there is no use calling
>> credential_fill() again.  And in the latter case, you do not want to
>> loop $askpasswordcount times.
>
> It would be pretty easy to add an "interactive=true" flag to the
> credential response (patch below). Credential readers are supposed to
> ignore elements that they don't understand. So storage helpers which are
> told "we got a password interactively" can choose to use that
> information if they want, but current implementations will fall back to
> ignoring it. Similarly, users of "git credential fill" can use it, but
> it won't hurt existing readers.

Yeah, it may be a sensible way forward.

>> I also have to wonder if this logic belongs to git-send-email.
>> Specifically, I wonder if we can place the looping logic in
>> Git::credential, so that other users of the library can take
>> advantage of it?
>
> A very early draft of the credential code added looping, but I cut it
> out (I think before it even made it to the list). I don't recall the
> exact reason, but it was probably a combination of:
>
>   1. It's awkward to do at the credential layer in C, because you need
>      input from the calling code on whether the credential worked or
>      not. The perl Git::credential can take a callback, though, which
>      means the credential code owns the outer loop, and it would be
>      pretty easy to just loop on trying.

I was wondering if it should go to Git::credential; I did not say it
might go to credential_fill() API, exactly for that "fill does not
know if that was accepted" reason.  We are in full agreement, I
think.

> I guess "send-email" does not (always) fall under the same category
> because the user may have put work into a cover letter, or filling
> interactive fields. So I have no objection to adding it there, but I do
> agree we might as well put it in Git::credential.
