From: Willy Tarreau <w@1wt.eu>
Subject: Multiple working trees with GIT ?
Date: Thu, 24 Jan 2008 08:49:52 +0100
Message-ID: <20080124074952.GA8793@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 09:21:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHxKq-0000hm-Rg
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 09:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbYAXIUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 03:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753205AbYAXIUu
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 03:20:50 -0500
Received: from 1wt.eu ([62.212.114.60]:1582 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134AbYAXIUu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 03:20:50 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71606>

Hi all,

I'm having long thoughts about how to use GIT to manage a distro. One of
the aspects which comes very often is the notion of "variant" for a
packaging. For instance, the whole project could consist in a list of packages
with their branches, but this list may vary depending on the platform, the
medium, etc... I was searching how to propagate common changes withing variants
with the least hassle.

I figured out that having one file list per variant will be very annoying. In
another project, that's already what I have and frankly, applying the same
change to 10 files is counter-productive. Since the lists will often be the
sames except for a few entries, and since most updates will be relevant to
all variants, I thought branches will be my best friends.

But I would like to be able to always access file lists, without having to
constantly git-checkout <variant-X>.

Finally, I found a very convenient solution, but I don't know if there are
any risks using it. If we can conclude to a riskless usage (with/without
some adjustments), I can contribute a script to setup this environment.

The idea is to have multiple working trees in a subdirectory of the normal
one. Some would probably like them to be movable anywhere else, but let's
not complicate things first. But in order not to constantly have to pull/push
in every tree, I set up the .git repo of each working tree with many symlinks :

  project/
          .git/ (normal repo)
          ... master checked out there by default ...
          worktree/
                   variant_a/
                             .git/ (symlinks)
                   variant_b/
                             .git/ (symlinks)
                   variant_c/
                             .git/ (symlinks)


Each variant is set up like this :
    4096 Jan 24 08:44 .git
      19 Jan 24 08:27 .git/HEAD
      28 Jan 24 08:30 .git/logs
     419 Jan 24 08:44 .git/logs/HEAD
      26 Jan 24 08:31 .git/logs/refs -> ../../../../.git/logs/refs
      18 Jan 24 08:31 .git/refs -> ../../../.git/refs
      21 Jan 24 08:31 .git/objects -> ../../../.git/objects
      18 Jan 24 08:31 .git/info -> ../../../.git/info
      19 Jan 24 08:31 .git/hooks -> ../../../.git/hooks
      25 Jan 24 08:31 .git/description -> ../../../.git/description
      20 Jan 24 08:31 .git/config -> ../../../.git/config
     118 Jan 24 08:44 .git/index
      22 Jan 24 08:31 .git/branches -> ../../../.git/branches
      63 Jan 24 08:44 .git/FETCH_HEAD
      41 Jan 24 08:44 .git/ORIG_HEAD

In fact, I found that each directory which hosts a HEAD file needs to
remain a directory because of this head, but all other dirs can be
symlinks to original tree.

This works pretty well. I can simply cd worktree/variant_a and work on a
file, or pull master, or even git-cherry-pick from other branches (pretty
convenient for this usage). But I don't know what caveats I may encounter.

Maybe there are other solutions too. I see that we tend to replace symlinks
everywhere with ref files. We might as well (in a far future version) accept
a file for ".git" which would contain a path to the central repo and the
branch's head.

I'm open to comments. Please keep me CC, I'm not subscribed to the git list.

Thanks,
Willy
