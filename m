From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 0/2] config includes, take 2
Date: Tue, 7 Feb 2012 02:05:34 -0800
Message-ID: <CAJDDKr5yiKvNnpVV29jFK1Z1yuUnA-=dn0yMB8iW9y53vRGDHQ@mail.gmail.com>
References: <20120206062713.GA9699@sigill.intra.peff.net>
	<CAJDDKr6A2UvB3D-Dapw7WCEzWfzLoLd0E8MSDjT0RtdxFeWZAQ@mail.gmail.com>
	<20120207051719.GA11598@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 07 11:05:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ruhvi-0003Ga-7L
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 11:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219Ab2BGKFh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 05:05:37 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63493 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706Ab2BGKFf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2012 05:05:35 -0500
Received: by ggnh1 with SMTP id h1so3273004ggn.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 02:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=WUtejaQjYPi8Uy3JUfUPXZuk04ObZZ1U/gGtZuSwPHs=;
        b=Khf6YmhEbJTsOt1IJUKjYbu5FCoaRrsFqXSMOeXMQnSZTK43RXaAyoynCuwTGgh7EK
         EX6JeAdZ6C0wOioJI4oj0tgOYjE10ChX2g7lP/hUmPbi3rXmFw2cFneZ89RF+H/al1aG
         b+BDReHT9AaO2s7rp3I7y/YOjlOuCKoVk50rM=
Received: by 10.101.177.39 with SMTP id e39mr9215064anp.54.1328609134759; Tue,
 07 Feb 2012 02:05:34 -0800 (PST)
Received: by 10.146.249.16 with HTTP; Tue, 7 Feb 2012 02:05:34 -0800 (PST)
In-Reply-To: <20120207051719.GA11598@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190159>

On Mon, Feb 6, 2012 at 9:17 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 06, 2012 at 09:01:21PM -0800, David Aguilar wrote:
>
>> I have a questions about this. =C2=A0Let's say I have ~/foo1.gitconf=
ig:
>>
>> [foo]
>> =C2=A0 =C2=A0 bar =3D 1
>>
>> ...and ~/.gitconfig (I forgot the syntax):
>>
>> [foo]
>> =C2=A0 =C2=A0 bar =3D 0
>>
>> #include "~/foo1.gitconfig"
>>
>>
>> Does that mean that:
>>
>> =C2=A0 =C2=A0 $ git config -f ~/.gitconfig foo.bar
>>
>> ...prints 0 and not 1?
>
> Yes, though the syntax is:
>
> =C2=A0[include]
> =C2=A0 =C2=A0path =3D foo1.gitconfig
>
> (it doesn't respect tilde-expansion, but it probably should). Note th=
at
> the syntax was specifically selected for backwards compatibility, and=
 to
> allow manipulation with existing tools.
>
>> I can see cases where this would be undesirable behavior.
>>
>> For example, an application that uses "git config -z --list -f
>> ~/.gitconfig" might expect that the result encompasses all of the
>> user-specific config bits.
>
> The problem is that an application might also expect it _not_ to happ=
en
> (e.g., if the application is really interested in knowing what's in
> ~/.gitconfig). Because includes aren't respected now, the safe defaul=
t
> seems to be not to have includes (i.e., don't change behavior for thi=
s
> case).
>
> A bigger question for me is: if you are interested in getting an answ=
er
> from anywhere, why are you restricting with "-f"? IOW, is this a
> real-world problem, or a hypothetical one? And if real-world, what is
> the actual use case?

It's a real-world problem.  I haven't had to change the code in a
while which is why this thread caught my eye ;-)

I won't claim it's the best solution, but this has worked extremely
well in practice:

https://github.com/git-cola/git-cola/blob/master/cola/gitcfg.py

Here's the problem.  I need to know which config items are "user"
config (~/.gitconfig), which are "repo" config (.git/config), and
which are "system" config (/etc/gitconfig).

I also need to avoid calling "git config" too many times so I query
these files once and cache it all in memory.  We need only stat()
these files to know whether to redo the "git config" call.

=46iguring out the repo config is tricky.  You can't just say "git
config --list" because that includes the user config stuff in
~/.gitconfig.

=46iguring out the user config is easy because you can say "git config
--global --list".  This is inconsistent with the behavior for "git
config --list" because it does not include the --system config, which
one would expect given the overlay semantics.

=46iguring out the system config can be done with --system.  That works=
 fine.

The generic interface for getting a concise listing of values from
these sources is to use "git config -f" on ~/.gitconfig, .git/config,
and $(prefix)/etc/gitconfig.

git config --global and git config --system are both consistent in
that they return just the information relevant to them.  Is --global
just a shortcut for "-f ~/.gitconfig"?  If yes, then does that mean
"git config --global" will not honor includes?  If it is not a
shortcut, does that mean that "git config --global" and "git config -f
~/.gitconfig" are not really the same thing?  The documentation does
lead one to believe that they should be equivalent...

The takeaway is that querying these files provides a convenient way to
access the effective configuration values for the system, user, and
repo.


>> I do know where I would use an `--include` flag (if following includ=
es
>> were not the default behavior when using '-f'), though, and that's w=
hy
>> I'm asking. =C2=A0The problem with not having it be the default mean=
s we
>> have to use a flag. =C2=A0This makes it harder to support multiple v=
ersions
>> of git.
>
> Yes, that's a general problem of adding new command-line options to t=
urn
> features off or on. We could add an environment variable to control t=
his
> feature. But I'd really like to hear the compelling use case first
> (i.e., both why it cannot simply be spelled "git config -z --list", a=
nd
> why not following includes is not OK).

Hopefully my explanation conveys why "git config -z --list" is insuffic=
ient.

Basically, I've been relying on the fact that querying each of these
files gives me exactly what users have effectively configured.
Pushing knowledge of includes onto the application is less fun.
Applications would either have to understand the [include] path =3D ...
construct and do something with it themselves or they'd have to check
the git version at runtime.

I would rather do without the runtime version check and have
everything "keep working".


So let's explore why I think it should follow includes.  Here are a
few reasons...

When the file format supports including other files then the most
logical thing for it to do is to follow those includes, no?  I know,
this is a tautology ;-).  I'll try again.

=46rom a naive user's POV --
I am asking "git config" to evaluate this file.  I don't care what's
inside of it; it's a black box to me.  All I know is that I get config
values out the other side.  Sometimes git respects the included files.
Sometimes it does not (when using -f).
^^^^^^^^^
I think this subtle difference in behavior is best avoided.

Here's another.  The naive user will do: `git config --list -f file`.
They will then edit that file to add an include statement.  They will
then run `git config --list -f file` again and be confused as to why
their included configuration is not honored.

Right now these two are synonymous: "git config --system --list" and
"git config -f $(prefix)/etc/gitconfig --list".  Having one form honor
includes and not the other is inconsistent.

What if we frame this the other way around -- when would we not want
it to follow includes?  I can imagine someone writing a "git config"
editing program, but I think that use case is rare (and they haven't
spoken up, either ;-).

Well.. okay. My use case is rare too!  The dumb "cache the values
behind a stat() call" thing has worked really well in practice so I've
been happy with it so far.  It's dumb, and it won't notice when
included files change, but I really don't care because it solves the
99% case.

I'd be happy to rewrite it using another approach.  The
overlay-semantics inconsistency is what led me to using the generic
"-f" interface.  Performance issues led me to use a stat cache.  Using
each file's stat info as the cache key mapped nicely onto the generic
approach of using "-f".

Rewriting it (for me) would mean using --global and --system and
probably not caring so much about the distinction of repo vs. user
configuration (or rather, deal with the fact that `git config --list`
returns both the user config and the repo config). At that point I
might as well just write (reuse) a proper .gitconfig parser, but
what's the fun in that when "git config" is so nice and easy to parse?
;-)
--=20
David
