From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH] contrib/subtree bugfix: Crash if FETCH_HEAD is tag
Date: Thu, 8 May 2014 11:04:29 +1000
Message-ID: <CAHYYfeENvT7Oe3DXSEAXuNpyd+kbKMvKZau0L9YGtaZmTaxeaw@mail.gmail.com>
References: <1399185212-17833-1-git-send-email-nod.helm@gmail.com>
	<df8addda-8c59-480a-ac52-a958de9d43c9@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Cagle <kcagle@micron.com>,
	Junio C Hamano <gitster@pobox.com>,
	James Denholm <nod.helm@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 08 03:04:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiClH-0008T9-Bh
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 03:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbaEHBEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 21:04:31 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:46870 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbaEHBEa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 21:04:30 -0400
Received: by mail-ve0-f179.google.com with SMTP id oy12so2375412veb.10
        for <git@vger.kernel.org>; Wed, 07 May 2014 18:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kwnjW3l5SSGFsVzqhXRewz1EGRpQAP3SO386h4ZW+kY=;
        b=c453s0LVrgxPtNKtDEqpNDorvClYUNVkbcvqVR+o1UdZJp4ed9JMrSn0pOBP8ub6H2
         ZA5liGq/a4AZGxU8xWJcv7iRicKBIbxbDyoMn2t7pWfkTw1hxXfbCNdkAtEkFgwyxXfk
         GocUIdXmP7oeg2C8QCBnu+FhD+epNdSGd7r74yj6diE5PKZRglPWxun/WfoWDyzyqgL9
         n0nftR3HW58rxklJQPxj5oPmbrBeCaCyTzn1RfY7Mw0Ts5Z+nvLyq0FmkaHcyFol4HkX
         3c98Wh77AZRpQ3vhMFbsMhVjv5VpvKSdjtRTCMhQEqJhRWncxu1yY0Xb+ex9pDyaWcHl
         t50A==
X-Received: by 10.220.167.2 with SMTP id o2mr312489vcy.8.1399511069793; Wed,
 07 May 2014 18:04:29 -0700 (PDT)
Received: by 10.58.12.2 with HTTP; Wed, 7 May 2014 18:04:29 -0700 (PDT)
In-Reply-To: <df8addda-8c59-480a-ac52-a958de9d43c9@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248394>

After a closer look, it seems the initial patch wasn't correctly sent
to the list. Please disregard, I'm re-sending the patch entirely.

Regards,
James Denholm.

On 8 May 2014 07:53, James Denholm <nod.helm@gmail.com> wrote:
> On 4 May 2014 16:33:32 GMT+10:00, James Denholm <nod.helm@gmail.com> wrote:
>>cmd_add_commit() is passed FETCH_HEAD by cmd_add_repository, which is
>>then rev-parsed into an object ID. However, if the user is fetching a
>>tag rather than a branch HEAD, such as by executing:
>>
>>$ git subtree add -P oldGit https://github.com/git/git.git tags/v1.8.0
>>
>>The object ID is a tag and is never peeled, and the git commit-tree
>>call
>>(line 561) slaps us in the face because it doesn't handle tag IDs.
>>
>>Because peeling a committish ID doesn't do anything if it's already a
>>commit, fix by peeling[1] the object ID before assigning it to $rev, as
>>per the patch.
>>
>>[*1*]: Via peel_committish(), from git:git-sh-setup.sh
>>
>>Reported-by: Kevin Cagle <kcagle@micron.com>
>>Diagnosed-by: Junio C Hamano <gitster@pobox.com>
>>Signed-off-by: James Denholm <nod.helm@gmail.com>
>>---
>>NB: This bug doesn't surface when using --squash, as $rev is reassigned
>>to the squash commit via new_squash_commit before git commit-tree sees
>>it (though for simplicity, new_squash_commit now also sees the peeled
>>ID).
>>
>>Also doesn't surface when using "git subtree merge", as git merge can
>>handle tag objects.
>>
>>On a side note, if merging a tag without --squash, git merge recognises
>>that it's a tag and adds a note to the merge commit body. It may be
>>worth mimicking this when using "subtree merge --squash" or
>>"subtree add".
>>
>> contrib/subtree/git-subtree.sh | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/contrib/subtree/git-subtree.sh
>>b/contrib/subtree/git-subtree.sh
>>index dc59a91..9453dae 100755
>>--- a/contrib/subtree/git-subtree.sh
>>+++ b/contrib/subtree/git-subtree.sh
>>@@ -538,7 +538,7 @@ cmd_add_commit()
>> {
>>       revs=$(git rev-parse $default --revs-only "$@") || exit $?
>>       set -- $revs
>>-      rev="$1"
>>+      rev=$(peel_committish "$1")
>>
>>       debug "Adding $dir as '$rev'..."
>>       git read-tree --prefix="$dir" $rev || exit $?
>
> I know that subtree isn't exactly the most popular or exciting part of
> the project at the moment, but given that this is adding a subtree based
> on an annotated tag is a reasonably sensible operation and (to me) the
> fix seems reasonably trivial, could I get some eyes on this?
>
> Regards,
> James Denholm.
