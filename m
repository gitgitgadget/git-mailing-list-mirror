From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Authenticate push via PGP signature, not SSH
Date: Mon, 28 Jan 2008 23:10:00 -0500
Message-ID: <20080129041000.GK24004@spearce.org>
References: <479D5611.4010205@vilain.net> <20080128081258.GE24004@spearce.org> <479E5021.7010404@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>, Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jan 29 05:10:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJhnz-00008G-U4
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 05:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499AbYA2EKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 23:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755435AbYA2EKH
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 23:10:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54090 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754869AbYA2EKF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 23:10:05 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JJhnD-0005z5-20; Mon, 28 Jan 2008 23:09:51 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6324920FBAE; Mon, 28 Jan 2008 23:10:01 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <479E5021.7010404@vilain.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71945>

Sam Vilain <sam@vilain.net> wrote:
> This could support fully distributed access control over the namespaces.
>   What it means for access control to be distributed is that any node
> can check the log of tags that granted permission to people, and
> assuming that they processed the same grants in the same order they will
> arrive at the same access control result.
> 
> To describe this with an example, say Linus decides that Junio can push
> to any ref on the project, he can note in a tag;
> 
>   "From this release forward, Junio Hamano <KEYID> will be authorized to
>    push to any reference, and grant access to others under the reference
>    space 'refs/heads/topics/'".
> 
> The ACL state could be a branch in a funny refspace with a directory for
> the keyring, and a place to keep copies of any tags it removed because
> they were there just for the push.
> 
> And yes, it would need a simple interface.

After some thought today about your message above and Pierre's about
the Debian package maintainers have gotten me into thinking that
we really should just support PGP signature verification as part
of send-pack/receive-pack, making it reasonably safe to expose an
open git-daemon over TCP/IP, complete with receive-pack enabled.

My attempt to use UNIX authentication over a domain socket was
probably stupid.  Good thing there are smarter people than I
on this list, and even better that they decided to join in the
conversation.  :)

Here's (I hope) a short outline of what I was thinking:

* New protocol extension to send-pack/receive-pack pair:

  If server wants to require (or optionally) accept a signed push
  event it sends a new capability string when it advertises its
  current known heads:

    auth-1=[0-9a-f]{40}

  The actual length and data value is mostly irrelevant to this
  discussion, but the data is a nonce for this single connection
  between send-pack and receive-pack.  It needs to come from a
  reasonably good PRNG.

  If send-pack then wants to upload one or more refs:

  Send back the capability "auth-1" as part of the first ref
  being pushed.  Note we skip the nonce in the capablity request.
  Send all ref update commands using current protocol.

  Generate a SHA-1 around the following:

    <nonce><command>+<auth>

    command  ::= <old_sha1> <new_sha1> <op> <ref> '\0'
    old_sha1 ::= 20 byte binary string
    new_sha1 ::= 20 byte binary string
    op       ::= ' ' | '+'
    ref      ::= ref name

  Send another pkt-line before the flush containing the user
  identity and the PGP signature for the hash from the above:

    <auth><pgp_sig>

    auth    ::= 'auth' ' ' <name> ' ' '<' <email> '>' '\n'
    name    ::= like a commit author-name
    email   ::= like a commit author-email
    pgp_sig ::= armored signature from PGP

  receive-pack expects this new auth pkt-line if the client asked
  to enable the auth-1 capablity in the first command.

  If receive-pack was configured (say by config receive.auth)
  to require authentication then it closes the connection if the
  client didn't request the capablity in the first command.

  receive-pack can generate the same SHA-1 hash from the commands
  it read from send-pack, and can verify the PGP signature on the
  auth line.

  This assures us the command stream wasn't modified, and likely
  originated from the named identity.  The rest of the packfile
  data is already well protected by its own SHA-1 footer and the
  individual object SHA-1s, and the roots pointing into that DAG
  (or sub-DAG) mentioned in the commands were verified by the PGP
  signature of them.

  Push isn't that common, but this extension format doesn't require
  any additional round-trips between the two peers, so latency
  doesn't change.  Which I guess is nice.

  It also avoids the relatively ugly part of having a dummy tag
  involved in the transfer and shoved into the ref namespace for
  a short period of time.


* receive-hook validations:

  If we got an auth line above then we export the <name> and
  <email> values into a pair of new environment variables:

    GIT_PUSHER_NAME=<name>
    GIT_PUSHER_EMAIL=<email>

  thus exposing the who down to any hooks we might execute, in
  particular the pre-receive and the update hooks, as tools like
  contrib/hooks/update-paranoid and gitosis can then base their
  per-ref access decisions off these.


* PGP public key storage:

  Use a "hidden" ref called "refs/access-keys" to store a commit.
  The access control change log is a normal Git commit chain.

  The tree under this commit stores a file per <email> string.
  Public keys for auth line validation are located by <email>,
  from the tip of this branch.

  This branch could be a symlink to another repository (e.g.
  a site-wide "admin" repository) and the ODB for that other
  repository could be an alternate for this repository.


* ref/access-keys security:

  Probably an update or pre-receive hook could verify pushes
  to this branch by something like this:

    - If the only difference between $old_sha1 $new_sha1 is
      a modification of $GIT_PUSHER_EMAIL then allow it
      (user is replacing their own key);

    - If the only difference between $old_sha1 $new_sha1 is
      modifications of names other than $GIT_PUSHER_EMAIL but
      the file content differences are only $GIT_PUSHER_EMAIL
      signing those public keys then allow it (the user doing
      the push is publishing some trust);

    - If the difference between $old_sha1 $new_sha1 is new
      keys added or existing keys removed then allow it only
      if $GIT_PUSHER_EMAIL is also listed inside of the
      "admin/" subtree and the new key is also signed by
      $GIT_PUSHER_EMAIL's key.


But here's where things start to get funny.

On a site like repo.or.cz the idea of being able to create your
own unique subnamespace by pushing your key at the server is
simple enough, and actually sorta cool.

But in my central repository layout at day-job I don't want people
forking.  Instead I want them to stay within their pre-assigned
namespace of the single common repository.  So the access control
rules being applied start to really head in lots of different
directions at this point.

-- 
Shawn.
