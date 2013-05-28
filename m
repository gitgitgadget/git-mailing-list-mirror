From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Tue, 28 May 2013 10:04:46 -0700
Message-ID: <7va9nf2fyp.fsf@alter.siamese.dyndns.org>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
	<20130108062811.GA3131@elie.Belkin>
	<7vip78go6b.fsf@alter.siamese.dyndns.org>
	<CACsJy8D9+KHT=YfU0+rPCbs+AwxQOpfKzPChDhk8d-MMkRzZug@mail.gmail.com>
	<7vvcb8f6aw.fsf@alter.siamese.dyndns.org>
	<20130528091812.GG25742@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Tue May 28 19:04:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhNKR-0006vC-Jb
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 19:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934899Ab3E1REv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 13:04:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33185 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934848Ab3E1REt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 13:04:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE2AF23D6D;
	Tue, 28 May 2013 17:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=BOcmD+eI9MISO6PJaxNlfxyiWhk=; b=eyRx6CvnbLvdEePpEJHu
	bZgQOhf1jC9a36zgZZtbBiGLDRifKJDXuv6ZL1ttEFNnXrppNF3weOhJfcXZK0tM
	IQSK8tgb1nT0WkId3lse93/uavOFyN81KDfBEFcxPi1+MkWyvnlZ+O96AJrgYg3M
	GeGQ6Jksk1mSe/Ikrd4ukwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=KS0ntpTSWASxYeQrhKx/EFvAqlbeKVxj6DZtRntMz/rUeu
	VnECEb+2Lt089EpTJORHRrC9fCKzC8J9gKBpmGHAUnKQrA1WNXMakLMlPQFc170P
	UceeW+af9Ff3bEBGrg6QgwH/t4iEswMnsHh72fL3P0/79RO0X8om75UOhOnDU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B480623D6C;
	Tue, 28 May 2013 17:04:48 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3DE523D67;
	Tue, 28 May 2013 17:04:47 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B3EA9B5C-C7B8-11E2-AD60-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225665>

Matthijs Kooijman <matthijs@stdin.nl> writes:

> Did you consider how to implement this? Looking at the code, it seems
> the "deepen" parameter in the wire protocol now means:
>  - 0: Do not change anything about the shallowness (i.e., fetch
>    everything from the shallow root to the tip).
>  - > 0: Create new shallow commits at depth commits below the tip (so
>    depth == 1 means tip and one below).
>  - INFINITE_DEPTH (0x7fffffff): Remove all shallowness and fetch
>    complete history.
>
> Given this, I'm not sure how one can express "fetch the tip and nothing
> below that", since depth == 0 already has a different meaning.

Doing it "correctly" (in the shorter term) would involve:

 - adding a capability on the sending side "fixed-off-by-one-depth"
   to the protocol, and teaching the sending side to advertise the
   capability;
   
 - teaching the requestor that got --depth=N from the end user to
   pay attention to the new capability in such a way that:

   - when talking to an old sender (i.e. without the off-by-one
     fix), send N-1 for N greater than 1.  Punt on N==1;

   - when talking to a fixed sender, ask to enable the capability,
     and send N as is (including N==1).

 - teaching the sending side to see if the new behaviour to fix
   off-by-one is asked by the requestor, and stop at the correct
   number of commits, not oversending one more.  Otherwise retain
   the old behaviour.

In the longer term, I think we should introduce a better deepening
mechanism.  Cf.

  http://thread.gmane.org/gmane.comp.version-control.git/212912/focus=212940

> Of course, one could using depth == 1 in this case to receive two
> commits and then drop one, but this would seem a bit pointless to me
> (especially if the commit below the tip is very different from the tip
> leading to a lot of useless data transfer).
