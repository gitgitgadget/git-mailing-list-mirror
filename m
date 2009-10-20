From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git hang with corrupted .pack
Date: Tue, 20 Oct 2009 10:13:50 -0700
Message-ID: <7vzl7mng35.fsf@alter.siamese.dyndns.org>
References: <20091014042249.GA5250@hexapodia.org>
 <20091014142351.GI9261@spearce.org> <7viqeaovmp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Isaacson <adi@hexapodia.org>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	Alex Riesen <raa.lkml@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 20 19:14:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0IHl-0004zA-KN
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 19:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661AbZJTROD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 13:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752634AbZJTROC
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 13:14:02 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41072 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbZJTROB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 13:14:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1B2C57E555;
	Tue, 20 Oct 2009 13:14:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZC9N3CwfrT2Q7Q6xlEG/iAvYM/o=; b=JoG6+T
	rZBIFHMiIsvEyWDxXrTxv5z9Y2V3j/XprKn9gZNlpH0mwgWR2xexFQD6cPARYlSC
	pPv05jRMtqKnsxi13cuPl3uEDcgPXiw9LsvtSugTBkE7vl8Ft8IObMWvcwal7uD9
	cOVxBrYOVowCZGT4NbuCr/zyGFv8JnATgeCz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EVOYoB4Ul+dS5DMvCGuiVYisIAJzj5Lr
	p/R3v9Ex+QGAtGlmdVXFYPSSHV9KBdxBNBpwrmk/4Htj0sGzhQRHGEX+4dt+mkt4
	QKg4IJN8hl3SIk3e9gganZ5CFYVi8Fd3vna7wxlBndmvW74RbxJiz3hegFsaKoU9
	VpFRzdrVvUg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C6B297E554;
	Tue, 20 Oct 2009 13:13:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F28587E54E; Tue, 20 Oct 2009
 13:13:51 -0400 (EDT)
In-Reply-To: <7viqeaovmp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 20 Oct 2009 09\:52\:46 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F484D27A-BD9B-11DE-9B0D-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130817>

Junio C Hamano <gitster@pobox.com> writes:

>> We now abort the loop if inflate() returns Z_BUF_ERROR without
>> consuming the entire input buffer it was given, or has filled
>> the entire output buffer but has not yet returned Z_STREAM_END.
>> Either state is a clear indicator that this loop is not working
>> as expected, and should not continue.
>
> When the inflated contents is of size 0, avail_out would be 0 and avail_in
> would still have something because the input stream needs to have the end
> of stream marker that is more than zero byte long.

After thinking about this a bit more, I am reasonably sure that this is
it.  The contents does not have to be a 0-length string, but you would hit
this if the pure-data portion of the deflated stream aligns at the end of
your (un)pack window and it happens to require another use_pack() to move
the window to read the end-of-stream signal.  In that situation, the
output buffer has already been filled, but you haven't read the input
stream fully.  Would't the new check incorrectly trigger in such a case?

>>  		st = git_inflate(&stream, Z_FINISH);
>> +		if (st == Z_BUF_ERROR && (stream.avail_in || !stream.avail_out))
>> +			break;

We won't see this on 64-bit platforms because we use larger (un)pack
window and the condition is much less likely to be met.
