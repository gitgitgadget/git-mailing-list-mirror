From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH resent] send-email: Honor multi-part email messages
Date: Fri, 25 Jan 2013 10:14:30 -0800
Message-ID: <7va9rx5dvd.fsf@alter.siamese.dyndns.org>
References: <cover.1359126360.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Krzysztof Mazur <krzysiek@podlesie.net>
To: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 19:14:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tynni-0006nw-N6
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 19:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242Ab3AYSOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 13:14:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55847 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932108Ab3AYSOc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 13:14:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66464BC03;
	Fri, 25 Jan 2013 13:14:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uYB4dtHVGrGpzKRv0bvZ3qVS6kY=; b=ZcOxjo
	BhMTsY2C2QyTc4duKEGiH0AAKmolUwaNIDsbR2rDOPU6PkvkXq685lkxGtHeBI84
	IjqOg1i9VRKcMAd9t7kdk4wKoiD5MS1mf3TSDXzAeYYVR55wIl6O/Uukp16CZRWk
	XWVlJfIcw86AoRahGsmmmnm/0rtkVNPCUUR5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Flo+TodKx9xPhF7/81OSEDx+FN3Gnqup
	R5TzLD3d/87c2bxIGAY58p7S9stDgvSh4S0g4JyKWPMm1Npgw21J1VfvFtTJK/Hq
	HyegJeSIsSvYk9WBtvaDWSM6oOHulAf7VagvYwL7ODo7qSunhgnXEHDD/YtesSRE
	m/pX/KLJye8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AC8DBC02;
	Fri, 25 Jan 2013 13:14:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B50F8BBFE; Fri, 25 Jan 2013
 13:14:31 -0500 (EST)
In-Reply-To: <cover.1359126360.git.Alex.Crezoff@gmail.com> (Alexey Shumkin's
 message of "Fri, 25 Jan 2013 19:28:53 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10C2DC76-671B-11E2-B124-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214564>

Alexey Shumkin <Alex.Crezoff@gmail.com> writes:

> This function is used to determine "broken" (non-ASCII) headers (to be encode them)
> The problem is if "Subject" is not broken, but message body contains non-ASCII chars,
> subject is marked as broken and encoded again.

I think that is not a "problem" but is a mere symptom.

The remainder of the codeflow of send-email, AFAICS (it's not my
code), is not prepared to deal with multipart messages at all.  In
order to handle multi-part properly, you may still have to fix
broken Subject: of the whole thing, and you may also want to fix
broken headers inside one part while keeping correctly formatted
part intact.

Your patch just stops an early error checking that is meant for a
non multi-part message that happens to trigger on a multi-part
message in your test case from triggering (i.e. masking a symptom)
and let the remaining lines of the multi-part message to codepath
that does not do anything special to handle multi-part messages
correctly, letting it do whatever it happens to do to a message
assuming it is not a multi-part message, no?

In other words, making send-email capable of handling a multi-part
might be a worthy thing to do, but I do not think your patch is a
good first step for doing so.
