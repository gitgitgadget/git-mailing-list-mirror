From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Makefile: split prefix flags from GIT-CFLAGS
Date: Tue, 19 Jun 2012 14:39:20 -0700
Message-ID: <7vzk7zx9pz.fsf@alter.siamese.dyndns.org>
References: <20120619195229.GA14692@sigill.intra.peff.net>
 <20120619200354.GC14714@sigill.intra.peff.net>
 <7vmx3zyqil.fsf@alter.siamese.dyndns.org>
 <20120619210426.GA21838@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 19 23:39:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh691-0001oE-QY
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 23:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135Ab2FSVjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 17:39:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63142 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753456Ab2FSVjX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 17:39:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAA7A8454;
	Tue, 19 Jun 2012 17:39:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0BPp2KzBTanRRA6jdqHe2yCOF10=; b=UXGJGm
	LqGKsZnc1V6Ng+k/DX7IwzKV+uvKw9l9AW+rujJqUD3MoP0sVyp3a3XJp9w23yPc
	3mti0jnj3D7MsTGYqavQvtqDteSFR68xgUa7ImwLbs0jhIy4ZYsOnsSfDNRJoSFv
	vJbvpam+gQLF2SiuHQlD9XrusFPlbjxgU2oA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dbIrkk0f7E9ReB31bcgyoDsGCgNdN66l
	+4LDg0NYLBZpcDIFmA6QpijaHaz7yabgTVb2EHKM5Mm0rwE7mlpke8uPZWlfMrPz
	wNLWbTzfcjXjTSPckqbCjUiVmOhUCqK9NXjAGGnMUifkytUi84hIwI5X8j9POFwj
	MsmYu/50gWY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDFA18453;
	Tue, 19 Jun 2012 17:39:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C72F844E; Tue, 19 Jun 2012
 17:39:22 -0400 (EDT)
In-Reply-To: <20120619210426.GA21838@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 19 Jun 2012 17:04:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3BB794EC-BA57-11E1-AF08-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200250>

Jeff King <peff@peff.net> writes:

> On Tue, Jun 19, 2012 at 01:51:14PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Most of the build targets do not care about the setting of $prefix
>> > (or its derivative variables), but will be rebuilt if the prefix
>> > changes. For most setups this doesn't matter (they set prefix once
>> > and never change it), but for a setup which puts each branch or
>> > version in its own prefix, this unnecessarily causes a full
>> > rebuild whenever the branc is changed.
>> [...]
>> 
>> I have to wonder if is this something we care about that much.
>
> It does speed up my build a fair bit, but I admit I have a somewhat
> uncommon setup.

Oh, I wouldn't question the "speeding up" part.  I simply expected
that people who use separate prefix depending on branch would have
separate checkout for these branches they build and install
regularly to their own prefixes, so recompilation due to prefix
change would not be an issue, because by definition in such a set-up
you won't change branch in a checkout.

> Yeah, I think that would be nicer overall. If we move to a link-time
> dependency, then we can even put _all_ of the Makefile-based strings in
> there without ever having to care about who uses it. Of course, it won't
> work for things that truly need to be preprocessor macros (for
> conditional compilation), so we'd still be stuck with those (most of
> them just end up in CFLAGS and trigger a full rebuild, which is probably
> OK).

Yeah, I didn't go through the list of Make variables to see how much
damage I was talking about ;-).
