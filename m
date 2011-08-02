From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: write out cache-tree information
Date: Tue, 02 Aug 2011 14:15:36 -0700
Message-ID: <7vfwljecqv.fsf@alter.siamese.dyndns.org>
References: <9f5e031045b55c4738de8bc9aae290827e128cd3.1312302862.git.trast@student.ethz.ch> <7vmxfrel63.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 02 23:15:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoMJV-00014k-3J
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 23:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401Ab1HBVPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 17:15:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60877 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755395Ab1HBVPj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 17:15:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FEC1463E;
	Tue,  2 Aug 2011 17:15:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M44nSI7WmcD/6gQpHxGcd0oWpvs=; b=cmIEUy
	cAQZxeuwEM0vhjAy//P6syLiJA4l6LO+sN+6q9KUCLBPoRshnR2QqSETFcacgseK
	27M6UQp+i7pyGV62YDqMG410VrUssAC2C1Gb7Q0uIWSB9yh12tbO49Upplnb85z5
	olYqBN3RZthafwUWl923QUwAzfdZWWXujCEh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B3gsEyguj8D6Q1VsS1FbcqtKH1UU7HMT
	oBuFhz+89U4DAxGEG6nfjnFQwCJHvvWYHodH2Ab6fthOT9rBK+7WHqhUF6SNXh41
	y3z/OHzwAyGrVckXX/GPWF61U6BGaYeGrij5wAVsUg/9dE3xs2mYuX9h2bTDpCjt
	JpuSbQCjkmA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26C19463D;
	Tue,  2 Aug 2011 17:15:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF48F463C; Tue,  2 Aug 2011
 17:15:37 -0400 (EDT)
In-Reply-To: <7vmxfrel63.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 02 Aug 2011 11:13:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 917EDC18-BD4C-11E0-A205-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178509>

Junio C Hamano <gitster@pobox.com> writes:

>> While write-tree has code to write out the cache-tree information
>> (since we have to compute it anyway if the cache is stale), commit
>> lost this capability when it became a builtin and moved away from
>> using write-tree.
>
> Earlier the code read from the index, made sure that it is not unmerged by
> running cache_tere_update(), before running prepare-commit-msg hook. The
> hook used to see the index that was read in this codepath which is the
> same as what pre-commit left us.
>
> Why run an extra I/O here? The index file could be quite large, and I do
> not want people to writing it out without good reason.

One possible good reason is if you did this only when we are committing
the whole index. Then theoretically the next operation after commit could
start from a fully populated cache-tree in the index.

When we are running a partial commit, the index file you are writing back
is a temporary index only to build a tree object to record in the commit,
which we already have done, and the temporary will be discarded.
