From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible kinder GIT-VERSION-GEN?
Date: Mon, 04 Feb 2008 13:59:25 -0800
Message-ID: <7vve54ids2.fsf@gitster.siamese.dyndns.org>
References: <18343.30080.67524.3427@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 23:00:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM9MN-0003pK-Hg
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 23:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbYBDV7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 16:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754080AbYBDV7n
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 16:59:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645AbYBDV7m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 16:59:42 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FCF84FB4;
	Mon,  4 Feb 2008 16:59:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 99D674FB2;
	Mon,  4 Feb 2008 16:59:37 -0500 (EST)
In-Reply-To: <18343.30080.67524.3427@lisa.zopyra.com> (Bill Lear's message of
	"Mon, 4 Feb 2008 14:28:48 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72577>

Bill Lear <rael@zopyra.com> writes:

> I have my home directory under git control, and I have a build
> directory (not tracked by git) under my home directory into which I
> untar files and then in which I build things, including git.

Let me make sure I understand you by rephrasing.  You are
extracting git tarball as an untracked subdirectory in an
unrelated project, and GIT-VERSION-GEN misbehaves.  One such
misbehaviour is that it adds -dirty.

And I think you are right.  The -dirty suffix should be relative
to the output of "git describe".  Version string derived from
any other codepath should not get the suffix, simply because we
do not even know if it is dirty.  In fact, we should not even
attempt to run that diff-index to figure out if it is dirty.

---

 GIT-VERSION-GEN |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 38a3273..127c428 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -15,7 +15,9 @@ elif test -d .git &&
 	VN=$(git describe --abbrev=4 HEAD 2>/dev/null) &&
 	case "$VN" in
 	*$LF*) (exit 1) ;;
-	v[0-9]*) : happy ;;
+	v[0-9]*)
+		dirty=$(sh -c 'git diff-index --name-only HEAD' 2>/dev/null) &&
+		VN="$VN-dirty" ;;
 	esac
 then
 	VN=$(echo "$VN" | sed -e 's/-/./g');
@@ -25,14 +27,6 @@ fi
 
 VN=$(expr "$VN" : v*'\(.*\)')
 
-dirty=$(sh -c 'git diff-index --name-only HEAD' 2>/dev/null) || dirty=
-case "$dirty" in
-'')
-	;;
-*)
-	VN="$VN-dirty" ;;
-esac
-
 if test -r $GVF
 then
 	VC=$(sed -e 's/^GIT_VERSION = //' <$GVF)
