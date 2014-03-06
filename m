From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] commit: fix patch hunk editing with "commit -p -m"
Date: Thu, 06 Mar 2014 13:47:54 -0800
Message-ID: <xmqqeh2fvw1h.fsf@gitster.dls.corp.google.com>
References: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
	<1394117424-29780-3-git-send-email-benoit.pierre@gmail.com>
	<xmqqr46fvx39.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 22:48:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLg95-0004V2-8e
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 22:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045AbaCFVr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 16:47:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38544 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbaCFVr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 16:47:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCC63723E9;
	Thu,  6 Mar 2014 16:47:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zKS7Qr+X9NH18JTAZnpouyBBLA4=; b=fz1bBl
	VexRVvXX8VQpA5tjvSmZMmHfdofvFQBvEfS8A1XuW0mu6I4gyOT2P+n/6twTs6IW
	SgUIo/VaK4VTOi0jEIuV7Y4gNaB+2k2xkTx8UUrw1FHAsDdpyWtluUfDub6s+tLN
	8LsmrztpIOxCqpPUIM9FPYY57o1qsEKKmONPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MalrUwPMx0yZz/uNV/+7kWjctkgZqDQ1
	mhgP4D2yTkMH8POZ3otepg32MCX/WTUu5l01Oq9XQj9iaw3D5GHyF7LmRcXWQ2F9
	Oj33w4yb0eNa8HU+t9eGjDf4csK8tNNZZAps/Bf2pp+i4oGBMkfOW4IxbuvS/O0H
	NCZpqBq5qFQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8D46723E6;
	Thu,  6 Mar 2014 16:47:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E8AC723E1;
	Thu,  6 Mar 2014 16:47:56 -0500 (EST)
In-Reply-To: <xmqqr46fvx39.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 06 Mar 2014 13:25:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FA4D12F2-A578-11E3-8167-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243561>

Junio C Hamano <gitster@pobox.com> writes:

> Name it run_hook_le() (name modelled after execle()), and call it in
> your change where you add new calls to this function, and add a thin
> wrapper run_hook() that preserves the traditional "We can pass only
> the index-file" for new callers we do not even know about on the
> topics in flight.
>
> Later we can eradicate callers of run_hook() that treats the index-file
> specially, which was a grave mistake in a public API.

I am also OK if the patch _removed_ run_hook() and renamed the one
with the current semantics to run_hook_with_custom_index() or
something.

It would allow us to catch any in-flight topic we do not know about
that adds a call to run_hook() expecting that it would take a custom
index file.  We will see a link failure, and then we can evil-merge
to update such a callsite to call run_hook_with_custom_index().

An updated run_hook() with different function signature (which is
in this patch) will also let us notice, but the evil-merge to fix
the resulting mess will have to be larger than necessary, which is
not what we want.

Thanks.
