From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Introduce branch.<name>.pushremote
Date: Sat, 09 Feb 2013 12:00:25 -0800
Message-ID: <7vhallw946.fsf@alter.siamese.dyndns.org>
References: <1360307982-20027-1-git-send-email-artagnon@gmail.com>
 <7v8v6y1sih.fsf@alter.siamese.dyndns.org>
 <CALkWK0kp5SvbeTQgLRKWUAT_koSi0wyp6iPTC324iH8+D8oeJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 21:00:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4GbU-0007BY-27
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 21:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504Ab3BIUA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 15:00:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34097 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932485Ab3BIUA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 15:00:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A71F0CF5E;
	Sat,  9 Feb 2013 15:00:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6OK7Z4d5qJqUlJ2KwDTF9hKGBG4=; b=bH+arW
	JrKvigAyp0VIl/1eRdR2L681GyYNSw/IuSl6fWGtsMWFbpkTaOikSkqMHB0ztSuX
	jqxuAN4/3qwz+vp15+t4s5qWemF4jt435AP/txced6oBUlemE97ra8JeJNyfd44h
	eSv1qehyP8WUFJxDUn+Sozep5nKpSzUjTlZtc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ISnQQPmuKuQO8tTdniSXAW52Y5jNtDHa
	07tRpd7EPbJj6i78sNjVf+AazSnTixpgR0SnvRPvcgDd5AkYyIE7IwkTdLC2W/jG
	UoceiIwxTn/3aBN3h+iGDlrwRCCOLzyjtyqrfE9OYpYec9v8Y6n8bCQTHWcaIpjS
	SCdDkFZ6N00=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A94FCF5D;
	Sat,  9 Feb 2013 15:00:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DECBFCF5C; Sat,  9 Feb 2013
 15:00:26 -0500 (EST)
In-Reply-To: <CALkWK0kp5SvbeTQgLRKWUAT_koSi0wyp6iPTC324iH8+D8oeJg@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sat, 9 Feb 2013 13:16:38 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 58EEE7B8-72F3-11E2-8514-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215871>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>
>> In other words, does it make sense to read branch.$name.pushremote
>> for all the other irrelevant branches?
>>
>> In yet other words, perhaps adding pushremote_name to the branch
>> structure is unneeded, and you only need this single global
>> variable?
>
> Frankly, I'm unhappy with this global.  Setting a global here and
> subsequently reading it in pushremote_get() feels flaky.

Why unhappy?

This is expressed as a per-branch configuration, but in realitiy the
configuration on any branch that is not the current one does *not*
matter an iota.

An API call find_pushremote_for_branch() that takes a branch name
and returns the pushremote for that arbitrary branch has no use in
your designed feature.  find_pushremote() that tells you where a
lazy "git push" goes under the conditoin is the only thing you need
in your design.  You can still implement it without globals, e.g.

	struct bp { const char *branch; const char *remotename; };

        static int pushremote(const char *var, const char *val, void *cb)
	{
		struct bp *bp = cb;
	        const char *name, *key;
                int namelen;

		if (!parse_config_key(var, "branch", &name, &namelen, &key) &&
                    namelen == strlen(bp->branch) &&
                    !memcmp(name, bp->branch, name, namelen) &&
		    !strcmp(key, "remotepush")) {
			git_config_string(&bp->remotename, var, val);
		}
		return 0;
	}

	char *find_pushremote(void) {
		struct bp bp;

                bp.branch = get_current_branch();
                bp.remotename = NULL;
                git_config(pushremote, &bp);
                return bp.remotename;
	}


And if you want to take default.pushremote that changes a lazy "git
push" to go to somewhere other than "origin", you make the
pushremote() callback notice that variable, add one element
"defaultremote" to struct "bp" to record that value, and then make
find_pushremote() do

	return bp.remotename ? bp.remotename : bp.defaultremote;

Sometimes "global variable" feels disturbing because then we cannot
run more than one user at the same time.  One caller may want to
know the value for "foo" branch while another want it for "bar"
branch.

But there is no reason for anybody to want to know the value for the
variables branch.$name.pushremote for all defined $name's at the
same time, exactly because this matters only for the current branch,
no?
			
