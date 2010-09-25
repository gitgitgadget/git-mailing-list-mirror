From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v1] stash show: fix breakage in 1.7.3
Date: Sat, 25 Sep 2010 16:19:50 +1000
Message-ID: <AANLkTimK4nTr9bS0L9xc9mGo5F900pUAOQoDnZ9HMdEz@mail.gmail.com>
References: <robbat2-20100924T191752-102740530Z@orbis-terrarum.net>
	<1285385521-17012-1-git-send-email-jon.seymour@gmail.com>
	<AF7816CF-7515-4386-9736-417005434433@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: robbat2@gentoo.org, git@vger.kernel.org
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 08:22:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzO9E-000501-KC
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 08:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755624Ab0IYGTx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Sep 2010 02:19:53 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56716 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab0IYGTw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 02:19:52 -0400
Received: by qwh6 with SMTP id 6so2250552qwh.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 23:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=a7SQ/YkT76r0uJ/zRGtjzoFbRjc/+MLcXeNz9WLFABs=;
        b=I4PAzJPv8u5VksYqAofTVC3m09TzbHB+o9OGMu5JXr8WdL4w+K7OyBLm09zzeTitRc
         iJWlgfYR5izF50t56jz0RPrxkZOq3AqKKNu8vv8fXnT7QXJTy/m6Fb1855S1RrtYxaow
         B+Wo41y1JgmfnYSSF0TN6OYdDGPOuhtLrReWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mwF6XcA1EIyBGvagLGUStvZRIDbSw5I/OcXV4ZSWgL0MM0XWnuijVaG0BkQBIrsG5S
         m0AOzSZWky/6mR1SxlmgiA5Sw48V5+u1ZddleV1anHoStGLihRFbtiATo0ABtO/M475W
         5mxBN5VYCp2Uv/2H+dOeJ8OrZ+opM4n2ViI7s=
Received: by 10.229.2.19 with SMTP id 19mr3232137qch.283.1285395591077; Fri,
 24 Sep 2010 23:19:51 -0700 (PDT)
Received: by 10.229.219.196 with HTTP; Fri, 24 Sep 2010 23:19:50 -0700 (PDT)
In-Reply-To: <AF7816CF-7515-4386-9736-417005434433@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157124>

On Sat, Sep 25, 2010 at 2:45 PM, Brian Gernhardt
<brian@gernhardtsoftware.com> wrote:
>
> On Sep 24, 2010, at 11:32 PM, Jon Seymour wrote:
>
>> due to a faulty assumption that:
>> =C2=A0 git rev-parse --no-revs -- stash@{0}
>
> This assumption is faulty, it should be "git rev-parse --no-revs --fl=
ags stash@{0}", which works properly for all revision arguments and fla=
gs _except_ -q and --quiet.

Agreed. If I recall the evolution of the code, I originally had
--no-revs --flags, but then found -q was being eaten. The only way to
prevent it being eaten was to remove --flags and add --, which "fixed"
the -q problem but created the git stash show xxx problem. Of course,
had my unit tests been more thorough, I would have picked this, but
alas they were not.

>
>> This revision further simplifies the parsing code
>> by removing use of git rev-parse for FLAGS parsing
>> altogether.
>
> That is simpler, and does fix this specific issue. =C2=A0However, I w=
ould strongly argue that "git rev-parse --no-revs --flags" is broken. =C2=
=A0I really don't have the time tonight or probably this weekend to wor=
k on it, but git-rev-parse should only take "-q" and "--quiet" for itse=
lf if "--verify" was passed. =C2=A0(Since that is the only mode in whic=
h rev-parse uses quiet, AFAIK.)
>

This seems like a reasonable compromise to me.

> Possibly rev-parse should also (or instead) separate "arguments for r=
ev-parse" and "arguments rev-parse is parsing" using the standard "--".=
 =C2=A0I don't know if this will affect any current users.
>

I suspect this could be problematic.

Current behaviour:

   $ git rev-parse --flags -X -- Y -Z
   -X

Here -- is being used to say, don't interpret anything after -- as
being flag-like even if it could be flag-like.

So, if a command foo uses git rev-parse to parse its own arguments:

    foo -X -- Y -Z

then I suspect, it would only want to treat -X as being flag-like,
from the user of foo's point of view, both Y and -Z are not meant to
be interpreted by foo.

It might make sense for --flags to be an instruction to git rev-parse
not to interpret any subsequent arguments as git rev-parse options so
that:

  $ git rev-parse --flags -q --no-flags -- --revs-only

would output:

  -q --no-flags

That is, prevent -q being eaten by git rev-parse, but preserve
existing interpretation of --.

> ~~ Brian
>
>
