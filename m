From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase-interactive: avoid breaking when
 GREP_OPTIONS="-H"
Date: Mon, 07 Sep 2009 23:54:06 -0700
Message-ID: <7vmy56gc4x.fsf@alter.siamese.dyndns.org>
References: <1252328160-4359-1-git-send-email-carenas@sajinet.com.pe>
 <7v7hwar1fp.fsf@alter.siamese.dyndns.org>
 <20090908064756.GA14155@sajinet.com.pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
X-From: git-owner@vger.kernel.org Tue Sep 08 08:54:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mkuax-0000dk-8N
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 08:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbZIHGyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 02:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753787AbZIHGyO
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 02:54:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782AbZIHGyL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 02:54:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BE442A07B;
	Tue,  8 Sep 2009 02:54:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ja+cw+/HY4RV5d9l1mlDdpnhq7M=; b=Ip0ZcY
	G6dDcde5Pt5QSodgAlLnK3GzyGvR/LQwxWQJkWAPuByXl2dxIvMminukrgFfjU5S
	RUpq/IrFxixgP3tvsfK0cJpYxe6J8P5+JhmYtzEtYpgOYDKxcJEJxXKajA3BVTJm
	eEMR8BXNin0kd9ddUDkpqw9vvs6jeiU73PvAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qBiMl6UeCHk/rgNOuvQVMr3n70/fqYhC
	WV0FVVJeZoQMJReS4FwXoBCH43NOQXnbacDqEwxue3hJgd63OES++2O7CpGWlxmm
	jc57Jpr5Biz1SYrMfkWD2o4LlRzz7bAavsH6r8hm+/ud9XVQNJ233X1kXeN6vUrY
	cQibdzEj5n8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DAAB2A079;
	Tue,  8 Sep 2009 02:54:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB0042A078; Tue,  8 Sep
 2009 02:54:08 -0400 (EDT)
In-Reply-To: <20090908064756.GA14155@sajinet.com.pe> (Carlo Marcelo Arenas
 Belon's message of "Tue\, 8 Sep 2009 06\:47\:56 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6A4DBFEA-9C44-11DE-9D31-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127977>

Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe> writes:

> On Mon, Sep 07, 2009 at 12:37:30PM -0700, Junio C Hamano wrote:
>> 
>> How does your patch help when the user has GREP_OPTIONS=-C3 in the
>> environment?
>
> It wouldn't help but at least wouldn't break aborting with an script
> error since you will always get a number.

That's actually worse, don't you think?

It is trying to count how many actions are done and how many are
remaining, and if you miscount it in that shell function, you will get
incorrect result.  The function happens to be merely for reporting, but
the point is that it is better to fail loudly than doing wrong thing.

>> I think a saner workaround for this user environment bug (or GNU grep
>> misfeature) is to unset GREP_OPTIONS at the beginning of the script, or
>> even in git-sh-setup.
>
> agree, and since grep is used almost everywhere filtering in git-sh-setup
> like CDPATH is makes sense, with the only user of grep that wouldn't
> benefit from that being git-mergetool--lib.sh AFAIK.

Not at all.  "git grep" itself will be broken.  See my other patch for a
possible alternative approach.
