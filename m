From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make NO_PTHREADS the sole thread configuration variable
Date: Sat, 30 Jan 2010 09:43:04 -0800
Message-ID: <7vwryzqyjb.fsf@alter.siamese.dyndns.org>
References: <1264814539-27209-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 18:44:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbHMj-0004mZ-V0
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 18:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759Ab0A3RnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 12:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752600Ab0A3RnM
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 12:43:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33149 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab0A3RnL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 12:43:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B95659531B;
	Sat, 30 Jan 2010 12:43:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8l4B5PyrqO3srwJVoYYkRE/JioY=; b=UEARtO
	NueVflzbRr7tDslfDTp8tiYr2HPpJOa5iH3vx6O0WiHAxmUvtX6JdeP1gkJxbAvg
	irSu+A9M7ys/TepO+CwX3k60ilE87ysAwAq4JR4DoRjjHHFjG4AzEmrZWVWfz3Lx
	0ELVFEv72gWpqMWXrqp7AlnY3zJ+5zChFtgYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BH8rHowsBMp1mrCAZXmlavWMrzoV9pVm
	KiORjQcIIG/FeYPvKOQ0Zj3xWkaXKHeGiE6jZw5J7T4833IMp1qQ3p5/23Qd0MnX
	6SlHA5knDZG/2942RiVc1aZcM3Vuj/Adst9ceEIuSf5CY30nTviHFBA5dNIb6PP6
	splddZMZ5i0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 960289531A;
	Sat, 30 Jan 2010 12:43:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E28AA95319; Sat, 30 Jan
 2010 12:43:05 -0500 (EST)
In-Reply-To: <1264814539-27209-1-git-send-email-dpmcgee@gmail.com> (Dan
 McGee's message of "Fri\, 29 Jan 2010 19\:22\:19 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EDA14666-0DC6-11DF-8A11-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138488>

Dan McGee <dpmcgee@gmail.com> writes:

> When the first piece of threaded code was introduced in commit 8ecce684, it
> came with its own THREADED_DELTA_SEARCH Makefile option. Since this time,
> more threaded code has come into the codebase and a NO_PTHREADS option has
> also been added. Get rid of the original option as the newer, more generic
> option covers everything we need.

The patch is a good change but only in the "if it were like this from day
one, things would have been much simpler" sense.  It is a breakage to
existing users with customized THREADED_DELTA_SEARCH in their config.mak
files, isn't it?

If we take only the part of your patch that applies to Makefile, but
exclude the first hunk (description of THREADED_DELTA_SEARCH) and the last
hunk (the necessary part to keep THREADED_DELTA_SEARCH working), and
instead add something like:

	ifndef NO_PTHREADS
        	THREADED_DELTA_SEARCH = YesPlease
	endif

immediately before we include config.mak, would that be a workable
solution to:

 (1) keep existing users happy;

 (2) remove the redundant logic to compute the default for two Make
     variables; and

 (3) keep control over use of threading in general _and_ use of
     threading in delta computation?
