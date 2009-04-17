From: Jeff King <peff@peff.net>
Subject: Re: git for local web development
Date: Fri, 17 Apr 2009 14:30:46 -0400
Message-ID: <20090417183046.GB30240@coredump.intra.peff.net>
References: <135754252540163221910297561025355826788-Webmail@me.com> <20090417115925.GB29121@coredump.intra.peff.net> <loom.20090417T153819-898@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: William DiNoia <william.dinoia@mac.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 20:32:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LusrV-0005N4-R7
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 20:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855AbZDQSaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 14:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755657AbZDQSaz
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 14:30:55 -0400
Received: from peff.net ([208.65.91.99]:39001 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755528AbZDQSay (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 14:30:54 -0400
Received: (qmail 18583 invoked by uid 107); 17 Apr 2009 18:30:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 17 Apr 2009 14:30:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Apr 2009 14:30:46 -0400
Content-Disposition: inline
In-Reply-To: <loom.20090417T153819-898@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116766>

On Fri, Apr 17, 2009 at 03:44:43PM +0000, William DiNoia wrote:

> I have since switched to using the post-update hook which now looks like:
> 
> git-checkout -f
> exec git-update-server-info

That will ignore any error code from git-checkout; you probably want

  git checkout -f && git update-server-info

> However upon git-push from /home/william/Desktop I receive the following:
> 
> Counting objects: 5, done.
> Compressing objects: 100% (2/2), done.
> Writing objects: 100% (3/3), 281 bytes, done.
> Total 3 (delta 1), reused 0 (delta 0)
> Unpacking objects: 100% (3/3), done.
> To /var/www/sites/test.com/.git
>    e337c9b..581228f  master -> master
> error: unable to unlink old 'index.html' (Permission denied)

So this is the same error as before, because it is coming from the
"git-checkout -f" invocation.

> The repo is owned by "www-data" and I am pushing as user "william". "william"
> is in the "www-data" group. I also ran
> 
> git-config core.sharedrepository group
> 
> as "www-data", but no change...

The error is in the permissions of the working tree that already exists.
core.sharedrepository is about the settings that git uses for files within
$GIT_DIR. The working tree files that already exist are not changed.

I suspect if you "ls -ld /var/www/sites/test.com" you will see that it
does not have group write permissions.  If that is the case, it is
probably simplest to just add group write permissions to the whole
tree:

  find /var/www/sites/test.com -name .git -prune -o -print0 |
    xargs -0 chmod g+w

I don't recall offhand whether newly created files in the working tree
will have the group and permissions set according to
core.sharedrepository (I think sharedrepository is usually about users
sharing a common repo for pushing into).

If you are just going to push as "william", is there a reason that the
repo and working tree are not owned by "william"? As long as www-data,
presumably the webserver could still serve it.

-Peff
