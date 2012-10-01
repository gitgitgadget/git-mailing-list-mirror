From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Retry HTTP requests on SSL connect failures
Date: Mon, 01 Oct 2012 16:20:51 -0700
Message-ID: <7vobklaiek.fsf@alter.siamese.dyndns.org>
References: <CAJo=hJs=Zm4BPm94-sNWDUNkg2vAReSsTmKnDVw+xOU9NWcfUQ@mail.gmail.com>
 <1349126586-755-1-git-send-email-spearce@spearce.org>
 <7v1uhhc10y.fsf@alter.siamese.dyndns.org>
 <20121001222306.GB12496@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 01:21:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIpIP-0002Oe-Uv
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 01:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955Ab2JAXUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 19:20:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57729 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964952Ab2JAXUy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 19:20:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A4A18304;
	Mon,  1 Oct 2012 19:20:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vQJOqc1P32DB3XS6SfKzviemW6Q=; b=M0yrZ1
	72LLCtOL/sBPx2jz1MboDaSU8fIK3PWeEpuxbyd1dnWhp/8doKPTTESljq/JWmjq
	ytO90FLTnXmiSyv37n2nCot79XYmruPmNhBjcsj+shnuIcn0krsIgxpe/brhG53e
	Kdlm2B1QKsV/bnc7A9UvWMaa0Og0z5A82gJss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WJTgCH7RdODKvKAm4q7DEiX22JPlLK2F
	JJGvKuNMv7orwY+nnw3Mci3qtHNldlZCH+Fwfhpu/F6Qra+0rQdQf+ppVjxcxapH
	RIz4DmUnBu3wIRptlki66MOLBO0a9sxiP8+LGU5ZLBFRUyIH5wdDhI33jPKrq4w2
	lS+TEskcOcs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 384758303;
	Mon,  1 Oct 2012 19:20:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9ACA18301; Mon,  1 Oct 2012
 19:20:52 -0400 (EDT)
In-Reply-To: <20121001222306.GB12496@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 1 Oct 2012 18:23:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4B51F82-0C1E-11E2-B4D3-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206778>

Jeff King <peff@peff.net> writes:

> On Mon, Oct 01, 2012 at 02:53:17PM -0700, Junio C Hamano wrote:
>
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> 
>> > +	for (attempts = 0; attempts < 2; attempts++) {
>> > +		if (start_active_slot(slot)) {
>> > +			run_active_slot(slot);
>> > +			if (slot->results->curl_result == CURLE_SSL_CONNECT_ERROR)
>> > +				continue;
>> 
>> Is it safe to continue and let start_active_slot() to add the same
>> curl handle again when USE_CURL_MULTI is in effect?
>
> I _think_ so. 

It seems that at the beginning of curl_multi_add_handle() there is a
check to see if the incoming slot->curl has already been added to
some curl-multi-handle and the function would return an error code
CURLM_BAD_EASY_HANDLE without doing anything useful.  Doesn't the
second attempt to call start_active_slot() set the slot->in_use to
zero and return false, skipping the call to run_active_slot() in
that case?
