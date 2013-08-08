From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] During a shallow fetch, prevent sending over unneeded objects
Date: Wed, 07 Aug 2013 23:51:02 -0700
Message-ID: <7vfvukbrqh.fsf@alter.siamese.dyndns.org>
References: <20130711220127.GK10217@login.drsnuggles.stderr.nl>
	<CACsJy8CP6pGRwEn6H=cbKxTMuOjzAF3=Qh8qsLbJaw6feK3NMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthijs Kooijman <matthijs@stdin.nl>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 08:51:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7K48-0007Hk-8K
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 08:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141Ab3HHGvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 02:51:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50758 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755915Ab3HHGvP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 02:51:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 769D732D9B;
	Thu,  8 Aug 2013 06:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gmGNhooo3LsNLVQR2gw40WG3USM=; b=Yth8dN
	W7wfbSDt0/yvNsnyzw4YEOVnNxd/dDSJtNnPso2WsenWpWyGmVVL/NfX9B1Ibb36
	uhxZ/dHJzbkFeWinV6IWPpgQ6XiJKq5mg5oP71X7FJG613EpE3PnY9jUX5MdBEV1
	ywarUAtmtFDKsJpbYZeH2OeahQaHUwljFlqnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i1UXlldFIieTuFLSEMAbpQlBwzapBz8Q
	zzKQFg3spj/22MxMxmhEs48FEBoN5sXnVFIfgoIh76c5/9hPlL1QWrBrFtonz1Uu
	5EABoO+5ef+w+CJxL/s5r8ZyLsC1WXkgNznhtOiB3L1dWmFoH+HKRoOZu5mvV5dB
	1vOCxxlVg5U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FBB232D9A;
	Thu,  8 Aug 2013 06:51:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8854D32D97;
	Thu,  8 Aug 2013 06:51:13 +0000 (UTC)
In-Reply-To: <CACsJy8CP6pGRwEn6H=cbKxTMuOjzAF3=Qh8qsLbJaw6feK3NMw@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 8 Aug 2013 11:50:55 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA7DC542-FFF6-11E2-9289-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231866>

Duy Nguyen <pclouds@gmail.com> writes:

> I think this applies to general case as well, not just shallow.
> Imagine I have a disconnected commit that points to the latest tree
> (i.e. it contains most of latest changes). Because it's disconnected,
> it'll be ignored by the server side. But if the servide side does
> mark_tree_interesting on this commit, a bunch of blobs might be
> excluded from sending.

I think you meant mark_tree_UNinteresting.

> ... So perhaps we could go over have_obj list
> again, if it's not processed and is
>
>  - a tree-ish, mark_tree_uninteresting
>  - a blob, just mark unintesting
>
> and this does regardless of shallow state or edges.

As a general idea, I agree it may be worth trying out to see if your
concern that the "have" list may be so big that this approach may be
more costly than it is worth.

If the recipient is known to have something, we do not have to send
it.

The things that we decide not to send are not necessarily what the
recipient has, which introduces a twist you need to watch out for if
we want to go that route.

If the recipient is known to have something, a thin transfer can
send a delta against it.  You do not want to send the commits before
the shallow boundary (i.e. the parents of the commits listed in
.git/shallow) because the recipient does not want them, and that
means you may have to use a different mark to record that fact.  The
recipient does not have them, we do not want to send them, and they
cannot be used as a delta base for what we do send.  Which is quite
different from the ordinary "uninteresting" objects, those we decide
not to send because the recipient has them.
