From: Junio C Hamano <gitster@pobox.com>
Subject: Re: commit-message attack for extracting sensitive data from
 rewritten Git history
Date: Mon, 08 Apr 2013 08:40:36 -0700
Message-ID: <7vehelyqrv.fsf@alter.siamese.dyndns.org>
References: <CAFY1edbNPjs5JGOPRxzB+ie4w=SvR+rUeePhsEnpr0tWtZpeHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:34:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPF1F-0003oz-8N
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172Ab3DHPkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 11:40:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50065 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965003Ab3DHPkj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 11:40:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA898139FB;
	Mon,  8 Apr 2013 15:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tfoKpMhgRFushjLsMBtoqosD6JA=; b=HyCqgL
	+vTU3Wo3B96pldwgMRubPLu09RLfewlWC/nQYru/k4m3+PO8kHB2eQq6FU0ePiON
	UYSRd6+ib6l7L8HtBuqWVRBsoemzY/SCK/pt1UZghsZU4WxYvJdTJtbyILCWyBYg
	b8vp0sAZlcJLfXwVisfrVh+8koR4bulePY/GY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JyAv4Ll8EKU/qXuvLABV85/7J0FU2SMb
	ZC25FsW4pi6eSetvLkjsBTl9WyaNJTt6BjQuI1xlJqQW2iWYuDYtEZ4zTNg1kE6O
	/QwvhTGxV43YvYNlUbcIjZOsjZVku5+pT+bAmjbIvgj9bXOZO/4QPP2z0wZmmZvL
	bsefL2iq0vo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DEAC7139FA;
	Mon,  8 Apr 2013 15:40:38 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29D33139F9; Mon,  8 Apr
 2013 15:40:38 +0000 (UTC)
In-Reply-To: <CAFY1edbNPjs5JGOPRxzB+ie4w=SvR+rUeePhsEnpr0tWtZpeHg@mail.gmail.com> (Roberto
 Tyley's message of "Mon, 8 Apr 2013 00:17:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A947A550-A062-11E2-824B-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220434>

Roberto Tyley <roberto.tyley@gmail.com> writes:

> Here's an unmodified repo, in which the user unwisely committed a
> database password:
>
> https://github.com/bfg-repo-cleaner-demos/gma-demo-repo-original/commit/8c9cfe3c
>
> The unwise commit is reverted with a second commit using 'git revert',
> which obviously leaves the password in Git history, and - some time
> later - it's decided to properly clean the repo history with
> git-filter-branch & git gc, purging the password so the repo can be
> more widely shared (open-sourced, or just externally hosted).
>
> git-filter-branch works exactly as intended, purging the password, but
> the one thing it does not- typically - do is update the commit
> message....
> .... The git-filter-branch command has a --msg-filter option
> which could be used for this purpose, with the application of some
> judicious bash-scripting, grep&sed-ing. However, I must confess that I
> believe users would be better advised to use The BFG:
>
> http://rtyley.github.io/bfg-repo-cleaner/

With or without the security issue, leaving old object names that
will become irrelevant in the rewritten history will make the
resulting history less useful, simply because people cannot look at
the objects these messages refer to. The same argument is behind the
reason why "cherry-pick -x" was originally the default, found to be
a mistake and made optional.

filter-branch provides "map" helper function to help mapping old
object names to rewritten object names, but stops there; it leaves
it up to the message filter script to identify what string in the
message is an object name to be rewritten.

It can be taught to be more helpful to the message filter writers,
and you seem to have done so in BFG, which is very good.
