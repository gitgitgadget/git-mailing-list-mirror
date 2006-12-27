From: Junio C Hamano <junkio@cox.net>
Subject: Re: Errors when updating an old git.git repository
Date: Tue, 26 Dec 2006 16:22:35 -0800
Message-ID: <7v1wmmchmc.fsf@assigned-by-dhcp.cox.net>
References: <87d566ww3r.fsf@trews52.bothi.fi>
	<8c5c35580612260737vae2669dkac6a81fe863484d4@mail.gmail.com>
	<87ac1awjh0.fsf@trews52.bothi.fi>
	<Pine.LNX.4.63.0612262350070.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Hannu Koivisto <azure@iki.fi>
X-From: git-owner@vger.kernel.org Wed Dec 27 01:22:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzMZE-0007hP-GW
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 01:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932837AbWL0AWh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 19:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932849AbWL0AWh
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 19:22:37 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:40965 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932837AbWL0AWg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 19:22:36 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061227002236.SWTE18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Dec 2006 19:22:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3cNp1W00J1kojtg0000000; Tue, 26 Dec 2006 19:22:49 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612262350070.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 26 Dec 2006 23:54:19 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35437>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Git works quite as expected here, so there is nothing to fix.
>
>> error: no such remote ref refs/heads/jc/bind
>> error: no such remote ref refs/heads/jc/bind-2
>> error: no such remote ref refs/heads/gb/diffdelta
>
> Since you said it is an older git repository, I guess that in your 
> .git/remotes/origin are some lines like this:
>
> 	Pull: refs/heads/jc/bind:refs/heads/jc/bind
>
> So, you _asked_ git to fetch these three branches!

I think it only half explains the problem.  Maybe my memory is
failing, but I do not recall pushing out any of these topic
branches, perhaps except jc/bind long time ago.

How did Hannu end up with these branches, both under his
$GIT_DIR/refs/heads/ and in $GIT_DIR/remotes/origin or
remote.origin.fetch in $GIT_DIR/config?

I see identical failure report from ancient time

	http://article.gmane.org/gmane.comp.version-control.git/21629

Maybe I did push them out earlier.

How about doing something like this?  In explain_fetch_failure
I think we could look at $ls_remote_result and automagically fix
remotes/$remote_nick or remote.$remote_nick.fetch, but I am lazy
;-)

-- >8 --

diff --git a/git-fetch.sh b/git-fetch.sh
index ffbd44f..361dfa3 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -81,6 +81,7 @@ case "$#" in
 esac
 
 remote_nick="$1"
+datasrc=$(get_data_source "$1")
 remote=$(get_remote_url "$@")
 refs=
 rref=
@@ -272,6 +273,21 @@ then
 	fi
 fi
 
+explain_fetch_failure () {
+	where=
+	case "$datasrc" in
+	'') ;;
+	config) where="remotes.$remote_nick.fetch configuration" ;;
+	branch) where=".git/branches/$remote_nick file" ;;
+	remotes) where=".git/remotes/$remote_nick file" ;;
+	esac
+	if test "z$where" != z
+	then		  	
+		echo >&2 "You may have stale remote branches in $where"
+		echo >&2 "Remove them if they do not exist anymore."
+	fi
+}
+
 fetch_main () {
   reflist="$1"
   refs=
@@ -325,8 +341,10 @@ fetch_main () {
 			break
 		done
 	  )
-	  expr "z$head" : "z$_x40\$" >/dev/null ||
+	  expr "z$head" : "z$_x40\$" >/dev/null || {
+	  	explain_fetch_failure
 		die "No such ref $remote_name at $remote"
+	  }
 	  echo >&2 "Fetching $remote_name from $remote using $proto"
 	  git-http-fetch -v -a "$head" "$remote/" || exit
 	  ;;
@@ -385,6 +403,7 @@ fetch_main () {
 	  case "$sha1" in
 	  failed)
 		  echo >&2 "Fetch failure: $remote"
+		  explain_fetch_failure
 		  exit 1 ;;
 	  # special line coming from index-pack with the pack name
 	  pack)
