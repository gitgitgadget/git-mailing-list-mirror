From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2] submodule: add 'deinit' command
Date: Tue, 04 Dec 2012 22:48:41 +0100
Message-ID: <50BE6FB9.70301@web.de>
References: <20121130032719.GE29257@odin.tremily.us> <50B54A68.60309@web.de> <20121130175309.GA718@odin.tremily.us> <CABURp0qNBcFnxbvhn7PsKWLUOsTiK4u5vx-=6cG3JQHw9aUeHA@mail.gmail.com> <50BA2892.7060706@web.de> <50BA3412.60309@web.de> <7vy5hhmcwp.fsf@alter.siamese.dyndns.org> <50BBB22A.7050901@web.de> <7vhao31s9e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>,
	"W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 22:49:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tg0MV-0003wA-PX
	for gcvg-git-2@plane.gmane.org; Tue, 04 Dec 2012 22:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317Ab2LDVsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2012 16:48:51 -0500
Received: from mout.web.de ([212.227.15.4]:64828 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752929Ab2LDVsu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2012 16:48:50 -0500
Received: from [192.168.178.41] ([91.3.166.253]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0LyUha-1T9bLu0XQc-0166ee; Tue, 04 Dec 2012 22:48:44
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vhao31s9e.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:BoFOsaUcYszK5lfNplhOV6FUUE1q3su0M8yYCG9XreW
 M6XVvNUpvX51pHJCe98nbM5onuD5V2qDDVzqXRwCpGRlf/ALkT
 sojFEXDeuTIQLqXbC4Btv1yN6Jz7MUKgcAKLgf9NdVqPslwdL+
 M876LMLCf6gBiwLonS4OqabB9V8CLu4oH0rRrTLi7ZeFQ/2T+B
 TV/pwGI6erJZIk3bambkA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211098>

With "git submodule init" the user is able to tell git he cares about one
or more submodules and wants to have it populated on the next call to "git
submodule update". But currently there is no easy way he could tell git he
does not care about a submodule anymore and wants to get rid of his local
work tree (except he knows a lot about submodule internals and removes the
"submodule.$name.url" setting from .git/config himself).

Help those users by providing a 'deinit' command. This removes the whole
submodule.<name> section from .git/config either for the given
submodule(s) or for all those which have been initialized if none were
given. Complain only when for a submodule given on the command line the
url setting can't be found in .git/config.

Add tests and link the man pages of "git submodule deinit" and "git rm"
to assist the user in deciding whether removing or unregistering the
submodule is the right thing to do for him.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 03.12.2012 08:58, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Maybe the principle of least surprise is better followed when we
>> nuke the whole section, as it might surprise the user more to have
>> a setting resurrected he customized in the last life cycle of the
>> submodule than seeing that after an deinit followed by an init all
>> former customizations are consistently gone. So I tend to think now
>> that removing the whole section would be the better solution here.
> 
> I tend to agree; I suspect that a "deinit" would be mostly done
> either to
> 
>  (1) correct mistakes the user made during a recent "init" and
>      perhaps "sync"; or
> 
>  (2) tell Git that the user has finished woing with this particular
>      submodule and does not intend to use it for quite a while.
> 
> For both (1) and (2), I think it would be easier to users if we gave
> them a clean slate, the same state as the one the user who never had
> ran "init" on it would be in.  A user in situation (1) is asking for
> a clean slate, and a user in situation (2) is better served if he
> does not have to worry about leftover entries in $GIT_DIR/config he
> has long forgotten from many months ago (during which time the way
> the project uses the particular submodule may well have changed)
> giving non-standard experience different from what other project
> participants would get.

Changes in v2:
- Remove the whole submodule section instead of only removing the
  "url" setting and explain why we do that in a comment
- Reworded commit message and git-submodule.txt to reflect that
- Extend the test to check that a custom settings are removed


 Documentation/git-rm.txt        |  4 ++++
 Documentation/git-submodule.txt | 12 ++++++++++
 git-submodule.sh                | 52 ++++++++++++++++++++++++++++++++++++++++-
 t/t7400-submodule-basic.sh      | 12 ++++++++++
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 262436b..ec42bf5 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -149,6 +149,10 @@ files that aren't ignored are present in the submodules work tree.
 Ignored files are deemed expendable and won't stop a submodule's work
 tree from being removed.

+If you only want to remove the local checkout of a submodule from your
+work tree without committing that use `git submodule deinit` instead
+(see linkgit:git-submodule[1]).
+
 EXAMPLES
 --------
 `git rm Documentation/\*.txt`::
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index b1de3ba..08b55a7 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 	      [--reference <repository>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
+'git submodule' [--quiet] deinit [--] [<path>...]
 'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
 	      [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
@@ -134,6 +135,17 @@ init::
 	the explicit 'init' step if you do not intend to customize
 	any submodule locations.

+deinit::
+	Unregister the submodules, i.e. remove the whole `submodule.$name`
+	section from .git/config. Further calls to `git submodule update`,
+	`git submodule foreach` and `git submodule sync` will skip any
+	unregistered submodules until they are initialized again, so use
+	this command if you don't want to have a local checkout of the
+	submodule in your work tree anymore (but note that this command
+	does not remove the submodule work tree). If you really want to
+	remove a submodule from the repository and commit that use
+	linkgit:git-rm[1] instead.
+
 update::
 	Update the registered submodules, i.e. clone missing submodules and
 	checkout the commit specified in the index of the containing repository.
diff --git a/git-submodule.sh b/git-submodule.sh
index 2365149..3f558ed 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -8,6 +8,7 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
+   or: $dashless [--quiet] deinit [--] [<path>...]
    or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
@@ -516,6 +517,55 @@ cmd_init()
 }

 #
+# Unregister submodules from .git/config
+#
+# $@ = requested paths (default to all)
+#
+cmd_deinit()
+{
+	# parse $args after "submodule ... init".
+	while test $# -ne 0
+	do
+		case "$1" in
+		-q|--quiet)
+			GIT_QUIET=1
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			usage
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
+	module_list "$@" |
+	while read mode sha1 stage sm_path
+	do
+		die_if_unmatched "$mode"
+		name=$(module_name "$sm_path") || exit
+		url=$(git config submodule."$name".url)
+		if test -z "$url"
+		then
+			# Only mention uninitialized submodules when its
+			# path have been specified
+			test "$#" != "0" &&
+			say "$(eval_gettext "No url found for submodule path '\$sm_path' in .git/config")"
+			continue
+		fi
+		# Remove the whole section so we have a clean state when the user
+		# later decides to init this submodule again
+		git config --remove-section submodule."$name" &&
+		say "$(eval_gettext "Submodule '\$name' (\$url) unregistered")"
+	done
+}
+
+#
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
 # $@ = requested paths (default to all)
@@ -1108,7 +1158,7 @@ cmd_sync()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | update | status | summary | sync)
+	add | foreach | init | deinit | update | status | summary | sync)
 		command=$1
 		;;
 	-q|--quiet)
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index de7d453..ee4f0ab 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -756,4 +756,16 @@ test_expect_success 'submodule add with an existing name fails unless forced' '
 	)
 '

+test_expect_success 'submodule deinit should remove the whole submodule section from .git/config' '
+	git config submodule.example.foo bar &&
+	git submodule deinit &&
+	test -z "$(git config submodule.example.url)" &&
+	test -z "$(git config submodule.example.foo)"
+'
+
+test_expect_success 'submodule deinit complains only when explicitly used on an uninitialized submodule' '
+	git submodule deinit &&
+	test_must_fail git submodule deinit example
+'
+
 test_done
-- 
1.8.0.1.348.gc64da69
