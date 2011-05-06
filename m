From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] status: display "doing what" information in git
 status
Date: Fri, 06 May 2011 10:29:21 -0700
Message-ID: <7vei4b20we.fsf@alter.siamese.dyndns.org>
References: <7vr58c4sip.fsf@alter.siamese.dyndns.org>
 <1304667535-4787-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri May 06 19:29:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIOqQ-0006LV-DD
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 19:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053Ab1EFR3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 13:29:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab1EFR3c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 13:29:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 310E0429D;
	Fri,  6 May 2011 13:31:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Eb4fhIOkIV/MD/4AcyQ9LFJ57f0=; b=jKO7Cl
	ehO+eVl3tBWLK7/AP7QXQmSlOZjPszd1Rd4LtmdQD8lDDWiQF8uCVtkaxbN/N/E/
	EwaIKFm316+VeZSRYO+rIc03rGlvXXl/blYlyqUYjBt3ULNKj9XRA8VWARdriRLi
	H5olMCksGkxKv8aCN35NG1QiZYl0r7gwyVOZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XgHYhKygXfWPlecfjH+7IKXobtVkVT9S
	HPDKCrUxZ32G2oATtYxUmW/TRcZuP89ydh5K9kCTekBx/6HZX2hqpVMDgvGEF+0x
	qwb3QghVqISsvr3LhZwaTfqV2dpHutLrN6mw79zbpIydCQEuXOniKCUN+UbPilVC
	2t7lglpquOg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0FC154293;
	Fri,  6 May 2011 13:31:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1DA2E4292; Fri,  6 May 2011
 13:31:26 -0400 (EDT)
In-Reply-To: <1304667535-4787-1-git-send-email-madcoder@debian.org> (Pierre
 Habouzit's message of "Fri, 6 May 2011 09:38:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ADA8FC06-7806-11E0-B72A-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172993>

Pierre Habouzit <madcoder@debian.org> writes:

> 	$ git status
> 	# in the middle of a git rebase -i of master (detached head)
> ...
> 	#       qkv/A/
> 	no changes added to commit (use "git add" and/or "git commit -a")
>
> If we have an ongoing operation then:
> - if we are on a branch it displays:
>   # On branch $branch ($what_is_ongoing)
>   #   ($ongoing_hint)
> - if we are on a detached head it displays:
>   # $what_is_ongoing (detached head)
>   #   ($ongoing_hint)

I'll reindent the above to align these example output the earlier output sample
when I apply them.

> +	const char * const rebase_advice =
> +		_("use \"git rebase --abort\" to abort current rebase or proceed");
> +	const char * const am_advice =
> +		_("use \"git am --abort\" to abort current mailbox apply or proceed");

If the reader does not even know that the "--abort" option is used to
abort, " or proceed" needs to be followed by "by doing $this", if it wants
to have any practical value.  I would suggest dropping it.

> +	const char * const merge_advice =
> +		_("use \"git reset --hard\" to abort, or resolve conflicts and commit");

This codepath being in wt-status.c, I wonder if any of these advices could
trigger to appear in the log message editor when the user tries to run
"git commit".  If so, I suspect any of the above is too late to help the
user, no?

Also, should we make these conditional upon advice.status or something?
