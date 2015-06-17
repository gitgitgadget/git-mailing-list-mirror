From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: co-authoring commits
Date: Thu, 18 Jun 2015 00:07:28 +0200
Message-ID: <CAOvwQ4j+62ETPZbikkWeo45a=NgOAnf3uACLQm_D-bbpPoC22A@mail.gmail.com>
References: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com>
 <xmqq4mm66r99.fsf@gitster.dls.corp.google.com> <CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com>
 <20150617205931.GB24079@cloud> <xmqqegla57hl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 00:08:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5LVH-0003bS-N4
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 00:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267AbbFQWIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 18:08:11 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:34253 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbbFQWIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 18:08:09 -0400
Received: by obbsn1 with SMTP id sn1so42400600obb.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 15:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=326cxf2AFtTMnzrx63UjklzxTAdMg5H0kO+puvk7Jfg=;
        b=XeqWbN7QB97jndZ559wb/eWENZKlQR3CTDs+NoFXuR553ZOMb4c2qzgUnEp2ZPM29w
         dJAGEXDvLyF5DLGzdKNcR9v2qLOgHwNw1eviSGLjpzyB1dDlD316BLuFTorxGJ16QMWS
         gQx532kdqnH8kRR63zWQ+b8P2yoUOutjboXI4PJEq13YCswQbVFxDsireKUHJeihJTmN
         hLZs2iK+RVReeHexyfPeNKEssdTCu8ruiIinrhTEbEqcgCHqDLIe+9+znZ6KvH1NIt6Y
         kur5OoW7XNIHZBNhfYGAi2ETbcS2BiQoyEifyPh3CcQkYGCH/VT3ObE1oc6sMOJ0ulz1
         dX1A==
X-Received: by 10.182.24.97 with SMTP id t1mr6479250obf.32.1434578888720; Wed,
 17 Jun 2015 15:08:08 -0700 (PDT)
Received: by 10.76.158.202 with HTTP; Wed, 17 Jun 2015 15:07:28 -0700 (PDT)
In-Reply-To: <xmqqegla57hl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271920>

On Wed, Jun 17, 2015 at 11:51 PM, Junio C Hamano wrote:
> josh@joshtriplett.org writes:
>
> > Having more than one author field in a commit would likely break
> > things, but having a coauthor field seems plausible these days.
> > Git added support for signed commits, and the world didn't end, so
> > it's possible to extend the commit format.
>
> Something being possible and something being sensible are two
> different things, though.
>
> I agree "coauthor field that is not understood by anybody" would
> unlikely break existing implementations, but it is not a useful way
> to add this information to commit objects. For one thing, until you
> teach "git log" or its equivalents in everybody's (re)implementation
> of Git, the field will not be shown, you cannot easily edit it while
> amending or rebasing, "git log --grep=" would not know about it, and
> you would need "git cat-file commit" to view it.
>
> A footer Co-authored-by: does not have any such issue.
>
> We left commit headers extensible long before we introduced commit
> signing, and we used it to add the "encoding" header. In general, we
> invent new headers only when structurely necessary. When you declare
> that the log message for this indiviaul commit is done in one
> encoding, that is not something you would want to _edit_ with your
> editor while you are editing your message. Similarly you would not
> want to risk touching the GPG signature of a signed commit or a
> signed merge while editing your message.
>
> The _only_ reason I would imagine why somebody may be tempted to
> think that "coauthor" as part of the object header makes sense is
> because "author" is already there. You can argue that "author" did
> not have to be part of the object header, and that is right. I would
> agree with you 100% that "author" did not have to be there.
>
> But that is too late to change.
>
> And being consistent with a past mistake is not a good reason to
> repeat that same mistake.

Makes sense.

Without intimate knowledge of current internals,
what about the following potentially crazy plan?

1. demote/deprecate GIT_AUTHOR_*

2. implement a new author-ship model that supports both and treats the
   old entries as supported-but-deprecated

3. maybe auto-migrate entries in the repo, or add a switch to do that
   as part of git-gc or another process

4. extend tooling to support 'commit --add-author' or similar

5. teach git.git tools to properly display additional authors as
   equals in commit ownership

6. let other tools catch up, but rest assured nothing was broken

7. consider other use cases and different implementations
   (flexibility), to not have to repeat this 5 years down the road for
   another field
