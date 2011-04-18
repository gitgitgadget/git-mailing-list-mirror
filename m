From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Inconsistency with -a vs -A
Date: Mon, 18 Apr 2011 08:04:13 -0700
Message-ID: <7v7hara9ea.fsf@alter.siamese.dyndns.org>
References: <loom.20110418T051443-551@post.gmane.org>
 <7vbp03ann1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bradly Feeley <bradlyf@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 17:04:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBq04-0004q9-Ee
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 17:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091Ab1DRPEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 11:04:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39238 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab1DRPEW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 11:04:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 37E7F38B6;
	Mon, 18 Apr 2011 11:06:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9DFkCI4OFZlT9cDdzzYe5V8IDW8=; b=NT1vaN
	FmimWNYBTnriN6NZzNp8Jj1sRqs1IBrqUzxF3b1WdW6fN048jGZlJKy1iLLn5c1A
	r0UwHXsYAdy9kj//44dYXBeDwXVbEJeNzTvnw3R0XVydOeEdOa436BJLxOIit3A2
	BVxbbXn5ea+9453Kw7TT7TIw1VpohVPiWuovg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vPthyQ3PbiNmiCUzokEtJdVJ4/Yd5ERq
	YL83GEE0s8CaiUwzGRbF4Hbu5Pf+krwp8qqX+euyvuFEQws/oXGVCkGvYBKnGlgk
	OPjfkz3lPtjpNL2yUrBiE9icEgcKTw8N8chlkTQKLz+U5S0LW38l+JwzMc0G3qlk
	+YhzzizcgWc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 010A438B5;
	Mon, 18 Apr 2011 11:06:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EE76438B2; Mon, 18 Apr 2011
 11:06:14 -0400 (EDT)
In-Reply-To: <7vbp03ann1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 18 Apr 2011 02:56:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 696EB324-69CD-11E0-92CE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171748>

Junio C Hamano <gitster@pobox.com> writes:

> The only uppercase "-A" I am aware of are these two, and both are about
> "everything under the sun", which is a special case in the context of SCM.
> All the other usual "all" options are spelled "-a".
>
> I think we could give "add -a" as a synonym to "add -u", which would be a
> safe addition that would not break any existing user, if we wanted to be
> picky and really make things more consistent.
>
> Also in the longer term, I suspect we probably should deprecate "add -A"
> as a failed experiment, if we are not going to do "commit -A" after all.
> "add ." and "add :/" (from a subdirectory) would be much less ambiguous,
> and it will get rid of the only instance of "-A" that means something
> slightly different from the usual "all".

The last paragraph is really "in the _longer_ term".  Two things need to
happen before we get there:

 - we need to teach "add ." or with any pathspec to do what the current
   "-A" with the same pathspec does implicitly, while keeping "add"
   without any pathspec a no-op.

 - ":/" (from root, whole tree) needs to be added.  We already know how
   that pathspec will behave and how to implement it.

The former may need a bit of thought and discussion, but I personally
think that "git add" with pathspec should notice deletion of tracked
paths.  It may have been Ok back when "git add $path" was only for adding
new paths, but we have changed from that semantics a long time ago and the
command deals with both tracked and untracked paths.  It does not make
much sense to special case tracked but removed paths anymore [*1*]

The latter we know we will have in a release or two.


[Footnote]

* The code does not do any special casing at the design level, but they
fall within the cracks of the implementation.
