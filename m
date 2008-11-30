From: Brian Dessent <brian@dessent.net>
Subject: Re: A better approach to diffing and merging
Date: Sat, 29 Nov 2008 17:56:44 -0800
Organization: My own little world...
Message-ID: <4931F2DC.CE9B1E35@dessent.net>
References: <823242bd0811291012g15c4d442qa5d7afc9cc762b20@mail.gmail.com>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ian Clarke <ian.clarke@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 30 03:38:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6cCw-0004vc-Ue
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 03:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908AbYK3Cd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 21:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753877AbYK3Cd2
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 21:33:28 -0500
Received: from dessent.net ([69.60.119.225]:38169 "EHLO dessent.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752848AbYK3Cd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 21:33:28 -0500
X-Greylist: delayed 2201 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Nov 2008 21:33:27 EST
Received: from localhost.localdomain ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.50)
	id 1L6bYD-0002Eu-Iy; Sun, 30 Nov 2008 01:56:45 +0000
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101947>

Ian Clarke wrote:

> Provide the merge algorithm with the grammar of the programming
> language, perhaps in the form of a Bison grammar file, or some other
> standardized way to represent a grammar.
> 
> The merge algorithm then uses this to parse the files to be diffed
> and/or merged into trees, and then the diff and merge are treated as
> operations on these trees.  These operations may include creating,
> deleting, or moving nodes or branches, renaming nodes, etc.  There has
> been quite a bit (pdf) of academic research on this topic, although I
> haven't yet found off-the-shelf code that will do what we need.
> Still, it shouldn't be terribly hard to implement.

There's a huge flaw in that approach for C/C++: in order to parse C/C++
you have to first preprocess it -- consider the twisty mazes that
#ifdef/#else/#endif can create.  But in order to preprocess source code
you need a whole heap of extra information that is not in the repository
(or if it is, cannot be automatically extracted.)

For example, you'd have to know all the -D/-U/-I flags that the makefile
or the user might pass to the compiler.  You'd have to replicate the
compiler's complicated header search path algorithm, which can depend on
the directives in the code as well as command line arguments,
environment variables, and values specific to the toolchain.  (Don't
forget that you can have code in a repository that's meant to be
cross-compiled and which uses a toolchain that has its own headers and
not the ones in /usr/include.)  You'd have to know all the built-in
predefined symbols of that toolchain, e.g. what's the value of
__GNUC_MINOR__ or __GNUC_PATCHLEVEL__, is __mips__ or __i386__ defined,
and on and on.  And of course the natural conclusion of this
progression: a change can be perfectly grammatically correct for one
particular platform/toolchain/setting of CFLAGS, and completely broken
for another.  There's no way for a VCS to know any of this, it takes
human comprehension.

If you look at a tool like doxygen that attempts to parse C/C++, it
don't actually do full preprocessing, only a very limited subset: it
only expands macros that the user names as relevant in the config file,
and it only preprocesses included headers that match a pathspec the user
provides.  Consequently it cannot fully parse the code to see if it's
grammatically correct, only to the limited extent that it can infer the
location where things appear to be defined.  And it is easily confused,
e.g. it will "see" code in both halves of an #ifdef section if it wasn't
told anything about the value of the macro in the config file, which can
cause it to incorrectly think that a function or variable was defined
there when in reality that section was discarded.

The idea may have value for langauges that are easy to parse and do not
have all this preprocessor cruft, but I just don't see how it would be
able to provide anything useful for non-trivial changes to real world
C/C++, which require human eyes to decipher.

Brian
