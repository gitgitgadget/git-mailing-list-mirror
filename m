From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: fix ls-tree usage with dash-prefixed paths
Date: Mon, 30 Mar 2009 11:05:53 -0700
Message-ID: <7vy6umdgxq.fsf@gitster.siamese.dyndns.org>
References: <22719363.post@talk.nabble.com>
 <20090326130213.GC3114@atjola.homenet>
 <83dfc36c0903260735q3231ce96h5949d1123858995f@mail.gmail.com>
 <83dfc36c0903270418q59a81290xcb8043b8c037be18@mail.gmail.com>
 <20090329060858.GB15773@dcvr.yhbt.net> <20090329061045.GA29721@dcvr.yhbt.net>
 <7v8wmoqdc1.fsf@gitster.siamese.dyndns.org>
 <20090329215651.GA4355@dcvr.yhbt.net>
 <7v3acvldc7.fsf@gitster.siamese.dyndns.org>
 <20090330174151.GA32728@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Anton Gyllenberg <anton@iki.fi>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Mar 30 20:08:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoLtb-0004In-PC
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 20:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbZC3SGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 14:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbZC3SGE
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 14:06:04 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58392 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686AbZC3SGD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 14:06:03 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CFB57AFBC;
	Mon, 30 Mar 2009 14:05:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 24C80AFBB; Mon,
 30 Mar 2009 14:05:55 -0400 (EDT)
In-Reply-To: <20090330174151.GA32728@dcvr.yhbt.net> (Eric Wong's message of
 "Mon, 30 Mar 2009 10:41:51 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6BF6136A-1D55-11DE-8A0A-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115182>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> I think that is an independent bug.  Not just "--" but it appears "--d"
>> seems to hit it (and this is an ancient bug---even v1.0.0 seems to have
>> it).
>
>> I suspect that ls-tree needs a fix, not about "--" but about the pathspec
>> filtering.  It appears that the part that decides if a subtree is worth
>> traversing into uses the correct "is a pathspec pattern match leading path
>> components?" semantics (i.e. "--dashed" matches but "--" doesn't), but
>> after traversing into subtrees, the part that emits the output uses a
>> broken semantics "does the path have any pathspec patter as its prefix?"
>> It shouldn't check for "prefix", but for "leading path components", in
>> other words, the match must happen at directory boundaries.
>> 
>> And I do not think *this* bug is too late to fix.  We should fix it.
>
> From the ls-tree documentation, I was under the impression that "--"
> matching "--dashed" was intended:
>
>   When paths are given, show them (note that this isn't really raw
>   pathnames, but rather a list of patterns to match).
>
> It doesn't make sense to me match like this, either; but I do think it
> was intended and it will break things if people depend on the
> existing behavior.

Ok, but then the decision to descend into --dashed should be consistent
with that policy, no?  Right now, it appears that giving "--" alone says
"Anything under --dashed can never match that pattern, so I wouldn't
bother recursing into it".
