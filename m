From: Junio C Hamano <gitster@pobox.com>
Subject: Re: URL Syntax Question
Date: Mon, 31 Mar 2008 23:11:39 -0700
Message-ID: <7vej9qgl44.fsf@gitster.siamese.dyndns.org>
References: <E1JgUp6-0002Sc-Ts@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Loeliger <jdl@jdl.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 08:12:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgZjS-0005fP-1G
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 08:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbYDAGLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 02:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbYDAGLr
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 02:11:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbYDAGLq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 02:11:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 81A4D165A;
	Tue,  1 Apr 2008 02:11:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B1B081659; Tue,  1 Apr 2008 02:11:41 -0400 (EDT)
In-Reply-To: <E1JgUp6-0002Sc-Ts@jdl.com> (Jon Loeliger's message of "Mon, 31
 Mar 2008 19:58:00 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78634>

Jon Loeliger <jdl@jdl.com> writes:

> On, for example, the git-clone man page, the stated URLs
> that are supported include these:
>
>     git://host.xz/path/to/repo.git/
>     git://host.xz/~user/path/to/repo.git/
> and:
>     ssh://[user@]host.xz[:port]/path/to/repo.git/
>     ssh://[user@]host.xz/path/to/repo.git/
>     ssh://[user@]host.xz/~user/path/to/repo.git/
>     ssh://[user@]host.xz/~/path/to/repo.git
> and:
>     rsync://host.xz/path/to/repo.git/
>
> In the first set, is the non-specified user form also supported?
> That is, this form:
>
>     git://host.xz/~/path/to/repo.git/

Because git-daemon protocol does not authenticate, ~/ cannot mean "home
for connecting user".  It appears that the "user_path" modification made
long time ago to daemon.c in 603968d (daemon: extend user-relative path
notation., 2006-02-04) was sloppily done and does not check and error out
for this case, but I think it should.

The ~user syntax depends on the daemon side running with --user-path
option; otherwise it won't be accepted.

> In the second set, is it fair to generalize and say
> that they could all be respresented as this:
>
>     ssh://[user1@]host.xz[:port]/[~[user2]/]path/to/repo.git/

We interpret [:port] part in order to add "-p port" parameter to the
command line we invoke "ssh" with; "[user1@]host.xz" part is handled by
the underlying "ssh".

The command line we pass to the "ssh" to run on the remote side is either
"upload-pack /path/to/repo.git" or "upload-pack ~[user2]/path/to/repo.git/";
I suspect how it is handled depends on the shell that run on the remote
end.

Personally, I'd prefer the scp syntax, which tends to be shorter and
sweeter, though:

	host.xz:path/in/my/home/directory/repo.git
        host.xz:/absolute/path/to/repo.git

> Lastly, how long before the deprecated and third class citizen,
> rsync, is actually _removed_?  Or will it linger for all time?
> Any plans in the works there?

I haven't heard of any concrete plans, but it might not be a bad idea to
declare for removal at 2.0.0.  rsync is really the last-ditch protocol,
and even after we stop supporting it natively, the user can still:

	cp -lr repo.git local-copy.git ;# prime with what we have
	rsync -r host.xz/path/to/repo.git local-copy.git

and then use the local-copy.git as if it is the remote one.
