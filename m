From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Wed, 25 Jun 2014 13:53:58 -0700
Message-ID: <xmqqk38490d5.fsf@gitster.dls.corp.google.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
	<1403518300-23053-3-git-send-email-tanayabh@gmail.com>
	<53A84077.4010200@ramsay1.demon.co.uk>
	<xmqqsimv9pjx.fsf@gitster.dls.corp.google.com>
	<53A99FEB.5040808@ramsay1.demon.co.uk>
	<xmqq61joamcc.fsf@gitster.dls.corp.google.com> <53AB2FAA.0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 22:54:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzuCq-0001FZ-E7
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 22:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311AbaFYUyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 16:54:07 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64838 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755309AbaFYUyF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 16:54:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9D1A421620;
	Wed, 25 Jun 2014 16:53:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/MHqV3svw1mEc0MdJhZxVMCz8Sk=; b=pugljz
	fIyYP7aJj+LHqWGBWyEXv51GFK4LHBSaT+DK3ku6LgvfMgMQ9aXJNoqpfKHxnjDP
	RHvAQ0wbIuyXCjbtFi+t1wfyRqhvXUdj7sUe6H1XUxhFIAXjCnc46EvxX369HDjG
	wa4Lk/PZd5z13aoeM8KJ0HQBU1vBStZolPCxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MbEnlxmNpSM04bkQ8gVvjodTPpyhOhEP
	L8L59BhxpGt7BeTR+TpDYLCDaQ9fqtaaE/6cIam0P1b2YCvvi9AlnFLii0sc3U/Z
	0z4nJqQGVoLv0HO8E3Wk+2XYu69OywxEZ5XdYRots51nDdat1/onnoExEzQ3JAdj
	NupVfjDMg7I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 933F22161F;
	Wed, 25 Jun 2014 16:53:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DA18B2161C;
	Wed, 25 Jun 2014 16:53:53 -0400 (EDT)
In-Reply-To: <53AB2FAA.0@gmail.com> (Karsten Blees's message of "Wed, 25 Jun
	2014 22:23:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D170C1BA-FCAA-11E3-9904-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252460>

Karsten Blees <karsten.blees@gmail.com> writes:

> Am 25.06.2014 20:13, schrieb Junio C Hamano:
>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>> I had expected to see one hash table per file/blob, with the three
>>> standard config hash tables linked together to implement the scope/
>>> priority rules. (Well, these could be merged into one, as the current
>>> code does, since that makes handling "multi" keys slightly easier).
>> 
>> Again, good point....
>
> Is this additional complexity really necessary?

Nothing is *really* necessary ;-) and it is possible that the best
balance may be at "parse a single chain of files into a single
hashtable for a config-set, and if anything changes, re-read
everything from scratch".

The point Ramsay raised about being able to share the pre-parsed
$HOME/.gitconfig across multiple config-sets (one for the top-level
superproject, and the others for submodules, when having to work
across module boundaries) triggered this thought experiment (aka "I
am not married to the approach") to use one table per source.  If we
wanted to take advantage of updating a single file and not having to
re-read the whole thing, includes need to be handled a bit more
carefully than "one config-file for one source", as you noticed, and
a single source may have to be split into multiple pieces.

And it is possible that the complexity necessary to do these
correctly may make it not worth pursuing the approach.  Or it may
not.  I don't know at this point, and thinking these things through
to arrive at a good design is part of the GSoC project after all, so
I'd rather not to think it through to the end myself ;-).

> What's the use case for this? Do you expect e.g. 'git gc' to
> detect changed depth/window size at run time and adjust the
> algorithm accordingly?

I did write "detect" but I think a more realistic example is that we
do git-config-set internally and wish to see the effect inside the
same process (i.e. something like "pull --set-upstream" that sets
configuration variable for later invocations and also perform the
operation with the configuration in effect at the same time).
