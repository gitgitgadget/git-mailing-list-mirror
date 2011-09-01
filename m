From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-checkout silently throws away the dirty status of index
 without a warning?
Date: Thu, 01 Sep 2011 10:11:32 -0700
Message-ID: <7v1uw0xk57.fsf@alter.siamese.dyndns.org>
References: <CAEvN+1h+mY+f3dzK7LFOwkqokOZSS-LosCzBqtYGbyjz=Dg7Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tzu-Jung Lee <roylee17@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 19:11:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzAnr-0005a9-6y
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 19:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755761Ab1IARLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 13:11:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52553 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755700Ab1IARLf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 13:11:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3966D4F24;
	Thu,  1 Sep 2011 13:11:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=82tzq1Y3vsA8KVavDf3slRTWBEY=; b=TQCQ1L
	n4pLQdc0wU493/v5IkOqi8XUVM2NP41NLMMEpWvbXAsQttGLGYnJcXHfUdJUu9f5
	jKimUIz/Q+uA5Hug/cDglZQmxleONTRP6a319Y+S1rGXBhid2WbBFgjGmvC1zm1m
	4WGyn06XJWEW2MeFvU2oD/Fe766ye2rFJqKds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fMJkwCF4z4TsP8zJnoA6xghv//5iZwHp
	0icTjVYXVW945xAvUpfJXPqLwYv0jx+uP0jxVpLNtwCmLZ00tJu9CRIuDG/kkuVi
	z2xAh0PczkwT4SGw2fmjZ9g4saHh/ovI+qbp0zb56H7f6TJf6z2RY1EMaF1GKTgx
	DQR4m5n/AOI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 305EF4F23;
	Thu,  1 Sep 2011 13:11:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B586D4F22; Thu,  1 Sep 2011
 13:11:33 -0400 (EDT)
In-Reply-To: <CAEvN+1h+mY+f3dzK7LFOwkqokOZSS-LosCzBqtYGbyjz=Dg7Zw@mail.gmail.com>
 (Tzu-Jung Lee's message of "Thu, 1 Sep 2011 23:47:59 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 716629DA-D4BD-11E0-953C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180552>

Tzu-Jung Lee <roylee17@gmail.com> writes:

> Is this an intended behavior?

Yes, I think you are talking about the case where "the current index does
not match the current HEAD, but it does match the tree we are switching
to" case. In that case we take the contents of switched-to branch.

It is the last case in the table in this old design document:

    http://thread.gmane.org/gmane.comp.version-control.git/4641

bug ignore the terminology (stage#). Read only the body of the table, with
the understanding that the three entries in each row talk about the state
for the same path in the index entry, the tree entry in the current HEAD,
and the tree entry in the switched-to branch. Also the table does not talk
about the checking performed on the working tree file, but assume that we
do not overwrite it when the resulting entry in the index does not match
what you have there.

The reason we allow branch switching in this case, instead of failing, is
so that you can be in a state where you applied the same change (relative
to the current branch to the branch you are switching to) lying around
already in your workspace and safely switch to the new branch without
losing any work (after all, the content matches).

By the way, the first six lines of your original message that describes
"saving and applying" is not correct.
