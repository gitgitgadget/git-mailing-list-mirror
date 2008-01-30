From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] Authenticate push via PGP signature, not SSH
Date: Wed, 30 Jan 2008 19:29:55 +1300
Message-ID: <47A01963.1030703@vilain.net>
References: <479D5611.4010205@vilain.net> <20080128081258.GE24004@spearce.org> <479E5021.7010404@vilain.net> <20080129041000.GK24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 30 07:30:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK6Sy-0002uD-W2
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 07:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbYA3GaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 01:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbYA3GaE
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 01:30:04 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:60395 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142AbYA3GaB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 01:30:01 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 2B75E21D170; Wed, 30 Jan 2008 19:29:59 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.1.7-deb
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id AD45121D125;
	Wed, 30 Jan 2008 19:29:55 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <20080129041000.GK24004@spearce.org>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72037>

Shawn O. Pearce wrote:
> * New protocol extension to send-pack/receive-pack pair:
> 
>   If server wants to require (or optionally) accept a signed push
>   event it sends a new capability string when it advertises its
>   current known heads:
> 
>     auth-1=[0-9a-f]{40}
  [...]
>     <auth><pgp_sig>
> 
>     auth    ::= 'auth' ' ' <name> ' ' '<' <email> '>' '\n'
>     name    ::= like a commit author-name
>     email   ::= like a commit author-email
>     pgp_sig ::= armored signature from PGP
> 
>   receive-pack expects this new auth pkt-line if the client asked
>   to enable the auth-1 capablity in the first command.
> 
>   If receive-pack was configured (say by config receive.auth)
>   to require authentication then it closes the connection if the
>   client didn't request the capablity in the first command.
> 
>   receive-pack can generate the same SHA-1 hash from the commands
>   it read from send-pack, and can verify the PGP signature on the
>   auth line.
> 
>   This assures us the command stream wasn't modified, and likely
>   originated from the named identity.  The rest of the packfile
>   data is already well protected by its own SHA-1 footer and the
>   individual object SHA-1s, and the roots pointing into that DAG
>   (or sub-DAG) mentioned in the commands were verified by the PGP
>   signature of them.

Ok - but I think if the client is pushing a signed tag to the tagname
listed in the signed body of the tag, that no extra signature should be
necessary.  It's only commits that need the extra information.

And remember, for global replication of the data between untrusted nodes
to be possible, the signatures must be saved somewhere.  I have sketched
a simple design below.

> * PGP public key storage:
> 
>   Use a "hidden" ref called "refs/access-keys" to store a commit.
>   The access control change log is a normal Git commit chain.
> 
>   The tree under this commit stores a file per <email> string.
>   Public keys for auth line validation are located by <email>,
>   from the tip of this branch.
> 
>   This branch could be a symlink to another repository (e.g.
>   a site-wide "admin" repository) and the ODB for that other
>   repository could be an alternate for this repository.
> 
> 
> * ref/access-keys security:
> 
>   Probably an update or pre-receive hook could verify pushes
>   to this branch by something like this:
> 
>     - If the only difference between $old_sha1 $new_sha1 is
>       a modification of $GIT_PUSHER_EMAIL then allow it
>       (user is replacing their own key);
> 
>     - If the only difference between $old_sha1 $new_sha1 is
>       modifications of names other than $GIT_PUSHER_EMAIL but
>       the file content differences are only $GIT_PUSHER_EMAIL
>       signing those public keys then allow it (the user doing
>       the push is publishing some trust);
> 
>     - If the difference between $old_sha1 $new_sha1 is new
>       keys added or existing keys removed then allow it only
>       if $GIT_PUSHER_EMAIL is also listed inside of the
>       "admin/" subtree and the new key is also signed by
>       $GIT_PUSHER_EMAIL's key.

Ok perhaps it is best to wrap all this up in a single state branch, that
has in it:

   access-keys/
     - tree with one key per e-mail address
   access
     - maps reference globs to e-mail addresses permitted to change
       them - with a "+" if the address may rewind the ref
   owners
     - maps reference globs to e-mail addresses permitted to add entries
       to the "access" map above
   signatures/
     - stores any detached signatures.  only the signatures verifying
       updates since the last commit to the access meta-branch need to
       be stored
   packed-refs
     - the new list of references (the refs/access commitid is naturally
       absent or the same as the parent), or just the changed
       references.

You don't necessarily need a new commit on this for every single push,
just once "every so often", and perhaps for safety once for every change
to the access file.

This branch should then be auditable; replicating tools can go and
verify that there have been no unauthorized changes.

Forks don't necessarily need special treatment; they can exist under
refs/forks/foobar/ - similar to the refs/remotes/ namespace, and have
their own independent ACL branches within.

Allowing "grant" permissions to refspaces would need to be handled
specially; you can't simply grant access to change refs/access; the
actual push to refs/access would need inspecting to see if the changed
"access" file comes within the rights of the user that signed the update.

I think this seems about right for a first cut.  Possibly bigger
projects like Debian would like to say that for certain ref spaces,
multiple signatures are required, so that no one PGP key retains
complete control.  But I think these things are easily added as features
on top of this basic infrastructure.

Sound like something worth working towards?
Sam.
