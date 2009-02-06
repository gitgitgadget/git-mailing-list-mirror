From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] valgrind: do not require valgrind 3.4.0 or newer
Date: Thu, 05 Feb 2009 16:12:30 -0800
Message-ID: <7vljska0ep.fsf@gitster.siamese.dyndns.org>
References: <7vzlh0bp6f.fsf@gitster.siamese.dyndns.org>
 <349b2bb9b8f5a6762cccb7834d82125ee4382436.1233867737u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 06 01:14:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVEM7-0002ml-Pj
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 01:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbZBFAMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 19:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbZBFAMh
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 19:12:37 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbZBFAMg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 19:12:36 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 116792A84D;
	Thu,  5 Feb 2009 19:12:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 46FF82A830; Thu, 
 5 Feb 2009 19:12:32 -0500 (EST)
In-Reply-To: <349b2bb9b8f5a6762cccb7834d82125ee4382436.1233867737u.git.johannes.schindelin@gmx.de> (Johannes Schindelin's message of "Thu, 5 Feb 2009 22:03:00 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DAD53DC0-F3E2-11DD-8E33-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108636>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Valgrind 3.4.0 is pretty new, and even if --track-origins is a nice
> feature, it is not the end of the world if that is not available.  So
> play nice and use that option only when only an older version of
> valgrind is available.
>
> In the same spirit, refrain from the use of '...' in suppression
> files, which is also a feature only valgrind 3.4 and newer understand.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks.

> +TRACK_ORIGINS=
> +
> +VALGRIND_VERSION=$(valgrind --version)
> +VALGRIND_MAJOR=$(expr "$VALGRIND_VERSION" : '[^0-9]*\([0-9]*\)')
> +VALGRIND_MINOR=$(expr "$VALGRIND_VERSION" : '[^0-9]*[0-9]*\.\([0-9]*\)')
> +test 3 -gt "$VALGRIND_MAJOR" ||
> +test 3 -eq "$VALGRIND_MAJOR" -a 4 -gt "$VALGRIND_MINOR" ||
> +TRACK_ORIGINS=--track-origins=yes

It took me a while to convince myself that

	"3 > major || (3 == major && 4 > minor) || do-this"

is equivalent to

	"if (3 < major || (3 == major && 4 <= minor)) { do-this }"

which would be:

	if test 3 -lt "$VALGRIND_MAJOR" ||
           test 3 -eq "$VALGRIND_MAJOR" -a 4 -le "$VALGRIND_MINOR"
        then
		TRACK_ORIGINS=--track-origins=yes
	fi
        
or more commonly:

	if test "$VALGRIND_MAJOR" -gt 3 ||
           test "$VALGRIND_MAJOR" -eq 3 -a "$VALGRIND_MINOR" -ge 4
        then
		TRACK_ORIGINS=--track-origins=yes
	fi
        
