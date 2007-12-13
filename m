From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-help: add "help.format" config variable.
Date: Wed, 12 Dec 2007 17:41:08 -0800
Message-ID: <7v63z374nf.fsf@gitster.siamese.dyndns.org>
References: <20071212063320.3cbb1698.chriscool@tuxfamily.org>
	<7vr6hs8erq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Dec 13 02:41:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2d54-0000ZM-HK
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 02:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbXLMBlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 20:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbXLMBlU
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 20:41:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50356 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbXLMBlT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 20:41:19 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DA8146129;
	Wed, 12 Dec 2007 20:41:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0747A6128;
	Wed, 12 Dec 2007 20:41:10 -0500 (EST)
In-Reply-To: <7vr6hs8erq.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 12 Dec 2007 01:04:57 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68110>

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> diff --git a/git.c b/git.c
>> index 4f9876e..d46b63d 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -324,7 +324,7 @@ static void handle_internal_command(int argc, const char **argv)
>>  		{ "gc", cmd_gc, RUN_SETUP },
>>  		{ "get-tar-commit-id", cmd_get_tar_commit_id },
>>  		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER },
>> -		{ "help", cmd_help },
>> +		{ "help", cmd_help, RUN_SETUP },
>>  #ifndef NO_CURL
>>  		{ "http-fetch", cmd_http_fetch, RUN_SETUP },
>>  #endif
>
> It would be _NICE_ if we read configuration when we are in a git
> repository, but I am afraid this change is unnice -- the users used to
> be able to say "git help" from anywhere didn't they?  Now they will get
> "Not a git repository".  It needs to do an optional repository
> discovery, not a mandatory one RUN_SETUP causes.

It turns out that the earlier git-browse-help is already broken with
respect to this.

-- >8 --
[PATCH] git-help -w: do not require to be in git repository

The users used to be able to say "git help cat-file" from anywhere, but
the browse-help script insisted to be in a git repository, which caused
"git help -w cat-file" to barf outside.  Correct it.

While at it, remove leftover debugging "echo".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-browse-help.sh |   13 ++++++++-----
 git-sh-setup.sh    |   45 ++++++++++++++++++++++++++-------------------
 2 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/git-browse-help.sh b/git-browse-help.sh
index 817b379..b465911 100755
--- a/git-browse-help.sh
+++ b/git-browse-help.sh
@@ -17,8 +17,10 @@
 #
 
 USAGE='[--browser=browser|--tool=browser] [cmd to display] ...'
-SUBDIRECTORY_OK=Yes
-OPTIONS_SPEC=
+
+# This must be capable of running outside of git directory, so
+# the vanilla git-sh-setup should not be used.
+NONGIT_OK=Yes
 . git-sh-setup
 
 # Install data.
@@ -37,7 +39,7 @@ valid_tool() {
 }
 
 init_browser_path() {
-	browser_path=`git config browser.$1.path`
+	test -z "$GIT_DIR" || browser_path=`git config browser.$1.path`
 	test -z "$browser_path" && browser_path=$1
 }
 
@@ -69,7 +71,8 @@ do
     shift
 done
 
-if test -z "$browser"; then
+if test -z "$browser" && test -n "$GIT_DIR"
+then
     for opt in "help.browser" "web.browser"
     do
 	browser="`git config $opt`"
@@ -91,7 +94,7 @@ if test -z "$browser" ; then
     else
 	browser_candidates="w3m links lynx"
     fi
-    echo "browser candidates: $browser_candidates"
+
     for i in $browser_candidates; do
 	init_browser_path $i
 	if type "$browser_path" > /dev/null 2>&1; then
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 5aa62dd..b366761 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -122,26 +122,33 @@ get_author_ident_from_commit () {
 	LANG=C LC_ALL=C sed -ne "$pick_author_script"
 }
 
-# Make sure we are in a valid repository of a vintage we understand.
-if [ -z "$SUBDIRECTORY_OK" ]
+# Make sure we are in a valid repository of a vintage we understand,
+# if we require to be in a git repository.
+if test -n "$NONGIT_OK"
 then
-	: ${GIT_DIR=.git}
-	test -z "$(git rev-parse --show-cdup)" || {
-		exit=$?
-		echo >&2 "You need to run this command from the toplevel of the working tree."
-		exit $exit
-	}
+	if git rev-parse --git-dir >/dev/null 2>&1
+	then
+		: ${GIT_DIR=.git}
+	fi
 else
-	GIT_DIR=$(git rev-parse --git-dir) || {
-	    exit=$?
-	    echo >&2 "Failed to find a valid git directory."
-	    exit $exit
+	if [ -z "$SUBDIRECTORY_OK" ]
+	then
+		: ${GIT_DIR=.git}
+		test -z "$(git rev-parse --show-cdup)" || {
+			exit=$?
+			echo >&2 "You need to run this command from the toplevel of the working tree."
+			exit $exit
+		}
+	else
+		GIT_DIR=$(git rev-parse --git-dir) || {
+		    exit=$?
+		    echo >&2 "Failed to find a valid git directory."
+		    exit $exit
+		}
+	fi
+	test -n "$GIT_DIR" && GIT_DIR=$(cd "$GIT_DIR" && pwd) || {
+		echo >&2 "Unable to determine absolute path of git directory"
+		exit 1
 	}
+	: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
 fi
-
-test -n "$GIT_DIR" && GIT_DIR=$(cd "$GIT_DIR" && pwd) || {
-    echo >&2 "Unable to determine absolute path of git directory"
-    exit 1
-}
-
-: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
-- 
1.5.3.7-1170-g8d08
