From: Jeff King <peff@peff.net>
Subject: Re: git reset --hard w/o touching every file
Date: Sun, 2 Nov 2008 01:52:12 -0400
Message-ID: <20081102055212.GG5261@coredump.intra.peff.net>
References: <gegn38$lku$1@ger.gmane.org> <20081101110529.GC3819@artemis.corp> <geicn8$ss8$1@ger.gmane.org> <20081102033313.GB4936@coredump.intra.peff.net> <gejanr$os$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 06:53:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwVty-0003PO-2F
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 06:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbYKBFwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 01:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbYKBFwQ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 01:52:16 -0400
Received: from peff.net ([208.65.91.99]:4537 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbYKBFwP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 01:52:15 -0400
Received: (qmail 22865 invoked by uid 111); 2 Nov 2008 05:52:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Nov 2008 01:52:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Nov 2008 01:52:12 -0400
Content-Disposition: inline
In-Reply-To: <gejanr$os$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99815>

On Sun, Nov 02, 2008 at 12:36:09AM -0400, Edward Z. Yang wrote:

> I'm using a script to automatically update a website with the contents
> of a Git repository at a specified interval. While I could use git pull,
> I've been told that it's safer to do a git fetch, and then a git reset
> --hard remotes/master, because the former could trigger a merge and on a
> live website that is NOT desirable.

Well, there will never be a merge if you aren't making local changes
(and your upstream is not doing silly things like rewinding the history of
what it gives you). But if you aren't making local changes, then doing a
reset is "safe" in the sense that you will have nothing to throw away.

> Unfortunately, since Git touches all files on a reset --hard, it's
> causing problems with the smart cache system, which checks whether or
> not the cache file is older than the source file, and regenerating if
> it is.

Ah, OK. I see what you want.

Git usually tries very hard not to touch files that don't need to be
touched. So that sounds like a bug. However, I can't reproduce it with
this test case:

    mkdir repo && cd repo && git init &&
    touch a b && git add a b && git commit -m added &&
    echo changes >a && git commit -a -m 'changed a' &&
    touch -d 1979-10-12 a b && echo before reset && ls -l a b &&
    git update-index --refresh &&
    git reset --hard HEAD^ && echo after reset && ls -l a b

I end up with:

    before reset
    -rw-r--r-- 1 peff peff 8 1979-10-12 00:00 a
    -rw-r--r-- 1 peff peff 0 1979-10-12 00:00 b
    HEAD is now at d7fd84e added
    after reset
    -rw-r--r-- 1 peff peff 0 2008-11-02 01:46 a
    -rw-r--r-- 1 peff peff 0 1979-10-12 00:00 b

which makes sense. The only tricky thing is the "update-index --refresh"
call, which basically tells git "update your cache with the new mtime
value", which is necessary because of the contrived use of "touch". But
if you are manipulating these files only through "git reset", it should
Just Work.

-Peff
