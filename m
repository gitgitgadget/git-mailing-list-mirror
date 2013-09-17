From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] git checkout $commit -- somedir doesn't drop files
Date: Tue, 17 Sep 2013 13:40:17 -0700
Message-ID: <xmqq1u4nxjv2.fsf@gitster.dls.corp.google.com>
References: <20130917190659.GA15588@pengutronix.de>
	<xmqqeh8nxltc.fsf@gitster.dls.corp.google.com>
	<20130917201259.GB16860@sigill.intra.peff.net>
	<xmqq61tzxkgz.fsf@gitster.dls.corp.google.com>
	<20130917202917.GA20020@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 17 22:40:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM24Q-0002pv-Kr
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 22:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316Ab3IQUkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 16:40:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35258 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041Ab3IQUkV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 16:40:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7B9143ADE;
	Tue, 17 Sep 2013 20:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2k/yuM4LqUtTgKRA68Nj6dLIKGQ=; b=lGRT24
	0jjpOV+YVNSxlRnyahsPw+9DF/2Zg6DtnDRdtoIElJVQx4OYyJyKCI6R3KVIVTiH
	VjJFyWzw3XKD9zm8McvlJZ8peCWxcu9FYEcX5xwy5cSE6Whh5wrY5FWlQQ+W6zTf
	Is+2YV6biaS2uKVzYxuA0rCt7rrrv+6Z2MYLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oSy1Eo//LpNiFkf+nPgl0Ko+yXHyFjiL
	Yl1O6NwUYqcaQthggG9EIPX78aN9P/AxsFL83GoRHnu5mkKa7pF2sPxaEPf6p1QL
	tchRLxNQx61D5qZ9te2Nc9zmS9cJ94oCVN/wgP2aSFDlxS3BjTSYRKA00cev8M9i
	1R05d94srNM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA70643ADD;
	Tue, 17 Sep 2013 20:40:20 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F2B643ADC;
	Tue, 17 Sep 2013 20:40:20 +0000 (UTC)
In-Reply-To: <20130917202917.GA20020@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 17 Sep 2013 16:29:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5E47DF7E-1FD9-11E3-B79B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234924>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 17, 2013 at 01:27:08PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > On Tue, Sep 17, 2013 at 12:58:07PM -0700, Junio C Hamano wrote:
>> >
>> >> I could argue that the above intended behaviour is suboptimal and it
>> >> should have been "the resulting paths in the index and the work tree
>> >> that match the given pathspec must be identical to that of the
>> >> tree-ish".  In the resulting index or working tree, paths that match
>> >> "subdir" pathspec in the above result is subdir/a and subdir/b, and
>> >> that is different from what exists in the given tree-ish (which has
>> >> only subdir/a and not subdir/b), and under that modified definition,
>> >> what the current one does is not correct.
>> >
>> > Our emails just crossed, but I basically ended up saying a similar
>> > thing.  Could we simply replace the "update_some" in builtin/checkout.c
>> > with a two-way merge via unpack-trees?
>> 
>> Would it work to resolve a conflicted index by checking out from a
>> known tree?
>
> Hrm. Probably not. It is almost a one-way merge going to the named tree
> (but limited by the pathspec), except that I think the current
> git-checkout code may provide some safety checks related to where we are
> coming from (e.g., do we unconditionally overwrite entries that are not
> uptodate?).

I think we do unconditionally overwrite and that has been very much
on purpose.

"git checkout tree-ish -- file.txt" has always been about replacing
whatever cruft is in paths in the worktree that match pathspec, just
like "cat content-created-elsewhere >file.txt" is.  "Oops, you have
a local change that do not match index" is the last thing we want to
say, because getting rid of that local change is the primary reason
why "checkout tree-ish -- file.txt" exists.

Taking the state of a subdirectory as a whole as "content", the
change we are discussing will make it more like "rm -fr dir && tar
xf some-content dir" to replace the directory wholesale, which I
personally think is a good thing in the longer term.
