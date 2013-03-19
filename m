From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] index-pack: guard nr_resolved_deltas reads by lock
Date: Tue, 19 Mar 2013 08:53:30 -0700
Message-ID: <7vsj3rjshx.fsf@alter.siamese.dyndns.org>
References: <CACsJy8C0AYvAEm6fJFv+JLWpg3HuFG0erKXnq3NxpkYAy=qb_w@mail.gmail.com>
 <8ddf4db38f33034b5ebf504a18948bccf841ab72.1363702423.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	<git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Stefan Zager <szager@google.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 19 16:54:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHyrR-0008Ra-2u
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 16:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682Ab3CSPxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 11:53:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42176 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932489Ab3CSPxc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 11:53:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A30CB105;
	Tue, 19 Mar 2013 11:53:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZDLGCpi0owLJISMedHzhQ/sNgKM=; b=leX9Xl
	dKP/9Y1UI9aaBkbuJbGESrmDST1xGYXKTI+nDw63HADrWgjxoQU6Y7lqfTQL8XKy
	SjSn+kTgXW/qWxs34QultAOnlXmecXqeJDO9SLBDndNvd3nKHgFF8ct22HIciZva
	Y7SRDVe+S0v4YjiSOUtTsZmS0vw0O/Nh2D+W4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ycZQh8d64xIJA6Oq005A6eCUqa3j4fyN
	mtodWyDbeankswslJ0xz3qsCaR6tISUcLrvhIPU9tXaExo189KEh/ktHHOaocE/z
	C4/V7MKQK6MNvLggepHMb17NmmhBzIDSkkz+W12rlgmAtKcr0exGleqJ/aQuY1Cn
	c4ZYy8SXrck=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E505B102;
	Tue, 19 Mar 2013 11:53:32 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A78E2B100; Tue, 19 Mar 2013
 11:53:31 -0400 (EDT)
In-Reply-To: <8ddf4db38f33034b5ebf504a18948bccf841ab72.1363702423.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue, 19 Mar 2013 15:16:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 261163C0-90AD-11E2-A243-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218530>

Thomas Rast <trast@student.ethz.ch> writes:

> The threaded parts of index-pack increment the number of resolved
> deltas in nr_resolved_deltas guarded by counter_mutex.  However, the
> per-thread outer loop accessed nr_resolved_deltas without any locks.
>
> This is not wrong as such, since it doesn't matter all that much
> whether we get an outdated value.  However, unless someone proves that
> this one lock makes all the performance difference, it would be much
> cleaner to guard _all_ accesses to the variable with the lock.
>
> The only such use is display_progress() in the threaded section (all
> others are in the conclude_pack() callchain outside the threaded
> part).  To make it obvious that it cannot deadlock, move it out of
> work_mutex.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
>> The only thing I don't
>> like here is the double locking (work_lock then counter_lock) is an
>> invitation for potential deadlocks (not now, but who now what can
>> change later). I think you could move work_lock(); down after
>> counter_unlock() so we hold one lock at a time.
>
> Good point.

Thanks guys for fixing my mess with these two patches.
