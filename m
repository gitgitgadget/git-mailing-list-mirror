From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] git-send-email: Message-ID caching
Date: Wed, 21 Aug 2013 17:20:24 -0700
Message-ID: <xmqqbo4qshiv.fsf@gitster.dls.corp.google.com>
References: <1376701126-5759-1-git-send-email-rv@rasmusvillemoes.dk>
	<1377111862-13199-1-git-send-email-rv@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sandals@crustytoothpaste.net, git@vger.kernel.org
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
X-From: git-owner@vger.kernel.org Thu Aug 22 02:20:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCIdc-0003pi-46
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 02:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845Ab3HVAU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 20:20:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52024 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752644Ab3HVAU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 20:20:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3FE8272C1;
	Thu, 22 Aug 2013 00:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cw9jfhYPYODm5TG0Pdn/RtBWyRc=; b=rJ+L94
	DiwDnR4p3R0g7pHi/CYmcfG6DntqyDgd6yQXLGFIId808xjUHmHKO9fQrnevwFT6
	GidH5w205vvEHWbXd3qFq/q30zCZbtjj78MDtNMz5IoElLfNHR9GLKIW62ZSRvFS
	21ww9NzLDGV+8StJdhIHumtk1H+XQ8ocg4ibI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GdDrDvYHf3pG83VhVl0zqYHxA+dGfW5L
	NhY+gVd5qqjbwDCjvUfO4OW2k+VrWBkWbPpZP4oHaC6usDRzN3t25J1NjFuLUVDK
	cZTX1FJrrwCY6XNwsRjKkbuMVoIyzxVR5rap2uAuA7GH+yM24R3Kcq59TXlIyAfm
	EKq77ZCDbho=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7DAF272C0;
	Thu, 22 Aug 2013 00:20:26 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 303E4272BD;
	Thu, 22 Aug 2013 00:20:26 +0000 (UTC)
In-Reply-To: <1377111862-13199-1-git-send-email-rv@rasmusvillemoes.dk> (Rasmus
	Villemoes's message of "Wed, 21 Aug 2013 19:04:20 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A48EFFFE-0AC0-11E3-80E2-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232753>

Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:

>> Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:
>>>  my %config_path_settings = (
>>> @@ -311,6 +314,7 @@ my $rc = GetOptions("h" => \$help,
>>>  		    "8bit-encoding=s" => \$auto_8bit_encoding,
>>>  		    "compose-encoding=s" => \$compose_encoding,
>>>  		    "force" => \$force,
>>> +		    "msgid-cache-file=s" => \$msgid_cache_file,
>>>  	 );
>>
>> Is there a standard, recommended location we suggest users to store
>> this?  
>
> I don't know. It is obviously a local, per-repository, thing. I don't
> know enough about git's internals to know if something breaks if one
> puts it in .git (say, ".git/msgid.cache").

I think $GIT_DIR is OK, when we _know_ we are in a Git controlled
directory.  "git send-email" can however be invoked in a random
directory that is _not_ a Git controlled directory, though.

In any case, if we were to store it inside $GIT_DIR, I'd prefer to
have "send-email" somewhere in the name of the file, as there are
other Git programs that deal with things that have "msgid" (notably,
"am") that will not have anything to do with this file.

> If storing it under .git is possible, one could consider making the
> option a boolean ('msgid-use-cache' ?) and always use
> ".git/msgid.cache".

Another possibility is to have it in the output directory specified
via the "format-patch -o $dir" option.  When you are rerolling a
series multiple times, you will only look at the message ID from the
previous round; you do not even need to look at old messages in an
unrelated topic.

I could imagine that

	git send-email $dir/0*.txt

can notice that these input files are all in the same $dir
directory, check to see if $dir/message-id file exists, read it to
offer it as the suggested initial-reply-to.  Similarly, when sending
the _first_ message in such an invocation, it can just write the
generated message-id to that file.  Then we need no choices.  It is
sufficient to just keep a single message-id of the first message in
the previous round and offer it as a possible initial-reply-to in a
Yes/No question.

Just a random thought.
