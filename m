From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] reset: handle submodule with trailing slash
Date: Wed, 11 Sep 2013 11:14:57 -0700
Message-ID: <xmqq8uz3tece.fsf@gitster.dls.corp.google.com>
References: <cover.1378840318.git.john@keeping.me.uk>
	<c7e026f44f9ccbf5736b72e728a360b31887a50f.1378840318.git.john@keeping.me.uk>
	<52300838.5040703@kdbg.org> <20130911082042.GR2582@serenity.lan>
	<CACsJy8BgEM3eEDo8wOgkqYTL1fkh9azZNqbogxBubp9g5KRNbQ@mail.gmail.com>
	<xmqqwqmnthfh.fsf@gitster.dls.corp.google.com>
	<20130911172705.GV2582@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 11 20:15:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJowd-0007vO-3u
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 20:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756016Ab3IKSPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 14:15:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39676 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755950Ab3IKSPI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 14:15:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C11B541E96;
	Wed, 11 Sep 2013 18:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9Tw4kEYMsi12xwTX4qP2XXsFEQU=; b=gzF3zK
	XyKskczwY3NSYOl8s2IfBdL8jE/rsShhEaXOKp9t1zSpDZ+nAd2LQ1LleNUnj8f1
	QZnciwuhboshd16UmHh8P+10DCsrBBPboI81/KmilKPtV5PUsQRY3x2Ar5ycAtbb
	+3QR+QO9vyixDiHtX4gUnr+3vAG4gcV+gyww0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KIixeoNapIOZvD+May/I2sh+3qy6rg05
	KsLo1bTa9K+tEfu4LKT97AgHqX3YM6htQEPIY4VuyZnngJqUfpXL881/2q33awqg
	vJCi8+zc8p9dKX3ExQBi2r5c7bNaSNd1MtC7mgxUN6D398BwWmiiht0T0E6OuBIN
	S1K32YM8LjY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FABE41E8C;
	Wed, 11 Sep 2013 18:15:04 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75ABB41E71;
	Wed, 11 Sep 2013 18:15:00 +0000 (UTC)
In-Reply-To: <20130911172705.GV2582@serenity.lan> (John Keeping's message of
	"Wed, 11 Sep 2013 18:27:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 142279EC-1B0E-11E3-A41B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234590>

John Keeping <john@keeping.me.uk> writes:

> On Wed, Sep 11, 2013 at 10:08:18AM -0700, Junio C Hamano wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>> 
>> > reset --soft does not go through these code paths (i.e. it does not
>> > need index at all). If we fail to load index index in "reset --soft" I
>> > think it's ok to die(). Corrupt index is fatal anyway.
>> 
>> Do I smell a breakage here?  Isn't "reset --soft HEAD" (or some
>> known good commit) a way to recover from a corrupt index?
>> 
>> If that is the case, I do not think it is OK at all.  What do we
>> suggest as an alternative?  "rm .git/index && read-tree"?
>
> Duy's suggestion below is necessary to avoid this then I think - we'll
> die if the user has a corrupt index and gives a path with a trailing
> slash, but without that path we won't try to load the index.

Sorry, but I don't quite follow.  Isn't "git reset --soft <path>" a
nonsense, with or without a trailing slash at the end of <path>?


>> > But "reset
>> > --soft" now has to pay the cost to load index, which could be slow
>> > when the index is big. Assuming nobody does "reset --soft" that often
>> > I think this is OK.
>> >
>> > Alternatively we could load index lazily in _CHEAP code only when we
>> > see trailing slashes, then replace these read_cache() with
>> > read_cache_unless_its_already_loaded_earlier() or something.
