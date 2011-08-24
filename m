From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: Demonstrate known breakage during recursive
 merge
Date: Wed, 24 Aug 2011 15:43:56 -0700
Message-ID: <7v39gqo2fn.fsf@alter.siamese.dyndns.org>
References: <680d2679c3275c01152500760311b5f96a93ea62.1314193375.git.brad.king@kitware.com> <20110824191438.GA45292@book.hvoigt.net> <7vty96obo9.fsf@alter.siamese.dyndns.org> <20110824194618.GD45292@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 00:44:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwMB3-0004VZ-IX
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 00:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467Ab1HXWoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 18:44:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54371 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021Ab1HXWn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 18:43:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE17656BF;
	Wed, 24 Aug 2011 18:43:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AFjGAfiX0w7VEM0PGNcPoFgmTac=; b=JoXmmY
	cRhg+tA64XBBHgl+YhFfbL+OjHWkIVPEBSjHW006IPaJoA3kiAq8kSbByG2AnwCs
	JluAeqLnxlGu/HhatnMiyEy8pAAsyoC3r7DN7mxi91UgvnMRTL3htEhDneN8BGUY
	TgnX9nmpiExUtdxl/eIxuPOR0+nlK00wNNbgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KwRbImf3W4HSTXvHxBjoiLSqk8QkG410
	nG5spMg1+xPVeARbjgDNn8zW4H5rstSATa5fagjdkt+GOQefKiE/4IQkBqNc6daV
	Rfm5a0AZYkiiQkKefsv8ZxQDqJriYKYD3CeMuB/AkA45zaFDf+rKJzeDluoCay7V
	XpBOrtqTg9o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B594C56BE;
	Wed, 24 Aug 2011 18:43:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D6D356BB; Wed, 24 Aug 2011
 18:43:58 -0400 (EDT)
In-Reply-To: <20110824194618.GD45292@book.hvoigt.net> (Heiko Voigt's message
 of "Wed, 24 Aug 2011 21:46:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8DDECAF2-CEA2-11E0-BAED-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180048>

Heiko Voigt <hvoigt@hvoigt.net> writes:

>> I have been suspecting that most of this should be done in a separate
>> helper program that is run via run_command() interface, without
>> contaminating the object pool the main merge process has with data from
>> the submodule object store to begin with (i.e. add_submodule_odb() and
>> everything below should go). Wouldn't it be a lot cleaner solution?
>
> Hmm, I would like to keep it in process. Since there are platforms where
> spawning new processes is very slow.

Adding submodule's odb into the main process _will_ also have performance
penalties because it will make it more expensive to look up objects that
belong to the superproject when the superproject wants its own look up.

In case you haven't realized yet, walking revision graph multiple times
while making sure that you do not affect other revision traversals in
effect is hard to arrange right. But more importantly, correctness counts
more than performing quickly and giving a bogus result with premature
optimization that makes it harder to implement things correctly (and
harder to verify the change is correct).
