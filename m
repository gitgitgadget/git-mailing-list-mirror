From: Jeff King <peff@peff.net>
Subject: Re: git-clone: Unobvious error messages when update-server-info
	has not been run
Date: Mon, 17 Dec 2007 07:43:59 -0500
Message-ID: <20071217124359.GA20800@coredump.intra.peff.net>
References: <20071217105541.GG14889@albany.tokkee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Gerrit Pape <pape@smarden.org>,
	git@vger.kernel.org
To: Sebastian Harl <sh@tokkee.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 13:44:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4FKf-0000jj-Lu
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 13:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbXLQMoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 07:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754645AbXLQMoF
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 07:44:05 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1411 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753091AbXLQMoE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 07:44:04 -0500
Received: (qmail 8835 invoked by uid 111); 17 Dec 2007 12:44:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 17 Dec 2007 07:44:01 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2007 07:43:59 -0500
Content-Disposition: inline
In-Reply-To: <20071217105541.GG14889@albany.tokkee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68558>

On Mon, Dec 17, 2007 at 11:55:41AM +0100, Sebastian Harl wrote:

> I was just trying to clone a repository using http but missed to run
> git-update-server-info on the server side. git-clone aborted with the
> following error messages:
> 
>   % git clone http://some/repo.git
>   Initialized empty Git repository in /path/repo/.git/
>   cat: /path/repo/.git/refs/remotes/origin/master: No such file or directory
>   cd: 482: can't cd to /path/repo/.git/refs/remotes/origin
>   fatal: : not a valid SHA1
>   fatal: Not a valid object name HEAD
> 
> It's kind of hard to guess where the error comes from in this case (I blamed
> Git at first). Is there some way to improve the error message in a case like
> this?

git-clone is supposed to detect this condition, but there was a bug in
the error checking code. Can you confirm that this patch fixes it?

Gerrit, I think was caused by your f28dd477 (it is a funny shell
interaction that the non-followed case branch resets $?, but it behaves
the same with bash and dash).

-- >8 --
clone: correctly report http_fetch errors

The exit status from curl was accidentally lost by the
'case' statement. We need to explicitly save it so that $?
doesn't get overwritten.

This improves the error message when fetching from an http
repository which has never had update-server-info run.
Previously, it would fail to note the fetch error and
produce multiple errors about the lack of origin branches.
It now correctly suggests running git-update-server-info.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-clone.sh |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 68085a3..9a160ee 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -56,11 +56,12 @@ fi
 
 http_fetch () {
 	# $1 = Remote, $2 = Local
-	curl -nsfL $curl_extra_args "$1" >"$2" ||
-		case $? in
-		126|127) exit ;;
-		*)	 return $? ;;
-		esac
+	curl -nsfL $curl_extra_args "$1" >"$2"
+	curl_exit_status=$?
+	case $curl_exit_status in
+	126|127) exit ;;
+	*)	 return $curl_exit_status ;;
+	esac
 }
 
 clone_dumb_http () {
-- 
1.5.4.rc0.1145.gef733-dirty
