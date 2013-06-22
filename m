From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2013, #07; Thu, 20)
Date: Sat, 22 Jun 2013 11:47:41 +0530
Message-ID: <CALkWK0=FaC9CqiTLE=UJA+Xg04=ZS45XddQ-RmPe_HSej2s5bA@mail.gmail.com>
References: <7v1u7woydw.fsf@alter.siamese.dyndns.org> <CALkWK0=1e5ospzJBqaz9iLwSiOoTy_+vTxwVMvW-H7kynfkbBg@mail.gmail.com>
 <7vk3lno40x.fsf@alter.siamese.dyndns.org> <CALkWK0kDDRicX9VmcRgG9daXVi6W-zGNt=x6ruy7X5MhrHOZbQ@mail.gmail.com>
 <7vvc57kxxt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 08:18:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqH9W-0004wv-Cp
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 08:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821Ab3FVGSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 02:18:22 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:58993 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab3FVGSV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 02:18:21 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so21538663ied.0
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 23:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gyGd8XivhBa+4o/hvLL/oA10LYlllaIBh9Yv1keRD2k=;
        b=e/GPAduK4wQ1knJ7G6s1bugVzVQDOV0FfySxm5Y8dAT/XoO0sWj4RHcq9ipuGQxGN/
         SVeEk5ELuGBPKZJ5OwlSWGORoLG7+sbU2aoH4JQluFe2ud5TkoaHsTcff7UsmadJgph/
         ZwEIt+s2u2Ptz3b94+Hg8rRu1VLPSqkx7Z0DLQMQlnmocbgzCGJPmI0fndFoDQ7Fc73N
         Z8yavtFQi3aeMOsVEj5ml0NlizJ2jx9Hv2gKzBjmkV8Jqj61Ep3+ZJeXkveAaDqiZCE0
         0wO60ehhH1yVIC6WyFpwO15Q3T2C+NgXKSVO99ojGcI+Ky/tMBRfpdOdMtSEUT5lf8LS
         9/pA==
X-Received: by 10.42.76.5 with SMTP id c5mr4149185ick.91.1371881901374; Fri,
 21 Jun 2013 23:18:21 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Fri, 21 Jun 2013 23:17:41 -0700 (PDT)
In-Reply-To: <7vvc57kxxt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228670>

Junio C Hamano wrote:
> Because the implementation is too ugly.

I know :)  The only reason I sent it with code is because I didn't get
any responses to an email without code.  If you agree that it is a
useful feature, we have to figure out a beautiful implementation.

> I would however can imagine an alternative implementation which
> might be more palatable. It may go like this:
>
>         [alias "lgF"]
>                 command = "log --oneline --boundary --first-parent"
>                 help = "show the first parent chain, one line per commit"

I'm not sure what value this adds.  If I ever forget what my alias is
called, I `git rp --help` to get the expansion and then look up the
manpage.  It would be ideal if I could `man git lgF` though: I'm sick
of having to type out `man git for-each-ref` everytime I need the
manpage for fer (obviously an unscripted `man` won't work: `git help`
will do the translation).

>                 completion = log

Again, unsure what value it adds.  I already have plenty of aliases
that complete fine.  The completion only fails if I have an !-command;
in that case, this solution is a hack: we should work towards not
requiring an !-command in the first place.

> so that not just alias.c code can take notice of alias.lgF.command
> to expand it,

How?  Fundamentally, alias_lookup_cb() is a fired off by the
config-parsing infrastructure which calls a tolower() on everything:
alias.c has control over nothing, unless we re-implement the entire
config-parsing infrastructure specifically for aliases (Bad idea).  I
don't see how changing from alias.<name> to alias.<name>.command helps
anything, especially when the other alias.<name>.* keys aren't even
useful.

> but we can later extend it to help "git help lgF"

Yeah, this is a good idea.

> and
> bash/zsh completion (i.e. they would learn "lgF parameter would
> complete in a way similar to 'log'" from alias.lgF.completion).

Solved problem: see __git_aliased_command() in git-completion.bash.
