From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] diff.c: implement a sanity check for word regexes
Date: Sat, 18 Dec 2010 13:00:32 -0800
Message-ID: <7vvd2qg5jj.fsf@alter.siamese.dyndns.org>
References: <cover.1292688058.git.trast@student.ethz.ch>
 <ee3026bd997fc6d8508b8e5617e572f99c8bf3d6.1292688058.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Johnson <scottj75074@yahoo.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Dec 18 22:01:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU3uQ-0001Nh-9j
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 22:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199Ab0LRVAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 16:00:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108Ab0LRVAs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 16:00:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C2B712F0A;
	Sat, 18 Dec 2010 16:01:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wgVLXckFGlnlJ9UhyFtX8oXTvl8=; b=Q1QZdI
	gttfGLQfChVDVc+IQfeBel5kbHFFvA9XGKeX4Aj4aXIh4Krc47WkHTJuqpmFcuOt
	gY11Mska802TwiyGrmJDlG61hqS78ej/NtFfznMVJDOUZ6b4W++1Cke43znCTZnF
	Xrj84caGvfYuoCzEyOeMqA0taC3TT6OORoQQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DnQsOtXUhCNVI3bmlzkWXT72vri3ub+Y
	ozt6tYUvlH1Mb3ZMf0Yh9Jcxh4pRklr3OUOqBKVsJxTRewwSgnm4VqyNYVH8l1iT
	Rg+YXQheB04mW8Vju7vixFkdYPaGsYO849r+wahyw+1DwIWuDP5wI6VzZ9NJARUo
	JxbN0uY5HJo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6FE6F2F06;
	Sat, 18 Dec 2010 16:01:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B43642F00; Sat, 18 Dec 2010
 16:01:01 -0500 (EST)
In-Reply-To: <ee3026bd997fc6d8508b8e5617e572f99c8bf3d6.1292688058.git.trast@student.ethz.ch> (Thomas Rast's message of "Sat\, 18 Dec 2010 17\:17\:52 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EF938DBE-0AE9-11E0-9198-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163934>

Thomas Rast <trast@student.ethz.ch> writes:

> Word regexes are a bit of a dangerous beast, since it is easily
> possible to not match a non-space part, which is subsequently ignored
> for the purposes of emitting the word diff.  This was clearly stated
> in the docs, but users still tripped over it.
>
> Implement a safeguard that verifies two basic sanity assumptions:
>
> * The word regex matches anything that is !isspace().
>
> * The word regex does not match '\n'.  (This case is not very harmful,
>   but we used to silently cut off at the '\n' which may go against
>   user expectations.)
>
> This is configurable via 'diff.wordRegexCheck', and defaults to
> 'warn'.

How expensive to run this check twice, every time word_regex finds a
match?

As this is about making sure that we got a sane regex from the user (or a
builtin pattern), I wonder if we can make it not depend on the payload we
are matching the regex against.  Then before using a word_regex that we
have not checked, we check if that regex is sane, mark it checked, and do
not have to do the check over and over again.
