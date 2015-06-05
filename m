From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [RFC] git-am: handling unborn branches
Date: Fri, 5 Jun 2015 14:37:24 +0800
Message-ID: <CACRoPnS9UK0ebD2JdSfun8+F0MXj6Loza4Y07whqbO6tV4_APQ@mail.gmail.com>
References: <CACRoPnSmF0ym7ONnLAfL=o5ouSrP2Ucxdh40k6Ps-hnTsSUx4w@mail.gmail.com>
	<xmqqpp5bv0z9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 08:37:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0lG2-0001rR-26
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 08:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbbFEGh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 02:37:29 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36647 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378AbbFEGhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 02:37:25 -0400
Received: by wiam3 with SMTP id m3so8385210wia.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 23:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+qFsNEg8G9bdLdJWPj1J1+Dh0TRffmsfqGP4o3nzpeI=;
        b=oQz06dwE1d8+1HQ0OXvqqsvo1Ou4g812TJd5JhPkFwrThZP5nnFcd8zIAA8Bh2UA7W
         7Hn9kuYvaz7nySex+/i20AQKzMQU3jTANre/DeHfvgnx/BwJbC9smBbkMospymUpLrcB
         4Weg415hFdf4Ko1E5IkbcTfVVT91k7qXJc2hqTyc/3xNHCWf/LxYsyBH+zIwvpOmntVp
         vK2HJObIhHgE+d+5BLA0OTILKoY4wstQrJMYFugpBSPE6VMwXpk+/HBX2EwE5GAbxmg6
         kW9ynD37n72ZU+ra8pnjl15DotZhp9F7dA2l+Dd4SWwyF2aA1tV/egQ6EyvbW7UTSIMv
         ezqQ==
X-Received: by 10.194.176.225 with SMTP id cl1mr3405843wjc.45.1433486244714;
 Thu, 04 Jun 2015 23:37:24 -0700 (PDT)
Received: by 10.194.85.113 with HTTP; Thu, 4 Jun 2015 23:37:24 -0700 (PDT)
In-Reply-To: <xmqqpp5bv0z9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270813>

On Fri, Jun 5, 2015 at 1:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> git-am generally supports applying patches to unborn branches.
>> However, there are 2 cases where git-am does not handle unborn
>> branches which I would like to address before the git-am rewrite to C:
>
>> 1. am --skip
>>
>> For git am --skip, git-am.sh does a fast-forward checkout from HEAD to
>> HEAD, discarding unmerged entries, and then resets the index to HEAD
>> so that the index is not dirty.
>>
>>         git read-tree --reset -u HEAD HEAD
>>         orig_head=$(cat "$GIT_DIR/ORIG_HEAD")
>>         git reset HEAD
>>         git update-ref ORIG_HEAD $orig_head
>>
>> This requires a valid HEAD. Since git-am requires an empty index for
>> unborn branches in the patch application stage anyway, I think we
>> should discard all entires in the index if we are on an unborn branch?
>
> Yes, and it should also remove the new files the failed application
> brought in to the working tree, if any, to match the "--skip" done
> in the normal case (i.e. when we already have a history to apply
> patches to), I would think.

Hmm, actually git-am.sh doesn't seem to do that even when we have a
history to apply patches to. This is okay in the non-3way case, as
git-apply will check to see if the patch applies before it modifies
the index, but if we fall back on 3-way merge, any new files the
failed merge added will not be deleted in the "git read-tree --reset
-u HEAD HEAD".

Should we do that? I dunno, but if we want to introduce this feature,
I think a "git read-tree --reset HEAD HEAD && git read-tree -m -u
$(git write-tree) HEAD" will do the trick? (We discard all unmerged
entries, then fast-forward from the tree the failed merged left us
with back to HEAD).

Clearing the index in the unborn branch case seems to be the most
consistent thing to do for now (for the purpose of the git-am
rewrite).

Thanks,
Paul
