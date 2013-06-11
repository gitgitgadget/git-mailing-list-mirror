From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: rebase --autosquash does not handle fixup! of fixup!
Date: Tue, 11 Jun 2013 20:50:07 +0200
Message-ID: <87obbc8otc.fsf@hexa.v.cablecom.net>
References: <20130611180530.GA18488@oinkpad.pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Andrew Pimlott <andrew@pimlott.net>
X-From: git-owner@vger.kernel.org Tue Jun 11 20:50:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmTe5-0006FO-7c
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 20:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840Ab3FKSuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 14:50:10 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:23484 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792Ab3FKSuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 14:50:09 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 11 Jun
 2013 20:50:04 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 11 Jun
 2013 20:50:07 +0200
In-Reply-To: <20130611180530.GA18488@oinkpad.pimlott.net> (Andrew Pimlott's
	message of "Tue, 11 Jun 2013 11:05:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227495>

Andrew Pimlott <andrew@pimlott.net> writes:

> git rebase -i --autosquash does not handle a fixup! of a fixup!, such as
> the history:
>
>     aaaaaaa fix nasty bug
>     ...
>     bbbbbbb fixup! fix nasty bug
>     ...
>     ccccccc fixup! fixup! fix nasty bug
>
> --autosquash produces:
>
>     pick aaaaaaa fix nasty bug
>     fixup bbbbbbb fixup! fix nasty bug
>     ...
>     pick ccccccc fixup! fixup! fix nasty bug
>
> This defeats the workflow I was hoping to use:
>
>     git commit -m 'fix nasty bug'
>     ...
>     git commit --fixup :/nasty
>     ...
>     git commit --fixup :/nasty
>
> The second :/nasty resolves to the previous fixup, not the initial
> commit.  I could have made the regular expression more precise, but this
> would be a hassle.
>
> Would a change to support fixup! fixup! be considered?

Sure, why not.  You could start with something like the patch below
(untested).  If that happens to work, just add a test and a good commit
message.


diff --git i/git-rebase--interactive.sh w/git-rebase--interactive.sh
index f953d8d..798ae81 100644
--- i/git-rebase--interactive.sh
+++ w/git-rebase--interactive.sh
@@ -689,7 +689,17 @@ rearrange_squash () {
 		case "$message" in
 		"squash! "*|"fixup! "*)
 			action="${message%%!*}"
-			rest="${message#*! }"
+			rest=$message
+			while : ; do
+				case "$rest" in
+				"squash! "*|"fixup! "*)
+					rest="${rest#*! }"
+					;;
+				*)
+					break
+					;;
+				esac
+			done
 			echo "$sha1 $action $rest"
 			# if it's a single word, try to resolve to a full sha1 and
 			# emit a second copy. This allows us to match on both message


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
