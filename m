From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] perf-lib: add test_perf_cleanup target
Date: Tue, 17 Sep 2013 10:43:35 -0700
Message-ID: <xmqq7gefz6m0.fsf@gitster.dls.corp.google.com>
References: <1379419842-32627-1-git-send-email-t.gummerer@gmail.com>
	<1379419842-32627-2-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@inf.ethz.ch
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 19:43:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLzJP-0007ru-PX
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 19:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253Ab3IQRni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 13:43:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59539 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753180Ab3IQRnh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 13:43:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44123427C5;
	Tue, 17 Sep 2013 17:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bwZk2gAYajL5HJefmE3HArSvtxo=; b=mmtwEb
	nNZVMbhkHjYhJJYRC96glh7lMxIy8GUlanurEsmYIix1BmNewLeWnTmy46BU+Q4u
	4LA0EeVwp6KHH65v78XK3TVLTfVLE0hDv8jhJOara2jwk5uDrGA2vC8mcoJFFDfJ
	bgw4CurFhOSMssjGumkD0wMVgV0uRumUzGP+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ayBhWUaIo2mwHKj+1v1Jk0QYm4UhqcKZ
	RsNC1pP/cHkTyJBV21Rn8q1cCLc6W6kegBdE9/YoF93x1n7xweWVGmAfCy1dp8O3
	fmnpHkwKM8/GwQG7jGBZO6jcpKBtOUXqJZngMHC/gbYpmdhy3x61O4I/0Xua75ve
	aS+Y9bCq1FQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A092427C4;
	Tue, 17 Sep 2013 17:43:37 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9B19427C2;
	Tue, 17 Sep 2013 17:43:36 +0000 (UTC)
In-Reply-To: <1379419842-32627-2-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Tue, 17 Sep 2013 14:10:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AE241256-1FC0-11E3-A631-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234895>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> +For performance tests that need cleaning up after them that should not
> +be timed, use
> +
> +	test_perf_cleanup 'descriptive string' '
> +		command1 &&
> +		command2
> +	' '
> +		cleanupcommand1 &&
> +		cleanupcommand2
> +	'
> +

Hmm, if "not timing the clean-up actions" is the primary goal, is it
an option to reuse test_when_finished for this (you may have to make
sure that the commands run inside it are not timed; I didn't check).

One thing I felt uneasy about the above construct is that it makes
cleanupcommand2 responsible for handling cases where not just
command2 but also command1 might have failed.

Compared to that, test-when-finished allows you to control what
clean-up to do depending on what have already been done, i.e.

        test_when_finished 'undo what command1 would have done' &&
	command1 &&
        test_when_finished 'undo what command2 would have done' &&
	command2 &&
        ...

The second "undo command2" must be prepared for the case where
command2 may have failed in the middle, but it can at least rely on
command1 having succeeded when it is run.
