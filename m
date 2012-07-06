From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 4/6] Teach "git remote" about remote.default.
Date: Fri, 6 Jul 2012 08:51:35 -0400
Message-ID: <CABURp0oYfzKrkKOZJrH2hrYMTPbFe_i5mMKQ3HnWQdGZa=oujw@mail.gmail.com>
References: <1341526277-17055-1-git-send-email-marcnarc@xiplink.com> <1341526277-17055-5-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de,
	peff@peff.net
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Fri Jul 06 14:52:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn813-0002Za-LN
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 14:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757285Ab2GFMv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 08:51:57 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46087 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755814Ab2GFMv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 08:51:56 -0400
Received: by yhmm54 with SMTP id m54so9320468yhm.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 05:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lLJLnSrd8X7eZvWfXLFiUKieRvVR5iI3mwJGgyxAJRw=;
        b=cg68kijA2S452uvQWPzykKxySRSiFcQjJlSx5IJ4sXDMhFlocueVp0vZpms5089nkv
         j19tMcYQ4ffwuaFgVwzuJtOi9jGDjOpY/iwEHYKmgEqwriiuuRfWrzfytbAX1HX3Wc6d
         NHQsuo6vLmF2tmI+/1pqykLBEXGZglDJL5TTamsk5JHvXqMdoG8V3XlmDNkkodJOaedS
         fG3/AtzN4MfRlcP5OIZ5BlxHr/VegmyPpWRPvjdu/aFBR4VBT5drtkX0+atZ6qWOnXwx
         Z4yae2Md0sauAKeS58BzPrkDdQaz0Uxp4WLKQyEiajsMFeydsV+TuahF6N5dbzg9tjry
         oYMg==
Received: by 10.236.138.136 with SMTP id a8mr35080266yhj.65.1341579115991;
 Fri, 06 Jul 2012 05:51:55 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Fri, 6 Jul 2012 05:51:35 -0700 (PDT)
In-Reply-To: <1341526277-17055-5-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201111>

On Thu, Jul 5, 2012 at 6:11 PM,  <marcnarc@xiplink.com> wrote:
> From: Marc Branchaud <marcnarc@xiplink.com>
>
> The "rename" and "rm" commands now handle the case where the remote being
> changed is the default remote.

I think this is the right thing to do.  But I noticed a subtle
behavior change that we may wish to consider.

Today I might do this (contrived example):

git checkout somelocalbranch
git push # pushes to "origin" by default
git remote rename origin origin1
git add origin ssh://new-server/foo
git push  # pushes to "origin" by default

But after this change, the last command is different.  Now it pushes
to "origin1" because the rename set the remote.default to "origin1",
even though it was previously not set at all.  It did this because the
"oldname" is compared to the "remote_get_default_name()", which
returns "origin" by default.  So the old setting, which did not exist,
is now "renamed" to have an actual value, and the actual value is not
"origin".

One can easily contrive an alternative example showing that this is a
good thing.  As I said, I think it is the right thing to do.

But it is different, I think.

I doubt many script writers are counting on default settings to carry
the day, so they are probably more explicit about how they push.  But
I didn't see this mentioned in the patch.

Phil
