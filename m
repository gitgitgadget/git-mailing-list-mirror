From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: Improve parsing for emails with spaces
Date: Fri, 29 Apr 2011 10:59:43 -0700
Message-ID: <7vvcxxvsz4.fsf@alter.siamese.dyndns.org>
References: <1303423656-32002-1-git-send-email-jistone@redhat.com>
 <20110429131103.GB4540@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Stone <jistone@redhat.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 29 20:00:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFrzN-0005sE-Vg
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 20:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760734Ab1D2R77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 13:59:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51033 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760720Ab1D2R76 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 13:59:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 453945BC4;
	Fri, 29 Apr 2011 14:01:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zgH4XCua4VZGvf6SrVVI3rEkud8=; b=gFC24W
	RpMnOxr5EyS9/y8XSI/CfA2xvRv7edMimAdujCzy6FWyL1971v66x9pJWDm+ocqf
	8DoJ14+DTxBElcPer320WDdZKCFknBWZ3Pxlp+qYmkIKA4F8oIlWqhbf/jLo/SD5
	dUOjFIY0dXLIh/VcPrRRQF9aw0RVtZv7eWVzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d5xeEmAXXAEtXTUjrDfp6ProkaVwbFaE
	eOEXFcVtbCJPkBC0EZalNqyF+ug5yrkCIlLPyCApCiUqjl97g4uKxMCkkJDltcDR
	O7Yt0cRCrD7y6tA7Q6it17ETox0JB4hDZpuoqpVKiBThj+fKiAn1/70e+YVh0EbX
	NNgMOyBENys=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1264D5BC2;
	Fri, 29 Apr 2011 14:01:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D6B535BBA; Fri, 29 Apr 2011
 14:01:47 -0400 (EDT)
In-Reply-To: <20110429131103.GB4540@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 29 Apr 2011 09:11:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2C4ED92-728A-11E0-9612-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172484>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 21, 2011 at 03:07:36PM -0700, Josh Stone wrote:
>
>> One of my git repositories has some old commits where the authors
>> obfuscated their email address as <author at example dot com>.  To
>> handle this, blame needs to look for the leading '<' when scanning
>> to split the "name <email>", rather then only a space delimiter.

Given that we enclose the e-mail inside "<>" pair and excise "<" from
author names in fmt_ident(), I think it makes sense to look for " <" like
this patch does.

> Hmm. That address seems bogus, and I wonder if we should be rejecting it
> at commit time. Still, it is something we may run across in existing
> repositories, so handling it more gracefully makes sense.

Perhaps but within reason.  

What new types of breakages are we proposing to tolerate, what breakages
are we declaring not worth fixing, and what is the price of not loosening
this?  Without this patch, such a broken commit will result in the author
email shown somewhat broken, but the original is already broken to begin
with, and also the entry for the blamed line will come with its commit
object name anyway, so I do not think it is such a big deal.

It would be an entirely different issue if the command barfed and refused
to blame the file.

> Looking over the other places we parse author info, I don't think the
> same problem exists elsewhere. Most other places parse from left to
> right, and just go to the closing ">".

Because fmt_ident() removes "<" or ">" from given email address, I think
it is sufficient.

It would be nice to have an abstraction around the parsing in a way
similar to fmt_ident() is an abstraction around the formatting, but that
would be a separate topic.
