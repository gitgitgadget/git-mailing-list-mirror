From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Expand ~ and ~user in core.excludesfile,
 commit.template
Date: Thu, 28 Aug 2008 21:08:37 -0700
Message-ID: <7vod3ca2ey.fsf@gitster.siamese.dyndns.org>
References: <7vprnyqo59.fsf@gitster.siamese.dyndns.org>
 <20080824220854.GA27299@coredump.intra.peff.net>
 <7vzln2j9y2.fsf@gitster.siamese.dyndns.org>
 <20080824231343.GC27619@coredump.intra.peff.net>
 <7vhc9aj82i.fsf@gitster.siamese.dyndns.org>
 <quack.20080825T1207.lthk5e46hi4_-_@roar.cs.berkeley.edu>
 <20080827002506.GB7347@coredump.intra.peff.net>
 <quack.20080826T2012.lthvdxn2ls4@roar.cs.berkeley.edu>
 <7vy72jrr00.fsf@gitster.siamese.dyndns.org>
 <quack.20080828T0209.lthmyixjyjx_-_@roar.cs.berkeley.edu>
 <20080829032630.GA7024@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl Chen <quarl@cs.berkeley.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 06:12:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYvLn-0008MY-9d
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 06:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbYH2EIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 00:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbYH2EIq
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 00:08:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:32979 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbYH2EIp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 00:08:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EAEBE54B9A;
	Fri, 29 Aug 2008 00:08:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1FD1454B99; Fri, 29 Aug 2008 00:08:39 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2BA552F8-7580-11DD-BBD5-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94248>

Jeff King <peff@peff.net> writes:

> On Thu, Aug 28, 2008 at 02:09:38AM -0700, Karl Chen wrote:
>
>>  builtin-commit.c |    2 +-
>>  cache.h          |    2 +
>>  config.c         |   13 +++++++-
>>  path.c           |   88 +++++++++++++++++++++++++++++++++--------------------
>>  4 files changed, 69 insertions(+), 36 deletions(-)
>
> Documentation?
>
>>  	if (!strcmp(k, "commit.template"))
>> -		return git_config_string(&template_file, k, v);
>> +		return git_config_userdir(&template_file, k, v);
>
> I like this.

Likewise, except for the name.  It is more like "pathname"; "userdir" is
stressing only one aspect of the magic we would do to a value that is a
pathname compared to a value that is a string without any magic.

>> +int git_config_userdir(const char **dest, const char *var, const char *value) {
>> +	if (!value)
>> +		return config_error_nonbool(var);
>> +	*dest = expand_user_path(NULL, value, 0);
>> +	if (!*dest || !**dest) die("Failed to expand user dir in: '%s'", value);
>> +	return 0;
>> +}
>
> I am not sure about !**dest here. This precludes somebody from using "".
> While it might not matter here, if there are other users of
> git_config_userdir(), they might want to allow a blank entry.

True again.

>> +	if (begin_username == end_username) {
>> +		return getpwuid(getuid());
>> +	} else {
>
> Style: omit braces on one-liner conditionals:

... except in cases like this where "else" side is a multi-statement
block, in which case the above is fine.  But as you pointed out, the early
return from here makes the else block unnecessary so you do not need the
braces around "if" side.

>> +		char *username = alloca(username_len + 1);
>
> I don't think we use alloca() anywhere else. I don't know if there are
> portability issues.

Avoidance of alloca() and c99 dynamic array on stack is deliberate in the
current codebase.  Portable use of alloca() is quite hard to get right.

>> +static inline const char *strchr_or_end(const char *str, char c)
>> +{
>> +	while (*str && *str != c) ++str;
>> +	return str;
>> +}
>
> This really seems like premature optimization to me.

So is overuse of inline, it seems.
