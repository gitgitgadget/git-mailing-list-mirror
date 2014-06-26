From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Thu, 26 Jun 2014 12:00:01 -0700
Message-ID: <xmqqpphv4hu6.fsf@gitster.dls.corp.google.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
	<1403518300-23053-3-git-send-email-tanayabh@gmail.com>
	<53A84077.4010200@ramsay1.demon.co.uk>
	<xmqqsimv9pjx.fsf@gitster.dls.corp.google.com>
	<53A99FEB.5040808@ramsay1.demon.co.uk>
	<xmqq61joamcc.fsf@gitster.dls.corp.google.com>
	<vpq1tubinbx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 26 21:00:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0EuB-0002Cs-9q
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 21:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbaFZTAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 15:00:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54324 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbaFZTAL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 15:00:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5976722741;
	Thu, 26 Jun 2014 15:00:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0tZVz/MBBEqb25tU70SiJAjZeQs=; b=Oj9Zla
	sge3h2dqUuYKNmLCij2HvRjkEgl0ZOuvM4Dq99vgh36II8BCik98ycXnbKzH3/x3
	L877MKU5gNupViJ15vXmLsPsvk6yAoLdrTqecKgQWFKkZAlPqWjALYPjvLGpBPF3
	+/S4ZLDYqdFwLFKwsBlPsg7bGgOghihPC/W14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pdr+Rlr7YjpSE+TUQSXADhdDBChyUnLb
	RoXllf+ZMWKJ1Bzr9D8aFDnrUZTwRAQ4kgvg8ywo4/KXBCItLQOlAh1XwAJxVXOd
	W+nMlxRwW1ez3sFmpmH77lO2eSnK+Q0i2JX3sucrFE88rNZR0NTEQBuv3J1/0jMf
	w5ioRp61LK0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2E1282273A;
	Thu, 26 Jun 2014 15:00:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 981FC2272A;
	Thu, 26 Jun 2014 14:59:56 -0400 (EDT)
In-Reply-To: <vpq1tubinbx.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	26 Jun 2014 19:37:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 107BB022-FD64-11E3-83AB-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252516>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> When the submodule script that uses "git config -f .gitmodules" is
>> converted into C, if the updated config API is ready, it may be able
>> to do something like these in a single program:
>>
>> 	const char *url;
>> 	struct config_set *gm_config;
>>
>>         /* read from $GIT_DIR/config */
>>         url = git_config_get_string("remote.origin.url");
>>
>>         /*
>>          * allow us to read from .gitmodules; the parameters are
>>          * list of files that make up the configset, perhaps.
>>          */
>> 	gm_config = git_configset_new(".gitmodules", NULL);
>>
>>
>>         if (!git_configset_get_bool(gm_config, "submodule.frotz.ignore")) {
>> 		/* do a lot of stuff for the submodule */
>>                 ...
>> 	}
>>
>>         /* when we are done with the configset */
>>         git_configset_clear(gm_config);
>
> Isn't that a bit overkill? Why not just let the caller manage a hashmap
> directly instead of a config_set?

Because I had an experience under my belt of a painful refactoring
of "the_index" which turned out to be not just a single array, I
simply suspect that the final data structure to represent a "set of
config-like things" will not be just a single hashmap, hence I do
prefer to have one layer of abstraction "struct config_set", which
would contain a hashmap and possibly more.  Doesn't "is the hashmap
initialized" bit belong there, for example?
