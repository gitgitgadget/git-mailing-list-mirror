From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: [PATCH v5 2/5] setup: sanity check file size in read_gitfile_gently
Date: Tue, 28 Apr 2015 21:28:12 +0200
Message-ID: <CAMpP7NY76Tj_=_6Evxvox20OmQ5LnNiK1j4VHLd0jKhRmci51g@mail.gmail.com>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
	<1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
	<1430030985-14499-3-git-send-email-erik.elfstrom@gmail.com>
	<20150428060222.GK24580@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 28 21:28:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnBB4-0007JD-2U
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 21:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030765AbbD1T2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 15:28:13 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34523 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030721AbbD1T2N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 15:28:13 -0400
Received: by oiko83 with SMTP id o83so4516597oik.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 12:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xjvIVWC3XwtoP/GP8eCNayAT5sWxlqLHGmaztONdBvg=;
        b=oXcYvMgBJg49qNO/vTGh48lTvaONp31eFUxf/erQmBgzgGfPGDOxvgefzrYAOlHGBh
         vHlxNGhRimvsFpMLmFyFNIBx2G5eaCOh7z1CyNgOYL+xp7WLTXRiboDzjQzZFX8+up8J
         wLl6Hi0wMkom1vIdKVP+6Y2wlMxG48B6SK+dZWqAh5wmEfWCEQmE4aR9zPjoUyrz0h3x
         qDbEJK3pHku27ahfeNSeBj6/Vpdki2Cqy8UwEjX7NwyrJhLIqDBwUT7VTJrlJmaDKc8p
         XDX+WAA2Cs2ppo05m5HhVT/0wDRiBQYx4qeYFCc7CbdoGpGyO2LwJBJEScI5BQlb1wRe
         pujA==
X-Received: by 10.60.103.70 with SMTP id fu6mr15947397oeb.27.1430249292575;
 Tue, 28 Apr 2015 12:28:12 -0700 (PDT)
Received: by 10.182.154.72 with HTTP; Tue, 28 Apr 2015 12:28:12 -0700 (PDT)
In-Reply-To: <20150428060222.GK24580@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267934>

On Tue, Apr 28, 2015 at 8:02 AM, Jeff King <peff@peff.net> wrote:
>
> My understanding is that PATH_MAX is set absurdly low on Windows
> systems (and doesn't actually represent the real limit of a path!).
> Since the value is picked arbitrarily anyway, could use something more
> independent (like 100K or something, which is large enough to be beyond
> absurd and small enough that a malloc isn't a big deal)?
>
> -Peff

I'm happy to set the limit to anything that makes everybody feel safe. I'll set
it to 1MB to be on the safe side.

I'm not sure though how the code (in general) is supposed to keep working if
a path can exceed PATH_MAX? A cursory search for PATH_MAX comes
up with char array sizes and check-and-die kind of things. If a path is longer
then surely we will be unable to handle it and abort in all sorts of places?

Are you only worried we might have a submodule with a too long path (that will
create various other problems in different codepaths) that we may mistakenly
clean (if it doesn't trigger any other abort earlier in the clean call
chain) or do
you want clean to keep working and do the right thing even in this case?

While digging around looking at this I also noticed that there is
another problem
I have overlooked previously.

read_gitfile_gently will call is_git_directory at the very end and it
contains the
following check at the very beginning:

    if (PATH_MAX <= len + strlen("/objects"))
        die("Too long path: %.*s", 60, suspect);

Now, this is good in the way that we will avoid mistakenly cleaning
stuff because
the path is too long but also bad because it makes read_gitfile_gently
behave very
ungently in this case.

I suspect I should make a gentle version of this also. The question is
what to do
in clean if the path is reported as too long? Abort? Avoid cleaning it
to be safe?
Ignore and clean it?

is_git_directory is also called from the new is_git_repository
directly but here I think
dying is ok since this path is a path in the working tree and if we
can't handle the paths
in the tree then there seem to be little point in trying to go on (as
opposed to when
some string in a file is too large for a path)

Thoughts?

/Erik
