From: henri GEIST <henri.geist@flying-robots.com>
Subject: tracking submodules out of main directory.
Date: Mon, 27 Jun 2011 15:07:36 +0200
Message-ID: <1309180056.2497.220.camel@Naugrim.eriador.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 27 15:26:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbBpu-0007Ib-IS
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 15:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759567Ab1F0NLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 09:11:16 -0400
Received: from mail13.surf-town.net ([212.97.132.53]:33140 "EHLO
	mailgw8.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759857Ab1F0NKl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 09:10:41 -0400
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jun 2011 09:10:41 EDT
Received: by mailgw8.surf-town.net (Postfix, from userid 65534)
	id 60BE8F4CD1; Mon, 27 Jun 2011 15:05:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw8.surf-town.net (Postfix) with ESMTP id 434D7F4CBC
	for <git@vger.kernel.org>; Mon, 27 Jun 2011 15:05:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw8.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw8.surf-town.net ([127.0.0.1])
	by localhost (mailgw8.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3n4UL+BnffER for <git@vger.kernel.org>;
	Mon, 27 Jun 2011 15:04:57 +0200 (CEST)
Received: from [10.0.0.17] (AStrasbourg-753-1-35-11.w92-141.abo.wanadoo.fr [92.141.170.11])
	by mailgw8.surf-town.net (Postfix) with ESMTPSA id A9827F4B04
	for <git@vger.kernel.org>; Mon, 27 Jun 2011 15:04:57 +0200 (CEST)
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176347>

Hello,

Here is my topic.

Is it possible to track a submodule through a relative path outside of a
submodule ?

The purpose of this thing is to maintain dependency through different
library or projects.

Let says this generic dependency tree.


project 1 --+--> library 1
            |
            +--> library 2


project 2 --+--> library 1
            |
            +--> library 3


project 3 --+--> library 2
            |
            +--> library 4
            |
            +--> project 1 --+--> library 1
                             |
                             +--> library 2

project 4 --+--> library 4
            |
            +--> project 1 --+--> library 1
            |                |
            |                +--> library 2
            |
            +--> project 2 --+--> library 1
            |                |
            |                +--> library 3
            |
            +--> project 3 --+--> library 2
                             |
                             +--> library 4
                             |
                             +--> project 1 --+--> library 1
                                              |
                                              +--> library 2

CAUTION : this is a tree of dependency not directory.

We can obviously solve this by doing trees of submodules just reflecting
the trees of dependency but it create somme problems.

  1. In project 4 I have 2 times project 1 and 3 times libraries 1 and 2
     And 2 times library 4.
  2. It is a wast of space.
  3. Different version of the same libraries or projects could be used.
  4. when linking object, multiples objects will export the same symbols

Point 2 could be acceptable in little project.

Point 4 could be addressed by a careful compilation schema.

Point 3 could be no issue and discard point 2 meaning if it is what you
        want in your work flow.
        But in my work flow it is a bug every thing NEED to be
        synchronized.

what I would like to have is every git tree in the same directory where
I put my code (not necessary a super project tree).

like this :

Anything/library_1
Anything/library_2
Anything/library_3
Anything/library_4
Anything/project_1 with a git submodule add ../library_1 ../library_2
Anything/project_2 with a git submodule add ../library_1 ../library_3
Anything/project_3 with a git submodule add ../library_2 ../library_4
                                            ../project_1
Anything/project_4 with a git submodule add ../library_4 ../project_1
                                            ../project_2 ../project_3

But when I do this I receive a
"fatal: '../library_1' is outside repository"

This is due to the fact that 'git add submodule' use the tests of
'git add' which prevent creating files outside of the working tree for
obvious security reasons.

But in my point of view the meaning of a submodule should be more like a
symlink on a repository than a sub tree.
And symlink does not seams to be prohibited even if they link to
something outside of the repository.

I have tried a work around by doing :
"git submodule add library_1 library_2" in project 1
and then replacing library_1 and library_2 by symlinks to
../library_1 and ../library_2
but git immediately track the symlink itself and not what is pointed to.
And even if it had worked, this type of work around is not clean.

I have think about removing the test in setup.c in case of adding a
submodule. But I am not deeply involved in git source code then I am not
sure of the possibles side effects of this modification.

As well may be there is an other solution that I still haven not think
about.

	Henri GEIST
