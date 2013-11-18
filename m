From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] commit -v: strip diffs and submodule shortlogs from the commit message
Date: Mon, 18 Nov 2013 08:01:49 -0800
Message-ID: <xmqqk3g5d7gy.fsf@gitster.dls.corp.google.com>
References: <loom.20131110T222043-57@post.gmane.org> <528140F5.6090700@web.de>
	<loom.20131111T214646-550@post.gmane.org> <52814C35.6040205@web.de>
	<5281DCC5.2000209@kdbg.org> <5282A90A.4030900@web.de>
	<xmqqy54tfeje.fsf@gitster.dls.corp.google.com>
	<5283C701.8090400@web.de>
	<xmqq7gccdq67.fsf@gitster.dls.corp.google.com>
	<5287F735.3030306@web.de>
	<20131117090935.GC17016@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Johannes Sixt <j6t@kdbg.org>,
	Ari Pollak <ari@debian.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 18 17:02:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViRH4-0004So-JC
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 17:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373Ab3KRQCC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 11:02:02 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53371 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203Ab3KRQCA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 11:02:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D25052504;
	Mon, 18 Nov 2013 11:01:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kWOb1TbuXFEGcx5rXlikAG2+lW4=; b=T58n+h
	jjKqZOibU1YSdIFRA2HJmdg43+W0/4GFiYvZXtu1ieHkfusqQXcouEiVKdRWqL1X
	LIyHSDGJbBQmlvIJ0TBwZeDKE5+fJhkcdC9heqTGcWFs3iMiyv6J5m69UgTgxrhD
	UOfb7bbzG+TbCNSQqA2tweC5/TGMiJi2mMGgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cc1btWi+oVz1BR2eoqQF81gtEec0fI5C
	IgWAypr5eee0dK0TdH/lJAlmny5UBUyf9qQtNjxPL4yQurIzZwv2azSGVMIwJjO1
	e/weB+hkLQDZUPCR1JgG4coImmpJqpnpvKGUYNDVM/DurRMwjDPyMc2/N+nloeHz
	J75caw5m/YI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B0F152503;
	Mon, 18 Nov 2013 11:01:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE789524FE;
	Mon, 18 Nov 2013 11:01:53 -0500 (EST)
In-Reply-To: <20131117090935.GC17016@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 17 Nov 2013 04:09:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BE2C692A-506A-11E3-9887-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237985>

Jeff King <peff@peff.net> writes:

> I found this hard to parse, I think because of the "keeping" (why would
> I not keep it?), and because you are talking about lines above and
> below. It is not as accurate to say:
>
>   # ------------------ >8 --------------------
>   # Everything below this line will be removed.
>
> because it is technically the line above that is the cutoff. But I think
> the meaning is clear, and it is simpler to parse.
>
> I do think it would be simpler with a single line. I know handling the
> i18n was a question there, but I think we should be fine as long as we
> check for the exact bytes we wrote. Surely gettext can do something
> like:
>
>   magic = _("# Everything below this line will be removed");
>   fprintf(fh, "%s", magic);
>   ...
>   p = strstr(magic);
>
> I don't know what guarantees on string lifetime gettext gives us, but
> the worst case is that we simply strdup the result.
>
> I suppose it's possible that the translated string could have utf8 with
> multiple representations, and the user's editor normalizes the text in a
> different way than we wrote it when it saves the result. I don't know if
> that is worth caring about or not; it seems kind of insane.

I agree with your rewording suggestion.  It might make it even more
robust to do something like

    const char cut_here[] = "# --- cut here --- >8 --- cut here ---";

    fprintf(fh, "%s\n", cut_here);
    fputs(_("# Everything below this line will be removed\n"), fh);
    ...
    p = strstr(cut_here);

i.e. a real marker line that will never be translated, with an
explanation immediately below that can be translated.
