From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/16] remote: remove dead code in read_branches_file()
Date: Fri, 21 Jun 2013 15:26:48 -0700
Message-ID: <7v1u7vkslz.fsf@alter.siamese.dyndns.org>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
	<1371813160-4200-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 00:26:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq9nD-0008G3-LT
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 00:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422959Ab3FUW0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 18:26:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44005 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161490Ab3FUW0v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 18:26:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0680B2AB78;
	Fri, 21 Jun 2013 22:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TGtX2QN1PEa+mc1do8y13L7Ei5Q=; b=oQLv51
	TJQ56lEMJg338HT7i0RyAUuR3FA8Emlf9zYjPvyw88WkDTuGjbywuaC49Xbes/m8
	xmLwmpUlJPG2ZdElfPK7+MGISD6xbE+RG4+M2deblMINLh6gdWP0bveEPtoh24K5
	IY/yrNOcmdZsnYte7CdV7MS/gdvO6A3f13jWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BwEeChqfOM5JEJIrYhg0bqa1hwcSMG+m
	CXCWDC0vVMbjC8M5GlEpZJu3xnR1ATcVO2VuLU5M+IXUauDWMBd8fr4y7PoDuddn
	TIo7OD+ojUc09hw3ZYnG0Ms0Vq+o7JodtqP/FCcPRVF6rhaDBNqy95iA7bRO3OEV
	BOyuwdH2iVA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEB802AB77;
	Fri, 21 Jun 2013 22:26:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FAD32AB76;
	Fri, 21 Jun 2013 22:26:50 +0000 (UTC)
In-Reply-To: <1371813160-4200-6-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 21 Jun 2013 16:42:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AADCA304-DAC1-11E2-9AF0-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228663>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The first line of the function checks that the remote-name contains a
> slash ('/'), and sets the "slash" variable accordingly.  The only caller
> of read_branches_file() is remote_get_1(); the calling codepath is
> guarded by valid_remote_nick(), which checks that the remote does not
> contain a slash.  Therefore, the "slash" variable can never be set:
> remove the dead code that assumes otherwise.

This is extremely interesting.

As far as I can tell, that valid-remote-nick was done in df93e33c
(Validate nicknames of remote branches to prohibit confusing ones,
2008-02-15), and back in that version, the codepath and the feature
that wants to see a slash and do magical things, which is described
by this comment you are removing:

> -	/*
> -	 * With "slash", e.g. "git fetch jgarzik/netdev-2.6" when
> -	 * reading from $GIT_DIR/branches/jgarzik fetches "HEAD" from
> -	 * the partial URL obtained from the branches file plus
> -	 * "/netdev-2.6" and does not store it in any tracking ref.
> -	 * #branch specifier in the file is ignored.

did exist (see "git show df93e33c:remote.c").  It expects to see
"jgarzik/netdev-2.6" in remote->name, grabs the leading "jgarzik"
part to form ".git/branches/jgarzik" to open and read from, and then
appends the remainder "/netdev-2.6" to the "partial URL" it read
to come up with the final URL.

So it appears that back then (and througout to today), nobody uses
that "partial URL" feature which is specific (and was a rather nice
invention/legacy by Cogito) to .git/branches file.

Reminds me of the strategy to deprecate functionality in X (cf. 
http://lwn.net/Articles/536520/) ;-)
