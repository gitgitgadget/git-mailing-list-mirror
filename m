From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Fix path prefixing in grep_object
Date: Sat, 24 Aug 2013 20:35:04 -0700
Message-ID: <xmqqa9k6moif.fsf@gitster.dls.corp.google.com>
References: <1377394558-371-1-git-send-email-hordp@cisco.com>
	<CABURp0qG7Nnjpp17MAO7Ltwf51EsswZ3GcT-qyt14Vs1tc9pGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <hordp@cisco.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 05:35:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDR6h-00081M-1v
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 05:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464Ab3HYDfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 23:35:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44445 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754939Ab3HYDfH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 23:35:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAF482C0B1;
	Sun, 25 Aug 2013 03:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D8OxzaKkO5Wqrb6yrR/oYP64tRw=; b=wK0L3k
	6iXyKjzDbjLvjPgNmzQeljerd6lUc048rLHczprp3tAfxP3e4l49KTtv7CsxGCS4
	yiN3JW3rEajXDsKzKlKMHfKXwE4/mXKa4dZr0AXHGAjgwGAtW/bDkDptSbHA/iKV
	VRlrziVVwwW1V1nqtctyjzokxSwMJV3HqJ0Jo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XufZb2XTzZJfXd0H7px8p+xnw/EYHwFM
	LTqnAx7Pd9DeDHNBFQwoshUoW6++p4AMVAwLa6vEe4jIiZIT9QiAR/ov+iYjt6nS
	U7e4zyimBjLIa4xDD1Et0P9l2WvsuAPJx28OrysHetFU1OjendfUiTwX+dyWl2vo
	kqisanEypRg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFF1B2C0AE;
	Sun, 25 Aug 2013 03:35:06 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 332F02C0AD;
	Sun, 25 Aug 2013 03:35:06 +0000 (UTC)
In-Reply-To: <CABURp0qG7Nnjpp17MAO7Ltwf51EsswZ3GcT-qyt14Vs1tc9pGw@mail.gmail.com>
	(Phil Hord's message of "Sat, 24 Aug 2013 22:07:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 55A07BD8-0D37-11E3-B503-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232903>

Phil Hord <phil.hord@gmail.com> writes:

> On Sat, Aug 24, 2013 at 9:35 PM, Phil Hord <hordp@cisco.com> wrote:
>>
>> When the pathspec given to grep includes a tree name, the full
>> name of matched files is assembled using colon as a separator.
>> If the pathspec includes a tree name, it should use a slash
>> instead.
>>
>> Check if the pathspec already names a tree and ref (including
>> a colon) and use a slash if so.
>
> I think I used lots of wrong terminology there.  What do I call these
> things?
>
> HEAD:path is a tree.

It is one way to name a tree object, yes (another obvious way is to
spell it out, e.g. 3610ac62).

> HEAD is a commit name.

It is one way to name the commit object, yes, but I am guessing that
you are interested in these in the context of resolving HEAD:path.
If that is the case, then "commit"-ness is not something you are
interested in---any tree-ish would do (e.g. v1.8.4, maint^{tree}).

> Maybe like this?
>
>   When a tree is given to grep, the full name of matched files
>   is assembled using colon as a separator.
>
>   If the tree name includes an object name, as in
>   HEAD:some/path, it should use a slash instead.

What problem are you trying to solve?  It should use HEAD:some/path,
not HEAD/some/path.
