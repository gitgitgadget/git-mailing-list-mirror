From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC PATCH] implement sample post-checkout hook to checkout
	new/unchanged submodules
Date: Wed, 14 Oct 2009 22:12:57 +0200
Message-ID: <20091014201257.GA5788@book.hvoigt.net>
References: <alpine.DEB.2.00.0910131115160.14223@ds9.cixit.se> <4AD47C65.5080904@web.de> <alpine.DEB.2.00.0910140728420.16100@ds9.cixit.se> <4AD5F0B1.4000507@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 14 22:22:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyAKS-0001hn-82
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 22:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933707AbZJNUNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 16:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933727AbZJNUNi
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 16:13:38 -0400
Received: from darksea.de ([83.133.111.250]:45594 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933665AbZJNUNh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 16:13:37 -0400
Received: (qmail 2639 invoked from network); 14 Oct 2009 22:12:57 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 14 Oct 2009 22:12:57 +0200
Content-Disposition: inline
In-Reply-To: <4AD5F0B1.4000507@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130332>

Currently gits default behaviour is not to recursively update submodules
when they are unchanged in the working copy. This hook implements this
by comparing whether the current HEAD in the submodule is the same as
recorded in the commit we are coming from. It then initializes or
updates the submodule as necessary.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

On Wed, Oct 14, 2009 at 05:39:29PM +0200, Jens Lehmann wrote:
> Peter Krefting schrieb:
> > Jens Lehmann:
> > 
> >> just calling "git submodule update" every time you want the submodule
> >> to be updated according to the state committed in the superproject
> >> will do the trick (but keep in mind that all referenced commits have
> >> to be accessible in the local clone of your submodule, so you might
> >> have to do a fetch there once in a while).
> 
> BTW: unless you use the -N or --no-fetch option, git submodule update
> will do the fetch for you.
> 
> 
> > Is it possible to automate this from a hook or something else?
> 
> Yep, you can use the post-checkout hook for that, just put a "git
> submodule update" in it.

Incidentially I have just been working on such a hook. Here is a patch
that implements it as a sample hook.

I tested most cases, but I have not worked with it productively so it
might have strange results in some cases. One I already found is that
post-checkout is not called after a merge so you need to add a
submodule update there as well.

cheers Heiko


 templates/hooks--post-checkout.sample |   50 +++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)
 create mode 100644 templates/hooks--post-checkout.sample

diff --git a/templates/hooks--post-checkout.sample b/templates/hooks--post-checkout.sample
new file mode 100644
index 0000000..9ffffa0
--- /dev/null
+++ b/templates/hooks--post-checkout.sample
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+# if this is a file checkout we do nothing
+flag=$3
+if [ ! $flag ]
+then
+	exit 0
+fi
+
+# if this is the initial checkout also intialize submodules
+if [ $1 == "0000000000000000000000000000000000000000" ]; then
+	git submodule init
+	git submodule update
+	# after initial checkout we are done now
+	exit 0
+fi
+
+# update all submodules that where not modified beforehand
+# or did not exist
+prev_sha1=$1
+new_sha1=$2
+
+git ls-tree $new_sha1 | grep ^160000 |cut -f2 |
+while read submodule
+do
+	prev_submodule_sha1=$(git ls-tree $prev_sha1 |
+		grep "	$submodule$" | cut -f1 | cut -d' ' -f3)
+	curr_submodule_sha1=$(cd "$submodule"; git rev-parse HEAD \
+		2>/dev/null)
+
+	if [ -z "$prev_submodule_sha1" ]
+	then
+		git submodule init "$submodule"
+		git submodule update "$submodule"
+		continue
+	fi
+
+	if [ "$prev_submodule_sha1" = "$curr_submodule_sha1" ]
+	then
+		if [ -z "$(git config submodule."$submodule".url)" ]
+		then
+			git submodule init "$submodule"
+		fi
+
+		if [ "$(git diff $prev_sha1 $new_sha1 -- "$submodule")" ]
+		then
+			git submodule update "$submodule"
+		fi
+	fi
+done
-- 
1.6.5.rc1.12.gc72fe
