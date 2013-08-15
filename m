From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/3] branch: report invalid tracking branch as broken
Date: Thu, 15 Aug 2013 11:38:53 -0700
Message-ID: <7vmwoire82.fsf@alter.siamese.dyndns.org>
References: <6bc0643a5fa0fae03be6fdb59f63075be1e4d983.1376590264.git.worldhello.net@gmail.com>
	<7vbo50uvty.fsf@alter.siamese.dyndns.org>
	<8db143908bc969bbe1d720479fb6214729f7b1ae.1376590264.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 20:39:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA2Rr-0002Uf-VO
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 20:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765Ab3HOSi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 14:38:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44404 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903Ab3HOSi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 14:38:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8736C39BC0;
	Thu, 15 Aug 2013 18:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Od6JGepUB7YuUkBvNwvJB5oacZY=; b=laJ5uP
	8ZUyGUNkmb/KLcGOctBmMi4iaqcNKtnmRD9J/k+gkHFL3VWjJIx209AbMbEB8WcS
	+MsEYxkadCvhRqffyCS9NcSk2sbWFvQekVU9AJO5NY4xPy/xm1xePm3/wfF84/Qg
	h3RqvjgXsgs97kyZMGbeGCM66ZsTpwD1OiQjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fUVzcui+1JYjwA67Ou2agG4ZwEGhjyQp
	99uDKsU/0Yfr2y9JgYekKl1AzKjaYqak2rHkmpinvU1NOFb2cWYxZwQXwZCRdLPu
	LffzRZKuOatTe1f5RNGwZX3AUomkLEpTA8s/3zH2M3mB4q5j1KdD5BJcME1kEWlJ
	ZmbQtnf5B0E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BA8D39BBF;
	Thu, 15 Aug 2013 18:38:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E990539BBA;
	Thu, 15 Aug 2013 18:38:54 +0000 (UTC)
In-Reply-To: <8db143908bc969bbe1d720479fb6214729f7b1ae.1376590264.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Fri, 16 Aug 2013 02:11:22 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F05932A6-05D9-11E3-AAB8-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232361>

Jiang Xin <worldhello.net@gmail.com> writes:

> If a branch has been set to track a upstream, but the upstream branch
> is missing or invalid, the tracking info is silently ignored in the
> output of some commands such as "git branch -vv" and "git status",
> as if there were no such tracking settings.
>
> Junio suggested broken upstream should be reported [1]. E.g.
>
>     $ git branch -v -v
>       master    e67ac84 initial
>     * topic     3fc0f2a [topicbase: broken] topic

I'd assume this is s/broken/gone/ to match what the rest of the log
message says?

>     $ git status
>     # On branch topic
>     # Your branch is based on a broken ref 'topicbase'.
>     #   (use "git branch --unset-upstream" to fixup)
>     ...
>
>     $ git status -b -s
>     ## topic...topicbase [broken]
>     ...
>
> In order to do like that, we need to distinguish these three cases
> (i.e. no tracking, with configured but no longer valid tracking, and
> with tracking) in function stat_tracking_info(). So the refactored
> function stat_tracking_info() has three return values: -1 (with "gone"
> base), 0 (no base), and 1 (with base).
