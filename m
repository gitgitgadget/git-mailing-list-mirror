From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 04/10] check_repository_format_gently: stop using git_config_early
Date: Thu, 3 Mar 2016 20:08:40 +0700
Message-ID: <CACsJy8Cvap9sJ39LnOCp5hMdYgoNR_HD18br+wWTWAZrCBaXaQ@mail.gmail.com>
References: <20160301143546.GA30806@sigill.intra.peff.net> <20160301144039.GD12887@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 03 14:09:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abT0S-0007Vz-R6
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 14:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757718AbcCCNJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 08:09:13 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:35673 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757715AbcCCNJM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 08:09:12 -0500
Received: by mail-lb0-f176.google.com with SMTP id bc4so22580031lbc.2
        for <git@vger.kernel.org>; Thu, 03 Mar 2016 05:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1QeMHRZfXyoplLgYu0a5ERWvKmhVB3y26J7ZhxskLWk=;
        b=RSZL/7k10yujp15gKPOzhniL2ePSbAUuH/cavN12wE4PEVJQ1ZCrK8MM3fq6vOpF6p
         uTjvuF1i9mSzP2mDMAfdcZhoIY10q4/sjYWEkEwinEnOp/A5gByZVB7vmGOESINx1dtn
         6pLks9EiWZ1FMNdyOn9dP5LjtYjSDP5BGrxrzctK6KBaGVzIN0PWbOrvUKKIAGsSW1s4
         Su8/5SQFgDl6pIJdUwtj6vxwuqAWtvcBYfokHA78xRU9grPVXE6Pk3Loj0EdD8iXBaYD
         x/voB3xf3cNekfUJdU5Ns171zUFdjwh+kshSlN05CoTJLq+KqTqcT9CQ/64mQW0GEzgv
         2LPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1QeMHRZfXyoplLgYu0a5ERWvKmhVB3y26J7ZhxskLWk=;
        b=JktopLc/dSZVuaamIyV2v7r+P2ijhphSY+R4TVp3jQh9W1iHBQxRxhA6LwGTRPLImQ
         vI2t7carAzsk9kYF1PY5LUk9Cp8M2dWgPko99s/4+m2QjTQ99+iEU8szlFy8JOoeJ9Ff
         +4pLMEN5IuNyCYvOGLM+nwqEv10uP8QbJdJxNBLUCiWxfAC8i5RoAtrqdLqA5bPqkWXW
         SNUvYuA9d+aKurkyJ270dnJ9SYaobDvCm3cSS+YBbSvaiiTLupW0HFodHZt46Bv6kCjj
         b9T44rHsZkdTWDvmMjyz0w79byH0PEtYs0ONwGLYPBzzRevCv1NOlJwvVzJwcbBliqj2
         Qtog==
X-Gm-Message-State: AD7BkJL4T46Lw3m3tEMTc8ZJTXRn2yjtCQ0EApVsHvGZ6g5/zPNBl46+l3x59P8oA4o9CJlac7XcsG4BWXNJDQ==
X-Received: by 10.25.212.213 with SMTP id l204mr1016751lfg.118.1457010550463;
 Thu, 03 Mar 2016 05:09:10 -0800 (PST)
Received: by 10.112.34.162 with HTTP; Thu, 3 Mar 2016 05:08:40 -0800 (PST)
In-Reply-To: <20160301144039.GD12887@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288176>

On Tue, Mar 1, 2016 at 9:40 PM, Jeff King <peff@peff.net> wrote:
> There's a chicken-and-egg problem with using the regular
> git_config during the repository setup process. We get
> around it here by using a special interface that lets us
> specify the per-repo config, and avoid calling
> git_pathdup().
>
> But this interface doesn't actually make sense. It will look
> in the system and per-user config, too; we definitely would
> not want to accept a core.repositoryformatversion from
> there.
>
> The git_config_from_file interface is a better match, as it
> lets us look at a single file.

Let's see. We look at core.worktree, core.bare,
core.repositoryformatversion, and extensions.* in this code. The first
three should definitely per-repo (and should be mentioned in the
commit as well). But what about the last one? Any possible use case
that wants to enable, say extensions.preciousobjects, for all repos?
Yes we would need to switch core.repo..version to 1 to take effect,
but that does not actually eliminate this case.. just thinking out
loud...
-- 
Duy
