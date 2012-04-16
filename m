From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] clean: add --null option
Date: Mon, 16 Apr 2012 13:14:39 -0700
Message-ID: <7vehrntowg.fsf@alter.siamese.dyndns.org>
References: <1334480962-18778-1-git-send-email-rosslagerwall@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Clemens Buchacher <drizzd@aon.at>
To: Ross Lagerwall <rosslagerwall@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 22:14:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJsK2-0006mN-HN
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 22:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048Ab2DPUOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 16:14:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47466 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753761Ab2DPUOn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 16:14:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C98A1797F;
	Mon, 16 Apr 2012 16:14:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RRs8syDBFY979neU3vBhuuceUhI=; b=C1OGo2
	f3luB9/moKUmRvoh5Gl6hVUPOewLULj1JAKDP/cybpnF6nnzO77vUfk1FKb5cIOv
	KzNcTT1akJcb6XxhaPwgyWA9yNELQqbrrAsH/w3RJOp7CJcrvb46SCStRG8mW+Dn
	ow5a8C3t4sUIiKB0tZcA4kbdXteI6mhYHFQ5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xAAWPCt7o5XL7DhL40VqBjghM/MFNua/
	SN4u27BKhPj1Dg737keyt1C8Xgc36pGRikRT4BuCOKgisj4vgVhL6We+wsSyXgzy
	5HOJkv4O67GwXN2m/Z4sta1VXqcJkvpEueEaiF+9VjSjOciAOAItk34Yqh8CD7Pd
	Mq/+WHHkPOc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0620797A;
	Mon, 16 Apr 2012 16:14:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C6977975; Mon, 16 Apr 2012
 16:14:41 -0400 (EDT)
In-Reply-To: <1334480962-18778-1-git-send-email-rosslagerwall@gmail.com>
 (Ross Lagerwall's message of "Sun, 15 Apr 2012 11:09:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC9B44F6-8800-11E1-AE2C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195686>

Ross Lagerwall <rosslagerwall@gmail.com> writes:

> Add a --null (-z) option to git-clean which prints out the files
> and directories separated with a NUL character rather than '\n'.
> This makes it useful in conjunction with xargs -0.

Hrm, I do not like this at all.

The parameters to print_path() are all _("l10n-ready string"). Isn't it a
clue already that they are not meant for machine consumption?  Why are we
moving to cast the output from an end-user facing Porcelain command in
stone?

I suspect that older days "git clean" was a scripted Porcelain around a
plumbing (perhaps ls-files?---I didn't bother digging its history as I do
not care too deeply about "git clean" which I do not use myself).  If we
have piled so many features into "git clean" after the rewrite-to-C to
make it impossible to express what "git clean" _would_ do in terms of
"ls-files", perhaps that is what needs to be fixed, so that we can express
"git clean --some-set-of-options" as:

    git ls-files -z --set-of-options-equivalent-to-what-is-given-to-clean |
    xargs -0 rm -fr
