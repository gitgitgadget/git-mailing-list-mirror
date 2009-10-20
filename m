From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-send-email.perl defect: address missing trailing > accepted
Date: Tue, 20 Oct 2009 16:28:59 -0700
Message-ID: <7vy6n5k5l0.fsf@alter.siamese.dyndns.org>
References: <1256076767.2029.59.camel@Joe-Laptop.home>
 <40aa078e0910201529m338ef3d1o4fa1a31c3dcc2a20@mail.gmail.com>
 <1256078917.2029.77.camel@Joe-Laptop.home>
 <40aa078e0910201556h4757dbbdn853be4dd8aa920d0@mail.gmail.com>
 <1256079633.2029.81.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, git <git@vger.kernel.org>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 01:29:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0O8k-0006z5-Un
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 01:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbZJTX3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 19:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752888AbZJTX3F
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 19:29:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbZJTX3E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 19:29:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8794360060;
	Tue, 20 Oct 2009 19:29:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JIbXLBYjO0j9vhDUy6sh39sc8iE=; b=uDmhbD
	OBIeltxeKdgDAZF4m4d5o2esJQegSuHwyptJMOAGpnyPsvToSZapb0nybStivd4g
	suaDWaq7wrRPfcrRcttiIPrhwNCYd371jZ4P6m5e/azCY1KZ1wXYTQYOj5ch2cBc
	7ciYZJjt4tt1T1QkVEqarV20f2oLsBS2Qa3cs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NAbAv2FieLYLmFVdVkY9uBpdjMwC8pmC
	nXJFr7ZAoV3RkF7bePftPqRoXrHOf0iHhbp6do3C5Mv2KYxDmlfx8tZqMEPZkljs
	Nr4IikG4y8leeRC4Iikznvl4/NW297XVHrB9edYtWAzbwDeAMs8fL4s9S8i/vgHw
	fvKzSdp/W/w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 588216005F;
	Tue, 20 Oct 2009 19:29:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F3BB6005E; Tue, 20 Oct
 2009 19:29:01 -0400 (EDT)
In-Reply-To: <1256079633.2029.81.camel@Joe-Laptop.home> (Joe Perches's
 message of "Tue\, 20 Oct 2009 16\:00\:33 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5B7337AE-BDD0-11DE-85AB-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130869>

Joe Perches <joe@perches.com> writes:

> It seems that the regex for address validation
> isn't very good and perhaps there could/should
> be a stronger validation done for each address
> entered.

The existing ones are actually already harmful.  It would trigger on a
valid addresses like this, wouldn't it?

    To: "Hamano, Jun" <gitster@pobox.com>

It is worse than that.

The "# Verify the user input" block is in a wrong place in the codepath.
After @to goes through this bogus "verification" step, it then is given to
expand_aliases(), which may expand to real addresses.  And then they pass
through sanitize_address() before getting used.

Three implications that come from this wrong code structure are:

 (1) The stricter checks you added on top of the existing bogus
     verification step may prevent @to to reach expand_aliases() step,
     even if the tokens in @to may expand to correct addresses by this
     expand_aliases() step if they were allowed to reach here;

 (2) The result from expand_aliases() is never checked.

 (3) The result from sanitize_address() is not checked either.
