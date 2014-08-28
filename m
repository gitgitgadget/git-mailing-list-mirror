From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] fsck: check tag objects' headers
Date: Thu, 28 Aug 2014 14:36:22 -0700
Message-ID: <xmqqegw08fft.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1408281646530.990@s15462909.onlinehome-server.info>
	<xmqqlhq88fyb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 28 23:36:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN7N1-0003RQ-FX
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 23:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbaH1Vgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 17:36:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54614 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbaH1Vgf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 17:36:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 716BD356C9;
	Thu, 28 Aug 2014 17:36:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z1Xa/ElfaBG4CZApMvn0d9CAiJ8=; b=enN0TX
	CaNx4QwqtolO1EwSVjkpxYAN8pOwe6GYAjFkO2Mb/75sfqBQpjE9bPWeyw0dFfxJ
	2RICed2hDwj3ulmcp6z4EPP9MRWjizaaY8UoI4gJLdLqvQgZADQd6t5Tj87MGI5a
	v7PFo64yaweIOg7U42IMcf+alOBpBIuYWuO34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KERIwFRbWAGSMnmNO8NPv3Qj3C8h2u4a
	aSPSZOOaVTfb++vTTg79fX8bcw2EpY8y878JBzoYFXQsebFdgSbp/3CGG+ViGYtD
	QIEZlj4/m9yec6YjUqGzPz4aYi/wSVsavzTqYFAaZ48J+Fj+W5vzpZ29PFT99BzK
	jYw/GmSRxrU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 65468356C8;
	Thu, 28 Aug 2014 17:36:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 67336356BC;
	Thu, 28 Aug 2014 17:36:24 -0400 (EDT)
In-Reply-To: <xmqqlhq88fyb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 28 Aug 2014 14:25:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5C1247B2-2EFB-11E4-A75B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256126>

Junio C Hamano <gitster@pobox.com> writes:

>> +	if (check_refname_format(buffer, REFNAME_ALLOW_ONELEVEL))
>> +		ret = error_func(&tag->object, FSCK_ERROR, "invalid 'tag' name: %s", buffer);
>> +	*eol = '\n';
>
> I actually think this check is harmful.

Let me take this one back; we do a moral equivalent when we create a
tag, like this:

	strbuf_addf(sb, "refs/tags/%s", name);
        return check_refname_format(sb->buf, 0);

So validating using check_refname_format() is indeed a very good
thing to do.

As you have length and buffer here, I would suggest updating this
part of your patch to print into a strbuf

	strbuf_addf(&sb, "refs/tags/%.*s", (eol - buffer), buffer);
       	if (check_refname_format(sb.buf))
        	ret = ...

and keep the constness of the incoming data.

	
