From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/7] rebase: write better reflog messages
Date: Wed, 19 Jun 2013 11:29:23 -0700
Message-ID: <7v4ncu0xa4.fsf@alter.siamese.dyndns.org>
References: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
	<1371581737-10013-7-git-send-email-artagnon@gmail.com>
	<51C1442A.2010904@viscovery.net>
	<7vy5a611hb.fsf@alter.siamese.dyndns.org>
	<7v8v260yy5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 19 20:29:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpN8N-0008UG-GV
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 20:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757064Ab3FSS31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 14:29:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39104 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756776Ab3FSS30 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 14:29:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44EDB29F30;
	Wed, 19 Jun 2013 18:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VQI9zxFrhBitrRp4SiLgwv/vxqY=; b=CR/lPH
	jewH8mjELRGd880MaruIJKjVB+jtKcK3+sWKkidTEiLkmPfxjm8czOHRqSzyxpdG
	e5TGrRcOnO6vdccYEmNMo8pXLO+HXxHC3c8yb6BlKxkXktp0Je86SsBzM81kqRBx
	Kq+mt/sEome+RdSdFPTFFpg39wzOOwjjxQIoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xDNJAMVkcdwiAsecnKhoiOeFOnEyecFc
	uzh3j/3NDucy1mA7CqTgy5yEg4wwBBuRNashdGRc2n+0gwmpIS4gVMSxM8HI4xUL
	ROpD2Pd5fqV5HhON6DxanyO2rTbG/plZ9oVGHe8sW5IU3rEhr7JSuXaPQanI7YAr
	+pYAzDh5YC8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38A1F29F2F;
	Wed, 19 Jun 2013 18:29:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9517329F2B;
	Wed, 19 Jun 2013 18:29:24 +0000 (UTC)
In-Reply-To: <7v8v260yy5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 19 Jun 2013 10:53:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2AD95FDA-D90E-11E2-873A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228406>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Excellent question, and I think this illustrates why the recent
>> reroll that uses an approach to use base_reflog_action is not
>> complete and needs further work (to put it mildly).
>> ...
>> That essentially boils down to the very original suggestion I made
>> before Ram introduced the base_reflog_action.
>
> So how about doing something like this?

Having said all that, although I think the "something like this"
patch is an improvement in that it spells out the rules regarding
the use of GIT_REFLOG_ACTION environment variable, which was not
documented so far, I think the environment variable is showing its
flaws.

It was a good mechanism in simpler times, back when "git commit",
"git fetch" and "git merge" were its primary users.  They didn't do
many ref updates, and having a way to record that "this update was
done by a 'merge' command initiated by the end user" was perfectly
adequate.

For a command like "rebase" that can do many ref updates, having to
set a custom message and export the variable in each and every step
is cumbersome, and keeping the same prefix across becomes even more
so.

The $orig_reflog_action used inside git-rebase--interactive is a
reasonable local solution for the "keeping the same prefix" problem,
but it is a _local_ solution that does not scale.  In the end, it
updates the GIT_REFLOG_ACTION variable, so the script has to be very
careful to make sure the variable has a sensible value before
calling any ref-updating "git" command.  It will have to set it back
to $orig_reflog_action if it ever wants to call another scripted
Porcelain.

Among the C infrastructure, commit, fetch, merge and reset are the
only ones that pay attention to GIT_REFLOG_ACTION, and we will be
adding checkout to the mix.  If we originally did not make the
mistake of using GIT_REFLOG_ACTION as a whole message, and instead
used it to convey _only_ the prefix (i.e. "rebase", "am", etc.) to
subprocesses in order to remember what the end-user initiated
command was, and used a command line argument to give the actual
messages, we would have been in much better shape.  E.g. a
"checkout" call inside "git rebase" may become

	git checkout \
            --reflog-message="$GIT_REFLOG_ACTION: detaching" \
	    $onto^0

and nobody other than set_reflog_action shell function would be
setting GIT_REFLOG_ACTION variable.

Oh well.
