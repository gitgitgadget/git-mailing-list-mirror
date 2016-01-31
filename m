From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Replacing strbuf_getline_lf() by strbuf_getline() in wt-status.c
Date: Sun, 31 Jan 2016 08:59:55 -0800
Message-ID: <xmqqd1shy99w.fsf@gitster.mtv.corp.google.com>
References: <56ACC916.8020008@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Sun Jan 31 18:00:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPvM5-00020g-Ia
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 18:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757489AbcAaQ77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 11:59:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56226 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750901AbcAaQ76 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 11:59:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 845663F37C;
	Sun, 31 Jan 2016 11:59:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jKCazYjlxtw2Uk24+yQLLmlQuNA=; b=OLGv6e
	uJS/tQ/8cbdIZYYJZB+1gciPeZJW1Ry1DbkrTxjL665916yvGkSZztRP5d4VRzYn
	EetjozMDZwycslRFvHUQs7VUciaVMu9xCj/S/sTj/y8PvOA97YvZ2mxuzwmdd2mG
	6KZLOnwcJdu1iHoRqIS3vFWZ26TbW1gRHSTKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xmOlFtX3pnD1U1zVDsXGKw593JQi4Of0
	CkIMBO2mTCBZaHQwpQs5WQ/31GrCqBf/F47T7UQvMyFT7WDls6PGvQDzkENtHjAt
	3wb2NicaEAGE99BFQMTIpSqX2Q076W71ycwuVIbBYNNgW7ALTfvBDs4fzFw6GkYs
	WrNa1X2j4ME=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B1FE3F37B;
	Sun, 31 Jan 2016 11:59:57 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E5B963F37A;
	Sun, 31 Jan 2016 11:59:56 -0500 (EST)
In-Reply-To: <56ACC916.8020008@moritzneeb.de> (Moritz Neeb's message of "Sat,
	30 Jan 2016 15:30:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0E61A522-C83C-11E5-891F-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285156>

Moritz Neeb <lists@moritzneeb.de> writes:

> Currently I am working on replacing strbuf_getline_lf() by
> strbuf_getline() in places where the input is trimmed immediately after
> reading, cf. $gmane/284104, "Notes on the remaining strbuf_getline_lf()
> callers", 2nd point.
>
> One instance I found was in wt-status.c. In read_rebase_todolist() the
> lines are read, checked for a comment_line_char and then trimmed. I
> wonder why the input is not trimmed before checking for this character?
> Is it safe to replace strbuf_getline_lf() by strbuf_getline() anyway?
>
> The only case I can imagine that could lead to unexpected behaviour then
> would be when someone sets the comment_line_char to CR. How likely is that?
>
> Why is the trim after checking for the comment char anyway? Should
> something like "   # foobar" not be considered as comment?

That is debatable, I would think, as "git commit" and others do not
generally accept a line that does not begin with a comment char as a
comment.

I however think we made an exception for the rebase-i's insn file
due to a mistake we made long time ago that allowed such line,
caused people to build a workflow around the assumption that it is
OK to prefix a comment line with whitespaces.

  Cf. the last paragraph of 1db168ee (rebase-i: loosen over-eager
      check_bad_cmd check, 2015-10-01).

  Cf. http://thread.gmane.org/gmane.comp.version-control.git/278841

So we probably want to be consistent with that in this codepath.
