From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/15] diff: ignore submodules excluded by groups
Date: Thu, 05 May 2016 13:19:22 -0700
Message-ID: <xmqqy47o9s1h.fsf@gitster.mtv.corp.google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-12-git-send-email-sbeller@google.com>
	<xmqqlh3wxnuq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaOXxqDEqVnf5K3QjXg5bfmKW2XkmPT-mqJ93+RF5N40g@mail.gmail.com>
	<CAGZ79ka37jWYDJrAWy5KLhaaJmrLRbmTzRC6A5DneuE63+XCeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 05 22:19:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayPkA-0003It-ES
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 22:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756016AbcEEUT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 16:19:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52588 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755262AbcEEUT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 16:19:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 15DFD19B7A;
	Thu,  5 May 2016 16:19:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7Sxudh3tjNRjz1cNly4dG1VjLTY=; b=YcjGxM
	p8OXnRlyzPNMiMXzj1cnRltBoY6Abw3tPny/LCNYyODj5zwBvmFV5eZFeE1G7OeT
	UL8/NC1Gp7TuPBUm4trEULZV1KHMKtHEKs2veGbeKbSUh7MwLaM5D0M3FH4S/+sM
	PfH5i3XcaYg0BWmc8FEwhA6fcoVqhKsmF+pwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MpSTiWc/6zw7//mjeBY0FqsSMBDHhpWx
	lb4MTIynv+POf5n4dG1qMRIUZmoCRCVrBRirVDuTW8pb3XtQG25hJ9p6tVcO1Six
	RJBGvMKUHeWKhRrd+VwAINpCDTjQtwRGBmxDzcC2qYacWM/oFgzOJ2xfJHGoNAK1
	SyHkoiMpdow=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D0EE19B78;
	Thu,  5 May 2016 16:19:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A9E119B75;
	Thu,  5 May 2016 16:19:24 -0400 (EDT)
In-Reply-To: <CAGZ79ka37jWYDJrAWy5KLhaaJmrLRbmTzRC6A5DneuE63+XCeQ@mail.gmail.com>
	(Stefan Beller's message of "Thu, 5 May 2016 12:57:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A8D8B3AE-12FE-11E6-83B9-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293676>

Stefan Beller <sbeller@google.com> writes:

> Any thoughts on my thoughts below?
>
>> So here is a thought experiment:
>>
>>     # get all submodules into the work tree
>>     git submodule update --recursive --init
>>
>>     # The selected default group will not include all submodules
>>     git config submodule.defaultGroup "*SomeLabel"
>>
>>     git status
>>     # What do we expect now?
>>     # either a "nothing to commit, working directory clean"
>>     # or rather what was described in 0/15:
>>
>>         More than 2 submodules (123 actually) including
>>             'path/foo'
>>             'lib/baz'
>>         are checked out, but not part of the default group.
>>         You can add these submodules via
>>             git config --add submodule.defaultGroup ./path/foo
>>             git config --add submodule.defaultGroup ./lib/baz

That may be an interesting thing to know, but I am not sure if it
adds value to the user.  The user wanted the defaultGroup to be
the set of submodules labeled with SomeLabel, and an alternative
valid suggestion could be

	'path/foo' and other submodules are not part of what you are
	interested in; if you want to deinitialize them, do

            git submodule deinit !defaultGroup

Both look equally valid to me, but offering both would be way too
much.  I'd say you should give that only with "status -v" or
something, perhaps?

>> If we want to go with the second option,

You already lost me here, as it is not clear what two "options" you
are comparing.

>> If we want to go with the second option, the design described in 0/15
>> is broken. Going one step further:
>>
>> ...
>>     # But what about subC which is not in the default group? It was
>> changed as well.

So why not show it?  Is there anything controversial?

If you are truly not interested in it by excluding it from the
default group, you wouldn't have touched it in the first place.  If
you did touch it, then you are showing some special interest that
overrides what you said in the default mechanism.

In short, I think I understood what you wanted with your analogy to
the ignore/exclude mechanism in 0/15.  Default is a handy way to say
"I do not want to bother specifying everything from the command line
every time" but we can say that it is nothing more than that.  That
is exactly how the ignore/exclude mechanism is used--"git add" by
default will not add those that are ignored when discovering paths
by recursively descending, but once added, that is part of what the
user told Git that she cares about.

>> In case we report these submodules which are checked out but not in
>> the default group, we probably want to adapt "git submodule update" to
>> un-checkout the work tree of the submodules in case they are clean.

Why?

Letting them know that they have such an option, and giving them a
way to tell which submodules fall into that category, are both good
things.  But why is it a good thing to automatically clean what the
user has checked out (which I expect that she expects to remain
until she explicitly tells us otherwise)?

We do not automatically "git rm" a clean tracked path that happens
to match .gitignore pattern and I do not think it is a good thing to
do so.

Puzzled.
