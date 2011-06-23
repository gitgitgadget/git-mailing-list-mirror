From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote.txt: fix wrong remote refspec
Date: Thu, 23 Jun 2011 08:33:05 -0700
Message-ID: <7vy60s36mm.fsf@alter.siamese.dyndns.org>
References: <1308804319-6354-1-git-send-email-namhyung@gmail.com>
 <7viprx3yay.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Namhyung Kim <namhyung@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 17:33:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZlu8-0005Fx-LB
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 17:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759613Ab1FWPdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 11:33:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40411 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759429Ab1FWPdI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 11:33:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F9815114;
	Thu, 23 Jun 2011 11:35:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t4qB5NJXQ3y0Nn+reZdOr3ewFKQ=; b=hUosJ2
	oHoc1Lca3TkJN2L/E/BAOBqSJGgOnYP954h5K2cth/suAYhabNdTiatgSZO3S9Wr
	23hlBMBTvWwoSejcawAlg8qbOeJwKxXSsrvhf2o6FEuJGRgbaYy9zkfLPDRwCDmZ
	JrOHreqCu2/kZ3HEH6lkpcmakpC5FdL0hE33o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T04Lksp67qq7LFHJch3mY6I9sNR4w5B8
	K9D11OQ9E6Lpe33MMC6N3yjzWnpCW9AlS5r532kJWxSuNhU2Mr5n+PhymxpSlCeE
	U4QcTruO7nlE0LCAozUkBJX1nYVhMZm2tAywODIbm4tLqWeYfCRDKmJGrnpent8S
	bnXpfSboxQs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 57AC35113;
	Thu, 23 Jun 2011 11:35:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8202C5112; Thu, 23 Jun 2011
 11:35:18 -0400 (EDT)
In-Reply-To: <7viprx3yay.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 22 Jun 2011 22:35:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 663000C2-9DAE-11E0-B61B-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176272>

Junio C Hamano <gitster@pobox.com> writes:

> Obviously correct; thanks.
>
> There is another questionable one you did not touch, though.
>
>     With `-t <branch>` option, instead of the default glob
>     refspec for the remote to track all branches under
>     `$GIT_DIR/remotes/<name>/`, a refspec to track only `<branch>`
>     is created.  You can give more than one `-t <branch>` to track
>     multiple branches without grabbing all branches.
>
> The above says "$GIT_DIR/remotes/<name>/", but it should say
>
>     ... all branches under refs/remotes/<name>/ namespace,...
>
> Also we should try to see if we can come up with a way to say the things
> the part your patch touched describe _without_ mentioning $GIT_DIR at
> all. "Store in $GIT_DIR/refs/$X" talks too much about the implementation
> detail that the ref in question is implemented as a loose ref. We would
> pack it into a single entry in $GIT_DIR/packed-refs file when we run gc,
> and at that point "$GIT_DIR/refs/$X" is no longer a correct description.

And here is my attempt, on top of Namhyung's v2 of this patch.

-- >8 --
Subject: git-remote.txt: avoid sounding as if loose refs are the only ones in the world

It was correct to say "The file $GIT_DIR/refs/heads/master stores the
commit object name at the tip of the master branch" in the older days,
but not anymore, as refs can be packed into $GIT_DIR/packed-refs file.

Update the document to talk in terms of a more abstract concept "ref" and
"symbolic ref" where we are not describing the underlying implementation
detail.

This on purpose leaves two instances of $GIT_DIR/ in the git-remote
documentation; they do talk about $GIT_DIR/remotes/ and $GIT_DIR/branches/
file hierarchy that used to be the place to store configuration around
remotes before the configuration mechanism took them over.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-remote.txt |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 1e3945f..5a8c506 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -60,11 +60,11 @@ the remote repository.
 +
 With `-t <branch>` option, instead of the default glob
 refspec for the remote to track all branches under
-`$GIT_DIR/refs/remotes/<name>/`, a refspec to track only `<branch>`
+the `refs/remotes/<name>/` namespace, a refspec to track only `<branch>`
 is created.  You can give more than one `-t <branch>` to track
 multiple branches without grabbing all branches.
 +
-With `-m <master>` option, `$GIT_DIR/refs/remotes/<name>/HEAD` is set
+With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
 up to point at remote's `<master>` branch. See also the set-head command.
 +
 When a fetch mirror is created with `\--mirror=fetch`, the refs will not
@@ -92,24 +92,25 @@ configuration settings for the remote are removed.
 
 'set-head'::
 
-Sets or deletes the default branch (`$GIT_DIR/refs/remotes/<name>/HEAD`) for
+Sets or deletes the default branch (i.e. the target of the
+symbolic-ref `refs/remotes/<name>/HEAD`) for
 the named remote. Having a default branch for a remote is not required,
 but allows the name of the remote to be specified in lieu of a specific
 branch. For example, if the default branch for `origin` is set to
 `master`, then `origin` may be specified wherever you would normally
 specify `origin/master`.
 +
-With `-d`, `$GIT_DIR/refs/remotes/<name>/HEAD` is deleted.
+With `-d`, the symbolic ref `refs/remotes/<name>/HEAD` is deleted.
 +
-With `-a`, the remote is queried to determine its `HEAD`, then
-`$GIT_DIR/refs/remotes/<name>/HEAD` is set to the same branch. e.g., if the remote
+With `-a`, the remote is queried to determine its `HEAD`, then the
+symbolic-ref `refs/remotes/<name>/HEAD` is set to the same branch. e.g., if the remote
 `HEAD` is pointed at `next`, "`git remote set-head origin -a`" will set
-`$GIT_DIR/refs/remotes/origin/HEAD` to `refs/remotes/origin/next`. This will
+the symbolic-ref `refs/remotes/origin/HEAD` to `refs/remotes/origin/next`. This will
 only work if `refs/remotes/origin/next` already exists; if not it must be
 fetched first.
 +
-Use `<branch>` to set `$GIT_DIR/refs/remotes/<name>/HEAD` explicitly. e.g., "git
-remote set-head origin master" will set `$GIT_DIR/refs/remotes/origin/HEAD` to
+Use `<branch>` to set the symbolic-ref `refs/remotes/<name>/HEAD` explicitly. e.g., "git
+remote set-head origin master" will set the symbolic-ref `refs/remotes/origin/HEAD` to
 `refs/remotes/origin/master`. This will only work if
 `refs/remotes/origin/master` already exists; if not it must be fetched first.
 +
