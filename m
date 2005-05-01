From: Junio C Hamano <junkio@cox.net>
Subject: Re: update-cache ./test.c
Date: Sun, 01 May 2005 03:31:11 -0700
Message-ID: <7v64y3z18w.fsf@assigned-by-dhcp.cox.net>
References: <20050501084145.GA30692@xi.wantstofly.org>
	<20050501084710.GJ26663@cip.informatik.uni-erlangen.de>
	<20050501085427.GB30692@xi.wantstofly.org>
	<20050501085922.GC30692@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 12:25:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSBdr-0005R7-Nj
	for gcvg-git@gmane.org; Sun, 01 May 2005 12:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVEAKb3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 06:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVEAKb3
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 06:31:29 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:1200 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261586AbVEAKbO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 06:31:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050501103113.DMVX8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 06:31:13 -0400
To: Lennert Buytenhek <buytenh@wantstofly.org>
In-Reply-To: <20050501085922.GC30692@xi.wantstofly.org> (Lennert Buytenhek's
 message of "Sun, 1 May 2005 10:59:22 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LB" == Lennert Buytenhek <buytenh@wantstofly.org> writes:

LB> Something like this:

LB> --- git/update-cache.c.orig	2005-05-01 10:56:17.859313581 +0200
LB> +++ git/update-cache.c	2005-05-01 10:57:31.634897508 +0200
LB> @@ -328,6 +328,7 @@
LB> -		if (!verify_path(path)) {
LB> +		_path = path;
LB> +		if (!strncmp(_path, "./", 2))
LB> +			_path += 2;
LB> +		if (!verify_path(_path)) {

Once you start doing ./ specially, you would be tempted to
handle foo/../bar/../../baz, which would lead to complexity
Linus did not want in the Core GIT layer.  Please do not pursue
this path again.

I once advocated that the path we get from the user should be
treated relative to the working directory on the filesystem and
not relative to the cache entry root as the current Core GIT
layer does (see archive).  With some clever scripting this
inconvenience can be hidden by the Porcelain layer without much
difficulty [*1*] and that was the reason behind the decision by
Linus to keep paths Plumbing layer gets relative to the cache.

I do not know Cogito already can do this, but you should be able
to do something like:

    $ cd linux-2.6
    $ ls -a
    ./  ../  .git/ fs/ mm/ Makefile ...
    $ cd fs
    $ xx-update-cache Makefile ../Makefile ext3/Makefile
    $ xx-diff-files Makefile ../Makefile ext3/Makefile

where xx-* are what the Porcelain layer would provide the end
user with.


[Footnotes]
*1* (PLUG) An implementation of my little SCM on top of GIT is
found at <http://members.cox.net/junkio/>   I've been using it
to manage the patches I feed Linus on the plumbing side.


