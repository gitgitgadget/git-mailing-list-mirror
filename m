From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] submodule--helper module_list_compute: allow label or name arguments
Date: Tue, 10 May 2016 19:24:39 -0700
Message-ID: <xmqqzirxjpqw.fsf@gitster.mtv.corp.google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
	<1462928397-1708-6-git-send-email-sbeller@google.com>
	<xmqq8tzhl6v7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de, git@vger.kernel.org,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 11 04:24:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0JpP-0006zC-7Q
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 04:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbcEKCYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 22:24:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62990 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751329AbcEKCYm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 22:24:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6017B1B056;
	Tue, 10 May 2016 22:24:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1wvTEWV1fzJSxCyz7/4af9ZV8ts=; b=uB6Y+/
	vBZmr3EWPim5BT0KZ4E7cyCdVTGCQVzcFxHaZU7pKG5I0O7Mdj3itFks87ng4bh0
	JritoUqnKCitb93kBtlcXl8QHu/nzobHt9CZDNk78EoTtt5RlWHSGNvbgOvhkLNl
	PTn6apDe+yObbKOBeM5MpgTDJ/ajmYrFDaiHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t3Txqz1rEjdwvI5iOrKQTILpjL0BAHgb
	7OEYlE/KCi9vnSn5kxqWwB1nrL4zUa3U9t7jiFpYKh5H6YIlDGDHiocrXtQoZeEQ
	kaUFCec6iZh9EA84LQ4a2T5yeEKNmHu/cIkoR3INvUB/k0PEaZXA/U14Edcw6VoF
	SnagoZQM7E4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 56CF61B055;
	Tue, 10 May 2016 22:24:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB2761B054;
	Tue, 10 May 2016 22:24:40 -0400 (EDT)
In-Reply-To: <xmqq8tzhl6v7.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 10 May 2016 18:29:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 840FEE1E-171F-11E6-89C7-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294224>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> +static void split_argv_pathspec_groups(int argc, const char **argv,
>> +				       const char ***pathspec_argv,
>> +				       struct string_list *group)
>> +{
>> +	int i;
>> +	struct argv_array ps = ARGV_ARRAY_INIT;
>> +	for (i = 0; i < argc; i++) {
>> +		if (starts_with(argv[i], "*")
>> +		    || starts_with(argv[i], ":")) {
>> +			string_list_insert(group, argv[i]);
>> +		} else if (starts_with(argv[i], "./")) {
>> +			argv_array_push(&ps, argv[i]);
>
> I'd suggest stripping "./" when you do this.  That is, make the rule
> to be "*label is a label, :name is a name, and everything else is a
> path.  You can prefix ./ to an unfortunate path that begins with an
> asterisk or a colon and we will strip ./ disambiguator".

To clarify, "./$path and $path are the same so why strip it?" is an
understandable, even though naive, question. The reason is because
you do not want to contaminate the code that parses pathspecs with
the knowledge of this submodule-group specific prefix.  "./$path"
and "$path" may be equivalent for a literal pathspec, but I'd want
to see user be able to say

   git submodule foreach './:(icase)foo'

and find Foo, foo, FOO, etc.

I would also recommend to strip '*' and ':' from group names and
module names, and maintain two separate lists.  You would eventually
want to do "*default*" to name all groups whose name matches with
the pattern "default*", as if it were a pathspec matched against the
available group names, and that will keep the door open for future
extension like  "*:(icase)default*".
