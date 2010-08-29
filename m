From: Geert Bosch <bosch@gnat.com>
Subject: How to deal with removal/addition of submodules?
Date: Sun, 29 Aug 2010 21:38:59 +0200
Message-ID: <5AC1B4DE-62F7-4439-9F2C-72DFC32CEEC1@gnat.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 29 21:48:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Opnrl-0005BX-U9
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 21:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907Ab0H2Ts2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 15:48:28 -0400
Received: from rock.gnat.com ([205.232.38.15]:36415 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753725Ab0H2Ts1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 15:48:27 -0400
X-Greylist: delayed 565 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Aug 2010 15:48:27 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 662362BAC14
	for <git@vger.kernel.org>; Sun, 29 Aug 2010 15:39:01 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at gnat.com
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id oCsfojDjo-dw for <git@vger.kernel.org>;
	Sun, 29 Aug 2010 15:39:01 -0400 (EDT)
Received: from potomac.lan (ip5454b6a1.adsl-surfen.hetnet.nl [84.84.182.161])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id D7F302BAB7B
	for <git@vger.kernel.org>; Sun, 29 Aug 2010 15:39:00 -0400 (EDT)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154707>

I'm making an integration project that includes submodules for various
components and each day makes a commit in the super-project with all
desired versions of the components. Because many components come from
Subversion repositories, I typically import them directly using git 
svn clone, and then add the submodule using a relative path, such as
git submodule add ./some_module.

The idea is that at any super-project checkout will automatically fetch
all the correct versions of the components. This seems the ideal use of
submodules. For the most part, this works correctly.

However, when creating new submodules, moving submodules around, or
deleting submodules, there are problems checking out old versions
of the project. Basically, when I delete a submodule, git seems to force
me to remove the entire subdirectory including .git files, which essentially
gets rid of all its history too. If I would leave the .git files around,
I wouldn't be able to treat the subdirectory as a regular subdirectory.

Probably I could work around the issue by having separate independent
git repositories for each component, so there would be no conflict
between working tree and submodule repository. However, this makes it
much more cumbersome and script-intensive to do automatic nightly updates 
of all component repositories and generally results in an extra level of
indirection.

If submodules would just be able to share the master .git directory
for their storage, it would seem that most of these problems would
disappear. It would still be possible to selectively initialize and
clone submodules; resulting packs would just share the same .git 
directory. They might even be in their own subdirectories of .git,
they just need to be found for resolving submodule references.

With this improved organization it would be trivial to check out
any old version of the super project, because the commits referenced
by these versions would be easy to find.

It seems that currently git itself, apart from its configuration files,
really adheres to the "content is king" credo, but for submodules we
are thrown back to making path names special. We have persistent identities
for submodules and they cause problems.

My question: how do I manage submodules without falling in these traps?

  -Geert

PS. Below is a script that shows a problematic chain of events to replace
    a submodule by a regular subdirectory.

git init super
cd super
git remote add origin $(pwd)
git init sub
cd sub
echo submodule>txt
git add txt
git commit -m "Initial subproject revision"
cd ..
git submodule add ./sub
git commit -m "Initial super project commit"
# The following line is problematic, but what to do instead?
rm -rf sub
git rm sub
mkdir sub
echo subdirectory>sub/txt
cd sub
git add txt
git commit -m "Sub is now a subdirectory" txt
cd ..
# Repository all done now, let's go back to last revision
git checkout HEAD~1
git submodule update
cd ..
