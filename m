From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC][PATCH] Allow transfer of any valid sha1
Date: Wed, 24 May 2006 02:07:13 -0700
Message-ID: <7vejyjpz9a.fsf@assigned-by-dhcp.cox.net>
References: <m164jvj1x3.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 24 11:07:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FipKs-0007RB-OV
	for gcvg-git@gmane.org; Wed, 24 May 2006 11:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWEXJHQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 05:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbWEXJHQ
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 05:07:16 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:52143 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932175AbWEXJHO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 05:07:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060524090714.TNJI15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 May 2006 05:07:14 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m164jvj1x3.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Wed, 24 May 2006 01:51:36 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20674>

ebiederm@xmission.com (Eric W. Biederman) writes:

> Can we fix the check in upload-pack.c something like my
> patch below does?  Are there any security implications for
> doing that?

> Could we just make the final check before dying if (!o) ?

The primary implication is about correctness, so I am reluctant
to break it without a careful alternative check in place.

The issue is that having a single object in the repository does
not guarantee that you have everything reachable from it, and we
need that guarantee.  Reachability from the refs is what
guarantees that.

We are careful to update the ref at the very end of the transfer
(fetch/clone or push); so if an object is reachable from a ref,
then all the objects reachable from that object are available in
the repository.

Imagine http commit walker started fetching tip of upstream into
your repository and you interrupted the transfer.  Objects near
the tip of the upstream history are available after such an
interrupted transfer.  But a bit older history (but still later
than what we had before we started the transfer) are not.

We do not update the ref with the downloaded tip object, so that
we would not break the guarantee.  This guarantee is needed for
feeding clients from the repository later.  If you tell your
clients, after such an interrupted transfer, that you are
willing to serve the objects near the (new) tip, the clients may
rightfully request objects that are reachable from these
objects, some of them you do _not_ have!

So this "on demand SHA1" stuff needs to be solved by checking if
the given object is reachable from our refs in upload-pack,
instead of the current check to see if the given object is
pointed by our refs.  When upload-pack can prove that the object
is reachable from one of the refs, it is OK to use it; otherwise
you should not.

Now, proving that a given SHA1 is the name of an object that
exists in the repository is cheap (has_sha1_file()), but proving
that the object is reachable from some of our refs can become
quite expensive.  That gives this issue a security implication
as well -- you can easily DoS the git-daemon that way, for
example.
