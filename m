From: Junio C Hamano <gitster@pobox.com>
Subject: git@vger.kernel.org
Date: Fri, 27 Jun 2008 15:08:30 -0700
Message-ID: <7viqvupm3l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:10:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM9B-0001Lw-Pr
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761322AbYF0WJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757712AbYF0WJB
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:09:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759400AbYF0WI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:08:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 47352D43F;
	Fri, 27 Jun 2008 18:08:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 16D94D43E; Fri, 27 Jun 2008 18:08:47 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A0FD4B30-4495-11DD-A8A9-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86664>

[jc: trying to resend this message I sent late last night, because vger
did not seem to have relayed it to the list for some unknown reason.]

Some people noticed that they have trouble going to remote site over ssh
transport using 'next' version of git.

A brief git transport primer may be helpful to understand what is going
on.  When you run "git fetch" (and remember, "git pull" runs it before it
runs "git merge") against a remote over ssh transport, it asks the other
side to run "git-upload-pack" program.  We have always used the dashed
form "git-upload-pack" to make this request.  Similarly, "git push" (and
"git send-pack") runs "git-receive-pack" and "git archive --remote" runs
"git-upload-archive" on the other end.

We have promised to move most of the git-$foobar programs out of the end
users' $PATH starting from 1.6.0.  After git-upload-pack moves outside
$PATH, however, asking the shell invoked via ssh on the other and to run
git-upload-pack won't find it, because the program is not found anywhere
on $PATH.  Hence, change to ask for "git upload-pack" is eventually
necessary.  We cannot avoid it.

Now, when the remote side runs pre-1.6.0 software, and the ssh daemon on
it runs a real shell, asking for "git upload-pack" (i.e. dashless form)
does not have any problem.  "git" will be on your $PATH and it always
knows where "git-upload-pack" is found, and it will run the program you
wanted to run just fine.

However, when the remote side does not let you run a real shell, this is
problematic.  For example, your login shell can be set to "git-shell" (git
restricted shell), which refuses to run anything but git-upload-pack,
git-receive-pack, or git-upload-archive.  Specifically, it does not allow
you to run "git" itself with arbitrary arguments.  Asking such a server to
run "git upload-pack" will not work.  gitosis is another example of such a
server.  Both git-shell and gitosis already have patches to prepare them
to accept requests in either forms.

It is still possible to connect to older remote end with new clients, but
you have to explicitly ask for "git-upload-pack" by using --upload-pack=
option when running "git fetch", which is a bit cumbersome.  Hence, we
have to wait before people can update their servers, and then update the
client side to start asking for "git upload-pack" and friends with
dashless form.

The patch to prepare the client side for this was prepared and queued in
"next" a few days ago.  Consider this glitch as a part of proving the
change while in next.  You have a real-world opportunity to make sure that
the workaround to use --upload-pack= actually works with older remote end
and send in success reports ;-)

In other words, Sorry, I screwed up.

I've cut v1.5.4.6 and v1.5.5.5 releases tonight (they are tagged and
pushed out already), both of which contain updates to "git-shell" so that
it accepts both dashed and non-dashed forms, to make it easier for people
to update their servers.  At the same time, the change to the client side
has been reverted from 'next' for now.

Cooking and proving the client side change in next will still be needed,
but we'll postpone it for now.

Also, 1.6.0 will still install git-upload-pack and friends that are needed
on the server side in $(bindir) that is on your $PATH, so that older
clients will still work.

So the timeline will be:

 * Futureproofed "git-shell" and gitosis are released.  People slowly
   start deploying them.  Both old and (unreleased yet) new clients will
   be able to talk to them.

 * 1.6.0 installs git-upload-pack and friends in $(bindir) on your $PATH.
   Both old clients and 1.6.0 clients will ask for git-upload-pack and the
   real shell will still be able to find them.

 * 6 months after 1.6.0 ships, these futureproofed "git-shell" and gitosis
   will be in widespread use and nobody runs older servers anymore.  A
   major release after this happens will change the client to start asking
   for "git upload-pack" (dashless form).

   You would need --upload-pack=git-upload-pack option to talk to ancient
   servers when this happens (and past few days were preview of this).

 * 12 months after that major release ships, these new clients will be in
   widespread use and nobody runs older clients anymore.  A major release
   after this happens will stop installing git-upload-pack and friends in
   $(bindir).

   Older clients (like v1.5.0) would use --upload-pack="git upload-pack"
   to talk to new servers.
