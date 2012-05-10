From: demerphq <demerphq@gmail.com>
Subject: Re: Git.pm
Date: Thu, 10 May 2012 19:22:59 +0200
Message-ID: <CANgJU+XFDMETTKxEeBO01d=qwoD+xjP51A6UKEub_t1AFU625A@mail.gmail.com>
References: <CAB3zAY3-Bn86bCr7Rxqi4vxbYFxUesLwm8gddxyMSexov2tOhw@mail.gmail.com>
	<CAFouetgwRpB1GFJOC8PTVryVY-94S3xa5ZiSaWQWoz070qQ-6g@mail.gmail.com>
	<CAB3zAY0NeXuH-wXyYkbim5U74eANY4hq5D6SsVLu3KeUqHFqzQ@mail.gmail.com>
	<20120426203136.GA15432@burratino>
	<CAB3zAY3VHtUobJfJ7=nSKb_6uJOXLGVHzR18qV6txPkzf54cDw@mail.gmail.com>
	<CANgJU+W-FJZRtu_4si7nr96KfNe2rzaiUaDC0GiK_WixudvcxA@mail.gmail.com>
	<CAB3zAY0NAQaN-nNeJdJy80omrXqUZ-vCWsFhbx_iHF5RPBYUQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>, git <git@vger.kernel.org>
To: Subho Banerjee <subs.zero@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 19:23:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSX58-0005jB-9x
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 19:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757759Ab2EJRXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 13:23:07 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46644 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756472Ab2EJRXA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 13:23:00 -0400
Received: by yhmm54 with SMTP id m54so1693976yhm.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=C02PagsfhNAECbYlsqpTj4dvy9GhbCk72rgJqZMvm/A=;
        b=yjehyhP9dUvWjS26pHvNJlwkLuZ3SxhHUeFPpVuZnmvezXig+OPcIHFXX8EYE1A5um
         lbNLXCfQOt9qqqBSEyISCuQM62zuxV8dVCRSrNQNIt8aFT1tqwXN4fii1QqSvR7MGTJU
         5wgvCIhTORMiBYwO0NqWS4xMKAKjuAtEUV9QATvcJQbS2+z/nUM35vX+ZSMww9rngYIR
         fm2sitH5FfU40U/BfQkvUKA4RgnicZeXVh5ZmJkzYe2ffPBK9WX+ZImVt83ywdFVJKdy
         wIZEQ6IHT858A3bz7mM4fJWj7LEpZ0qeKK/e1skb30Z/JdltVVgARZR70JWpIkaO3KmV
         KYkg==
Received: by 10.236.192.198 with SMTP id i46mr6424765yhn.22.1336670579520;
 Thu, 10 May 2012 10:22:59 -0700 (PDT)
Received: by 10.236.152.35 with HTTP; Thu, 10 May 2012 10:22:59 -0700 (PDT)
In-Reply-To: <CAB3zAY0NAQaN-nNeJdJy80omrXqUZ-vCWsFhbx_iHF5RPBYUQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197605>

On 10 May 2012 18:18, Subho Banerjee <subs.zero@gmail.com> wrote:
> Hello Yves,
> I am aware of that. But you see the problem is that using eval/warn/do
> is that the $@ has to be localized every time eval is called.

It doesn't *have* to be localized every time. Although it does help a
bit. On the other hand it also hinders.

> From my
> understanding of how the Try::Tiny package works, this is exactly what
> happens. So we are just calling a simple eval statement but in a block
> where the $@ is handled properly, which is eventually what we would
> have to do if we wrote it ourselves(Though I am not sure about how DBI
> does it, I will have a look into that). And that is why I arrived in
> favor of the Try::Tiny module in the first place. Well, that and the
> ability to throw exception objects if required.

As far as I know Try::Tiny exists because of a bug in Perl.

The bug is that since $@ is a global, if an object is created in an
eval, and then its DESTROY itself does an eval it can "hide" the
error, if one uses eval incorrectly. However if one does things
correctly one can detect this case regardless, although perhaps in the
process losing the error message. Ny simply arranging that every eval
statements returns a true value then you can ALWAYS detect when an
eval failed, even if $@ is clobbered.

$ perl -le'sub Foo::DESTROY { print "in DESTROY"; eval 1 } my $ok=
eval q(my $o= bless {}, "Foo"; my $zero=0; print 1/$zero; 1); if ($@)
{ print $@ } if (!$ok) { print "error in eval: ", $@||"Zombie Error"}'
in DESTROY
error in eval: Zombie Error

remove the eval 1 in the DESTROY method:

$ perl -le'sub Foo::DESTROY { print "in DESTROY"; } my $ok= eval q(my
$o= bless {}, "Foo"; my $zero=0; print 1/$zero; 1); if ($@) { print $@
} if (!$ok) { print "error in eval: ", $@||"Zombie Error"}'
in DESTROY
Illegal division by zero at (eval 1) line 1.

error in eval: Illegal division by zero at (eval 1) line 1.

Now it is true that using local does somewhat save things, however
ONLY if EVERYONE uses local when they eval. Which they dont. Nor do
they use Try::Tiny. So in regards to localization the only thing
Try::Tiny saves you from is other people using Try::Tiny or similar
functionality.

Now, it is true that Try::Tiny arranges to check the eval, and it
localizes $@, so I suppose it does save some people from shooting
themselves in the foot. But Perl is most definitely not about not
shooting yourself in the foot, indeed, if you ask it nicely Perl will
hand you a loaded shotgun to make it easier.

Basically all Try::Tiny does is make:

try {
     do_something();
} catch {
     do_something_with_error($_);
};

behave the same as this:

local $@;
eval {
    do_something();
    1;
} or do {
    my $error= $@ || "Zombie Error";
    do_something_with_error($error);
};

Which for me is silly. Id rather see the code than have a module wrap
it up in sub calls, replace $@ with $_ and related junk. Yes this
requires Perl programmers to know their stuff. But then so does any
non-trivial programming task.

Now notice some issues with Try::Tiny, it doesnt support string eval
anyway, so you can just swap it into the code I wrote, nor the general
case of eval. And even if you use it, it doesnt save you if the code
you are executing does not ALSO use it:

$ perl -MTry::Tiny -le'sub Foo::DESTROY { print "in DESTROY"; eval 1 }
my $ok= eval {my $o= bless {}, "Foo"; my $zero=0; print 1/$zero; 1};
if ($@) { print $@ } if (!$ok) { print "error in eval: ", $@||"Zombie
Error"}'
in DESTROY
error in eval: Zombie Error
$ perl -MTry::Tiny -le'sub Foo::DESTROY { print "in DESTROY"; eval 1 }
my $ok= try {my $o= bless {}, "Foo"; my $zero=0; print 1/$zero; 1}; if
($@) { print $@ } if (!$ok) { print "error in eval: ", $@||"Zombie
Error"}'
in DESTROY
error in eval: Zombie Error
$ perl -MTry::Tiny -le'sub Foo::DESTROY { print "in DESTROY"; eval 1 }
my $ok= try {my $o= bless {}, "Foo"; my $zero=0; print 1/$zero; 1}
catch { print "error in eval: ", $_||"Zombie Error"}'
in DESTROY
error in eval: Zombie Error

Notice how it provides no more benefit than writing eval like this:

eval {
     stuff();
     1; # this is important
} or do {
     my $error= $@ || "zombie error"; # must do this as early as possible
     do_something_with_error($error);
};

And for me, if I see code written like this I KNOW it works, i know
what side effects it has (localizing $@ has its own issues), and I
know I can understand it.

So for me Try::Tiny is a waste of time. Using it saves you from almost
nothing, and just forces consumers of your code to know how to do eval
properly AND how Try::Tiny works. Not using Try::Tiny at all means
people JUST have to know how to use eval properly, which if they want
to do any kind of real Perl work they need to know anyway.

Anyway, on the side of annoying you about Perl trivia, you can find a
lot of reusable library code in git-deploy on github. Feel free to
steal whatever you like.

  https://github.com/git-deploy

I would have loved to have a better git library module than Git.pm
when I wrote the original version of git-deploy. So I am all in favour
of your project.

cheers,
Yves








-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
