From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible timestamp problems with diff-files?
Date: Wed, 21 Sep 2011 14:33:02 -0700
Message-ID: <7vboud1sz5.fsf@alter.siamese.dyndns.org>
References: <4E786B5D.40601@syntevo.com>
 <20110920175458.GA3776@sigill.intra.peff.net> <4E79DF81.8090605@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 23:33:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6UPn-0007pT-Vk
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 23:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161Ab1IUVdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 17:33:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48727 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777Ab1IUVdF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 17:33:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 111B4572C;
	Wed, 21 Sep 2011 17:33:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=057H08+owJ1JyEOFg6pEO1zxZVs=; b=s3GzTF
	PCGA+AKs0mzM+e4EmjXZHctcNd9Y9K8UYDPMIoEEjf9po6l7Gdw/BcZYY3XnrwmH
	F5Uby+wLc6QtHJQUIWxoF0zfvRbhcT/djY1B7IEwuE+TtIdNZhAOUX3Rjag6UtrH
	1Lm9nQ/3fAqUVusGqI1pN1Ns1YIOXW/1s/Lrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ybx/aFEwJisrat1MSZwRFTLEMGHKKF6g
	q0/e1Wtnx4yBlmr/hADYjbcLBFOde0qO0PeLilu7mlvkRPOpNqQsX/KPEmd207lg
	La4zntgwYwPaazHcKN64bIly/k/U7avlJQtETCN6FZ8MfMK5Tg58ey075Auwp5IK
	3vYlapVy8Z0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07593572B;
	Wed, 21 Sep 2011 17:33:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DDDE572A; Wed, 21 Sep 2011
 17:33:03 -0400 (EDT)
In-Reply-To: <4E79DF81.8090605@syntevo.com> (Marc Strapetz's message of "Wed,
 21 Sep 2011 14:58:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4988C166-E499-11E0-80DA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181864>

Marc Strapetz <marc.strapetz@syntevo.com> writes:

> On 20.09.2011 19:54, Jeff King wrote:
>> On Tue, Sep 20, 2011 at 12:30:53PM +0200, Marc Strapetz wrote:
>> 
>>> For our Git client, we are invoking
>>>
>>> git diff-files--quiet --ignore-submodules
>>>
>>> immediately after a commit of *all* changes. Hence, the expected exit
>>> code would be 0 (because there are no changes). A user has now reported
>>> that for commits with many changes, exit code is sometimes 1. For the
>>> last incident, the commit was started at 15:24:11,820 and finished at
>>> 15:24:12,329, diff-files was invoked at 15:24:12,455 and failed with
>>> exit code 1 at 15:24:21,394. A subsequent diff-files succeeded, so I'm
>>> wondering now, if that could be a timestamp problem (maybe related to
>>> the Index)?

What peff said already.

If you do not refresh the cached stat information, diff-files may report
"they differ" for a path that is otherwise unchanged without looking at
the contents of such a path to notice that the only difference is the
cached stat information (the whole and only point of having the cached
stat information is to avoid looking at the contents). Also, it may look
at the contents of such a path if it has a reason to suspect that the file
might have changed if it cannot tell from the cached stat information
(look for "racy-git" if you are really interested).

Update the cached stat information before you use plumbing commands in
your script.
