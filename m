From: Junio C Hamano <gitster@pobox.com>
Subject: Re: speed of git reset -- file
Date: Tue, 31 May 2011 16:39:25 -0700
Message-ID: <7v62oqignm.fsf@alter.siamese.dyndns.org>
References: <20110531190015.GA12113@gnu.kitenet.net>
 <20110531212639.GA13234@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 01:39:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRYXE-0004BK-8d
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 01:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932940Ab1EaXjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 19:39:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36434 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932922Ab1EaXje (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 19:39:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E36A7546E;
	Tue, 31 May 2011 19:41:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X2Onh625Qu7aGc0m1+z6Q4hwIYE=; b=PezF/y
	/YAvZoZLqpiSkscZ/qKIlzRMAkzE17VxQCYcwXFvCaH5e6PsYrV763vOvJ2eKwVt
	HBAyLI0LOgxBJOMPui50/4/DxeViwcuTWwxbeWwRpThUSXx/F1LzhMMa2xX2nMCT
	XpFrcdzfRWqst5TfN80U2TycGD6v5cok/P2+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ffaPGY0ECYuq+Iex/FBTIt9Z+aIGwWpr
	0NFEnV2k2d4BYQ+a7Pm1j1eZqicZ79AWqj52kKBh4QvRB4geXp6ePm5K39sxzBNA
	rFXkz4No+4hIsj6ECao0OyWGmydJrB2Hzo+8AMfmVL6/f5KQYgdA8MBIUxiX2qpC
	gFmeBPcDYtU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B06F9545C;
	Tue, 31 May 2011 19:41:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 921B75457; Tue, 31 May 2011
 19:41:35 -0400 (EDT)
In-Reply-To: <20110531212639.GA13234@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 31 May 2011 17:26:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87F86DF6-8BDF-11E0-8CC4-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174839>

Jeff King <peff@peff.net> writes:

> ... Unfortunately this seems to trash the index (see the
> comment there), and we end up having to refresh it.

I think you are reading it wrong. Yes, diff-index will contaminate the
in-core index when it tries to find out which paths are to be reset, the
"discard" refers to the fact that it would be useless to add_cache_entry()
or remove_file_from_cache() to the in-core index without reading the in-core
index afresh.

So we restart from a freshly read index (see read_cache() at the beginning
of update_index_from_diff() callback) with all the stat information just
as fresh as you used to have before you ran this "git reset", and then we
update the paths that the internal diff-index found in the in-core index.

"git reset" has always refreshed the index. If somebody _really_ wants to
introduce a slight inconsistency to "git reset" so that only in "per-path"
mode it doesn't refresh, the call to refresh_index() can easily be removed
from update_index_refresh(). There is no "we end up having to".

IOW, we refresh by choice, design and inertia ;-).
