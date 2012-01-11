From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] diff-index: pass pathspec down to unpack-trees
 machinery
Date: Wed, 11 Jan 2012 00:05:12 -0800
Message-ID: <7vvcoi7jgn.fsf@alter.siamese.dyndns.org>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org>
 <1314653603-7533-1-git-send-email-gitster@pobox.com>
 <1314653603-7533-4-git-send-email-gitster@pobox.com>
 <20120111063104.GA3153@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 09:05:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RktBU-0000et-Bd
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 09:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756648Ab2AKIFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 03:05:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755393Ab2AKIFP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 03:05:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AD64592C;
	Wed, 11 Jan 2012 03:05:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LiYboDQ5b8WjsOJdGRvWvRRzPWA=; b=SzUnlH
	57b2g1ulv4CM4HDcgW4iaiTo8IsAByH+8hhpqVlXAJPkycwIGhkcIuQ1Hk07KxP3
	s3LtD5Ml3QY9T0+HIgYvzQezXLTg19ZKx1nxx3FaiV5p2y43/09aXe36AOO9CH6i
	p964ibGpAl65OWsFi+EIQR5+Um7k4Zi6DAGKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cf0T/MWF7hVXk1B01ujhHt9/sv9LzqG6
	8Xrdys4uzO0G49MBiZ8CnVISm5XvWOJsV4wG38nYUC7z8lbGSE3E3K9Aap+4u00q
	XB40J1oMdqcV4jPPGag2ZKL/cufkQBW9GwGmc7wl3Jaf/qkYJZcbPCfEftwW0yJL
	NBRPIJKtuEQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82B62592B;
	Wed, 11 Jan 2012 03:05:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07F70592A; Wed, 11 Jan 2012
 03:05:13 -0500 (EST)
In-Reply-To: <20120111063104.GA3153@burratino> (Jonathan Nieder's message of
 "Wed, 11 Jan 2012 00:31:04 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FDB23BA2-3C2A-11E1-99F4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188339>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> And finally, pass the pathspec down through unpack_trees() to traverse_trees()
>> callchain.
>
> In git versions which include the patch described above, the unchanged
> subdir/hello.h shows up as a newly added file.  Reverting that patch
> (v1.7.7.1~22^2, diff-index: pass pathspec down to unpack-trees
> machinery, 2011-08-29) makes "git diff HEAD" with wildcards work
> again.

I suspect that the particular change on the side branch predates Nguyen's
effort to unify the pathspec semantics to teach the wildcard (i.e. not the
traditional "prefix match") to the tree traversal code, but it is fairly
late here, so I didn't check.

I think the right fix is to update the logic that still assumes that a
pathspec used for tree traversal is always prefix match when leaving the
traversal early, and instead use the proper matching logic that knows that
a wildcard pathspec needs to dig deeper into the tree regardless (I think
the pathspec implementation used in "git grep" got this right, but please
double check), so that we do not dig unnecessary subtrees when pathspecs
are all prefixes, but still keep digging when there is a wildcard match.

I suspect that it would lead to a fairly complete unification of the three
implementations of pathspec matching logic and would allow us to also do
something like "git log -- '*.h'" for free.
