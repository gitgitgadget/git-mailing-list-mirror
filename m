From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] Verify index file before we opportunistically update it
Date: Thu, 10 Apr 2014 09:57:33 -0700
Message-ID: <xmqqob09xgua.fsf@gitster.dls.corp.google.com>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
	<1397108075-30891-1-git-send-email-yiannis.marangos@gmail.com>
	<CACsJy8D9dsxOA6xVmhxa7N20OxEQ1a63rQm6QCtwq9ThG6E3RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 18:58:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYIId-0001Yn-9E
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 18:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758787AbaDJQ5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 12:57:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758769AbaDJQ5h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 12:57:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C08DB79D21;
	Thu, 10 Apr 2014 12:57:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1xrqSUfS9zALPAgUvWWJJsdm3cI=; b=lJWb9z
	Pcll1AjShEFwLDSqyoTrLD/lXl9UYK1qOV2Cf0YtlOVW/oMUzHVMmTPyRnETFshE
	rLej/ImDkzuc0MiUpdXDy26TuOdFyZT7X7vey0n3qcIMTwzOeWf5kw0QlsKZqQtw
	RRiH2iTJJ70Qtv4K3y/nPYPXdkrdIYuxAbcBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TrNHEhzQuHDQlrSiJ9lwx/ttpRRzsd6d
	J168uH0O9bMdzvz89P3diWnx15QUVEcuJ1s35GXRAlmzfCkhJGpZix6ivkS0AiZk
	a/c677RZSfP4p1YAhl/FxqgyCFVCYXld/D1q0zKRs06+o4jI2kDFwcMy4j3F9YlQ
	kyXEvcHgqmg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB51E79D20;
	Thu, 10 Apr 2014 12:57:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F19B79D1F;
	Thu, 10 Apr 2014 12:57:35 -0400 (EDT)
In-Reply-To: <CACsJy8D9dsxOA6xVmhxa7N20OxEQ1a63rQm6QCtwq9ThG6E3RA@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 10 Apr 2014 17:40:55 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3713CC6C-C0D1-11E3-A1B4-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246018>

Duy Nguyen <pclouds@gmail.com> writes:

> verify_hdr() is a bit expensive because you need to digest the whole
> index file (could big as big as 14MB on webkit). Could we get away
> without it? I mean, is it enough that we pick the last 20 bytes and
> compare it with istate->sha1? If we only need 20 bytes, pread() may be
> better than mmap().

True.

I do not think we offer xread() equivalent for pread() to help
coders to avoid the common mistake of failing to resume interrupted
system calls, though.

The only callsite of pread() we currently have is in index-pack.c,
which just does

		n = pread(pack_fd, inbuf, n, from);
		if (n < 0)
			die_errno(_("cannot pread pack file"));

without paying attention to EAGAIN/EINTR, that seems wrong and may
want to be fixed, before we introduce another call site of pread().

Thanks.
