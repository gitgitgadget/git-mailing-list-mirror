From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/2] add `config_set` API for caching config-like files
Date: Thu, 10 Jul 2014 09:46:14 -0700
Message-ID: <xmqqvbr588mh.fsf@gitster.dls.corp.google.com>
References: <1404903454-10154-1-git-send-email-tanayabh@gmail.com>
	<1404903454-10154-2-git-send-email-tanayabh@gmail.com>
	<vpq61j6d92z.fsf@anie.imag.fr> <53BD3805.40504@gmail.com>
	<vpqion68viq.fsf@anie.imag.fr>
	<xmqqmwci7e9p.fsf@gitster.dls.corp.google.com>
	<xmqq38ea77gt.fsf@gitster.dls.corp.google.com>
	<vpqa98hwnxp.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 10 18:46:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5HUM-0004bH-Hm
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 18:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbaGJQqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 12:46:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64306 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbaGJQqX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 12:46:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 14BC426317;
	Thu, 10 Jul 2014 12:46:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P4YeC9Zy1+gC2MGpv2lpg37q6oI=; b=PD5leQ
	xnNocn/76201aOBCa1MCRkZMj0fyx1gfLFGQczPZE7ZwNzHTLtuUun1/uwVc0erb
	DclAKJJbjg9cHoD2j1xCrQASTrNBtDwG8sP8I9snESlbMZAdGzixv+twczeRwuLN
	oXEz2AwlvIIxO6H8CMkhV2s4Kyv1vEdkkddOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QbhBECbibGmWEWOkWWiMUjvO7S/HsPN+
	b2nrmf4XEcyMvFtKADDboC50hZKa6vqNCdrB6929k7vW3iDgKin3X2yQMRawZZGi
	/CTanN127DwKrjD1ky5eSlkjVOWbvr3ELyrYLVnlpauug7VcNFwmd7DHVFhM4bMu
	KGRyr3MUoF4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0643F26316;
	Thu, 10 Jul 2014 12:46:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 461BD2630A;
	Thu, 10 Jul 2014 12:46:01 -0400 (EDT)
In-Reply-To: <vpqa98hwnxp.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	10 Jul 2014 11:41:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ACEE3E14-0851-11E4-A600-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253189>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> After thinking about it a bit more, I think <file, line> support
>> needs to be done not as a mere client of the generic, uncached
>> git_config() API that we have had for forever, like the current
>> iteration, but needs to know a bit more about the state the caller
>> of the callback (namely, git_parse_source()), and we obviously do
>> not want to expose that machinery to anybody other than the
>> implementation of the config subsystem (to which the new facility
>> this GSoC project adds belongs to), so in that sense you have to
>> have your code in the same config.c file anyway.
>
> I do not buy the argument. Why would callers of the callback-style API
> not be allowed to give <file, line> errors?
>
> To me, it is a weakness of the API that <file, line> information is not
> available to callback functions, regardless of the config-cache.

I agree that it is good to allow scan-all-config-items-with-callback
callers to learn <file, line>, but that is irrelevant.  Perhaps you
misread what I envision as the endgame of this thing to be and that
is where our differences come from.  One thing I think would be good
to see in the endgame will be to give the benefit of the caching
layer to the callback callers without having them change a single
line of their code.

One possible sequence of changes to make it happen would go like
this, roughly in this order:

 - rename the current git_config() to git_config_raw(), and
   make it static to the config.c.

 - write a thin wrapper git_config() around git_config_raw() in
   config.c, until caching layer learns the iterator.

 - write caching layer to read from git_config_raw().

 - teach git_config_raw() feed its callback functions to learn the
   <file, line> information.  git_configset_get_<type> can then
   start using this in their error reporting.

 - implement iterator in the caching layer.

 - rewrite git_config() that was a thin wrapper around
   git_config_raw() by using the iterator over the cached values.

 - (optional) think about ways to give <file, line> information to
   the callback style callers.  Perhaps we need git_config_2().
   Perhaps we can rewrite all callers of git_config().  We do not
   have to decide it now.

Between git_parse_source() and git_config_raw() we would need to
pass the line-number information, but there is no reason for us to
make public (all of these will be implementation details of the
config system, including the config caching).

My answer to "why shouldn't the callbacks have <file, line>
information?" is "there is no reason why they shouldn't.  It is a
good addition in the long run".  But the optionality of the last
step in the above list makes it an irrelevant question.
