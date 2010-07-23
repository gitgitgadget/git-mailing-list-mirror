From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] rebase: protect against diff.renames configuration
Date: Fri, 23 Jul 2010 14:03:49 -0700
Message-ID: <7vvd85ewqy.fsf@alter.siamese.dyndns.org>
References: <7vwsfb2k3u.fsf@gitster.siamese.dyndns.org>
 <1279742303-29817-1-git-send-email-ddkilzer@kilzer.net>
 <20100722075133.GA9292@burratino>
 <681325.9577.qm@web30002.mail.mud.yahoo.com>
 <20100723170103.GA2507@burratino> <20100723170613.GF2507@burratino>
 <AANLkTi=j8-YFwOYxcTWw3zqo=353fsB=vkmRttL4U+au@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"David D. Kilzer" <ddkilzer@kilzer.net>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 23:04:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcPPg-00047e-9B
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 23:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757197Ab0GWVEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 17:04:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63005 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679Ab0GWVED (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 17:04:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 001ECC7444;
	Fri, 23 Jul 2010 17:04:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tzm3Izkjrrkp2b4dySBMe+EcGVU=; b=XMcb4P
	UXaAEdkGVDsOLSXLdoUqB+OWoBkLM16gytl9WTLpm/mK/CDKRnprPC8s4aI7f99V
	yvDKPUASD5JCAiffeFFr/wU8CAdyObF4AFe2eA0LsdP+BOID2BaaOtvtQaIgYXgl
	/vRbqkMwwGtbhdh2MOK6S04Pfs3ds4Pvqr9Uk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fhZVj++NtLDgebrGoNUf87bC+t14Y5gc
	yigcXN0hoK49kEAcjAL8J/elo15c+wTqPEn/AbgjUSSMXMQIYTsiKDS1QhdDluAb
	pXlOFkZf4Un2cWrRtTMajpZh8RDi++cAKIuCfHzGyBO9W4OLvH/tfxVXl4F+91SF
	b6i3k7sUObo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E06AC743F;
	Fri, 23 Jul 2010 17:03:56 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 983BCC743C; Fri, 23 Jul
 2010 17:03:50 -0400 (EDT)
In-Reply-To: <AANLkTi=j8-YFwOYxcTWw3zqo=353fsB=vkmRttL4U+au@mail.gmail.com>
 (Sverre Rabbelier's message of "Fri\, 23 Jul 2010 14\:51\:29 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CEB1F07E-969D-11DF-94C1-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151574>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Fri, Jul 23, 2010 at 12:06, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> The end user configuration for "diff" should not affect the result
>> produced by the higher level command that is related to "diff" only
>> because internally it is implemented in terms of it.
>
> Almost completely unrelated and perhaps not relevant, I seem to recall
> that if you set 'ui.color' to 'always' you will get unapplyable
> patches because 'git format-patch' will include the color in it's
> output. Perhaps it should --no-color as well, while we're fixing it?

I think that it actually was a mistake for git_diff_basic_config() to call
git_color_default_config().  Parsing of diff.color.<slot> there is Ok and
was justified by 9a1805a (add a "basic" diff config callback, 2008-01-04),
but the change made to the function with 6b2f2d9 (Add color.ui variable
which globally enables colorization if set, 2008-02-18) was probably a
screw-up.  The call should instead have gone to diff_ui_config().

I also think format_config() should be changed not to call log_config()
(we need to move parsing of the format.subjectprefix from the latter to
the former), and instead call diff_basic_config() directly.
