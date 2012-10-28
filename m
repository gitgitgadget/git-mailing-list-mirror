From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] submodule status: remove unused orig_* variables
Date: Sun, 28 Oct 2012 22:37:16 +0100
Message-ID: <508DA58C.2040504@web.de>
References: <CABURp0op2+QUvusUmAFUxT8s8c02bB9V3=ag9gTTSiiN4t96OA@mail.gmail.com> <1351278834-28867-1-git-send-email-hordp@cisco.com> <508AE4AB.4070209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, phil.hord@gmail.com,
	Jeff King <peff@peff.net>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 22:37:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSaY7-0005Wn-5S
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 22:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047Ab2J1Vh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 17:37:27 -0400
Received: from mout.web.de ([212.227.15.3]:60514 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756041Ab2J1Vh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 17:37:26 -0400
Received: from [192.168.178.41] ([91.3.156.115]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0Mf0pJ-1TmCpR3pqD-00PGGv; Sun, 28 Oct 2012 22:37:17
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <508AE4AB.4070209@web.de>
X-Enigmail-Version: 1.4.5
X-Provags-ID: V02:K0:PZ46O08WhIxg9zyDM3u6AwOZkYSOAgQL+8FHsziKA21
 oAV/7Znt+F0HfCvZFfwlx1Uurb+NotDTUu+0bIoWTnSjJRLT8I
 14Lr9zHKbLHpRCbG0otyVqYgKiJZXIZPbRWMe4m4HhTkyDWh1T
 egVqkTCLi5CKssv8KT2gDU5e9yxbBpOMpB1RvfcSAjray86WrA
 WbxBRXhhYSaDNR4mRmW9A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208571>

When renaming orig_args to orig_flags in 98dbe63d (submodule: only
preserve flags across recursive status/update invocations) the call site
of the recursive cmd_status was forgotten. At that place orig_args is
still passed into the recursion, which is always empty since then. This
did not break anything because the orig_flags logic is not needed at all
when a function from the submodule script is called with eval, as that
inherits all the variables set by the option parsing done in the first
level of the recursion.

Now that we know that orig_flags and orig_args aren't needed at all,
let's just remove them from cmd_status().

Thanks-to: Phil Hord <hordp@cisco.com>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 26.10.2012 21:29, schrieb Jens Lehmann:
> Am 26.10.2012 21:13, schrieb Phil Hord:
>> A test in t7404-submodule-foreach purports to test that
>> the --cached flag is properly noticed by --recursive calls
>> to the foreach command as it descends into nested
>> submodules.  However, the test really does not perform this
>> test since the change it looks for is in a top-level
>> submodule handled by the first invocation of the command.
>> To properly test for the flag being passed to recursive
>> invocations, the change must be buried deeper in the
>> hierarchy.
>>
>> Move the change one level deeper so it properly verifies
>> the recursive machinery of the 'git submodule status'
>> command.
> 
> Me thinks we should definitely do this.

And I also think this patch should go on top of Phil's patch after what
we learned so far.

I'm currently checking if we can also safely remove orig_flags from
cmd_update(). At least the test suite runs fine without it ...


 git-submodule.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ab6b110..c287464 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -926,7 +926,6 @@ cmd_summary() {
 cmd_status()
 {
 	# parse $args after "submodule ... status".
-	orig_flags=
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -950,7 +949,6 @@ cmd_status()
 			break
 			;;
 		esac
-		orig_flags="$orig_flags $(git rev-parse --sq-quote "$1")"
 		shift
 	done

@@ -990,7 +988,7 @@ cmd_status()
 				prefix="$displaypath/"
 				clear_local_git_env
 				cd "$sm_path" &&
-				eval cmd_status "$orig_args"
+				eval cmd_status
 			) ||
 			die "$(eval_gettext "Failed to recurse into submodule path '\$sm_path'")"
 		fi
-- 
1.8.0.42.g2ea983b
