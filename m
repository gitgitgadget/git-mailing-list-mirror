From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 01 Nov 2007 17:32:04 -0700
Message-ID: <7vmytx7aij.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org>
	<916BE4AD-5BD9-48E6-8026-B1AC7387E28D@adacore.com>
	<7v4pg5btis.fsf@gitster.siamese.dyndns.org>
	<20071101204755.GA15842@glandium.org>
	<7vhck5acj4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Bosch <bosch@adacore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 01:32:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InkSZ-0002gu-9f
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 01:32:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825AbXKBAcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 20:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754611AbXKBAcM
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 20:32:12 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:45056 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbXKBAcL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 20:32:11 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 998C92EF;
	Thu,  1 Nov 2007 20:32:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D5F82912FF;
	Thu,  1 Nov 2007 20:32:27 -0400 (EDT)
In-Reply-To: <7vhck5acj4.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 01 Nov 2007 14:20:15 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63043>

Junio C Hamano <gitster@pobox.com> writes:

> I am personally very much in favor of removing "git clean", but
> having many people on the list saying loudly that it is a bad
> command is not good enough justification, as people who are
> content with the status quo tend to be silent.
>
> The steps I think is sensible to transition to that goal would
> be:
>
>  - Change clean.requireForce to default to 'true' in the next
>    (or one after) version of git, to make 'clean' even safer.
>    See if anybody complains (I do not expect any).
>
>  - Implement the same functionarity as a new option to "git rm",
>    which is already in C.
>
>  - Do "git clean" in C, but sharing the code with "git rm"
>    implementation above.
>
>  - Discuss deprecation and removal of redundant commands.  Ship
>    a version of git with deprecation and future removal notice.
>    Outline how to achieve the same thing as the deprecated
>    command used to do (or give convincing argument why what the
>    deprecated command used to do was a bad thing and do not
>    offer an alternative).
>
>  - Wait for a while (6 months to 1 year) and then remove them.

And this is the first step.

---

 Documentation/config.txt |    4 ++--
 git-clean.sh             |    6 +++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index edf50cd..2144855 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -345,8 +345,8 @@ branch.<name>.mergeoptions::
 	supported.
 
 clean.requireForce::
-	A boolean to make git-clean do nothing unless given -f or -n.  Defaults
-	to false.
+	A boolean to make git-clean do nothing unless given -f
+	or -n.   Defaults to true.
 
 color.branch::
 	A boolean to enable/disable color in the output of
diff --git a/git-clean.sh b/git-clean.sh
index 4491738..f4965b8 100755
--- a/git-clean.sh
+++ b/git-clean.sh
@@ -20,12 +20,16 @@ require_work_tree
 ignored=
 ignoredonly=
 cleandir=
-disabled="`git config --bool clean.requireForce`"
 rmf="rm -f --"
 rmrf="rm -rf --"
 rm_refuse="echo Not removing"
 echo1="echo"
 
+# requireForce used to default to false but now it defaults to true.
+# IOW, lack of explicit "clean.requireForce = false" is taken as
+# "clean.requireForce = true".
+disabled=$(git config --bool clean.requireForce || echo true)
+
 while test $# != 0
 do
 	case "$1" in
