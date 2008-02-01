From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] --format=pretty: new modifiers cID, cIS, CIY
Date: Fri, 01 Feb 2008 15:04:15 -0800
Message-ID: <7vir188ej4.fsf@gitster.siamese.dyndns.org>
References: <odb072ca.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 00:05:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL4wP-0001ds-4N
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 00:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759518AbYBAXEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 18:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759264AbYBAXEX
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 18:04:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758051AbYBAXEW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 18:04:22 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 68E7E4B57;
	Fri,  1 Feb 2008 18:04:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CCA144B56;
	Fri,  1 Feb 2008 18:04:17 -0500 (EST)
In-Reply-To: <odb072ca.fsf@blue.sea.net> (Jari Aalto's message of "Sat, 02 Feb
	2008 00:12:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72189>

Jari Aalto <jari.aalto@cante.net> writes:

> +	case 'I':	/* date, ISO 8601 + fine grained details */
> +		switch (next) {
> +		case 'D':	/* up till date */
> +			strbuf_addstr(sb,
> +					show_date(date, tz,
> +						DATE_ISO8601_YYYYMMDD));
> +			return;
> +		case 'S':	/* up till date + sec */
> +			strbuf_addstr(sb,
> +					show_date(date, tz,
> +						DATE_ISO8601_YYYYMMDDHHMMSS));
> +
> +			return;
> +		default:	/* up till hour */
> +			strbuf_addstr(sb,
> +					show_date(date, tz,
> +						DATE_ISO8601_YYYYMMDDHHMM));
> +
> +		}
> +		return;

I think this "default" is not quite nice.  If you want to
support down-to-hour, you'd beter explicitly support 'H'.
"default:" should error out, saying "Ah, oh, sorry, I do not
support %cIX (yet)".

Otherwise, it casts the set of truncated ISO 8601 date format we
supports in stone.  People would depend on being able to say
"%cIhour" and a new implementation cannot introduce %cIh
modifier that means something.

But I do not like the idea of adding more short-hand format this
way.  I think we would very much prefer, instead of piling hacks
on top of the originally supported "minimum set", to introduce a
truly extensible syntax, like:

	%cT(flexible formatting specification for committer time)

or even

	%c(flexible formatting specification for committer info)

and that specification may say which field to format with what
prettiness.  For example:

	%c(name|initial) %c(time|local,HH:MM) %c(time|gmt,HH) <%c(email)>

might say:

	JCH 15:00 23 <gitster@pobox.com>

(23 is because US/Pacific is 8 hours behind right now).

Of course, %a(likewise for author time) can be defined the same
way.
