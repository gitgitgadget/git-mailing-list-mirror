From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH RFC 0/8] introduce 'git remote add --push' and 'git clone --push'
Date: Mon, 20 Jul 2009 19:49:47 +0200
Message-ID: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 19:50:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSx08-0005Xp-5t
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 19:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbZGTRuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 13:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752719AbZGTRuA
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 13:50:00 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:56548 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbZGTRt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 13:49:59 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MSwzu-00032X-8I
	for git@vger.kernel.org; Mon, 20 Jul 2009 13:49:58 -0400
X-Mailer: git-send-email 1.6.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123622>

I post as an initial RFC the third series in the push.default saga.
This is on top of origin/next and even then it requires the
"push --current" patches to be fully functional.  Even without it,
however, it will create correct configuration.

The series adds --push options to "git remote add" and "git clone".
These accept a push strategy of the same kind as "push.default",
and will use it to create push configuration and refspecs.  These
will then override push.default.

The argument is optional, in which case it will be taken from the
"push.default" config key itself.  In this case, since the user explicitly
requested something they did not configure, a warning is emitted similar
to the one of 1.6.3.  If --push is used appropriately, in a non-specified
future "git push" might not use push.default anymore and thus require
a push refspec.  (Or more realistically, it would look at push.default,
but only to suggest the user commands that do the transition).

This patch is a bit harder to justify than the others so far, since
it may as well look like a feature in search of a use case.  To this,
my reply is that this is just a step towards a more polished (IMO)
implementation of the existing "push.default" feature.  Actually, the
patch is big but it is mostly builtin-remote.c and tests.  And you
will have to put up with this for only another series or two.

Patch 1 is just taken from the push --current series.  Patch 2 adds
a new value for `push.default', so that it's easier to map --mirror
to a --push suboption.

Patches 3 and 4 add the option to "git remote add" (refactoring
first, adding the feature later).

Patches 5 to 8 add the option to "git clone".  The first two share
the code for the config setup between "git remote add" and "git clone".
The third adds a new function to get just the global configuration
(not the repository one), for usage in "git clone" before the repository
is actually created.  The final one finally adds the new option,
which is little more than tweaking the call into "git remote add".

That's it for now.  I'll post the final version of this series when I
get comments *and* once both autosetuppush and push --current have been
committed to next.  In the meanwhile, opinions, reviews and flames are
welcome as usual.


Paolo Bonzini (8):
      reintroduce PUSH_DEFAULT_UNSPECIFIED
      push: add push.default = mirror
      git remote add: refactor configuration
      git remote add: add --push option
      clone: refactoring of building the fetch refspec
      clone: use setup_remote_config
      config: add git_config_norepo
      clone: add --push option

 Documentation/config.txt     |    2 +
 Documentation/git-clone.txt  |   13 +++-
 Documentation/git-remote.txt |   13 ++--
 builtin-clone.c              |  133 +++++++++++++++---------------
 builtin-push.c               |   13 +++-
 builtin-remote.c             |  188 ++++++++++++++++++++++++++++++++++--------
 cache.h                      |    5 +
 config.c                     |   74 +++++++++++-----
 environment.c                |    2 +-
 remote.h                     |    3 +
 t/t5505-remote.sh            |   73 ++++++++++++++++
 t/t5517-push-mirror.sh       |   22 +++++-
 t/t5601-clone.sh             |   78 +++++++++++++++++
 13 files changed, 486 insertions(+), 133 deletions(-)
