From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should "git apply --check" imply verbose?
Date: Tue, 20 Aug 2013 10:57:25 -0700
Message-ID: <xmqqioz06y9m.fsf@gitster.dls.corp.google.com>
References: <5213873A.6010003@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 19:57:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBqBa-0006JW-NX
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 19:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610Ab3HTR5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 13:57:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35742 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586Ab3HTR5i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 13:57:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 846D33AE54;
	Tue, 20 Aug 2013 17:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SkzWtuRaMH29CYPyuL4jeDZW884=; b=gN3nkk
	DuFkP+9JYEn8UktFQqmTUQycI6yeUzd50OEYijDqFSlBi3TtTkUdGZIC9kHsS2qg
	FRKBzXkza3Uiz3NgDEsKkH7JCs8f/W0C5GVNNSm2w+hB5U42oEBZFCJ+25xzuUNs
	JcunNuipSxIqtErN1pJgsgDmAr7EN7y3HXs38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bCgIyoFIHaNAlL+j/LgUwJSxHBUSnGtt
	GQT8exoNdYkAokqyqFFC8cnGrKCduzBtS/WWgiJYWPJYLvAHOvQXFPICQkAA41pV
	uulErqOwruAcykRykuabd+DLQGhG8FfVY7iZioj5nMZxEIdTtRyUXPMPf/HLppeG
	pPfETkX/wzY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BB5A3AE53;
	Tue, 20 Aug 2013 17:57:37 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3A5B3AE48;
	Tue, 20 Aug 2013 17:57:35 +0000 (UTC)
In-Reply-To: <5213873A.6010003@windriver.com> (Paul Gortmaker's message of
	"Tue, 20 Aug 2013 11:11:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FEB91CA8-09C1-11E3-89A9-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232622>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> TL;DR -- "git apply --reject" implies verbose, but the similar
> "git apply --check" does not, which seems inconsistent.

Hmmm, I am of two minds.  From purely idealistic point of view, I
can see why defaulting both to non-verbose may look a more
attractive way to go, but I have my reservations that is more than
the usual change-aversion.

Historically, "check" was primarily meant to see if the patch is
applicable cleanly in scripts, and we never thought it would make
any sense to make it verbose by default.  

On the other hand, the operation of "reject", which was a much later
invention, was primarily meant to be observed by humans to see how
the patch failed to cleanly apply and where, to help them decide
where to look in the target to wiggle the rejected hunk into (even
when it is driven from a script).  It did not make much sense to
squelch its output.

In addition, because "check" is an idempotent operation that does
not touch anything in the index or the working tree, running with
"check" and then "check verbose" is possible if somebody runs it
without verbose and then decides later that s/he wants to see the
details.  But "reject" does touch the working tree files with
applicable hunks, so after a quiet "reject", there is no way to see
the verbose output like you can with "check".
