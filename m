From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP 0/6] Detached HEADs in new worktrees considered harmful
Date: Fri, 26 Feb 2016 09:37:24 -0800
Message-ID: <xmqq60xbl6ej.fsf@gitster.mtv.corp.google.com>
References: <cover.1456504190.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 18:37:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZMKh-0004Fe-It
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 18:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422718AbcBZRhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 12:37:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56139 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422666AbcBZRh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 12:37:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3CE6344870;
	Fri, 26 Feb 2016 12:37:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9UiWabaIp2Y1erqzsPbXj4iFo28=; b=V5Hgmw
	I0BsxYvjtWvo/PtiaTK5lsnK32lLpABzmdsxX++xZbIzA7QGTeJPhKhO1gfXj+K9
	cFgfW+j3HrjcfcKYgbu0nkRXGzexnPCMi0KANApzqKCsQ0ooT+jwY0i9PRFZE00L
	j8urQtBaPCritCYkSd852bpkuZGu8Ibqs4hFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tccHeU4Qv225E2HF/N+FC+Zqq0sLb60/
	ndE2M35GB/BIO9RsC6+tPEbikEVXXWwfMBxQTCntDdtsXdRJj0oHiw3X+qwp1hGR
	Mx9dLsP98q/ey05BNFMjDFr01AwRqeQRFW9H3FS6+WhenCGj5CfT5tfa2+6A3mf3
	SkDzZW8VmyQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 32B354486F;
	Fri, 26 Feb 2016 12:37:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9CD8F4486C;
	Fri, 26 Feb 2016 12:37:25 -0500 (EST)
In-Reply-To: <cover.1456504190.git.git@drmicha.warpmail.net> (Michael
	J. Gruber's message of "Fri, 26 Feb 2016 17:39:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 99743F76-DCAF-11E5-BCEA-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287598>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Before someone loses their HEAD I should put this series out (again).
>
> 1/6 is a tiny documentation fix.
>
> 2/6 demonstrates that "git prune" in the main worktree loses HEADs in other
> worktrees, and vice versa.

You do need to teach the reachability code to consider points that
are outside refs/ (HEAD and index, at least; I also recall there
were talks about per-worktree hierarchies in refs/?) as anchoring
objects to the non-prunable part of the history.

The prune/fsck reachability code already knows to consider objects
that are reachable only from the index as reachable, and I do not
think "rev-list --all" is used to enumerate them for safekeeping
(even when the worktree feature is not used).  The reachability code
that enumerates objects in the index and cache-tree needs to learn
to peek into sibling worktrees' private objects, I would think, and
I do not think the addition is a good match for rev-list.
