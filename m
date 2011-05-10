From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: Re: [PATCH v3 0/3] Git commit --patch (again)
Date: Mon, 9 May 2011 23:42:17 -0700
Message-ID: <BANLkTikwjZkzMxksBsVTFRYdhE3L6ZQM0A@mail.gmail.com>
References: <1304748001-17982-1-git-send-email-conrad.irwin@gmail.com>
	<20110509144451.GA11362@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 10 08:42:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJgeF-000275-Rv
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 08:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124Ab1EJGmT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2011 02:42:19 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41297 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab1EJGmS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2011 02:42:18 -0400
Received: by gwaa18 with SMTP id a18so2043071gwa.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 23:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M1NLApe5M399vWQfUcJPisp2bSkI6nUAbFC4lHubBAs=;
        b=MjtGotpdT78RjoHtTSxDbf6/f0wRmZ2HFcuzqlYRRlSWGnuMb4cZQFEr5hi0QL2BHU
         zxbon+iPZjRI4lg7ggwID2yWXdKxbuXDWmhMvSWZCLVZG+WK0H3nMKkyti7zOFUPr0bz
         GnDiS7dleNQEWARI6tDDs1LzJPDyvFC2648jo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nQUrGpX9lBGCSRh7haJwHdWYpW+d5t2+hVbUp0g50ZJqGR2YT71jmb5d/wGvHV7N8W
         2mgqG0VmaDOXRFZZItRDgSKj+tyKpcKeIZkQYXUNoSadOR5W+nPf9R7kFQn1c8IOW/6H
         ztspxjIJQ/oArp/MH9pm3AYpLB9RICcXWCnPk=
Received: by 10.236.9.68 with SMTP id 44mr8599032yhs.511.1305009737669; Mon,
 09 May 2011 23:42:17 -0700 (PDT)
Received: by 10.236.110.176 with HTTP; Mon, 9 May 2011 23:42:17 -0700 (PDT)
In-Reply-To: <20110509144451.GA11362@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173316>

On Mon, May 9, 2011 at 7:44 AM, Jeff King <peff@peff.net> wrote:
>
> That still leaves an inconsistency in "git add -p" versus "git commit
> -p" (e.g., if you abort "git add -p" with "^C"). But if we care, the
> right solution is probably to make "git add -p" atomic. That can be a
> separate topic, though, and I'm not sure anyone really cares enough t=
o
> work on it.

I have pondered this problem too. "git add -p" is a particularly unintu=
itive,
it inherits the update-the-index-after-every-complete-file semantics of
"git add --interactive", but without ever making the file boundaries cl=
ear
to the user. Depending on how much this bugs me, I might try to fix it
in the future, but I wonder whether any users of "git add --interactive=
"
are relying on the file based granularity.

>
> I have one final question. If I do abort a commit, is there any way t=
o
> recover the state that was in the temporary index? That is, if I abor=
t
> "git commit -i" by using an empty commit message, it is easy enough t=
o
> use shell history to repeat the command (possibly with a different se=
t
> of files). But if I spend some time selecting (and possibly editing)
> hunks, and then decide to abort the commit, is there any way to recov=
er
> the intermediate index state?

Not really. You could use your knowledge of git-commit to assume that t=
he
tree object with the most recent ctime is probably useful, but that onl=
y
works some of the time. The occasions on which I have wanted to abort
the process half-way, I've just created a temporary commit with what I
have so far. A "git reset --soft" at that point makes the whole process
long-hand for "git add -p".

>
>> =A0 Allow git commit --interactive with paths
>
> Hmm. Test t7501.8 explicitly tests that this isn't allowed. But the t=
est
> is poorly written, and falsely returns success even with your patch.
>

Well spotted. Thank you Junio for fixing that test.

> which does properly fail with your change. Your commit should tweak t=
hat
> test (speaking of which, it would be nice for patch 1 to have a test,
> too).

I'll try to get my head around the tests :).

Conrad
