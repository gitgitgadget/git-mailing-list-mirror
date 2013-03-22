From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] remote.c: introduce a way to have different remotes
 for fetch/push
Date: Fri, 22 Mar 2013 15:13:39 -0700
Message-ID: <7vli9f5bho.fsf@alter.siamese.dyndns.org>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
 <1363938756-13722-5-git-send-email-artagnon@gmail.com>
 <20130322212159.GJ12223@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 23:14:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJADy-00032s-26
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 23:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423048Ab3CVWNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 18:13:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60532 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422662Ab3CVWNm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 18:13:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C92F8B652;
	Fri, 22 Mar 2013 18:13:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T1Jsb8/TsR2g/nXVQu5NcanAFQk=; b=ctKktE
	R72QQZgTcnMiXW8iHXqzvuDBXzSeywTk7qFYtqLXPBIA3Od1EaFXuSyM6rfrblkX
	PnU5TxLbntNzPLkILqTORp5PZVpE0XDdCTZHyJNZKsYinxSJVvgqmNmBlfEMS+Vk
	JV9WWDSO4kZe9JMWyVHvNsqmL4DJ0JXMEkfPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XxlAPCOuK7e940RZWdgXqbJfaKuzOrim
	Vxo2aH6IEWUCjm+UV/5+RqJo0W/5jvbLb7y5PLWL8q9wP5ZYCR9FWXhp9D1FK1CJ
	3HD5qY7UF4sNZTHNzp7LPqKO36vSIggDxoYtVhtinpd37hmXhV60AdBSomqOyPK/
	xgzIGddZGn4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE2F8B651;
	Fri, 22 Mar 2013 18:13:41 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22B9DB64C; Fri, 22 Mar 2013
 18:13:41 -0400 (EDT)
In-Reply-To: <20130322212159.GJ12223@google.com> (Jonathan Nieder's message
 of "Fri, 22 Mar 2013 14:21:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0CD91DA-933D-11E2-A064-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218856>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> --- a/builtin/push.c
>> +++ b/builtin/push.c
>> @@ -322,7 +322,7 @@ static int push_with_options(struct transport *transport, int flags)
>>  static int do_push(const char *repo, int flags)
>>  {
>>  	int i, errs;
>> -	struct remote *remote = remote_get(repo);
>> +	struct remote *remote = pushremote_get(repo);
>
> "struct remote" has url and pushurl fields.  What do they mean in the
> context of these two accessors?  /me is confused.
>
> Is the idea that now I should not use pushurl any more, and that I
> should use pushremote_get and use url instead?

I thought the basic idea from the user-level is:

 - If you have to use different URL to push to and fetch from the
   logically same location (e.g. git://k.org/pub/scm/git/git.git
   used for fetch, k.org:/pub/scm/git/git.git/ used for push), use
   url for fetch, pushurl for push and you don't have to bother with
   per-branch pushremote at all.  You are logically working with the
   same remote, perhaps called 'origin'.

 - If you push to and fetch from logically different repositories,
   (e.g. fetch from https://github.com/gitster/git, push to
   github.com:artagnon/git), you may want to call your upstream
   'origin' and your publishing repository 'mine'.  You set the
   remote.pushdefault to 'mine', perhaps like:

	[remote "mine"]
        	url = github.com:artagnon/git

   (this can also be written with remote.mine.pushurl).

By splitting remote_get() used for fetch and pushremote_get() used
for push, the latter function can return 'origin' and 'mine' for
these two cases, while remote_get() will return 'origin' for both of
these cases.  At the programming level, you would still ask what the
URL to be pushed to to the remote obtained here, and would use
pushurl if defined, or url otherwise.

Ram, am I following your thoughts correctly?
