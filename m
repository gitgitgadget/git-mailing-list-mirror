From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/5] git log -L, all new and shiny
Date: Tue, 19 Jun 2012 03:33:18 -0700
Message-ID: <7vpq8v1tht.fsf@alter.siamese.dyndns.org>
References: <cover.1339063659.git.trast@student.ethz.ch>
 <7vlijpchm2.fsf@alter.siamese.dyndns.org> <8762as4sax.fsf@thomas.inf.ethz.ch>
 <7v1ulgd2f5.fsf@alter.siamese.dyndns.org>
 <7v1ulf94nq.fsf@alter.siamese.dyndns.org> <87wr33wqzl.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	Bo Yang <struggleyb.nku@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 19 12:33:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgvkT-0001n4-LC
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 12:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281Ab2FSKdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 06:33:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56543 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056Ab2FSKdU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 06:33:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E0307CB6;
	Tue, 19 Jun 2012 06:33:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=le0un1McJGkPG6B81nSFzIMjSJg=; b=SFhGpS
	KS5g6HRA4Y97mlYIKS4EgjpFHy/7XGCdC4bMVAWqOQtKQmMzgFQzcD26Y9Sua8x0
	ysQX+5cJjQsJVgoCs0CynvjfRrCko+4wAs7KdsBqXq74DEuMyOW3o3nD54ZyxHk5
	OuPzM8E36L6QjoGCFnkzc4X1IZ21JdNNGkvvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DRU03E1/mffsCZZO+GD/TXPgqjtJytL2
	1NS3KwFAyrBi13Q9lm2hns5HRMHSo4s9W+s6+kpdDhizNrwxaauqvEYf2DV5Koa7
	8ygvxDWvGfuHTQ+WUsGbNzBD27VOqxYjw1LojJgQy/YqqL7sd8jcazUQMIOI31r2
	Y/xTrwnMxuo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44CB87CB5;
	Tue, 19 Jun 2012 06:33:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D20CB7CB4; Tue, 19 Jun 2012
 06:33:19 -0400 (EDT)
In-Reply-To: <87wr33wqzl.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 19 Jun 2012 12:11:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3027FDB8-B9FA-11E1-938C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200194>

Thomas Rast <trast@inf.ethz.ch> writes:

>> Then the revision machinery looks at B.  It does the same between B
>> and A, but this time around, the diff machinery finds that, even
>> though A and B were _not_ TREESAME at the revision traversal level,
>> there is nothing to be shown after filtering with the -w option.
>> Hence no patch is shown and log message for B is not shown, either.
>
> Thanks for the great explanations.
>
> Having spent some time letting this sink in (and being busy doing other
> things), I think it's actually a good idea.  It forces us to go back and
> change it around so that the diff machinery gets a say _before_ we
> simplify history.  I think this bit will be important for log -L history
> to make sense, and it's a bug waiting to happen for the -w case.

Note that this is not limited to "diff_patch() already filters -w".

If you are running with --diff-filter=A to grab only the additions,
for example, you may want the merge simplification to know about
this filtering as well.

So it is likely that you would want to hook diffcore_std(), not just
diff_flush(), to the TREESAME machinery.  Obviously you would want
to do this only for the merge commits; there is no point doing this
for single strand of pearls where the output phase already knows how
to squelch output correctly.
