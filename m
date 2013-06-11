From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 31/45] rebase: trivial cleanup
Date: Tue, 11 Jun 2013 09:12:59 -0700
Message-ID: <7vhah4d3sk.fsf@alter.siamese.dyndns.org>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-32-git-send-email-felipe.contreras@gmail.com>
	<20130609191518.GB12122@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 18:13:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmRC1-0000UY-7Z
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 18:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485Ab3FKQNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 12:13:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52503 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903Ab3FKQND (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 12:13:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29268241D4;
	Tue, 11 Jun 2013 16:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y1W2isIgoRUFxARUjWqJ6peFP8g=; b=duYjrS
	cqZuXRWH+PvFNQxXpkhied7KgLo+sHO9YrKmVcEttw7WGhe8dar7k2CXun6pGeJn
	pcUp+ZsOjBWZCjP8H9t30w35wUJHTpDJOHTvs9nI9tiQpvkxOQwcx43hzdN4yN66
	llNmF2f6ggAUgAXbmn+q//fyuz6UV4Yq3nJgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b825JMWrphIt58SQlrwfl1xnpQK5KlMT
	d3sx87lx4mqVRWxxtfCaKqZYDvZ6JojXdvo3n6jh0CmpnamxnP+JC4+TEZ8fYNwp
	lFRybCbwP0pdeX5vZMaTlFLQ466SHQJTNlfLhqPsDjgqbWVdpRjfz538BSGO3r13
	pZIe3iPVSac=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18DDF241D3;
	Tue, 11 Jun 2013 16:13:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C5A0241CE;
	Tue, 11 Jun 2013 16:13:01 +0000 (UTC)
In-Reply-To: <20130609191518.GB12122@paksenarrion.iveqy.com> (Fredrik
	Gustafsson's message of "Sun, 9 Jun 2013 21:15:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA02CCF8-D2B1-11E2-90EF-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227458>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> Here we have two sh-scripts (git rebase
> and git am) interacting with each other.
> Both uses GIT_QUIET,

Correct.

> so if GIT_QUIET already is set by the caller (git rebase) the
> callee doesn't have to set it to.

Incorrect.  "git rebase" invokes "git am", not dot-sources it, so it
does not propagate.

Both do dot-source git-sh-setup, which clears GIT_QUIET pretty
early, so even GIT_QUIET exported into the environment by mistake
will not affect them.

> However GIT_QUIET is undocumented for git-am (in Git Manual). If we
> translate git am to C/ruby/python/perl/etc. will we catch this?

I think it is irrelevant.  git-am uses many shell variables,
e.g. HAS_HEAD, interactive, abort_safety, etc. but they are
implementation details of the program and there is no point
documenting it, and somebody rewriting it in C does not have to
stick to the same name.

What may deserve to be documented in Documentation/technical/
somewhere is the way how some shell variables (OPTIONS_SPEC,
OPTIONS_KEEPDASHDASH, LONG_USAGE, USAGE, GIT_REFLOG_ACTION, etc.)
are used in git-sh-setup, which is a collection of helper shell
functions for use in scripted Porcelains that dot-source it.  It
allows the scripted Porcelains to say things like:

	die "message"
        say "message"

and the latter pays attention to GIT_QUIET.

> This raises a few more generall questions:
> do we already pass information between processes(!) with enviroment
> variables? And is this documented the way it should be?

There are a few used as implementation details, I think.  GIT_QUIET
is not among them.
