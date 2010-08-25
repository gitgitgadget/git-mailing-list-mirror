From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] diff_tree(): Skip skip_uninteresting() when all
 remaining paths interesting
Date: Wed, 25 Aug 2010 16:25:23 -0700
Message-ID: <7v1v9mp95o.fsf@alter.siamese.dyndns.org>
References: <1282704795-29661-1-git-send-email-newren@gmail.com>
 <1282704795-29661-6-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 01:25:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoPLf-0004uv-5Q
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 01:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938Ab0HYXZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 19:25:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45352 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab0HYXZc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 19:25:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB227D0DAC;
	Wed, 25 Aug 2010 19:25:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZUGtDki04z5oNHJfdp7yIhDfYS0=; b=taVhWR
	NwDOupLbXg0HIZw+eC2lecqKmG3AblmQzKq5163r3ev7NwfIQAkKOnKrPrYwek9Y
	8m98w2z2LTcw4FYQfU/myXai/KBj5OjE/c9zZMeKH3doKqQtWUi2dlw6+0I+PPFD
	NBlpRvmFsiNK7WVfbmzWpC4d7UNtP7rp6OlmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aPgqTUTjIl8jacFEhgkrvY62nWfIdSw6
	xUlwIKSMaJ77NjTnc1vFswd9bEJt2AW6fGgqlOJe8ceLQqGZnreoJf+kemZEibUP
	zfjNwXRmwBCEAwVBbfKwD1QQ7M7gBVZkKkX48hiRj9dsw31nEQnXUPQPC0z2dGBW
	Xl/PZku91zI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 815A1D0DAB;
	Wed, 25 Aug 2010 19:25:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBDB5D0DAA; Wed, 25 Aug
 2010 19:25:25 -0400 (EDT)
In-Reply-To: <1282704795-29661-6-git-send-email-newren@gmail.com> (Elijah
 Newren's message of "Tue\, 24 Aug 2010 20\:53\:13 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0BE05A50-B0A0-11DF-9CD4-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154494>

This and the previous patch seem to make sense to me, independent of the
rest.

As to mixing pathspecs with --objects, I would say it is unfair to Linus
to call it a bug that that particular use case has not been supported.  I'd
say it _is_ a bug that we didn't error out when --objects was given with
pathspec at the command line level, though, as that is a combination we
knowingly ignored to support.

It simply hasn't been deemed as a sane operation to produce a pack using
an output from rev-list with pathspec and --objects, as it will leave some
trees and blobs that the pack knows about in the result, without actually
having them in it.  In the context of "narrow clone", these wounds to
trees are deliberate, and the existence of these wounds alone is not the
reason why I called it insane to produce such a pack.

To make use of such a pack, however, you need to somehow cauterize these
deliberate wounds in trees so that fsck, a later run of pack-objects,
fetch-pack and friends will not choke on them.  We didn't plan to have
such an infrastructure so far, and that is what made such a pack with
thousands of cuts "insane".  As soon as "narrow clone" addresses that
issue, mixture of pathspecs with --objects stops being an insane use
case.
