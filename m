From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i -p: use rerere to resolve conflicts if enabled
Date: Fri, 15 Jun 2012 22:19:08 -0700
Message-ID: <7vd34z96lv.fsf@alter.siamese.dyndns.org>
References: <1339769855-94161-1-git-send-email-ddkilzer@kilzer.net>
 <7vwr38bmj5.fsf@alter.siamese.dyndns.org>
 <B4036488-1ECA-41C9-BD97-B2ABD116D54C@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kilzer <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Sat Jun 16 07:19:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SflPo-0005Ju-2r
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jun 2012 07:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150Ab2FPFTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jun 2012 01:19:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45881 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751906Ab2FPFTL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2012 01:19:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 566A23A7F;
	Sat, 16 Jun 2012 01:19:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=13BIchn8FONVgcUn3k/5k7bibzU=; b=Nd+OQu
	pUL1bH7DFk8FAwVC8npPepF+DIRE/YQ41hDJRE8IVFch9P9FY1bvrod4cWu/f7Ao
	zH6w4b0OiZ1zULTdxZjYMj+TOtmvA4ONqXqYFZE/MjG9rW8gLuYGN+sVxxR5VD+i
	SNzS+9EC/RuiGK+LZd1uA9PIl43fLc2ISI2qY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u90DM3ypUiCOxZvgx4RSYVnD3Cli1uh1
	shqM+3LVj0/4WmvwX48SAPQu5CiR4ZZR+YsZiMluU/eBNsZZ5zvoxYaoBHMD5Ygg
	w+VUKA6rlZKLRllTz1RLBzZrQatcOUo9lPwD3oMtExC10SadjKqu0Fjztis05fHm
	4eH0aKrfJyg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D7413A7E;
	Sat, 16 Jun 2012 01:19:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D74A13A7D; Sat, 16 Jun 2012
 01:19:09 -0400 (EDT)
In-Reply-To: <B4036488-1ECA-41C9-BD97-B2ABD116D54C@kilzer.net> (David
 Kilzer's message of "Fri, 15 Jun 2012 21:08:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD741244-B772-11E1-A5E3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200109>

David Kilzer <ddkilzer@kilzer.net> writes:

>> The configuration rerere.enabled *never* meant that the user blindly
>> trusts the result of replaying a previous resolution.  If you were
>> checking rerere.autoupdate configuration variable, the patch may
>> have made some sense, but basing the decision on rerere.enabled
>> (which by the way is not necessary to trigger the rerere machinery
>> these days, as long as $GIT_DIR/rr-cache/ directory exists) sounds
>> very wrong.
>
> Thanks!  I'll repost the patch based on rerere.autoupdate for further discussion.

I do not use the configuration variable myself, and I didn't check
the code, but if you had rerere.autoupdate set, doesn't "git merge"
in the codepath you are touching (or anywhere for that matter)
already blindly take the replayed resolution and commit the result?

In other words, do you need to do anything special to make the
command honour rerere.autoupdate?

Assuming that your patch does not need to do anything special based
on the rerere.autoupdate configuration (because the underlying
"merge" may automatically take care of it), I think what you need
may be a mechanism to give --[no-]rerere-autoupdate option to "git
rebase -m/-i/-p" and pass that option to the invocation of
underlying "git merge", so that the user who does not usually want
to blindly trust the replayed resolution (hence rerere.autoupdate
configured to false) can choose to tell the "git rebase -m/-i/-p"
command that "for this single invocation it is OK to trust the
replayed resolution".  Or the other way around, i.e. "Even though I
have rerere.autoupdate configured to true, for this single
invocation of 'rebase', I am giving the '--no-rerere-autoupdate'
option to tell you that you should _not_ blindly replay the
resolution."

Hrm?
