From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] shorten_unambiguous_ref(): tighten up pointer arithmetic
Date: Fri, 10 Jan 2014 10:03:17 -0800
Message-ID: <xmqqlhyn90ka.fsf@gitster.dls.corp.google.com>
References: <1389192220-13913-1-git-send-email-mhagger@alum.mit.edu>
	<1389192220-13913-4-git-send-email-mhagger@alum.mit.edu>
	<xmqqtxdc92ub.fsf@gitster.dls.corp.google.com>
	<52D000CC.1060402@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jan 10 19:03:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1gQd-0004Cc-Bj
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 19:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbaAJSD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 13:03:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34398 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962AbaAJSD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 13:03:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6562B619D7;
	Fri, 10 Jan 2014 13:03:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3MUcjuRmuNdY86a4bThvet5o8aA=; b=iF5zXY
	zv5MlLeqxsKBoPqsPORrHuJNW0pAf/BsK4+kVT+sIKJPpjJowodaHgptgbbamzfH
	VEnPnY/Do0Gdg3AcKgXO8MZFaO/Nyixsr1gjsTZxYTc9ZX1uLwrVxdMgPyFucd6U
	6qY3zoC6iJjU8nl7iyHiD400mBhgdziR+9wUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H0msa+i19L6G9zPIL3t8XfBXcu1eTY0l
	bK4TqFXGQ+IfKE+WUJeoc7YhPC7wtVtsRKRcrGv7+9YiZ8pAtvfyWS5zaFsqhxLN
	czEVJ60Wml/u4+Sf4OtJ4FkEez2GwT05KJcK6QeO3ktl/RrW9lu8wXIn50Uy8dfz
	OQgO6J2CiKU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C451619D6;
	Fri, 10 Jan 2014 13:03:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 612F6619CD;
	Fri, 10 Jan 2014 13:03:21 -0500 (EST)
In-Reply-To: <52D000CC.1060402@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 10 Jan 2014 15:16:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7DC93990-7A21-11E3-810F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240305>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> As for removing the third argument of refname_match(): although all
> callers pass it ref_ref_parse_rules, that array is sometimes passed to
> the function via the alias "ref_fetch_rules".  So I suppose somebody
> wanted to leave the way open to make these two rule sets diverge (though
> I don't know how likely that is to occur).

It is the other way around.  We used to use two separate rules for
the normal ref resolution dwimming and dwimming done to decide which
remote ref to grab.  For example, 'x' in 'git log x' can mean
'refs/remotes/x/HEAD', but 'git fetch origin x' would not grab
'refs/remotes/x/HEAD' at 'origin'.  Also, 'git fetch origin v1.0'
did not look into 'refs/tags/v1.0' in the 'origin' repository back
when these two rules were different.

This was originally done very much on purpose, in order to avoid
surprises and to discourage meaningless usage---you would not expect
us to be interested in the state of a third repository that was
observed by our 'origin' the last time (which we do not even know
when).

When we harmonized these two rules later and we #defined out
ref_fetch_rules away to avoid potential breakages for in-flight
topics.  The old synonym can now go safely.
