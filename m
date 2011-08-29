From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf_grow(): maintain nul-termination even for new
 buffer
Date: Mon, 29 Aug 2011 16:09:14 -0700
Message-ID: <7vk49v4xyd.fsf@alter.siamese.dyndns.org>
References: <c8d8686c1813885a36d8f4cada218686989df236.1314651926.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Pierre Habouzit <madcoder@debian.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 30 01:09:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyAxH-0008A7-2Z
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 01:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab1H2XJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 19:09:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39728 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755259Ab1H2XJR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 19:09:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D53854E1;
	Mon, 29 Aug 2011 19:09:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=37OxJ+AgvbQTUkRn51857OvdTzI=; b=nFFBAI
	qTRgT/U8s2jNHqCCgglffZMNkp3aJaZme1Ins+NMNdMp31hAL6WBcjHYEf8DLWBP
	j8Ri9/Ezk4zSHb4LXG/ZwMPH2Vv5BMZD85tJbf4e6Mbo9pTOnY/M348mWtDVHE6C
	/l/d3I16isZzpCk6i/upxpfBAgl7RkMPpP6GY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jChNtAzwhZvDyG0tInHJNmWkxk3WtARt
	uozsE7nn09lvdDpIpWcoCgn743OcGT00si0L0W44/tbajwru6Wylzz8yM2du7P5s
	8aCmEKraHeVWTyiTYEPgi4iW0k4V9L9iInYSliuQiTFIjP6gpBE6zE0qAEoGVXF0
	tvXv16fHu9Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 061CB54E0;
	Mon, 29 Aug 2011 19:09:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F09454DF; Mon, 29 Aug 2011
 19:09:15 -0400 (EDT)
In-Reply-To: <c8d8686c1813885a36d8f4cada218686989df236.1314651926.git.trast@student.ethz.ch> (Thomas Rast's message of "Mon, 29 Aug 2011 23:16:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA6A3492-D293-11E0-83FD-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180374>

Thomas Rast <trast@student.ethz.ch> writes:

> So make sure that strbuf_grow() puts in a nul even if it has nowhere
> to copy it from.  This makes strbuf_grow(sb, 0) a semantic no-op as
> far as readers of the buffer are concerned.

Makes sense, thanks.

> Also remove the nul-termination added by strbuf_init, which is made
> redudant.

Ok.

This is a tangent but if we do not have hint, we point at strbuf_slopbuf[]
which is:

    /*
     * Used as the default ->buf value, so that people can always assume
     * buf is non NULL and ->buf is NUL terminated even for a freshly
     * initialized strbuf.
     */
    char strbuf_slopbuf[1];

While nobody should be writing into it, we do not really enforce the
constness of this buffer.

I wonder if it would be worth making this into "const char []" and have
the complier/linker move it to read-only section to catch potential bugs.
