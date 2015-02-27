From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer: preserve commit messages
Date: Fri, 27 Feb 2015 10:31:15 -0800
Message-ID: <xmqqd24vjjf0.fsf@gitster.dls.corp.google.com>
References: <1424540906.15539.22.camel@scientia.net>
	<f58ae048d7fd468cfdd7f7d369b3b4fc0a564641.1424697676.git.git@drmicha.warpmail.net>
	<xmqqsidwtq4i.fsf@gitster.dls.corp.google.com>
	<54EC98BD.7060100@drmicha.warpmail.net>
	<xmqq8ufnrwm1.fsf@gitster.dls.corp.google.com>
	<54ED9AF7.6080908@drmicha.warpmail.net>
	<xmqqoaohonpt.fsf@gitster.dls.corp.google.com>
	<54EEFDF7.8090306@drmicha.warpmail.net>
	<xmqq61aomp1d.fsf@gitster.dls.corp.google.com>
	<54F08DE8.3080907@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Christoph Anton Mitterer <calestyo@scientia.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 27 19:31:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRPh5-00086P-At
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 19:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbbB0SbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 13:31:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751776AbbB0SbS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 13:31:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 824873BF56;
	Fri, 27 Feb 2015 13:31:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P5Rfx6puNFErCDe0WnMKkVEpeGU=; b=NgiUmm
	mIjrEIaiyU5UoDcJDmvOAv/QjNxVmM/xjOAebUa1n9H4XhxqgIsaABystsWs7MSV
	iT6Gx61kpeqpFZwiK+LA7SABVUkQKDBa9fI+KW7MV0OGVqtEbEExHaD8agaWFvrN
	69vFArzkOe1o3kfLC46AEW9Ia+dwYSpiL0F+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vsjl73J+UKELsQuDHrI9rOxBa8fIrde4
	2ZhSBFFIzxn+ZbQoxO1GrK6A8uzGkZHkPg+vwnfYe2B6My7WE4SG7dlUaAwdXYFj
	Vfr/ivwKlb88MR3CTbV4cG1qGU+/xK3pWgz0vycrZa+aCNVXzRuu81FL1BncP/AD
	T+DAp+vdSu0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 79E183BF54;
	Fri, 27 Feb 2015 13:31:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF4273BF51;
	Fri, 27 Feb 2015 13:31:16 -0500 (EST)
In-Reply-To: <54F08DE8.3080907@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 27 Feb 2015 16:31:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D0FF8BC8-BEAE-11E4-971C-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264504>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Without any config being set the result is certainly what I'm after.
>
> What I'm still wondering about is the case without --edit but with
> commit.cleanup: It seems to me that "git commit" being involved in a
> conflict-less cherry-pick is solely an implemention detail (and it could
> be done differently). Applying commit.* in this situation is a total
> surpise to the normal user, isn't it? I mean, again, what's the
> difference to rebase from a user perspective?

OK, a revised logic with the above input from you may look like
this:

     #if IN_THE_FUTURE
         if (config_exists(cherrypick.cleanup))
             mode = config_value(cherrypick.cleanup);
         else
     #endif
         if (editing && config_exists(commit.cleanup))
             mode = config_value(commit.cleanup);
         else
             mode = 'verbatim';
 
         invoke "commit --cleanup=" + mode;

This is a change in behavoiur (I just checked with v1.6.0 codebase
and we seem to run a clean-up without "--edit"); what is our plan to
help those who have been relying on the auto clean-up behaviour?

Also a tangent.

I recently run "cherry-pick -s" on two commits, and I am not sure if
"with --edit, and only with -edit, do the usual clean-up" is a
sensible thing to do, or "-s" or any other option should trigger the
usual clean-up if it implies that the user understands and asks the
log message to be different from the original (I am leaning towards
the latter).
