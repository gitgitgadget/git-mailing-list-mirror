From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i -p: use rerere to resolve conflicts if enabled
Date: Sat, 16 Jun 2012 22:49:39 -0700
Message-ID: <7vmx427aj0.fsf@alter.siamese.dyndns.org>
References: <1339769855-94161-1-git-send-email-ddkilzer@kilzer.net>
 <7vwr38bmj5.fsf@alter.siamese.dyndns.org>
 <B4036488-1ECA-41C9-BD97-B2ABD116D54C@kilzer.net>
 <7vd34z96lv.fsf@alter.siamese.dyndns.org>
 <76A6615B-5758-4D67-A556-2EE131FF7B20@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kilzer <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Sun Jun 17 07:50:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sg8Nc-0004xB-Qk
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jun 2012 07:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236Ab2FQFtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jun 2012 01:49:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50074 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889Ab2FQFto (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2012 01:49:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A4669D97;
	Sun, 17 Jun 2012 01:49:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=z57X8B2tW5i87dd5x6dfxhSdw08=; b=Ke9MXXdltM7aw+0G8gBr
	ZbaX9bbix5yadydQYBjluma3x3yHzGlSj9PNtvG1QLalqHZFn+sBL7JESlFBEY+K
	89QlV1SUapUJErWI1EPm7wqllmRVGC14fEwbKnYtc15t0umG5Eb6KFhkVnyWUXeU
	rLKKElfHzt+BvY1WC4J3a6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=TTv48Z78bO7QZXRTiKTqSXFOjQr8Q+aqa8TeOmk1aXJSJh
	0jZBlckMYEuKyKP5ERQY/N09h6D0OtStofSgdlZ1KLpm54ju6eQKBv6rPLtiX4rV
	f154GNdnRgO5KNXW9TipfeO6nBpP1sXKvSSEfKGsik28wfQUkRROkKA2aLizo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90C719D96;
	Sun, 17 Jun 2012 01:49:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 276DD9D95; Sun, 17 Jun 2012
 01:49:41 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B64F3D6-B840-11E1-A494-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200117>

David Kilzer <ddkilzer@kilzer.net> writes:

> On Jun 15, 2012, at 10:19 PM, Junio C Hamano wrote:
>
>> I do not use the configuration variable myself, and I didn't check
>> the code, but if you had rerere.autoupdate set, doesn't "git merge"
>> in the codepath you are touching (or anywhere for that matter)
>> already blindly take the replayed resolution and commit the result?
>
> No, it does not.  That is what I originally expected to happen
> when I used "git rebase -i -p" through a merge with conflicts, but
> it currently does not behave this way.

After looking at what is done in t/t4200-rerere.sh, I think "git
merge" (or anything that use --rerere-autoupdate, that is) is meant
to exit with an error code after allowing rerere to add the result
of replayed resolution to the index, so that the user can deal with
any remaining paths that may be still in conflict.

Are you sure that the autoresolved paths are not "git add"ed when
you have rerere.autoupdate set by "git merge" in "git rebase -i/-p"?

Or are you only talking about the error exit from "git merge" that
would cause "git rebase -i" to stop and give control back to the end
user?

I suspect that the latter behaviour to stop "rebase" in the middle
is in line with the spirit of --rerere-autoupdate, and it is not
likely that we would want to change it.
