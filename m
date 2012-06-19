From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Try harder to find a remote when on a detached HEAD or
 non-tracking branch.
Date: Tue, 19 Jun 2012 15:26:18 -0700
Message-ID: <7vobofx7jp.fsf@alter.siamese.dyndns.org>
References: <1340038866-24552-1-git-send-email-marcnarc@xiplink.com>
 <7vaa004j9f.fsf@alter.siamese.dyndns.org> <4FDFA030.7080408@xiplink.com>
 <7vmx402rru.fsf@alter.siamese.dyndns.org> <4FE08797.50509@xiplink.com>
 <7vipen191a.fsf@alter.siamese.dyndns.org>
 <20120619201259.GB14692@sigill.intra.peff.net> <4FE0F267.5070803@xiplink.com>
 <20120619214646.GA22436@sigill.intra.peff.net>
 <7vsjdrx8tt.fsf@alter.siamese.dyndns.org>
 <20120619220026.GA22852@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 00:26:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh6sU-0002pv-Gz
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 00:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425Ab2FSW0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 18:26:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57844 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155Ab2FSW0U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 18:26:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B58B9487;
	Tue, 19 Jun 2012 18:26:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QQJGMABXGbE8MXavdxXNKSNZVPw=; b=K2ilRJ
	TJcz/G9pCZNI7i/dkSEkApS8aEjyFCVeEg5XiO4mOzhyY8RqrPgDrlQi8TPbMQEG
	ibuj+OPj44QiU2MQq2GMwNAJr8NATwHdOKTY8s4ORRWp1sNwhjCD+hM8WMBtwV7Q
	QCgMT8dOM5NJONTI2nuVBQBQrfADbPJCjKVEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fUgwACtPB7sO+72RG5hW7Ev56P+DhkxA
	63UmxIRlSeqSjIecFjI6OdcWaGWmX5A/GxSROyIQXgRLGLW7QKflAxGxvZdK49ud
	Pb46T+h/HQgCIV82/D3yGiNpyw4kXeMKU9Yi4EaknUBhjgluKfYzajTNosIMiZm4
	dXtMpW2hM3U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51A509486;
	Tue, 19 Jun 2012 18:26:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D86FF9484; Tue, 19 Jun 2012
 18:26:19 -0400 (EDT)
In-Reply-To: <20120619220026.GA22852@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 19 Jun 2012 18:00:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB09DB36-BA5D-11E1-B71C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200260>

Jeff King <peff@peff.net> writes:

> On Tue, Jun 19, 2012 at 02:58:38PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > On Tue, Jun 19, 2012 at 05:43:03PM -0400, Marc Branchaud wrote:
>> >
>> >> I suggest git would be better off changing the way it finds the default
>> >> remote to:
>> >> 
>> >> 	Use the currently checked-out branch's remote;
>> >> 	or Use the remote specified in the original clone command[*];
>> >> 	or use "origin".
>> >> 
>> >> [*] With some strong mechanism for identifying this remote.
>> >
>> > Yes, that sounds like a much saner path. I think your [*] is just
>> > "record the different name in remote.default during the clone".
>> >
>> > Then we continue to use "origin" when that is not set (so existing repos
>> > without "-o" see no change at all). New repos cloned with "-o" would be
>> > fixed. Old repos cloned with "-o" are still broken, but there is at
>> > least a simple one-time workaround ("git config remote.default foo").
>> 
>> Yeah, I can certainly buy that.
>
> It is also a step towards defining remote.defaultFetch and
> remote.defaultPush if you wanted them to be different, something that
> has come up in conversation a few times (e.g., when you treat a
> read-only upstream as your origin, but publish elsewhere).

Yeah, we are on the same page on that one.
