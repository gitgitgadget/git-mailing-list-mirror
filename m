From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/1] refs.c: SSE4.2 optimizations for check_refname_component
Date: Mon, 09 Jun 2014 15:16:26 -0700
Message-ID: <xmqqfvjdenk5.fsf@gitster.dls.corp.google.com>
References: <1402012575-16546-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:16:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7rt-0006Bw-Qy
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbaFIWQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:16:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58376 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753838AbaFIWQh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:16:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA55E1DEF6;
	Mon,  9 Jun 2014 18:16:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/5nuYt9TTvGtPv97gyxozREjq4o=; b=fIIl0f
	quuEfbY+HqEO47qfLLVtDILA6xwZhbS/mhwBpM+Ay7B8ZDYEdW7Mz06++smlVmla
	/xrmoxBMaxki6U1clnAv/UMVZKroUwhkRrGimUIP4Luv37LrKznblNnzso/n7mhX
	TxIb3vetLCthDUqbmSZdyuH02qkcSpMc9soTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r23fcP4nfzdicTSSvAikzb7ATUyxYcOB
	vncxDj8J/wYSr9U4JgID6I1T9+530dXLnvZZOkxP1lNEgGePHLYykRFvLYvk/IcV
	F6TPRWVBLp3mWINkbVjbwBkGvt/meSJg1GzMuC4pNv5gcO3nMCkm/cRvMLpQuaH+
	X5h9muDO8XQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B02251DEF5;
	Mon,  9 Jun 2014 18:16:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BCBD71DEEA;
	Mon,  9 Jun 2014 18:16:27 -0400 (EDT)
In-Reply-To: <1402012575-16546-1-git-send-email-dturner@twitter.com> (David
	Turner's message of "Thu, 5 Jun 2014 19:56:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B38863EE-F023-11E3-960D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251107>

David Turner <dturner@twopensource.com> writes:

> Since Junio has picked up the first patch from previous versions of
> this series, I'm just going to send the second (SSE) one.  I decided
> not to s/NO_SSE42/!HAVE_SSE42/ because it looks like git mostly uses
> the former convention (for instance, that's what GIT_PARSE_WITH
> generates).

Yeah but NO_FROTZ is used only when FROTZ is something everybody is
expected to have (e.g. it's in posix, people ought to have it, but
we do support those who don't), isn't it?  For a very arch specific
stuff like sse42, I'd feel better to make it purely opt-in by
forcing people to explicitly say HAVE_SSE42 to enable it.
