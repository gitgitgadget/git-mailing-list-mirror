From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Is there something like a git format-patch --squash?
Date: Thu, 18 Feb 2010 16:56:30 -0500
Message-ID: <32541b131002181356n633418e1jb608dfa71e5f8a5b@mail.gmail.com>
References: <32541b131002181145w44d69e9eo150d08f34273cefb@mail.gmail.com> 
	<20100218203440.GA8110@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Seymour <jon.seymour@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 18 22:57:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiEMq-0005i7-2X
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 22:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756226Ab0BRV4w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 16:56:52 -0500
Received: from mail-gx0-f227.google.com ([209.85.217.227]:48628 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988Ab0BRV4v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2010 16:56:51 -0500
Received: by gxk27 with SMTP id 27so3284809gxk.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 13:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gEnlQFHa3w6TiocRJSShnuA2fHrbOTPus9y6lP5ej2U=;
        b=P6LrmL0I+n6/QKM5vbE8DTiUOUvVsbEiJk0RAYHPml5WVZKKmF1ToivNPWh3yv3jPv
         C2WNDSHmfuM2LZXFi4s3US2f8EDKmxN30/oGWksk3RVAIQ+M9lTm/zUyw53d/H3FfNOY
         dJ+bTEuq+4gcmkatO2E+mz9MOhATR9Y2F6lkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FIG9qJjy9iibqo82xlcD+/6yue+ZjoheW2+I2faD5PyefsUkjizS/CABC3Mgr5SSpE
         zMIfsTEultfHGkcXJCfnukj2ZNpa5dByJ6LNPgv6T0KCgFjoyGYcj8SpIpz30bR/k2q/
         1TjUfEhZWkrTJZdh+LlG3l02amYTkVTZ334PM=
Received: by 10.151.29.8 with SMTP id g8mr2170887ybj.74.1266530210150; Thu, 18 
	Feb 2010 13:56:50 -0800 (PST)
In-Reply-To: <20100218203440.GA8110@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140384>

On Thu, Feb 18, 2010 at 3:34 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 18, 2010 at 02:45:54PM -0500, Avery Pennarun wrote:
>> In the above, in the 'else' clause, what I really wanted was somethi=
ng like:
>>
>> =A0 =A0git format-patch --stdout --squash $parent..$commit
>>
>> with one big "| git am" at the end of the loop.
>
> I don't think there is a way to do it automagically. Obviously you ca=
n
> use diff (as you did) to produce the diff, but how should the many
> commit messages be combined?

Something like what merge --squash does would be fine, I think.

As it happens, the script I wrote ends up using the commit message
from merge commits (since those are the ones that end up including all
the patches from their side branch), which is precisely equivalent to
how it would look in a "linearizing" SCM like svn or cvs.

I happen to have merge.summary=3Dtrue in my ~/.gitconfig so my merge
commits have extra information in them, though.

> Worst case, you could probably do it yourself by echoing the mail
> headers yourself, throwing all of the commit messages in the body, an=
d
> then doing the diff:

True.  But format-patch already has the code for that, so it's kind of
error-prone to duplicate it.

> (also, do you really need $parent? In
> --first-parent --reverse, isn't it always going to be $commit^1?).

Good point.  That script was quickly hacked together after a few
iterations that previously did more important things with $parent.

> But I think you can do it without diff application by just re-using t=
he
> tree-state of each merge:
>
> =A0git rev-list --first-parent --reverse $from..$to |
> =A0last=3D$from
> =A0while read commit; do
> =A0 =A0last=3D`git cat-file commit $commit |
> =A0 =A0 =A0 =A0 =A0sed '1,/^$/d' |
> =A0 =A0 =A0 =A0 =A0git commit-tree $commit^{tree} -p $from`
> =A0done
> =A0git update-ref refs/heads/new $last

I don't think that works, since commit-tree takes the commit message
on stdin but the other stuff via environment variables.  Which is too
bad, really, at least for this case.

Have fun,

Avery
