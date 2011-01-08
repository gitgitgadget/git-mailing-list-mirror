From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git rev-list --no-walk A B C sorts by commit date
 incorrectly
Date: Fri, 07 Jan 2011 21:41:22 -0800
Message-ID: <7vk4ig7y0t.fsf@alter.siamese.dyndns.org>
References: <CEF26B82-4281-4B8F-A994-DE32EFB92BA7@sb.org>
 <7v62u043ba.fsf@alter.siamese.dyndns.org>
 <BB84A2F6-E6B0-49E4-9DC7-6BA8860623E6@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Jan 08 06:46:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbRdN-00059V-8D
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 06:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849Ab1AHFlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 00:41:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56017 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab1AHFlb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 00:41:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 55D014F86;
	Sat,  8 Jan 2011 00:42:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ksYz2CijjWjwH5eQzubyrl6sHQg=; b=N52KHi
	vkZxhkiXBfGHy9ZQmImz9H8SqYSaiFmphAoJXlQTIP8TgNo8te7GFfxPlxOkcAXW
	B1fj7EKVqWQu+hjYfMm+K/qZB4jrTkd+thiJSIiRNT1Z6N7br6mgwLFjueLTL/UC
	3peHHYGURjyCA73EDTabmkQ7tfiJW6ji7BUSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jo+KJcmZ2mAYP4T6V9g9OQeQk76C2NX9
	VYM0pyhyvB3Ivj86PY3g8vQqc3yw3WQKzNry/C78vRPkSmik5fPiDoV/5NxEz1KB
	/zgRAReZeDgsbOcg1uCQ88yd73nZXsjA230SRBvhyHHpDitnywuH2ZGfgJlFbpVD
	EHbY0OWGbEU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 310574F85;
	Sat,  8 Jan 2011 00:42:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4906E4F7E; Sat,  8 Jan 2011
 00:42:03 -0500 (EST)
In-Reply-To: <BB84A2F6-E6B0-49E4-9DC7-6BA8860623E6@sb.org> (Kevin Ballard's
 message of "Fri\, 7 Jan 2011 19\:12\:20 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 06E6F5D6-1AEA-11E0-9624-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164806>

Kevin Ballard <kevin@sb.org> writes:

> It almost works, but not quite. My inclination is to say
> `git rev-list --no-walk A B C` should emit A B C in that order. Implemented
> this way, `git rev-list --no-walk ^HEAD~3 HEAD` emits commits in the wrong
> order,

"git rev-list --no-walk ^HEAD~3 HEAD"?  Isn't it a nonsense?  If it is "no
walk", then why do you even list a negative one?


As to cherry-pick, I wouldn't be surprised if it relies on the current
internal working of pushing commits in the date order to the queue
regardless of how they were given from the command line.

Indeed, it does exactly that, and then tries to compensate it---notice
that builtin/revert.c:prepare_revs() gives "revs->reverse" to it.  That
also needs to be fixed.
