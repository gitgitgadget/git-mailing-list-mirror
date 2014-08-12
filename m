From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read-cache.c: Ensure unmerged entries are removed
Date: Tue, 12 Aug 2014 11:39:25 -0700
Message-ID: <xmqq8umt5z8i.fsf@gitster.dls.corp.google.com>
References: <1407857491-16633-1-git-send-email-jsorianopastor@gmail.com>
	<1407857491-16633-2-git-send-email-jsorianopastor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jaime Soriano Pastor <jsorianopastor@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 20:39:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHGyz-000840-2Y
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 20:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938AbaHLSjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 14:39:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54599 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753574AbaHLSjg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 14:39:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1A59D30D3F;
	Tue, 12 Aug 2014 14:39:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OmgW4IoZJv4yjjjudxJXXK3EXf8=; b=WJMgHC
	x8bg93wsqtotcMMvZFfiyHgnSRgHeT4go6ZSngwxXRYxzuZjCYMUyfl2EQH8HLj+
	WXS4zeLTKgWygDxnJb1E86Zb0JGz0b/4JIfgc0HLp+EYi3RkRBAqQ1GAp9qrbQjA
	aVGOLRR2Pvsx0c+vkg1X+DMSXnNCvak8eQWX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mTwxA98NGj63hu9VdDfdA6IcfmU0Pesj
	KzaOC86KR1xMuIyco+IbIHDTVvNU1JMzUrxkwWU24gHFVNKl2LzqvfgymvV6/dIK
	UYau/dTfjHCjhQvjNL2Es+zCUtw1xmTP8oZrwt4oZ/KkX5eECmf5Sv0WskGICqOo
	5yOXRE8dG4M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 10BF630D3E;
	Tue, 12 Aug 2014 14:39:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 67DA130D30;
	Tue, 12 Aug 2014 14:39:28 -0400 (EDT)
In-Reply-To: <1407857491-16633-2-git-send-email-jsorianopastor@gmail.com>
	(Jaime Soriano Pastor's message of "Tue, 12 Aug 2014 17:31:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FDD5A098-224F-11E4-AB9D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255160>

Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:

> Wrong implementations of tools that modify the index can left
> some files as merged and unmerged at the same time. Avoid undesiderable
> behaviours by handling this situation.

It is understandable that the way _you_ decided to "handle the
situation" is so obvious to be spelled out to _you_, but that is the
most important design decision that needs to be described here.  Do
you silently remove higher-stage entries when an entry at stage 0
exists?  Do you silently remove stage 0 entry when higher-stage
entries exist?  Do you error out without doing neither?

Silently removing these at runtime may not be something we would
want to do; after all, we do not know if the broken tool actually
wanted to have the higher stage entries, or the merged entry.

Ideally, I think we should error out and let the users figure out
how to proceed (we may of course need to make sure they have the
necessary tools to do so, e.g. "git cat-file blob 0:$path" to
resurrect the contents and "git update-index --cacheinfo" to stuff
the contents into the stages).

Thanks.
