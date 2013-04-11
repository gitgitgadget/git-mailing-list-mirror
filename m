From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] transport-helper: update remote helper namespace
Date: Wed, 10 Apr 2013 23:53:38 -0500
Message-ID: <CAMP44s0FkiwPMJVhVBNa32J3rgghRZy6xDTN-YnHKcQ4Fj0BMQ@mail.gmail.com>
References: <1365638832-9000-1-git-send-email-felipe.contreras@gmail.com>
	<1365638832-9000-3-git-send-email-felipe.contreras@gmail.com>
	<20130411043346.GE14551@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 06:53:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ9WC-0003T6-DX
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 06:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237Ab3DKExq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 00:53:46 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60688 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab3DKExj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 00:53:39 -0400
Received: by mail-wg0-f44.google.com with SMTP id z11so1179650wgg.11
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 21:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Kt8BStIatNJhQXH1owaC3Q4L77wA6FP+9pMjMF+xpBE=;
        b=R4ktJ1XKc4lRhSb3W/hS14eif4XKpVq2ycYLM2n6mbOcApWRcvhDWoD2AMFXC/ScgZ
         hk0NVl29TBbu9Yr/jSR1mu8OJ4ggnoqKoPXjVVLUi5YsrC9tvbQJjzx7Chr9sBcou4cJ
         6xlYFCywbieagfO7sJNg2aFR7PfzlaY/SWIHxqcghLRnjnnSZ3HcqnAqzvQvMOlioJ2D
         aV0SQ4ma1Gi4PON2XCc/oyU5FSrR0JGLC2fEpcDsItVyLjteuYd3gPF2RK2QJTrjqOa1
         NkQoSJzzkeXhVNH6zOAlmzKr4r503zt/tVW0XyuMEocmyrXhayO5eMMe4r7yY6AbzhKt
         BV6w==
X-Received: by 10.194.109.35 with SMTP id hp3mr7802418wjb.15.1365656018447;
 Wed, 10 Apr 2013 21:53:38 -0700 (PDT)
Received: by 10.194.170.196 with HTTP; Wed, 10 Apr 2013 21:53:38 -0700 (PDT)
In-Reply-To: <20130411043346.GE14551@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220818>

On Wed, Apr 10, 2013 at 11:33 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Apr 10, 2013 at 07:07:12PM -0500, Felipe Contreras wrote:
>
>> When pushing, the remote namespace is updated correctly
>> (e.g. refs/origin/master), but not the remote helper's
>> (e.g. refs/testgit/origin/master).
>>
>> Let's update it correctly.
>
> I would have thought it was the helper's responsibility to update these.
> Obviously remote-testgit can handle this fine, but will any other
> helpers be using these refs as a marker to know the last point they
> imported, and get confused if we update the refs behind their back?
>
> For example, during the import, a helper might know that it has imported
> up to X on a foreign vcs, and that resulted in commit Y in git, which it
> stored in refs/$helper/heads/master during the last import. When we
> fetch from it again, it picks up from X to the tip of the foreign vcs,
> and then imports that history on top of commit Y.
>
> But if we push some commits to the helper, moving Y up to Z, then it
> would build the new commit (which contains the foreign-vcs's equivalent of
> Y..Z) on top of Z, not Y.

Why would it do that? If X points to say revision 100, presumably it
was stored somewhere while doing a fetch. Similarly, if foreign
version of Z is 150, it can update that number while doing a push. The
next fetch it would start from 151.

All this is hypothetical of course, because...

> I do not offhand know of any helpers that are implemented this way,
> though. vcs-svn does not seem to use the refspec feature at all, and I
> assume that your hg/bzr helpers do not have this problem. So perhaps it
> is not worth worrying about.

They cannot be implemented this way, because as I have already argued
and shown[1], remote helpers must be using marks, they don't work
otherwise (transport helper is broken for those cases).

Cheers.

[1] http://article.gmane.org/gmane.comp.version-control.git/210306

--
Felipe Contreras
