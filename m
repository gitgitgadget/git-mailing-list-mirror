From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 5/5] add tests for checking the behaviour of "unset.variable"
Date: Thu, 02 Oct 2014 16:38:31 -0700
Message-ID: <xmqqiok2m494.fsf@gitster.dls.corp.google.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
	<1412256292-4286-6-git-send-email-tanayabh@gmail.com>
	<xmqqr3yqmdxa.fsf@gitster.dls.corp.google.com>
	<542DB2FE.609@gmail.com>
	<xmqqmw9emdax.fsf@gitster.dls.corp.google.com>
	<542DB711.9040503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 01:38:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZpxG-0006JA-6z
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 01:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbaJBXie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 19:38:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62446 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448AbaJBXid (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 19:38:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 178B23FB86;
	Thu,  2 Oct 2014 19:38:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fif0aeZxii+VAf8o1KREc5W3KK8=; b=H1+5sV
	KVyF0syBnT7Ogu7KecUZzYYOAPW8yerlplQOn3vR4oTI39V4PiQuX2swEalc0cgi
	Ra0CDafT4Mro4Wkp6L+T54Hz7FO4B9dGfbKgwRgROxqTixWlqWsuM7nJCbvfsi3a
	R97qCcNSCnIncb8FiHAYLrWhSUa3/6nZYQ4Yg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=frMO3rZ48lNv3wcByUD5VBYOM1ackWZ4
	XgRWEQ/psa8OL0I0s/k8oNUWOG+/O4WxRU3ZpAIeMMjOsmocbUBOgSNNMbTmuo+P
	PDjMTvTcG5ChZLD4F+fQ/DqIGEfvzGUa0ZRu/vjYO2hCNerqc13Bx8qJUXryOGaU
	AqGVwNhInIQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0D4DB3FB85;
	Thu,  2 Oct 2014 19:38:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8A2313FB84;
	Thu,  2 Oct 2014 19:38:32 -0400 (EDT)
In-Reply-To: <542DB711.9040503@gmail.com> (Tanay Abhra's message of "Fri, 03
	Oct 2014 02:05:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3871615A-4A8D-11E4-8C79-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257826>

Tanay Abhra <tanayabh@gmail.com> writes:

> I can think of two solutions, one leave it as it is and advertise it to be
> explicitly typed in the config files at the appropriate position or to change
> the behavior of unset.variable to unset all matching variables in that file,
> before and after. We could also change git config --add to append at the end
> of the file regardless the variable exists or not. Which course of action
> do you think would be best?

Off the top of my head, from an end-user's point of view, something
like this would give a behaviour that is at least understandable:

 (1) forbid "git config" command line from touching "unset.var", as
     there is no way for a user to control where a new unset.var
     goes.  And

 (2) When adding or appending section.var (it may also apply to
     removing one--you need to think about it deeper), ignore
     everything that comes before the last appearance of "unset.var"
     that unsets the "section.var" variable.

That way, if you do not have "[section]" after "[unset] variable =
section.var", you would end up adding a new "[section] var = value",
and if you already have "[section]", you would add a "var = value"
in that existing "[section]" that appears after the last unset of
the variable, so eerything will be kept neat.

Alternatively, if the syntax to unset a "section.var" were not

	[unset]
        	variable = section.var

but rather

	[section]
		! variable

or soemthing, then the current "find the section and append at the
end" code may work as-is.
