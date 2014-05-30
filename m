From: Chris Packham <judge.packham@gmail.com>
Subject: Re: .gitmodules containing SSH clone URLs should fall back to HTTPS
 when SSH key is not valid/existent
Date: Fri, 30 May 2014 16:51:20 +1200
Message-ID: <CAFOYHZAMEfkadzaxaYjETb5oxR25HgXZJeiPdzVGxUT-9KP+cA@mail.gmail.com>
References: <CA+OJ3uv0XqeodTCzeauUrH9FjzknBupMd5kxh+3qgyji5TwOzA@mail.gmail.com>
	<53871B8D.40608@web.de>
	<CA+OJ3utofb+od5uct4HF1yoQGfWgX7YTn4hPChDpC7LTFVJDYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, GIT <git@vger.kernel.org>,
	John Albietz <inthecloud247@gmail.com>
To: Jonathan Leonard <johanatan@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 06:51:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqEmu-000259-3X
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 06:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691AbaE3EvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 00:51:22 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:56535 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598AbaE3EvU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 00:51:20 -0400
Received: by mail-pd0-f172.google.com with SMTP id fp1so527639pdb.17
        for <git@vger.kernel.org>; Thu, 29 May 2014 21:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WSzx3ETRB9X5kNj4QQV5HRna6wFOyp/9nJUYGvZtBcg=;
        b=eO5odK8Jrip+Yy0hnjTML0V1An7LXtu7mfabozDMlPf1eKW3Vg/Be4nv5P5SBQouko
         XbSMJjoDWA3DDL1hYvycH8fWgMP2fmQ+7ux6Y3XhyQ2guUsEOiFiFYYXo/i5Tx/5aQa5
         2c2+izVtdcssSDjDS6IZR7tjWmheqVwH81eY2e/IFRC3Q0mVP8CCOCGax/bXQmZ5mCPq
         ULmwcR5UMsC6MY/qNW5aZ1Zu4FmH8qZGfH8QXpjBsVkh6pLeQV8wwd3QwmLOCLIQfDWe
         J5X/vHZCsYTOkYX8hH/6tAywSTdu56cJVeaPTOFrJ5oTirr9VZ0TXLPWySkFrUII56gT
         Rexg==
X-Received: by 10.66.244.109 with SMTP id xf13mr15410396pac.28.1401425480397;
 Thu, 29 May 2014 21:51:20 -0700 (PDT)
Received: by 10.70.59.70 with HTTP; Thu, 29 May 2014 21:51:20 -0700 (PDT)
In-Reply-To: <CA+OJ3utofb+od5uct4HF1yoQGfWgX7YTn4hPChDpC7LTFVJDYQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250431>

On Fri, May 30, 2014 at 11:12 AM, Jonathan Leonard <johanatan@gmail.com> wrote:
>> But you do not give much information about your special use
>> case. I assume you have submodule repositories for which some
>> developers have a valid ssh key and others don't (maybe
>> because they should only have read access via https)?
>>
>
> Precisely. Specifically this is for a collection (17 or more) of
> GitHub-hosted projects which are maintained by only a couple of people
> (who have the ability to directly push via git:// or ssh://).
> Everyone else (including deployments and ordinary users) who clones
> the repo should be able to just grab the code via HTTPS and have it
> work.
>
>> If that is the case you might want to look into access control
>> tools like gitolite.
>>
>
> We are using GitHub.
>
>>>  Lack of this feature (or presence
>>> of this bug [depending on your perspective]) is a major PITA.
>>
>> But why is https special? Why not fall back to the git
>> protocol? Or http? (And no: I'm not serious here ;-)
>>
>
> HTTPS isn't special except in that it is the least privileged
> transport type (and thus should be the last resort). Whether to
> fallback to git:// from ssh:// or vice versa is inconsequential to
> this request.
>

The problem is that a ssh:// url can't necessarily be transformed into
a correct https:// or git:// with a simple sed 's/ssh/https/' chances
are other parts of the URL will need changing. Which quickly becomes
non-trivial.

One solution that we use at work is to use relative paths (e.g.
../code/mod1.git) in .gitmodules (assuming the submodules are all part
of the same project). That way if you clone the superproject over
https:// all the submodules use that too. This works well for us using
local mirrors across multiple sites _and_ different protocols.

Another option would be to have a policy of storing the most
permissive transport in .gitmodules which makes it easy for users and
puts the special config requirements on the maintainers.

Both of these are obviously solutions you need to convince the
maintainer(s) of the superproject to implement.

Perhaps what git could do is allow multiple urls for a submodule and
at git submodule init time try them in order until the fetch is
successful. Or provide a mechanism to map transports, arguably this is
the url.<foo>.insteadOf mechanisim that has already been suggested.
