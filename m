From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test that checkout does not overwrite entries in
 .git/info/exclude
Date: Mon, 21 Nov 2011 07:18:24 -0800
Message-ID: <7vk46th5bz.fsf@alter.siamese.dyndns.org>
References: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com>
 <7vehx2ijf8.fsf@alter.siamese.dyndns.org>
 <20111120221930.GF14902@foodlogiq3-xp-d620.thebe.ath.cx>
 <7vzkfqgn91.fsf@alter.siamese.dyndns.org> <4EC9FC81.3080306@viscovery.net>
 <20111121081701.GA7985@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Taylor Hedberg <tmhedberg@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 16:18:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSVdi-0001JB-S6
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 16:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab1KUPS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 10:18:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864Ab1KUPS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 10:18:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BC605408;
	Mon, 21 Nov 2011 10:18:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l4gBshkG2HEoSpCrhju59gf5sJc=; b=g7M6s5
	RRioI80RDf/sU3lD35GtdX9DVASytXeWvtEdnMzvKFXCSD+uJSRg6gX4+TTofBvS
	t9pGf35njbyGlghtpTXaJLMaJN5OPwy+WD4SHeD7egmmsNraMkBWPYATDMdkd1iX
	EMzzB5w8QO2blle59YgsSALZsxbRR+f/ZwvhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L50LVTtipx5vszFJ2pr807DrQ1s0Vjk5
	O5SMZrjgl7C/0QHht5ePQmDA4HtGc7Di37tBG+EEPa9WAK94v+PRBQgKwF3e0WkS
	Ec3IDZrGJ/wEZYKOcEzq5YGd6aUu1i2GCzQNMu1qvkbD8OJHV7Uyd1RVykIl2hrl
	POH/zQATAvA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12FA05407;
	Mon, 21 Nov 2011 10:18:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69E0353FC; Mon, 21 Nov 2011
 10:18:26 -0500 (EST)
In-Reply-To: <20111121081701.GA7985@do> (Nguyen Thai Ngoc Duy's message of
 "Mon, 21 Nov 2011 15:17:01 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F4EB452-1454-11E1-AE61-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185746>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> If you want to keep this accident (which is a bug to me), you may want
> to add the reason: callers to unpack_trees() are supposed to also
> setup exclude rules in .git/info/exclude before calling
> unpack_trees(), which they don't.
>
> So .git/info/exclude is entirely dismissed.

Ohh, thanks for this and also for digging this through in your other
message.

I think it is the right thing to do to make sure .gitignore and
info/exclude behave the same way regardless of the original issue in this
topic.

In the medium term, I think one reasonable way forward solving the "TODO
that used to be tracked but now untracked and ignored" issue is to
introduce "info/exclude-override" that comes between command line and
in-tree patterns. The info/exclude file is designed as the fallback
definition to be used when all other sources are too lax, and comes near
the precedence stack; the "TODO" situation however calls for an override
that is stronger than the in-tree patterns.

In the longer term, we should carefully determine if we need "precious" in
the first place. The last time this was brought up there were people who
argued they are OK with having to remove the ignored file by hand when
checking out another branch (i.e. we switch the semantics of "ignored" so
that they are "not tracked but all precious").

I think it matters in two cases.

 (1) If you change an untracked "cruft" file on branch A into a directory
     with tracked files in it on another branch B. If you are on branch A,
     have that "cruft" file (perhaps it is a build product after running
     "make"), and try to checkout branch B, such an updated "git checkout"
     will start erroring out telling you that "cruft" will be lost.

 (2) If you have a directory on branch A, underneath of which there are
     untracked "cruft" files (e.g. think "build/" directory that is full
     of "*.o" files and ".gitignore" to mark object files as ignored but
     is otherwise empty), and another branch B that has the same path as a
     file. If you are on branch A, have "cruft" files in that directory,
     and try to checkout branch B, such an updated "git checkout" will
     start erroring out telling you that "cruft" will be lost.

If people are OK with such a behaviour, we can do without "precious".

Otherwise we would need to update excluded() in dir.c to return tristate
(ignored, precious or unspecified) instead of the current boolean (ignored
or unspecified), examine and decide for each caller what they want to do
to "precious" files.
