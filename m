X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 15 Dec 2006 00:07:44 +0100
Message-ID: <200612150007.44331.Josef.Weidendorfer@gmx.de>
References: <20061130170625.GH18810@admingilde.org> <e7bda7770612100347j78854d79x547084972ed14e99@mail.gmail.com> <e7bda7770612141327r11368e4dtabe8077e96545040@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 23:31:24 +0000 (UTC)
Cc: "R. Steve McKown" <rsmckown@yahoo.com>,
	"Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1393 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 18:31:07 EST
User-Agent: KMail/1.9.5
In-Reply-To: <e7bda7770612141327r11368e4dtabe8077e96545040@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34438>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv02i-0001i8-Ii for gcvg-git@gmane.org; Fri, 15 Dec
 2006 00:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751916AbWLNXbJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 18:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbWLNXbJ
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 18:31:09 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:54624 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1751916AbWLNXbI (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 18:31:08 -0500
Received: from dhcp-3s-46.lrr.in.tum.de (dhcp-3s-46.lrr.in.tum.de
 [131.159.35.46]) by mail.in.tum.de (Postfix) with ESMTP id 50A752826; Fri, 15
 Dec 2006 00:07:50 +0100 (MET)
To: "Torgil Svensson" <torgil.svensson@gmail.com>
Sender: git-owner@vger.kernel.org

On Thursday 14 December 2006 22:27, Torgil Svensson wrote:
> This example is somewhat complex since the build for lib1.so and the
> header-file might not has gone through the same commit on the lib1
> subproject.  Consider this example:

If you want to track build results for some source,
why would you ever want these builds go out of sync with the source?
As the built files depend on the source (and other things), the
source should be a submodule of the build project.

Hmm... I think I see a problem / wish for submodules here.

With the current submodule proposal, we force submodules to be
subdirectories inside of a supermodule.

Your example has the folling submodule dependence
("X ==> Y" means Y being a submodule of X):

  App     ==>   Lib
   ^             ^
   |             |
 AppBuild ==> LibBuild

If we force submodules to be subdirectories of supermodules,
Lib needlessly will have to appear two times in a checkout of
AppBuild.

However, there is nothing wrong with it. Yet, you perhaps want
the 2 Lib submodules not to go out of sync. This easily
can be done with symlinking the Lib checkouts. As they are submodules,
everything should work fine.

Perhaps an option you want to have is to force a checkout
of AppBuild to make these symlinking itself when it detects
identical submodules links.

Hmmm... the only problem with a symlink is that it can go wrong
when moved. Unfortunately, I do not have a good solution for
this. We can not make UNIX symlinks smart in any way.
Hardlinking directories would be a solution, but that is not
possible.

Another thing:
With normal "$buildroot != $srcroot" environments, the source
can not be a subdirectory of the build directory.
Yet, we want to specify submodule/supermodule relation.
This is difficult to do with a submodule object, as it needs
to appear in trees in the supermodule.

Actually, the best workaround for this is to make Lib a direct
submodule of AppBuild, and specify the relationship of
LibBuild ==> Lib only in AppBuild.

BTW, build project commits probably should not depend on any
history of other build commits.
So you actually want all build commits to be root commits, and
have a tag name which could include the source commit id from
which the build was done. This gives some loose coupling.


> Link: /headers/lib1.h -> <lib1-commit3>/src/lib1.h
> Link: /bin/lib1.so -> <build1-commit>/i386/lib1/lib1.so
> Link: /bin/app1 -> <build1-commit>/i386/app1/app1
> 
> 
> <lib1-commit1>, <lib1-commit2> and <lib1-commit3> should be the same,
> dictated by the app1 project.

I do not see any problem here. Symlinks are stored in the git repository.
As the AppBuild commit depends on App and LibBuild submodule commits, the
symlinks always should be correct.

> Can we enforce this in the modules file 
> or should the different supermodules fix this somehow using
> scripts/hooks?

I do not see any need for an hook. But of course, a checkout hook should
be able to generate files/links. However, IMHO this should be not
done with hooks but with Makefile targets.
 
> How do the super-projects in this case get access to the blobs pointed
> by the links - transparent or explicit in the build-process?

Submodules should automatically be checked out when checking out the
supermodule. So the blobs should already be there.
Or do I miss something?

