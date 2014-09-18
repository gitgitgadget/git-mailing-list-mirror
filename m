From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: Fix size passed to qsort
Date: Thu, 18 Sep 2014 10:34:48 -0700
Message-ID: <xmqqzjdwomrr.fsf@gitster.dls.corp.google.com>
References: <1410956079-23513-1-git-send-email-stefanbeller@gmail.com>
	<xmqq8ulgq25h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pdebie@ai.rug.nl, git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 19:34:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUfbb-0003LC-9R
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 19:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbaIRRev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 13:34:51 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50675 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755755AbaIRRev (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2014 13:34:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 76FCF3A372;
	Thu, 18 Sep 2014 13:34:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fIYOb6w4cJzRy07HFgqEocYGVgM=; b=kPv5cj
	d1Edwb79q8sqUuFrY2zj5oQhsMgCAIK/MQ+w97i5S/6fYRv14fWuBdWPld7ZwwZI
	F9iUxTHRvD0GxD/XzCFCghrDyu4M3cyolcQT3bE2ePBO5obYCtzafjfKkISh6YKB
	tJIdRHiNrPzNo/MnOxqu9dKFmS3Zk29vDcM+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uZglmsCe1PLcsvGUPfDEzcmKQm65gzPT
	NWP1VpqqNOC6nrvGV1WXzWVidWj6IA7FOpTN2nPC9eI9urepTyGB4pfXxtVpmav1
	ffX+Q1ICeWcUwNpUQzVSGl2nlkEs1381GIkQGGB8JoqJCrAJRiw54Pbd8mJG1tQ1
	A1FMUHLsKpo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6D4F53A371;
	Thu, 18 Sep 2014 13:34:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E0D293A36C;
	Thu, 18 Sep 2014 13:34:49 -0400 (EDT)
In-Reply-To: <xmqq8ulgq25h.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 18 Sep 2014 10:17:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1759E034-3F5A-11E4-BF6C-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257269>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <stefanbeller@gmail.com> writes:
>
>> We actually want to have the size of one 'name' and not the size
>> of the names array.
> ...
> I suspect that the latter is "size of a pointer that points at a
> cmdname structure", but the original code in help_unknown_cmd() is
> wrong.  The ones in load_command_list() do this correctly and
> another qsort() invocation in this function does so as well.  I
> wonder why they didn't correctly cut&paste ;-)
>
> 746c221a (git wrapper: also use aliases to correct mistyped
> commands, 2008-09-10) seemed to have introduced the culprit.
>
> The call to uniq() would fail to uniquify because main_cmds would
> have the standard command all in front and then aliases and commands
> in the user's PATH later, but I do not quite see if there is any
> end-user observable breakages that can arise from this.  What is the
> practical implication of this breakage?

Heh, I should have spent a bit more time before starting to type.
The answer probably is "nothing", as

	struct cmdnames {
        	...
                struct cmdname {
                	...
		} **names;
	} main_cmds;

is what we are dealing here, so main_cmds.names is a pointer that
points at a slab of memory to hold many pointers, each of which
points at "struct cmdname".  And sizeof(struct cmdname **) is
incorrectly passed where we should pass sizeof(struct cmdname *),
which you fixed, but in practice they would be the same size anyway
;-)

>>  	qsort(main_cmds.names, main_cmds.cnt,
>> -	      sizeof(main_cmds.names), cmdname_compare);
>> +	      sizeof(*main_cmds.names), cmdname_compare);
>>  	uniq(&main_cmds);
>>  
>>  	/* This abuses cmdname->len for levenshtein distance */
