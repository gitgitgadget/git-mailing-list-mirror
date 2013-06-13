From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/4] push: make upstream, simple work with pushdefault
Date: Thu, 13 Jun 2013 14:40:44 +0530
Message-ID: <CALkWK0mDDKETE1O=g7X5s5MJvU7UA_NQiMNESor_8=phW0WR-A@mail.gmail.com>
References: <1370798000-2358-1-git-send-email-artagnon@gmail.com>
 <1370798000-2358-3-git-send-email-artagnon@gmail.com> <7vip1moq3k.fsf@alter.siamese.dyndns.org>
 <CALkWK0mesZay8Cpi6yTvhUG=136=9JLyFUZXm8t_fMOrY0F62Q@mail.gmail.com>
 <7v4nd6l31d.fsf@alter.siamese.dyndns.org> <CALkWK0mY5=H6FoUZCOXTYykEV1f=3wrP21WPXj1v4VBCeOxocg@mail.gmail.com>
 <7vwqq2j7c9.fsf@alter.siamese.dyndns.org> <CALkWK0mfWs3LBocvn=QMcX0_ZCROx4Nw=+xjpCbKLQU0JzSdXg@mail.gmail.com>
 <7vobbdhjeg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Leandro Lucarella <leandro.lucarella@sociomantic.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 11:11:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un3Z7-00010L-0l
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 11:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757500Ab3FMJL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 05:11:28 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:53298 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758254Ab3FMJL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 05:11:26 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so7737751iec.8
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 02:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Pv6M/xoClMYGK21tw+r2v9uZKfMF3cSm/fVSq5McvtM=;
        b=tK/6onp9KiJTtJk8WoV7pVsbDU7ONIryjWlMQSeBDJlVb8PnOQu1L6LzExEVraumgE
         hcS0ygcMbspMBAJJB2augAR2QLhcDKK/wWXg6QubycuhjV2K3OrUbhjwsTeNnobL5kej
         pvklAa/JdJf4Gc5vfs6GV3naV63pODzbuKC1VkZtqbNypFomLKFO1ZuylR+W3EUwhOvM
         dCbx787DjqSud3bs1zAFg7/nU6B0BBOwKEXtxNrhO7VDt37pglVR4D6H5vHyEGCSB/Ai
         xiRP3ddDcA11oRZxrWLlMcXn2J0eGzrRc/heeOOcQeJT21eKFSzVxQTpiGeXuInWDTXK
         fw0w==
X-Received: by 10.50.56.20 with SMTP id w20mr5116840igp.40.1371114686207; Thu,
 13 Jun 2013 02:11:26 -0700 (PDT)
Received: by 10.204.186.77 with HTTP; Thu, 13 Jun 2013 02:10:44 -0700 (PDT)
In-Reply-To: <7vobbdhjeg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227707>

Junio C Hamano wrote:
> If you recall the earlier discussion on "@{publish} which is
> different from @{upstream}", one idea to allow mapping on the push
> end was to introduce "push.default = single" that would act as
> "upstream" when in "branch I fetch and integrate with is the same
> branch at the same repository the one I want to update with my
> result" workflow, and in a triangular workflow maps the branch being
> pushed using remote.$name.push refspecs (if exists).

I'm still resisting this idea, because I don't like these special-case
push.default modes.  If possible, I want to avoid introducing another
one to the existing mess.

> [...]

Okay, so what you're saying makes sense.  I'm cooking the following idea:

- current: push "$(HEAD)".  No restrictions on destination.  The most
generic, sensible, and extensible one, in my opinion.

- matching: push ":" to the destination specified by the current
branch. [since I cannot know what I'm pushing in advance, I think this
is generally ugly]

- upstream: In the special case when fetch source is equal to push
destination, push "$(HEAD):$(branch.$(HEAD).merge)".  Otherwise,
fallback to current.  Useful in central workflows.

- simple: [still haven't thought about what to do with this; I'm
generally not in favor of artificially crippling functionality by
erroring out]

Just like upstream respects branch.<name>.merge, current respects
branch.<name>.push, making branch-level ref mapping in triangular
workflows possible.  Finally, remote.<name>.push is entirely
orthogonal to all this, and is respected no matter what.

Am I making any sense?
