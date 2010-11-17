From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] log.decorate: accept 0/1 bool values
Date: Wed, 17 Nov 2010 11:36:30 -0800
Message-ID: <7v4obfg2td.fsf@alter.siamese.dyndns.org>
References: <20101117170045.GA4108@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 17 20:36:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PInoD-0008PT-Jp
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 20:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935246Ab0KQTgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 14:36:39 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932364Ab0KQTgj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 14:36:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4E5292D82;
	Wed, 17 Nov 2010 14:36:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O6VrPGDsqp8oC/YHl5dvNDov++s=; b=oRPrXa
	0UhYRzl4YAeADA5jA9YTUHIbWAHk8MemdqKWFKr4qbbBI9PB1ScgIfdYqscGR33H
	Kyd6T37UBD9bKOvnVPqlot8iw6i8Wkq2Y8MhTALjrWSFm87YGG7Bmr65Desfnf2e
	3wZYlDpELOHf3hf/ZOTPCMnLWQcPBV84yYRnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r1mP1qtMJXOC5A2FLGBXnGghCsEqZLZ4
	Q5Y7Ssypdk8X/0vdw0tu+njYoTX/4fq6ix+poX0a58X3M9/lieya0ryvGL75TrgR
	JbVccPWzlpwaYvvNuTGXPyxrwFB1aFg2ahSVtYDwe2304Esw/IX/ZmWL8T4QaSm3
	fYmll4ID3iI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2DEA02D81;
	Wed, 17 Nov 2010 14:36:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 382BE2D7B; Wed, 17 Nov 2010
 14:36:40 -0500 (EST)
In-Reply-To: <20101117170045.GA4108@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 17 Nov 2010 12\:00\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 02391C48-F282-11DF-B67F-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161630>

Jeff King <peff@peff.net> writes:

> We cannot simply add 0/1 support to git_config_maybe_bool.
> That would confuse git_config_bool_or_int, which may want to
> distinguish the integer values "0" and "1" from bools.

... e.g. number one spelled as "1" do mean one not true in contexts like
status.submodulesummary, where "true" means "unlimited" and "1" means
"limit to one".  It surely is necessary to avoid breakage there.

A caller that uses git_config_maybe_bool() expects to see 0/1 when the
input looks like a boolean, and your patch looks like the right thing to
do.

The repertoire of parsers that involve elements that are possibly boolean
are now:

 - git_config_bool(): takes "0/false/no/..." or "$n/true/yes/..." (where
   any non-zero number $n is taken as true [*1*]), or more traditional

   [section]
       var

   without any equal sign, which means true.  Errors out if the input is
   not a boolean.

 - git_config_maybe_bool(): similar, and returns -1 (not a bool), 0
   (false) and 1 (true).  "0" is false, "1" is true.  But all other
   numbers are not boolean;

 - git_config_bool_or_int(): the caller can tell if the value was boolean.
   "0" and "1" are integers, and not boolean.  Errors out if the input is
   not bool nor int.

Perhaps we would want to add Documentation/technical/api-config.txt
someday?   Hint, hint....


[Footnote]

*1* I doubt anybody is insane enough to have an existing configuration
file that spells "true" with "2" (or "100"), so it might be ok to tighten
the rule after the fact a bit here to take only "1" as true from purist's
point of view, but I do not think the upside outweighs possible breakage.
