From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Enhancements to git-protocoll
Date: Sat, 28 Jul 2012 23:58:09 -0700
Message-ID: <7vehnvvyta.fsf@alter.siamese.dyndns.org>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 08:58:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvNSp-0002nI-7w
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 08:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547Ab2G2G6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 02:58:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64108 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475Ab2G2G6M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 02:58:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19098631D;
	Sun, 29 Jul 2012 02:58:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hS4PzFhsX9ZM2GcFsD46eYJs/QU=; b=aBOJiU
	S+nxgNfkPGYMpoZ3eOfwLh28NS8rFrjCLMjbJBHuZy8BOReuVgYtBGR89rgUEZyB
	0yMuO0gIUfBI7IBkqsmD5JotySalgvany5MLb9zTp1lggT+lHsydba6KxgTC9cGL
	06H2QFiarjqXTkeKbwi4MbOs1JZNZIep0Cl5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xwmuTrC2dj1gvil+aDa3gxzXXVosr4ZS
	jYZNuY5MvfXZulrOLFXxKhb1/eignoNVH3ijTvg5PvX68/oMO6IUZA21vKGbYTiL
	Dgi8eZ7P3qez7VoxbrrKSa2YSoL+JuF3T1+uGwgtDZbCyl1WkLl3OoSaqXPQKnPV
	didH5aj5q/o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06FCC631C;
	Sun, 29 Jul 2012 02:58:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62BA3631B; Sun, 29 Jul 2012
 02:58:11 -0400 (EDT)
In-Reply-To: <20120728214116.GA3591@paksenarrion.iveqy.com> (Fredrik
 Gustafsson's message of "Sat, 28 Jul 2012 23:41:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2A3470A-D94A-11E1-9D05-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202473>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> Sometimes the server wants to communicate directly to the git user.
> ...
> For example:
> gitolite has something called wild repos[1]. The management is
> cumbersome and if you misspell when you clone a repo you might instead
> create a new repo.
>
> This could have been avoided with a simply:
> "Do you want to create a new repo[Yn]"

I do not think the automatic repository creation done by gitolite is
a good use case or example for whatever you seem to be advocating.

IIUC, the auto-creation in gitolite-shell::main() is done way before
gitolite-shell (which is used as a login shell for incoming ssh
sessions) creates a new git repository, goes into it and spawns the
git-receive-pack command.  It all happens outside Git.

    # auto-create?
    if ( repo_missing($repo) and access( $repo, $user, '^C', 'any' ) !~ /DENIED/ ) {
        require Gitolite::Conf::Store;
        Gitolite::Conf::Store->import;
        new_wild_repo( $repo, $user, $aa );
        gl_log( 'create', $repo, $user, $aa );
    }

The "access()" we see here is not the Perl builtin access(), but is
a function defined in src/lib/Gitolite/Conf/Load.pm; that would be
the place to allow the incoming ssh session to talk back to the end
user, but at that point there is no Git processing on the server
end.

While I am not fundamentally opposed to adding yet another sideband
channel to the git protocol, I do not think adding user interaction
at random places in the protocol exchange is a viable or useful
approach to implement an enhanced server that works with both
enhanced and vanilla clients (and the same is true for enhanced
client that works with both enhanced and vanilla server).
