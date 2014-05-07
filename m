From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH] contrib/subtree bugfix: Crash if FETCH_HEAD is tag
Date: Thu, 08 May 2014 07:53:39 +1000
Message-ID: <df8addda-8c59-480a-ac52-a958de9d43c9@email.android.com>
References: <1399185212-17833-1-git-send-email-nod.helm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Kevin Cagle <kcagle@micron.com>,
	Junio C Hamano <gitster@pobox.com>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 23:54:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi9nA-0001Lt-31
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 23:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbaEGVyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 17:54:16 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:51250 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbaEGVyN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 17:54:13 -0400
Received: by mail-pd0-f171.google.com with SMTP id r10so1579355pdi.2
        for <git@vger.kernel.org>; Wed, 07 May 2014 14:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=+B1convd81bqM7TYFfdpP5vcRruEDA8hMYjncxDL5IU=;
        b=qWFqEL6HhTFRa4H4prR1/3CFT+/j6lcfd4mefnLD7UIt+8S7cuK9gcnrzbAzS20vmh
         pv1cSHIK3gyAaftW/ZQztAk0cqSHUKj9jJ7rE3F5yeaib+lKUsYqhGrq8tBfZKkcfBfz
         LhmtZ6ROESlB9J1zFaUx/jxGhP7+7Uz7Duvm6mfG6zUerNvLaPrCemFvw2AOr3evhsmb
         0NsXUkH5MXS1HoXfQuMGN/0n0pYGl5q45UewKVgle/gLXAccHVOEm8VvemGMdmxRKRgx
         D7+7FYORua+oFLcZ6rYOVUmTN6UaBYYT9ZiyghROfomONosIfTdAGY21zoc7IbukBTzV
         myBA==
X-Received: by 10.66.233.72 with SMTP id tu8mr23711007pac.112.1399499652789;
        Wed, 07 May 2014 14:54:12 -0700 (PDT)
Received: from [10.68.252.199] ([101.119.26.148])
        by mx.google.com with ESMTPSA id yv7sm119144888pac.33.2014.05.07.14.54.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 14:54:11 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <1399185212-17833-1-git-send-email-nod.helm@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248383>

On 4 May 2014 16:33:32 GMT+10:00, James Denholm <nod.helm@gmail.com> wrote:
>cmd_add_commit() is passed FETCH_HEAD by cmd_add_repository, which is
>then rev-parsed into an object ID. However, if the user is fetching a
>tag rather than a branch HEAD, such as by executing:
>
>$ git subtree add -P oldGit https://github.com/git/git.git tags/v1.8.0
>
>The object ID is a tag and is never peeled, and the git commit-tree
>call
>(line 561) slaps us in the face because it doesn't handle tag IDs.
>
>Because peeling a committish ID doesn't do anything if it's already a
>commit, fix by peeling[1] the object ID before assigning it to $rev, as
>per the patch.
>
>[*1*]: Via peel_committish(), from git:git-sh-setup.sh
>
>Reported-by: Kevin Cagle <kcagle@micron.com>
>Diagnosed-by: Junio C Hamano <gitster@pobox.com>
>Signed-off-by: James Denholm <nod.helm@gmail.com>
>---
>NB: This bug doesn't surface when using --squash, as $rev is reassigned
>to the squash commit via new_squash_commit before git commit-tree sees
>it (though for simplicity, new_squash_commit now also sees the peeled
>ID).
>
>Also doesn't surface when using "git subtree merge", as git merge can
>handle tag objects.
>
>On a side note, if merging a tag without --squash, git merge recognises
>that it's a tag and adds a note to the merge commit body. It may be
>worth mimicking this when using "subtree merge --squash" or
>"subtree add".
>
> contrib/subtree/git-subtree.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/contrib/subtree/git-subtree.sh
>b/contrib/subtree/git-subtree.sh
>index dc59a91..9453dae 100755
>--- a/contrib/subtree/git-subtree.sh
>+++ b/contrib/subtree/git-subtree.sh
>@@ -538,7 +538,7 @@ cmd_add_commit()
> {
> 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
> 	set -- $revs
>-	rev="$1"
>+	rev=$(peel_committish "$1")
> 	
> 	debug "Adding $dir as '$rev'..."
> 	git read-tree --prefix="$dir" $rev || exit $?

I know that subtree isn't exactly the most popular or exciting part of
the project at the moment, but given that this is adding a subtree based
on an annotated tag is a reasonably sensible operation and (to me) the
fix seems reasonably trivial, could I get some eyes on this?

Regards,
James Denholm.
