From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-svn failure when symlink added in svn
Date: Sun, 15 Apr 2007 20:13:35 -0700
Message-ID: <m2slb1c8ps.fsf@fhcrc.org>
References: <m2647zh2zc.fsf@gmail.com> <20070414201003.GA28389@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 05:40:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdI4e-0007dn-7y
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 05:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbXDPDkL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 23:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754412AbXDPDkL
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 23:40:11 -0400
Received: from MAZZITE.FHCRC.ORG ([140.107.152.11]:39275 "EHLO
	mazzite.fhcrc.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbXDPDkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 23:40:09 -0400
X-Greylist: delayed 1610 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Apr 2007 23:40:09 EDT
Received: from mica.fhcrc.org (MICA.FHCRC.ORG [140.107.152.12])
	by mazzite.fhcrc.org (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id l3G3Dx0l011235
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Sun, 15 Apr 2007 20:14:00 -0700
Received: from jade.fhcrc.org (JADE.FHCRC.ORG [140.107.42.223])
	by mica.fhcrc.org (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id l3G3D921017698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 15 Apr 2007 20:13:14 -0700
Received: from ziti (DORMOUSE.FHCRC.ORG [140.107.170.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jade.fhcrc.org (Postfix) with ESMTP id BE8D6E7EA;
	Sun, 15 Apr 2007 20:13:09 -0700 (PDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
X-PMX-Version: 5.3.1.294258, Antispam-Engine: 2.5.1.298604, Antispam-Data: 2007.4.15.200434
X-PMX-Version: 5.3.1.294258, Antispam-Engine: 2.5.1.298604, Antispam-Data: 2007.4.15.200035
X-FHCRC-SCANNED: Sun Apr 15 20:13:18 2007
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44566>

Eric Wong <normalperson@yhbt.net> writes:
> I can't reproduce it on Linux with ext3.  I translated your recipe into
> a test script in the patch below.  Anybody familiar with OSX and/or HFS
> know if there's a workaround or fix for this?

Thanks for sending the test case.  It doesn't properly fail for me on
OSX, but if I run it with -v then I do see the error (so it is failing
on OSX and, as you found, not on Linux).

I added a silly print statement to see the symlink args:

diff --git a/entry.c b/entry.c
index d72f811..70f6402 100644
--- a/entry.c
+++ b/entry.c
@@ -129,6 +129,7 @@ static int write_entry(struct cache_entry *ce, char *path, struct checkout *stat
                                return error("git-checkout-index: unable to write file %s",
                                        path);
                } else {
+                        fprintf(stderr, "symlink: '%s' => '%s'\n", path, new);
                        wrote = symlink(new, path);
                        free(new);
                        if (wrote)

And so then on Linux with -v I get (after snipping most of the
output):

   * expecting success: 
           cd git &&
                   git svn rebase
                   cd ..
   
           A       bar.txt
   r2 = 31e734669e3fe4dbbd375e5a9f5af828a5b7ba92 (git-svn)
           D       foo.txt
   r3 = bd3b318730e8efc77235976abb18d04bc927bf9e (git-svn)
           A       foo.txt
   r4 = 2376eedcfec1de7cbe69b2bbad1c5de231a0ed0d (git-svn)
   First, rewinding head to replay your work on top of it...
   symlink: 'foo.txt' => 'bar.txt'
   HEAD is now at 2376eed... add foo as symlink
   Fast-forwarded master to refs/remotes/git-svn.
   *   ok 4: rebase in git-svn
   
   * passed all 4 test(s)

On my OSX laptop I get:

   * expecting success: 
           cd git &&
                   git svn rebase
                   cd ..
   
           A       bar.txt
   r2 = 4964f302b94ede0301b33faf5f4242c4bab3108b (git-svn)
           D       foo.txt
   r3 = 178a9ff3c7013d4ad8ec7defa93b91a1080c1e53 (git-svn)
           A       foo.txt
   r4 = 9f0bc38df8113fe1e11e47b708589d82bfa035a0 (git-svn)
   First, rewinding head to replay your work on top of it...
   symlink: 'foo.txt' => ''
   error: git-checkout-index: unable to create symlink foo.txt (Invalid argument)
   HEAD is now at 9f0bc38... add foo as symlink
   Fast-forwarded master to refs/remotes/git-svn.
   *   ok 4: rebase in git-svn
   
   * passed all 4 test(s)

If you're still with me, the curious part is what the symlink call is
trying to do.

  Linux:    symlink: 'foo.txt' => 'bar.txt'
    OSX:    symlink: 'foo.txt' => ''

So it looks like the problem is some sort of off-by-one that happens
well before the symlink call.  Perhaps this is enough for someone more
knowledgable than me to have a clue where to look next?

+ seth
