From: Jeff King <peff@peff.net>
Subject: Re: [BUG] "git pull" will regress between 'master' and 'pu'
Date: Sun, 19 Apr 2015 09:07:46 -0400
Message-ID: <20150419130745.GA20476@peff.net>
References: <xmqqbnikoq0n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 15:08:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yjox6-0006EH-8x
	for gcvg-git-2@plane.gmane.org; Sun, 19 Apr 2015 15:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbbDSNHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2015 09:07:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:47287 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751690AbbDSNHs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2015 09:07:48 -0400
Received: (qmail 29309 invoked by uid 102); 19 Apr 2015 13:07:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Apr 2015 08:07:48 -0500
Received: (qmail 17439 invoked by uid 107); 19 Apr 2015 13:08:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Apr 2015 09:08:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Apr 2015 09:07:46 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbnikoq0n.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267440>

On Sat, Apr 18, 2015 at 06:39:20PM -0700, Junio C Hamano wrote:

> This is primarily note-to-self; even though I haven't got around
> bisecting yet, I think I know I did some bad change myself.
> 
> "git pull $URL $tag" seems to:
> 
>  * fail to invoke the editor without "--edit".
>  * show the summary merge log message twice.

I think that "git merge -m $msg $commit" is not quite the same as "git
merge $msg HEAD $commit".

The former suppresses the editor. This makes sense, as it's consistent
with "commit -m", etc. You can override that with "--edit".

But the latter also respects merge.log. Which also makes sense, because
the contents of "-m" are generally user-created, not the output of
fmt-merge-msg. So it is merge's job to format the content appropriately.

It is tempting to "solve" both by dropping the call to git-fmt-merge-msg
right before calling git-merge. Then "git-merge" will call fmt-merge-msg
itself. However, we feed it only the sha1 of the merge-head, whereas our
fmt-merge-msg call gets to see FETCH_HEAD. So we would lose the nice
"Merge tag 'v1.0' of git://..." part of the message. Instead we get
"Merge tag '1234abcd'".

So this is _almost_ enough:

diff --git a/git-pull.sh b/git-pull.sh
index 252969e..63493ee 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -323,7 +323,7 @@ then
 	fi
 fi
 
-merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
+merge_name=$(git fmt-merge-msg --no-log <"$GIT_DIR/FETCH_HEAD") || exit
 case "$rebase" in
 true)
 	eval="git-rebase $diffstat $strategy_args $merge_args $rebase_args $verbosity"
@@ -334,7 +334,7 @@ true)
 	eval="git-merge $diffstat $no_commit $verify_signatures $edit $squash $no_ff $ff_only"
 	eval="$eval $log_arg $strategy_args $merge_args $verbosity $progress"
 	eval="$eval $gpg_sign_args"
-	eval="$eval -m \"\$merge_name\" $merge_head"
+	eval="$eval --edit -m \"\$merge_name\" $merge_head"
 	;;
 esac
 eval "exec $eval"

But that is starting to feel pretty hacky.  Moreover, both fmt-merge-msg
and "merge -m" will verify the tag signature and output the tag message.
I don't see a way to suppress that. So it really would be nice to be
able to just drop the extra fmt-merge-msg call and have git-merge do it
all internally, which would mean telling it to use FETCH_HEAD and not
$merge_name.

Which I guess is just:

diff --git a/git-pull.sh b/git-pull.sh
index 252969e..15d9431 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -323,7 +323,6 @@ then
 	fi
 fi
 
-merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 case "$rebase" in
 true)
 	eval="git-rebase $diffstat $strategy_args $merge_args $rebase_args $verbosity"
@@ -334,7 +333,7 @@ true)
 	eval="git-merge $diffstat $no_commit $verify_signatures $edit $squash $no_ff $ff_only"
 	eval="$eval $log_arg $strategy_args $merge_args $verbosity $progress"
 	eval="$eval $gpg_sign_args"
-	eval="$eval -m \"\$merge_name\" $merge_head"
+	eval="$eval FETCH_HEAD"
 	;;
 esac
 eval "exec $eval"

as we seem to special-case the name FETCH_HEAD. It assumes that
git-merge's parsing of FETCH_HEAD is the same as what we do in git-pull,
but that seems safe. Unfortunately we still have to compute $merge_head
ourselves here for the "git pull --rebase" case.

-Peff
