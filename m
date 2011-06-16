From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rewrite history
Date: Thu, 16 Jun 2011 12:43:00 -0700
Message-ID: <7vhb7ph8aj.fsf@alter.siamese.dyndns.org>
References: <362053118.20110616231758@gmail.com>
 <20110616192644.GB13466@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 16 21:43:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXIT8-0001JJ-TP
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 21:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758083Ab1FPTnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 15:43:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61802 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757970Ab1FPTnD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 15:43:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 023D067CE;
	Thu, 16 Jun 2011 15:45:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=14AMWmmwIpwjwMS33YzYJqtLLMM=; b=qA9H6c
	TzOYt82esK8J6YVbz8vQibjLuFMTN59bftQ7ynLwtq/7tCUBtYMmrvgIi1rP0VC7
	xt1hmOWEA/1M2rbH4i7ZdHlvPAVS85fiPb0PTEB2PMmM0r2+YLv4bQbxPxjysZYM
	ZFtMQKi2N7hxOyCUE0350lCkBlMYrsdvj9Zpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q4eaqUALKFGV+qduXQCLp2sTjY1lU8xx
	FBNUQMxNC6FP0uFN1jDz/OAsztAvkLw263F/DYobB6d/spbceQLzVx+YcSvnM8xE
	JiN4ZyGQWwNGt9+UNXXp73JnD3Wl5n+Oz3K5N2K73K4VX8dyL1ZN5YzgMAZdUhMV
	EUqOwNZPV50=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EEED067CD;
	Thu, 16 Jun 2011 15:45:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2E74767CC; Thu, 16 Jun 2011
 15:45:12 -0400 (EDT)
In-Reply-To: <20110616192644.GB13466@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 16 Jun 2011 15:26:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2636592E-9851-11E0-A279-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175921>

Jeff King <peff@peff.net> writes:

> On Thu, Jun 16, 2011 at 11:17:58PM +0400, Ilya Basin wrote:
>
>> Hi list. There were 2 branches. One's HEAD was modified to match a
>> specific commit at another branch. Now, how to merge them according to
>> this scheme?
>> 
>> A---B---X---E---F
>>                      =>  C---D---X---E---F
>> C---D---X'
>> 
>> X and X' have no difference. I tried to write a script to cherry-pick
>> E and F, but some of commits are merges and cherry-pick fails.
>
> I think you just want to rebase using the "-p" option to preserve
> merges. Something like:
>
>   $ git checkout -b rebased-branch F
>   $ git rebase -p --onto D B
>
> that will pick X, E, and F, and replay them on top of D, resulting in
> the graph you showed above.

Eh, careful. Nobody said the change between B and X is any similar to the
change between D and X'. Replaying the changes E and F introduce on top of
X' to arrive at C--D--X'-E--F is the best you could do, i.e.

>   $ git rebase -p --onto X' X
>
> if you wanted to keep X' instead of X.

is more like "even if you wanted to keep X instead of X'".

If you prefer commit message of X over X', you can rebase -i it after you
are done the first round to get rid of A and B, though.

But wouldn't filter-branch a better tool for this?  Graft to pretend that
the parent of X is D instead of B, and filter the branch with F at its
tip, that is.
