From: Paul Sokolovsky <paul.sokolovsky@linaro.org>
Subject: Re: git 2.2.x: Unexpected, overstrict file permissions after "git
 update-server-info"
Date: Tue, 6 Jan 2015 14:12:11 +0200
Organization: Linaro
Message-ID: <20150106141211.2ad83df4@x230>
References: <20150105210724.032e9718@x230>
	<20150106034702.GA11503@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 06 13:18:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8Szr-0001G3-UA
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 13:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbbAFMMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 07:12:18 -0500
Received: from mail-la0-f52.google.com ([209.85.215.52]:48642 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbbAFMMR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 07:12:17 -0500
Received: by mail-la0-f52.google.com with SMTP id hs14so19562990lab.25
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 04:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-type
         :content-transfer-encoding;
        bh=WNHXwloEjRJVx/oqA1ySqb1yMYjD6wAJ0fYyKi6mylo=;
        b=LdCQ+k1HWmraklHRUrGnSCD7rVPrg4OeWnJYf4FE2srjiHOG6Rzt4PMgDaGRZ7xfnn
         9GfhF+dvUgy/g35ff3W/U0QTvLQctBWay1A+8urgXIJ9bZ2U9ZOY0uCpcptYIA86UA/N
         LzGe7kZEpFmBBREQjYZK7jSZf3x0/J1Jg7wb0J2C87L4BZPExEWjd/L+xmv6gC2VURkI
         cTtAKtI10KUl36GUphgOlUPO4O583t95LNYQPt/wu2a+ZylF/hbKsizP07icF6f3MS+I
         ln1FqKMOUasA2tD0rWr8bEJaO9d3GmuNIvbIQOUCLWawc+u0D2wYpqOeuDTaRVYP7eLl
         6pYg==
X-Gm-Message-State: ALoCoQlrbBAbstueKiCcocJMVHnhuJKgHlgLB5/+RaQN0VQHHJVFNMNlxLCkUOxLIJUM1WTI8Pvn
X-Received: by 10.153.8.132 with SMTP id dk4mr95284911lad.56.1420546336144;
        Tue, 06 Jan 2015 04:12:16 -0800 (PST)
Received: from x230 ([91.225.122.14])
        by mx.google.com with ESMTPSA id kk7sm15333215lbc.33.2015.01.06.04.12.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 04:12:15 -0800 (PST)
X-Google-Original-From: Paul Sokolovsky <Paul.Sokolovsky@linaro.org>
In-Reply-To: <20150106034702.GA11503@peff.net>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262060>

Hello,

On Mon, 5 Jan 2015 22:47:02 -0500
Jeff King <peff@peff.net> wrote:

> On Mon, Jan 05, 2015 at 09:07:24PM +0200, Paul Sokolovsky wrote:
> 
> > So, after the upgrade, users started to report that accessing
> > info/refs file of a repo, as required for HTTP dump protocol, leads
> > to 403 Forbidden HTTP error. We traced that to 0600 filesystem
> > permissions for such files (for objects/info/packs too) (owner is
> > gerrit user, to remind). After resetting permissions to 0644, they
> > get back to 0600 after some time (we have a cronjob in addition to
> > a hook to run "git update-server-info"). umask is permissive when
> > running cronjob (0002).
> > 
> > I traced the issue to:
> > https://github.com/git/git/commit/d38379ece9216735ecc0ffd76c4c4e3da217daec
> 
> Yeah, I didn't consider the mode impact of using mkstemp. That is
> definitely a regression that should be fixed. Though of course if you
> really do want 0644, you should set your umask to 0022. :)

Well, group permissions are ok - we just need it to be world-readable,
and that's not random, but complies with hosting requirements - our
repos are public otherwise.

> > It says: "Let's instead switch to using a unique tempfile via
> > mkstemp." Reading man mkstemp: "The  file  is  created  with
> > permissions 0600". So, that's it. The patch above contains call to
> > adjust_shared_perm(), but apparently it doesn't promote restrictive
> > msktemp permissions to something more accessible.
> 
> If you haven't set core.sharedrepository, then adjust_shared_perm is a
> noop. But you shouldn't have to do that. Git should just respect your
> umask in this case.

My reference to adjust_shared_perm() was because I initially wanted to
write "apparently, it makes sense to do chmod after mkstemp()", but I
spotted that there's adjust_shared_perm() already, which does some
shuffling of permissions.

> > Hope this issue can be addressed.
> 
> Patches to follow. Thanks for the report.
> 
>   [1/2]: t1301: set umask in reflog sharedrepository=group test
>   [2/2]: update-server-info: create info/* with mode 0666

Thanks much for the prompt reply and patches!

> 
> -Peff



-- 
Best Regards,
Paul

Linaro.org | Open source software for ARM SoCs
Follow Linaro: http://www.facebook.com/pages/Linaro
http://twitter.com/#!/linaroorg - http://www.linaro.org/linaro-blog
