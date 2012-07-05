From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] stash: Delete MERGE_RR before stash apply
Date: Thu, 05 Jul 2012 10:15:15 -0700
Message-ID: <7v7guiruxo.fsf@alter.siamese.dyndns.org>
References: <CABURp0pNsRQgbf7_iYc-xVaySa9-gGiA++Lw4-WgSCQ4QGCXsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	martin.von.zweigbergk@gmail.com, tytso@mit.edu
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 19:15:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmpeH-0003ne-66
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 19:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093Ab2GERPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 13:15:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57086 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694Ab2GERPR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 13:15:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50E778823;
	Thu,  5 Jul 2012 13:15:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HL6QsJbhGIvgLprZFHvbguXiMS4=; b=GesCfM
	ILm+T5P5C7lrSP2flyghKHPj3kAoIkJigSjQy3LpyNQ19vmZCNEjk3mtX5IVlSlK
	GdgLbjZJn1WaL85Ytx9niYJKNPiumV/aq3C4XKcdy0wEYWf6AOxyFz/FC+0rqN6g
	fQGndh7vRLTJF0YZaCbxZVVvuMFDwGXo8+Zk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hp+eDDnEe9wRPYd59t/jd5e539ogyUVC
	P3048Vmd32n/WJ6B06gQ5sijoMkQRBrad5a4rL2gz7DuyiIBH2LdS9ZR+g7SLplR
	ZUHDaRdrjMoaMtG0oNtDX1YiSmZzzLgBFuUY3rTMCQD1tLZ9RfRVOr6idF9rMPIF
	kwuJlGC5Uhs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46FDB8822;
	Thu,  5 Jul 2012 13:15:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF9CE8820; Thu,  5 Jul 2012
 13:15:16 -0400 (EDT)
In-Reply-To: <CABURp0pNsRQgbf7_iYc-xVaySa9-gGiA++Lw4-WgSCQ4QGCXsA@mail.gmail.com> (Phil
 Hord's message of "Thu, 5 Jul 2012 09:48:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD9CB85C-C6C4-11E1-95E9-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201052>

Phil Hord <phil.hord@gmail.com> writes:

> The presence of a GIT_DIR/MERGE_RR file indicates we
> were resolving a merge which had rerere candidates for
> recording.  But the file does not get deleted after
> all resolutions are completed.  This is ok for most
> cases because the file will get replaced when the
> next merge happens.  But stash apply does not use
> a merge that supports rerere, and so the old
> MERGE_RR does not get replaced with a current one.

Thanks for digging to the real cause.  It does use merge-recursive
backend directly, and as a backend, it probably is correct that it
does not invoke rerere itself.

In your patch, you are removing the state before you check and
notice that the user is in the middle of a merge and give control
back with "Cannot apply a stash in the middle of a merge".  Wouldn't
it be nicer to the user if you didn't remove the rerere state when
this happens (i.e. the user mistakenly said "stash apply" after a
conflicted merge), as that rerere state likely is from that merge
that produced the conflicted state?

Would an obvious alternative of running "git rerere" ourselves after
running "git merge-recursive" in this script work?

 git-stash.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-stash.sh b/git-stash.sh
index 4e2c7f8..bbefdf6 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -469,6 +469,7 @@ apply_stash () {
 	else
 		# Merge conflict; keep the exit status from merge-recursive
 		status=$?
+		git rerere
 		if test -n "$INDEX_OPTION"
 		then
 			gettextln "Index was not unstashed." >&2
