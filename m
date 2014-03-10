From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Trust issues with hooks and config files
Date: Mon, 10 Mar 2014 08:18:26 -0700
Message-ID: <xmqqiormrsjh.fsf@gitster.dls.corp.google.com>
References: <5318ECFF.40908@0x4a42.net>
	<20140307210403.GA6790@sigill.intra.peff.net>
	<531CA468.3060604@0x4a42.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Julian Brost <julian@0x4a42.net>
X-From: git-owner@vger.kernel.org Mon Mar 10 16:18:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN1yS-0003mJ-Sn
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 16:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbaCJPSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 11:18:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60795 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905AbaCJPSf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 11:18:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC8CF730B4;
	Mon, 10 Mar 2014 11:18:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tPFSxVmFRMth2wuhAGXv4dQxCPI=; b=tV2cIP
	qTINr+DOL+Te8WMfrCbL+NjrGuUBRh++OoRwRDtV6N/1SWZ9WCQuydPOWGYxFcyy
	F1ZBhqO+981tIW1niZTWVkk57c6RaKWp8L7iUjRx8Hsp7gUZZbzxkC0gHwsEiEDQ
	0hVLcmANmYVvAbSLAfgWfnZFFBcMcwnYFf5sI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r3Jmb/NZhFAuUvhUH8LGB+x82XWMvrz+
	dZvw9TNM6HiMcDI02O1mGDcp8gMyvO44WaNGXEwqCJErxmqb9ALJMFxE3TNhZEFT
	O9IIhs1oavOYKJQ48fJLFLw4dhT30TOFctpKl6P6vkT5b2fCJeRszDV4ys9Ly/gg
	lSbU5685kN8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CACEE730B3;
	Mon, 10 Mar 2014 11:18:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D14BC730AE;
	Mon, 10 Mar 2014 11:18:28 -0400 (EDT)
In-Reply-To: <531CA468.3060604@0x4a42.net> (Julian Brost's message of "Sun, 09
	Mar 2014 18:27:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3BBE1C54-A867-11E3-BA67-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243764>

Julian Brost <julian@0x4a42.net> writes:

> On 07.03.2014 22:04, Jeff King wrote:
>> 
>> If you want to work on it, I think it's an interesting area. But
>> any development would need to think about the transition plan for
>> existing sites that will be broken.
>
> I can understand the problem with backward compatibility but in my
> opinion the default behavior should definitely be to ignore untrusted
> config files and hooks as it would otherwise only protect users that
> are already aware of the issue anyways and manually enable this option.
>
> Are there any plans for some major release in the future that would
> allow introducing backward incompatible changes?

Git 2.0 has been in the planning for quite some months, and I am
inclined to merge these topics prepared for that release to 'master'
during this cycle.  Anything new like this one is way too late for
it, but that does not mean we can never do 3.0 in the future.

Perhaps going this way might be possible:

 * Introduce a configuration that is read only from $HOME/.gitconfig
   (or its xdg equivalent) to enable or disable the "unsafe" behaviour.

   By default (i.e. when the above configuration is not set), allow
   "unsafe" read; when instructed by the above configuration to
   forbid "unsafe" read, ignore configuration files that are not
   owned by the owner of the process.  People can toggle the
   "unsafe" read to experiment with the above (~gitdaemon/.gitconfig
   can perhaps be used to restrict the daemon access)

   Keep it that way for a few releases.

 * After a few releases, start warning people who do not have the
   "unsafe" option in their $HOME/.gitconfig about a future default
   change, to force them to explicitly set it.

   Keep it that way for a few releases.

 * Flip the default, perhaps still keeping the warning on the
   flipped default to help people who have not been following along.

   Keep it that way for a few releases.

 * Then finally remove the warning.

A release cycle usually last 10-12 weeks on average.
