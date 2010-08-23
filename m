From: Junio C Hamano <gitster@pobox.com>
Subject: "git -c web.browser=w3m help -w help" still kicks firefox
Date: Mon, 23 Aug 2010 11:05:04 -0700
Message-ID: <7viq3119yn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 23 20:05:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnbOk-0008Vk-UR
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 20:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708Ab0HWSFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 14:05:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab0HWSFT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 14:05:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1233D0E5C;
	Mon, 23 Aug 2010 14:05:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=37Xe
	sXUHm3urIZyDqBcqv93Ines=; b=yjOZtfVGS/iaUbV2V0W0z0c8wtPbMLqHbYKU
	cGBmhWw0QL2RxvCqr3GH/n8XrusV+SDKsRoYgA0FeA77pA4h+xDC0SxneHds7uj8
	fcz1adjX2biy76V+kiFrEgmOaeBDyQOphNdg/PkynSi9SC87cYrK7L8CQmXAfrsu
	RWdcmA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	yUi9IJAxfFHdnBotUjjMmZA6Cb5nW5+VugNgdW2uEQWDozimFNXSOvSM13dW4LXa
	BZ+8iJTory3E+sf/t/dHYYCELTZp8TdbJL5/tpt0euFKdK9pguv60eD2Y5JCQIwI
	48D/vtd4ls0QxSAp1ePWUeX252ZJ6++157wbp/AGLT8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C1A2D0E56;
	Mon, 23 Aug 2010 14:05:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 914E4D0E52; Mon, 23 Aug
 2010 14:05:05 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F8E5B1CC-AEE0-11DF-B537-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154241>

My firefox runs in a different "workspace" than what I usually look at
while working, and I've beem scratching my head why "git help -w help"
doesn't seem to do anything, while I was opening a new tab every time I
tried it.  And then I tried the command on the Subject line, only to end
up with yet another new tab X-<.

I know exactly why this happens---we save the config from the command line
on a list only so that we can apply them in the correct order after items
coming from files, but we do not use the saved values to pass them around
to sub-git invocations.

  8b1fa77 (Allow passing of configuration parameters in the command line, 2010-03-26)

A "trivial fix" would be to pass this info through the execv_git_cmd()
interface by either exporting it via an environment variable or by
modifying the command line options, but I am not sure about the possible
fallouts from such a change.  For example, does "git -c var=value config ..."
work sensibly when what "config" is told to do (say, remove a section)
contradicts with having the named var with a given value?

I am wondering if this is worth fixing it in the first place.

Opinions?  Patches ;-)?
