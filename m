From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] git-config: Parse config files leniently
Date: Thu, 03 Sep 2009 00:00:43 -0700
Message-ID: <7vab1cfr6s.fsf@alter.siamese.dyndns.org>
References: <7vvdkmte4p.fsf@alter.siamese.dyndns.org>
 <f29b5893b7022f53d380504fe201303acd9ee3da.1251922441.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 03 09:01:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mj6JY-0004gh-8Y
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 09:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbZICHAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 03:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754675AbZICHAt
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 03:00:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59825 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528AbZICHAt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 03:00:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE599237A8;
	Thu,  3 Sep 2009 03:00:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RteYkJOx0Vld/1d/ShhaH+D9fTU=; b=YAtgkm
	XlU+jqT1WXdCgJ9aESFApNZESMyN0KTdOl0ng9dXxs+38sc7MsBNSZGJd09gC1B6
	Khu/2Aa9oampg4eTpPPFcPNKCRrBxw2PKDX8nxORd4ERVI9ByrW6XwuUW/WH8pMQ
	gFncDn3gEgZWz/D8Nrw9mPErkrzFeE2Qh9rs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qOn3mJpYsJBa0N1E8ygxZNHRjj6S6Dzu
	CemMb2482okm+XT9wcE2mUXIieSAL/KVV8tZVfz7FBL34zlMnBkeTc6r8e4Xym7D
	CFDwdmPch/O0iBbkF5OMUwZfBMnsbC5R0pvI7Vqdko/Ywrn0W2DDdc2YLGEmirME
	BwLicULOlt8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9048F237A7;
	Thu,  3 Sep 2009 03:00:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E29D4237A6; Thu,  3 Sep
 2009 03:00:44 -0400 (EDT)
In-Reply-To: <f29b5893b7022f53d380504fe201303acd9ee3da.1251922441.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Wed\,  2 Sep 2009 22\:17\:10 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 826F16D2-9857-11DE-A9B0-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127641>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, git config dies as soon as there is a parsing error. This is
> especially unfortunate in case a user tries to correct config mistakes
> using git config -e.
>
> Instead, issue a warning only and treat the rest of the line as a
> comment (ignore it). This benefits not only git config -e users but
> also everyone else.

This changes the behaviour enough to break t3200-branch.sh, test #52.

The test stuffs an invalid (but not syntactically incorrect) value used by
"git branch" in the configuration and tries to make sure that "git branch"
diagnoses the breakage, but it does not fail anymore with your patch.

There are probably other breakages as well (e.g. t5304-prune.sh, test #5)
but if you trace "git branch" under the debugger in the trash directory
left after running t3200 with -i, it should be pretty obvious that your
patch is utterly bogus.  get_value() can return negative result after
diagnosing a semantic problem with the value, and that is different from a
syntax error that you would try to recover and continue, pretending you
can ignore the remainder of the line as if it is a comment.

Why was I CC'ed, if the patch wasn't even self tested?
