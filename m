From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] log: pass rev_info to git_log_config()
Date: Thu, 04 Oct 2012 21:16:14 -0700
Message-ID: <7vk3v5v9ip.fsf@alter.siamese.dyndns.org>
References: <7v626r48cv.fsf@alter.siamese.dyndns.org>
 <1349314419-8397-1-git-send-email-gitster@pobox.com>
 <1349314419-8397-6-git-send-email-gitster@pobox.com>
 <7v1uhe3efa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 08:50:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK1kH-0003Mk-JV
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 08:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650Ab2JEGuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 02:50:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58655 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510Ab2JEGuh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 02:50:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C65F29FF4;
	Fri,  5 Oct 2012 00:16:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ULfXSHGGuqhqdIXyacguqkFkIIg=; b=mlSM7u
	XGyARHIIs2NT7FuJm6Dznv7eUIDhZFIMdQG0L8LdB5Rml/uskhc1f1YiuaTcs4On
	UZRdugemSGTxUhiyrDB75ILwta/R5rcdD5YccwpP9lzgiL0y+4u5/rfNn5zUkcwQ
	mUQKUzL1e3d5wNSIMOWIR2SUeEAxacByTIgs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fcGm63cbkft/EcBgoJ7a1zS+OPMNIm9l
	X5/YSppphoDvEmZgkKB0DRh1NDSto0l2ZyyCugwF6fvVBAK9uOTZn9n5+jT06+02
	ek6hj1kgqFeSVVubXeEWiuvei4UERHtZPqAkv9HzLWRazYLxLMl1jhPADR3fGfCH
	cfTrO9Vp2eM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B43379FF3;
	Fri,  5 Oct 2012 00:16:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18EEF9FF2; Fri,  5 Oct 2012
 00:16:16 -0400 (EDT)
In-Reply-To: <7v1uhe3efa.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 04 Oct 2012 00:05:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 67F4D506-0EA3-11E2-8C1F-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207074>

Junio C Hamano <gitster@pobox.com> writes:

> So we would need to do something like:
>
>     - call git_log_config() first to let diff_context_default
>       updated from the configuration as before.  find the values of
>       grep.* defaults at the same time, but stash it away in a
>       separate "struct grep_opt" (yuck);
>
>     - call init_revisions() and let it initialize revs->grep_filter
>       and revs->diffopt as before;
>
>     - copy the grep.* defaults we learned during git_log_config() to
>       revs->grep_filter.
>
> which is a bit yucky, but survivable.

After thinking about it a bit more, I came to a conclusion that the
configuration handling lifted from builtin/grep.c needs a much
larger overhaul.

The grep_config() function takes one instance of grep_opt as a
callback parameter, and populates it by running git_config().  This
has three practical implications.

 - You have to have an instance of grep_opt already when you call
   the configuration.  The codepath under discussion in this thread
   is a prime example why that arrangement is not always possible.

 - It is not easy to enhance grep_config() in such a way to make it
   cascade to other callback functions to grab other variables in
   one call of git_config(); grep_config() can be cascaded into from
   other callbacks, but it has to be at the leaf level of a cascade.

 - If you ever need to use more than one instance of grep_opt, you
   will have to open and read the configuration file(s) every time
   you initialize them.

The right way to arrange your configuration callback is probably to
model it after how diff configuration variables are handled.  You
call git_config() once, and remember the values you read in set of
static variables. Later, whenever you need to instantiate a grep_opt,
you initialize it from these static variables.

All of the above did not matter back when the code in builtin/grep.c
was isolated and the configuration was never meant to be used by
other subsystems.  But the last two patches in this series do want
to break that assumption, so grep_config() needs to be rethought.

Luckily, we don't have to have this in the upcoming 1.8.0 release
(it is is too late for any topic that is not a regression fix).
