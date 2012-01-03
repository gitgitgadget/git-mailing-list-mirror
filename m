From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] expanded hook api with stdio support
Date: Tue, 03 Jan 2012 11:53:22 -0800
Message-ID: <7vsjjwtvf1.fsf@alter.siamese.dyndns.org>
References: <1325207240-22622-1-git-send-email-joey@kitenet.net>
 <1325207240-22622-2-git-send-email-joey@kitenet.net>
 <4EFD88CB.3050403@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jan 03 20:53:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiAQM-0005Oo-Qq
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 20:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754663Ab2ACTx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 14:53:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35290 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754438Ab2ACTxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 14:53:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AF215D48;
	Tue,  3 Jan 2012 14:53:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c4MR4lCCRu5p09yRXh9rMtUZs9o=; b=IQuvqH
	8zOH4qBwaz6Rr8/8pzAWNwNgy9AkrOeabeS5DJGRn5yAbH5xlVQiNWzOB4S73UVZ
	I3F1TgtyPP6Q4oXbhgsqEX7KNG8nGPJIm7mrQb2CkQziWuQI0ZgF+w8kF39/4egg
	2vGgQ2vvLfGIi4tZQKjG3mpr3wMKpHFxZY1bg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WGUbiYaVyTXHrTCCHF74leiCD59F5kvO
	d60mZ6/HQpFvwfqi/TPD2CF9KKW7ANzg4eDN/vX+hV21WkfNizxv7bIoQNs81neO
	lY3khI0S17zSmBlByvz5Fo1e6U0ChESXWRoC2BgcZ6weIEZlrahsTtn7zEm0QeJf
	XC6fDa23seA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 901055D47;
	Tue,  3 Jan 2012 14:53:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25EBB5D46; Tue,  3 Jan 2012
 14:53:24 -0500 (EST)
In-Reply-To: <4EFD88CB.3050403@kdbg.org> (Johannes Sixt's message of "Fri, 30
 Dec 2011 10:47:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 987A7100-3644-11E1-9753-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187883>

Johannes Sixt <j6t@kdbg.org> writes:

> IMO, as the first step, the user of this infrastructure should only be
> required to construct the hook input as a strbuf, and receive the hook
> output, if needed, also as a strbuf.

Now you brought it up, I think I would agree. The only reason I suggested
a callback feeder approach was because I somehow was hoping that it may be
possible to share more code with the codepath for textconv that may not
want to hold too much buffer in core when we know the data is only used
sequencially and I wanted to see more things to go through streaming API
in the future.

>> +`run_hook_complex`::

Also, I think the updated interface should become the "run_hook" function;
nothing "complex" about it. The name "run_hook()" was a perfectly fine
abstraction for what it did when it used to be a static helper function
within builtin-commit.c, but its special-casing of GIT_INDEX_FILE
environment is _not_ general enough to deserve it to be called the
"run_hook" in the global scope.

IOW, I am saying that we screwed up at ae98a00 (Move run_hook() from
builtin-commit.c into run-command.c (libgit), 2009-01-16.

The environment tweaking should not take a "index_file" field in the
structure, but an array "environ" that is used to tweak the environment
variables for the hook process.
