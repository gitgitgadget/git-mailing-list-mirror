From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: add a config option to always use the depth argument
Date: Mon, 01 Dec 2014 12:58:16 -0800
Message-ID: <xmqqvblvnl3r.fsf@gitster.dls.corp.google.com>
References: <1417460823-17295-1-git-send-email-sbeller@google.com>
	<xmqqzjb7nlyx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 21:58:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvY35-0000YO-2o
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 21:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbaLAU6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 15:58:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53671 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932112AbaLAU6S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 15:58:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 163EB21CC5;
	Mon,  1 Dec 2014 15:58:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wzcLlspgn2ej6TG1iGx+YQYlk18=; b=fnByuY
	KM1j50aMODE8Sf6/aeeUZhexTb3jfEl2J762SQN64dnJi6bZaF8fsAjz6deIm4Kr
	0v9TVdRSZP2+tDbR1kVSYuz74GelwC1eIK0Yr1Rk90CTzaWaBk1FjbTll0/D8DnQ
	OVJahpOKKBU8C1BwBqarlWqZqskd9cTJL0VLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QMxoe18jSEVUkuX1O8s4OklDi7D8VAJ2
	F5IgXbSARzX7LC1G3Z30+a9plDF2spAnUhf/qQhdaPbtyDKtw89nzA09NfSDCBW5
	nDWnFt3qnVEAPJzo5BDioV8bjzNvIJwQzOS0QU8h2U4R5YBKxrxS8SPgEMfHgfYj
	hJPFfj6jD6o=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C61B21CC4;
	Mon,  1 Dec 2014 15:58:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73FC521CC3;
	Mon,  1 Dec 2014 15:58:17 -0500 (EST)
In-Reply-To: <xmqqzjb7nlyx.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 01 Dec 2014 12:39:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C62FD09C-799C-11E4-B343-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260513>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> +fetch.depth::
>> +	If set, fetch will automatically behave as if the `--depth`
>> +	option was given on the command line.  This allows users to keep
>> +	the git directory at low space requirements, and thus comes in handy
>> +	for users with large binary files in the repository.
>> +
>
> Hmm, is this something a user would typically want repository-wide?
> I am wondering if "remote.$nick.fetchDepth" or something scoped to
> remote is more appropriate.

Regardless of what configuration variable is used, I think setting
depth directly from the config will mean the user cannot defeat a
configured value by passing --unshallow because of this code
sequence in builtin/fetch.c; am I mistaken?

	...
	git_config(git_fetch_config, NULL);
	argc = parse_options(argc, argv, prefix,
			     builtin_fetch_options, builtin_fetch_usage, 0);
	if (unshallow) {
		if (depth)
			die(_("--depth and --unshallow cannot be used together"));
	...

I think depth variable should be left alone.

The right solution may be to leave the above "unshallow and depth
are incompatible" check done only for the command line options as
the original code, and much later in the code path after you figure
out which remote we are talking to, only when neither --depth nor
--unshallow is given, consult the configuration system to see if
there is a default, perhaps in prepare_transport().  That approach
will let you later support "remote.$nick.fetchDepth", even if you
start with a repository-wide "fetch.depth" option, I would think.
