From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] git rebase not accepting :/ syntax
Date: Mon, 10 Sep 2012 09:19:31 -0700
Message-ID: <7v8vchq298.fsf@alter.siamese.dyndns.org>
References: <20120907150803.0ae2b186@chalon.bertin.fr>
 <m2ipbqx7iu.fsf@igel.home> <20120910091224.4eca1b6e@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Mon Sep 10 18:20:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB6iY-0000Ti-K6
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 18:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758117Ab2IJQTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 12:19:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40032 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758192Ab2IJQTe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 12:19:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6779E9EB3;
	Mon, 10 Sep 2012 12:19:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fKBsd/n4hZlTyR0JC5jJdlncjjA=; b=Cr+UZ3
	eQ9TI/NHYwcNbyURlpNLMyeU2XPGPPAT4EtQuSOVDjVBCngzIhl8ORhweRpmixaj
	ICqLuN15JgjoaWXKwpfgDd8mNHw8aeJvSZ2ClERryrUq64oFiG15Ij/5zjkGYFl7
	doWEVqfqY6xug7nc44m5uIAYJalQ8UDsu7Yvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FTFX6VJ+5g4+dV96JkwVIB7B3IGN4kb6
	IBI8ynxiTd4ACtZBKte4O1i76/0D+XsFSlU4FYqZzlHqJN08IjnI/t1m/gLxVMsa
	8tKHDXAEuZvwhdtDTbxXhPZj3bXACbXOEHHkU4GVccIxyYrAzwJio49+tlLvtVm5
	JHaVyU3M4sE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54F309EB2;
	Mon, 10 Sep 2012 12:19:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 439629EB1; Mon, 10 Sep 2012
 12:19:33 -0400 (EDT)
In-Reply-To: <20120910091224.4eca1b6e@chalon.bertin.fr> (Yann Dirson's
 message of "Mon, 10 Sep 2012 09:12:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4E5C7638-FB63-11E1-AEBF-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205136>

Yann Dirson <dirson@bertin.fr> writes:

> Hm.  But then, git rev-parse $(git rev-parse :/Merge}^0 does work, a trivial
> patch would appear to make things better.

That, if done unconditionally, smells like a bad hack that wastes an
extra fork for a corner case that appears only very rarely.

I guess something like this

	upstream=$(
        	git rev-parse --verify -q "$upstream_name"^0 ||
                git rev-parse --verify -q $(git rev-parse --verify "$upstream_name")^0
	) ||
	die "$(eval_gettext 'invalid upstream $upstream_name')"

may be an acceptable usability workaround, but I wonder if we can do
the same fallback inside the revision argument parser, so that

	git <cmd> ":/Merge^0"

first looks for a commit that has string "Merge^0" in it and if it
fails then it looks for a commit that has string "Merge" and then
apply "^0" to it.
