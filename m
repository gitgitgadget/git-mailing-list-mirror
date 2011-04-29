From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: Improve parsing for emails with spaces
Date: Fri, 29 Apr 2011 11:09:19 -0700
Message-ID: <7vr58lvsj4.fsf@alter.siamese.dyndns.org>
References: <1303423656-32002-1-git-send-email-jistone@redhat.com>
 <20110429131103.GB4540@sigill.intra.peff.net>
 <7vvcxxvsz4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Josh Stone <jistone@redhat.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 20:09:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFs8T-0003DI-1N
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 20:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760752Ab1D2SJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 14:09:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61197 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760577Ab1D2SJb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 14:09:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6A8A75CC0;
	Fri, 29 Apr 2011 14:11:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jY/pHbOsfSzgbVQRYb8XsMpm9tQ=; b=qZTE4k
	pDIO+Vw3DpufokLgwLSGjI2UTP/CJekPdrHKbHg67WU9wQFkqCvdrqQBM7V8hYO8
	zRD7mtIjEpIpq3Z7rYV9nBOu6HVcJsmRsz274PXEEMom6U06sG+ShsrDf9ZHF4Ht
	7LqZBwn890rMIE9FuHtUvTdlD+5lNBoh0XG7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dd6BkvaJGAfYhT29bVMytcyum3XLw3W4
	itv8NOysMSFecoJu+RjBjAg7SkyQCv0oTVjbI8xGTyTnY4GXeXRu9YshuwHqPdt7
	WEjXW8mzptrKOQmSB+0jIEs/oLyp2Q/EY0Vn2/JJV4N3CNWd5FC5+7UK8cxPd5FI
	zm84a8T2L+k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 393EC5CBF;
	Fri, 29 Apr 2011 14:11:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 06C225CBE; Fri, 29 Apr 2011
 14:11:23 -0400 (EDT)
In-Reply-To: <7vvcxxvsz4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 29 Apr 2011 10:59:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A313E40-728C-11E0-A37E-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172485>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Thu, Apr 21, 2011 at 03:07:36PM -0700, Josh Stone wrote:
>>
>>> One of my git repositories has some old commits where the authors
>>> obfuscated their email address as <author at example dot com>.  To
>>> handle this, blame needs to look for the leading '<' when scanning
>>> to split the "name <email>", rather then only a space delimiter.
>
> Given that we enclose the e-mail inside "<>" pair and excise "<" from
> author names in fmt_ident(), I think it makes sense to look for " <" like
> this patch does.

Will queue.  Thanks.

Author: Josh Stone <jistone@redhat.com>
Date:   Thu Apr 21 15:07:36 2011 -0700

    blame: tolerate bogus e-mail addresses a bit better
    
    The names and e-mails are sanitized by fmt_ident() when creating commits,
    so that they do not contain "<" nor ">", and the "committer" and "author"
    lines in the commit object will always be in the form:
    
        ("author" | "committer") name SP "<" email ">" SP timestamp SP zone
    
    When parsing the email part out, the current code looks for SP starting
    from the end of the email part, but the author could obfuscate the address
    as "author at example dot com".
    
    We should instead look for SP followed by "<", to match the logic of the
    side that formats these lines.
    
    Signed-off-by: Josh Stone <jistone@redhat.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
