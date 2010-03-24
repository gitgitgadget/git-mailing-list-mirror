From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: lazily assign editor variable
Date: Wed, 24 Mar 2010 10:52:08 -0700
Message-ID: <7vaatxobef.fsf@alter.siamese.dyndns.org>
References: <20100322145947.GA1709@pengutronix.de>
 <eb0d92cf28820eb9783e789a8c4c62c3af4dd0d0.1269274203.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 24 18:52:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuUkm-0007uU-VS
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 18:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625Ab0CXRwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 13:52:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784Ab0CXRwU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 13:52:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C9D31A5566;
	Wed, 24 Mar 2010 13:52:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OOhOiTrBLqx+QS6YlKNG1TkGvCU=; b=rU315B
	akKmVd3mJTv8UvJ15Q1Tp8VWNtosBs5QMigR+dfNgCc3q7erUQxHqrJvcn7CuGX0
	/s0fpvpao4sRsJgMRYQDzJA9WcReP3Em5cA7q/6nUlgjzGDQj879ZsYRm4vtoZXS
	GpA9Fns3ZcoPA0+/XTvFj3r3M020KQDn/I554=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RZaEcpzr6Hey6O45wzo8MezVznH0G5X2
	rwHb4ezaRQadIXhyQW2fejm+cdQWylBrIrdyjw1VkEa9XJa66mbPEHktUuIcSLLC
	EBfrcHhC7S1Vhrewa67iUVMfZQFRFKtdZrDUVgV9WYvEEawCGqYe152CCzfXWu4U
	sPe5+lWl6+8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 83D2BA5558;
	Wed, 24 Mar 2010 13:52:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5078A5554; Wed, 24 Mar
 2010 13:52:09 -0400 (EDT)
In-Reply-To: <eb0d92cf28820eb9783e789a8c4c62c3af4dd0d0.1269274203.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon\, 22 Mar 2010 17\:12\:53 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FAEB1E98-376D-11DF-BF07-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143097>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> b4479f0 (add -i, send-email, svn, p4, etc: use "git var GIT_EDITOR",
> 2009-10-30) introduced the use of git var GIT_EDITOR which may lead to
> problems when send-mail is used without a tty.

We would want to describe what kind of problems they are better than "may
lead to problems", though.  Something like this?

    b4479f0 (add -i, send-email, svn, p4, etc: use "git var GIT_EDITOR",
    2009-10-30) introduced the use of "git var GIT_EDITOR" to obtain the
    preferred editor program, instead of reading environment variables
    themselves.

    However, "git var GIT_EDITOR" run without a tty (think "cron job") would
    give a fatal error "Terminal is dumb, but EDITOR unset".  This is not a
    problem for add-i, svn, p4 and callers of git_editor() defined in
    git-sh-setup, as all of these call it just before launching the editor.
    At that point, we know the caller wants to edit, and they cannot without a
    tty.

    But send-email ran this near the beginning of the program, even if it is
    not going to use any editor (e.g. run without --compose).  Fix this by
    calling the command only when we edit a file.
