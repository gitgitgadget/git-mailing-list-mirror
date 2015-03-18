From: Chris Packham <judge.packham@gmail.com>
Subject: Re: git submodule: update=!command
Date: Wed, 18 Mar 2015 20:38:31 +1300
Message-ID: <CAFOYHZA=d94swSvfrR0+RdfVrf8a5RwwnYPphtnKz44O_nFeCg@mail.gmail.com>
References: <1426620537.1785877.241673949.72FB3B40@webmail.messagingengine.com>
	<20150317195030.GA18725@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ryan Lortie <desrt@desrt.ca>, GIT <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 18 08:38:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY8Yo-00027D-D3
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 08:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256AbbCRHid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 03:38:33 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34729 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744AbbCRHic (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 03:38:32 -0400
Received: by pacwe9 with SMTP id we9so34764103pac.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 00:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+5j2e6a95++pArLymkn1kWsUNkRtaB9e70d+PMAL97o=;
        b=FIPBzlK4LOzCulCfIma0uSeQ2ZGjRSJB6sUXzj29cfeOS0LSq3TncFQgYw40+ouuXm
         Hl3xNySun6PJ7xZKEbdGS/ozQDeYTuvGfLvZrpiQkLqa+FIitL/Bah1pGO3MmLXxT0mj
         Z7wQhlJb0MAYKh5Uv0rTJhCZAQuh6aMju6487cl7hpJC4rXXg0z88Q/z/Bt4h+v8f0Lf
         j+tG38OzXtDj2Vft2HUX1UTmj4C2tsIGJ/qKhhF9PE9Pv6QNF5VOdHq2CJf/0zNum4U9
         mpg54y3bDfWCu6f20RA1A3J/DNLpuC7tuSl93Cm1TRF4hFMtp40CtJ+wVX+NA8JkURxi
         s71w==
X-Received: by 10.70.127.140 with SMTP id ng12mr135466228pdb.24.1426664311938;
 Wed, 18 Mar 2015 00:38:31 -0700 (PDT)
Received: by 10.70.0.171 with HTTP; Wed, 18 Mar 2015 00:38:31 -0700 (PDT)
In-Reply-To: <20150317195030.GA18725@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265688>

A little late to this thread

On Wed, Mar 18, 2015 at 8:50 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 17, 2015 at 03:28:57PM -0400, Ryan Lortie wrote:
>
>> The first is a question about git's basic policy with respect to things
>> like this.  I hope that it's safe to assume that running 'git' commands
>> on repositories downloaded from potentially-hostile places will never
>> result in the authors of those repositories being able to run code on my
>> machine.
>
> Definitely, our policy is that downloading a git repository should not
> result in arbitrary code being run. If there is a case of that, it would
> be a serious security bug.
>
> I am not an expert on submodules, but I think the security module there
> is:
>
>   1. You can do whatever you like in submodule.*.update entries in
>      .git/config, including arbitrary code. Nobody but the user can
>      write to it.

Which was always the intention of the !command feature. It's for users
who want to use additional git porcelains that need some help dealing
with submodule updates (e.g stgit).

>   2. The submodule code may migrate entries from .gitmodules into
>      .git/config, but does so with an allow-known-good whitelist (see
>      git-submodule.sh lines 622-637).
>
> So AFAICT there's no bug here, and the system is working as designed.
> It might be worth mentioning that restriction in the submodule
> documentation, if only to prevent non-malicious people from wondering
> why adding "!foo" does not work in .gitmodules.

At the time the !command feature and copying of update config from
.gitmodules slid past each other on the list. But out of that I think
we got a much better handling that provides security and version
compatibility.

>> If that is true then, the second request would be to spell this out more
>> explicitly in the relevant documentation.  I'm happy to write a patch to
>> do that, if it is deemed appropriate.
>
> Yeah, spelling out the security model more explicitly would be good.
> There is also some subtlety around hooks. Doing:
>
>   git clone user@host:/path/to/repo.git local
>
> should never run code controlled by "repo.git" as "user@host". But
> doing:
>
>   ssh user@host 'cd /path/to/repo.git && git log'
>
> will respect the .git/config in repo.git, which may include arbitrary
> commands.
>
> -Peff
