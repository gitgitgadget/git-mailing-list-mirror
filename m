From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] rebase: implement --[no-]autostash and rebase.autostash
Date: Tue, 23 Apr 2013 10:34:24 -0700
Message-ID: <7vip3di21r.fsf@alter.siamese.dyndns.org>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
	<1366725724-1016-8-git-send-email-artagnon@gmail.com>
	<7vr4i1i3a9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 19:34:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUh6w-0004UM-L1
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 19:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756871Ab3DWRe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 13:34:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40608 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756762Ab3DWRe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 13:34:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4866719388;
	Tue, 23 Apr 2013 17:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8xu86rDS5QAEg+RDTvyZEteY3Tg=; b=DhC5bS
	QYOMql6WV7oiyzhEMAUJy0T6BWclGinpPAjn9sZog2ttYO71X/Zn4xUxYdcQZM4I
	aC1JVccH70C9R4wc/4jaZ+m/b5d4loNqUrR98Dyh7Z4KFx9T//t0XR8kiNnGB4ks
	DQDU6aFH2JOimTkf7eRoY/CmdRlZwHjudaWCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xyODVK50xb2blHA7qJICmZ60Zg+0Ayow
	Zydn3W3jq0Psagg1wEKQT3yXhqujQF1Tttxg/DQKZ3hIhBlVDn2LiWbiEQDAhroN
	DtI1e/Y/of1ph/It0HrVGcJtGbL7VUyEL5eXfPvKyTsSAlvglBYbBK+MZuOKzfcd
	Rgt2FMapB54=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FCCE19387;
	Tue, 23 Apr 2013 17:34:26 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B59C19384;
	Tue, 23 Apr 2013 17:34:25 +0000 (UTC)
In-Reply-To: <7vr4i1i3a9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 23 Apr 2013 10:07:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0AF668A6-AC3C-11E2-B129-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222199>

Junio C Hamano <gitster@pobox.com> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> +apply_autostash () {
>> +	if test -f "$state_dir/autostash"
>> +	then
>> +		stash_sha1=$(cat "$state_dir/autostash")
>> +		git stash apply $stash_sha1 2>&1 >/dev/null ||
>> +		die "
>> +$(eval_gettext 'Applying autostash resulted in conflicts.
>> +Either fix the conflicts now, or run
>> +	git reset --hard
>> +and apply the stash on your desired branch:
>> +	git stash apply $stash_sha1
>> +at any time.')" &&
>> +		echo "Applied autostash"
>
> That && looks funny.  What does it even mean for die to succeed and
> give control back to you for a chance to say "Applied"?
>
> 	stash apply || die
> 	echo applied
>
> would be far more logical.
>
>> +	fi
>> +	git gc --auto &&
>> +	rm -rf "$state_dir"
>> +}
>
> This is somewhat worrisome.

One more thing on this function.  [4/7] (and [5/7]) justified nicely
why it is a good idea to have a central place to do the clean-up
tasks.  apply_autostash is a poor name for that "clean-up" function.
The central clean-up may happen to involve applying a stash in this
version, but applying stash will not stay the entirety of the
clean-up work forever.  The entirety of the clean-up work used to be
just 'git gc --auto && rm -fr "$state_dir"' for eternity, and this
series is adding something else. It is not hard to imagine somebody
else would want to add other kinds of clean-up tasks in here.

Perhaps "finish_rebase" or something?
