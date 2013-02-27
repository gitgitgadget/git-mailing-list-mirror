From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: git subtree workflow
Date: Wed, 27 Feb 2013 23:37:10 +0000
Message-ID: <CALeLG_nNQ_ERa23Or+qmNmsxQDahRtxbejmUHKnGFd8EoQCtww@mail.gmail.com>
References: <CAH3cagOtcR3fgoXK-Xd8vm48q0GPQtYMkWiqQGgydb27HeO0wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ben McCann <ben@benmccann.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 00:37:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAqZB-0002RR-Ux
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 00:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758235Ab3B0XhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 18:37:13 -0500
Received: from mail-oa0-f51.google.com ([209.85.219.51]:45514 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583Ab3B0XhM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 18:37:12 -0500
Received: by mail-oa0-f51.google.com with SMTP id h2so2468638oag.38
        for <git@vger.kernel.org>; Wed, 27 Feb 2013 15:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=4oDUBML2apOAus1ztwsODMvb847N3rRXCPgVunqH7Hk=;
        b=hZzT7gr1f+0MnhD07Sx1idRFu/YYgEtqMrulftdHwAnfhnls77w8wTAq4ETKwPZdh0
         Js+wbr8nVBl5DawY5+pVbOfzB0L5SibNsfABkcSl7XVXRcHNCRah1D/tWN1Bsa0ZWVpg
         /GwoLMa6VO3tZBp9s7sl9kfZ4QI6vHNQ+xwCOM4lWonUYC0MY6OD0Jusyv6qj7td6/eB
         Lmbfo8ksdZXmbYTad8CiVKv+ZWfhjMQbwCI9t/44ebKI9AGfjZFBePPC9WP3bu7mngEJ
         KpkXQZTcauN5dwq5MvB8Mh3+gcZhTseQbIn8gXbAabHFsFPbpOXvxBdGl/05KIWE0G6n
         wa2A==
X-Received: by 10.60.171.144 with SMTP id au16mr4244842oec.56.1362008230466;
 Wed, 27 Feb 2013 15:37:10 -0800 (PST)
Received: by 10.76.132.234 with HTTP; Wed, 27 Feb 2013 15:37:10 -0800 (PST)
X-Originating-IP: [2.102.85.14]
In-Reply-To: <CAH3cagOtcR3fgoXK-Xd8vm48q0GPQtYMkWiqQGgydb27HeO0wQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQnWgfH/VG7i2LSZ/ZSkhs9i2EkcX1hwbaArbRMgBnrCLksLvDahE12pDwlKmWZyHptU1X0J
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217226>

On Tue, Feb 26, 2013 at 9:04 AM, Ben McCann <ben@benmccann.com> wrote:
> I'm fairly new to git and am trying to determine if git subtree would
> be helpful for managing our company's codebase, which has several
> repos some of which depend on each other. All the examples I've seen
> make sense to me as a one-time operation to merge separate repos into
> one monolithic one or to split one monolithic repo into separate
> repos. I'm having a harder time understanding how this fits into a
> larger picture and what the workflow for working with subtree would
> be.

The git subtree command does support pushing and pulling changes
to/from a subtree to a remote repo. This operation can be repeated
over time as the underlying git subtree split command produces an
accurate extract from the subtree.

For example:

$ git clone $superrepo super
$ cd super
$ git subtree add --prefix=child $childrepo master
$ split_head=$(git subtree split --prefix=child)

git subtree split creates a synthetic copy of the child subtree and
returns the SHA1 for the head of that subtree.

$ cd ..
$ git clone $childrepo child
$ cd child
$ child_head=$(git rev-parse master)

$split_head and $child_head match.

You could pass either $*_head to gitk and be able to browse identical
trees and histories.

$ gitk $child_head &
$ cd ../super
$ gitk $split_head &

The only difference you should see is that the tree in the super
project doesn't have any branches or tags from the child repo.

> If I have a bunch of repos on GitHub and some depend on each other,
> how would I set them up to work with subtree? Would GitHub continue to
> host them as is, host a merged monolithic repo, or host both a
> monolithic repo and the splitted out repos? The exact answer probably
> varies, but I imagine there's basic workflow that would satisfy 80% of
> users.  If I have GitHub host both monolithic and splitted out repos,
> it seems unclear as to how I keep those repos in sync and make sure
> all the developers in our company push their changes to both repos.

This is what I'm using git-subtree for. I have a super project which
holds child repos, some of which hold other child repos.  You can
develop on all of your projects within the super project and still
periodically pull and push updates with the remote child repos.

Someone who doesn't know about your child repos can take the
monolithic repo and commit to it as normal. You can then pull their
commits and push any changes to the child repos. Probably to a
non-master branch so you they can be integrated like other pull
requests.

Caveats:

1) I would probably avoid the --squash option as I suspect that might
mess with $split_head == $child_head. Whether or not it would have any
impact of your ability to push or pull I don't know. I've not tried
it.

2) When you commit you should ideally not commit a set of files that
are in more than one subtree. You're commit history when you push back
to the source repo for a subtree might look a bit odd if it's
referring to other parts of the super project or it's subtrees.

-- 
Paul [W] Campbell
