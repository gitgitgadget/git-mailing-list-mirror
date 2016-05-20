From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/9] connect: only match the host with core.gitProxy
Date: Fri, 20 May 2016 14:48:28 -0700
Message-ID: <xmqqbn40cser.fsf@gitster.mtv.corp.google.com>
References: <20160517013554.22578-1-mh@glandium.org>
	<20160517013554.22578-3-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tboegi@web.de
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri May 20 23:48:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3sHc-0004Ba-Kr
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 23:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbcETVsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 17:48:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751153AbcETVsc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 17:48:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E6451E171;
	Fri, 20 May 2016 17:48:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LOQiBKcEfugwyVvQWSRL5hsk6PI=; b=DIREg4
	71niT7jK/FOeN09M0uOxihZsW6SXIKOFe7UcPpr5aiAdAd79TajOWY0E8Ll0dGro
	Lx8nCkA6kTJjynmbScw95h5eXlt+RWzqKzsmh20wR8cAOVyVhhD+kNFcxQWbQPu7
	qMbmKM5//YdVR6VFt3rggT0OyaQkepM6UfMys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VLrUF/BB8HHi8m8CE7PHKsQ+pC4T0+o/
	S6rLBZzdu3k3FItvmNW7Jd4e2t+PU/1mpyVNdS3hpXUErthZDfcjwCNWxOE8BSzM
	h5ZiDKUElcNrhUdK+azYoPJHzBZzk5F5TiQ1j5G+OqgotY/r6F7Z8alGNgG9Iaey
	7O36SKMU6ZA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 83E631E170;
	Fri, 20 May 2016 17:48:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 04ADD1E16B;
	Fri, 20 May 2016 17:48:29 -0400 (EDT)
In-Reply-To: <20160517013554.22578-3-mh@glandium.org> (Mike Hommey's message
	of "Tue, 17 May 2016 10:35:47 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 973813A6-1ED4-11E6-914B-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295211>

Mike Hommey <mh@glandium.org> writes:

> Currently, core.gitProxy doesn't actually match purely on domain names
> as documented: it also matches ports.
>
> So a core.gitProxy value like "script for kernel.org" doesn't make the
> script called for an url like git://kernel.org:port/path, while it is
> called for git://kernel.org/path.

Let's recap.  When you are accessing "git://kernel.org:9418/path"

 - "script1 for kernel.org" does not match, which may be
   counter-intuitive;

 - "script2 for kernel.org:9418" matches and gets used.

Isn't that what the current code does?  If so, I suspect that
allowing the first one to match may be an improvement with slight
backward incompatibility that we agreed that we do not mind.

	Note for those other than Mike: The reason why we do not
	care about the breakage of the backward compatibility is
	because it would only matter when you configured both
	"script1 for kernel.org" and "script2 for kernel.org:9418",
	so that URL can be used to differenciate which proxy script
	to use.  In such a configuration, we used to call script2,
	but "fixing" it would make it call script1.  Given that the
	proxy script takes the port number as its parameter, this
	can be worked around easily by introducing a new script0
	that switches between script1 and script2 based on the port
	number parameter.  IOW, we accept the compatibility breakage
	because adjusting is easy.

We of course need to warn the user if we do this.  That is

 - If the URL we access has :<port>, and we apply <host>-only
   core.gitProxy entry to it, and

 - If the user has core.gitProxy entry for <host>:<port>,

we definitely need to warn so that the user is told that the "easy
adjustment" is necessary.

Thinking aloud a bit more, if the user has "script1 for kernel.org"
without "script2 for kernel.org:9418", and relied on the fact that
having :9418 that is not necessary (as it is the default port) in
the URL lets her bypass the proxy script, the user also needs to be
told that we have changed the rule of the game and her configuration
needs to be updated.  So the above condition to warn would need to
be loosened, i.e. "if the URL being accessed has :<port>, and if we
apply gitProxy specified with only <host>" we need to warn.

A proper transition plan is necessary; if the long term ideal is to
use "script1 for kernel.org" for "git://kernel.org:9418/path", we do
not want to keep giving this warning forever.

And if we need a transition plan _anyway_, we probably should have a
period during which those who have been relying on the fact that
"script2 for kernel.org:9418" was a supported way to specify proxy
for "git://kernel.org:9418/path" would get a warning but will still
use "script2 for kernel.org:9418" as a valid core.gitProxy
specification.

> This per-port behavior seems like an oversight rather than a deliberate
> choice, so, make git://kernel.org:port/path call the gitProxy script in
> the case described above.

So, even if we agree that per-port behaviour is not something we
would use if we were building the system without any existing users
today, I do not think we want "git now fails with an error" at all.
It goes against the approach Git takes to give smooth transtion to
users when we must break backward compatibility.

> However, if people have been relying on this behavior, git now fails
> with an error message inviting for a configuration change.
