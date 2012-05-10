From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: Git.pm
Date: Thu, 10 May 2012 21:55:10 +0100
Message-ID: <4FAC2B2E.7060101@pileofstuff.org>
References: <CAB3zAY3-Bn86bCr7Rxqi4vxbYFxUesLwm8gddxyMSexov2tOhw@mail.gmail.com> <CAFouetgwRpB1GFJOC8PTVryVY-94S3xa5ZiSaWQWoz070qQ-6g@mail.gmail.com> <CAB3zAY0NeXuH-wXyYkbim5U74eANY4hq5D6SsVLu3KeUqHFqzQ@mail.gmail.com> <20120426203136.GA15432@burratino> <CAB3zAY3VHtUobJfJ7=nSKb_6uJOXLGVHzR18qV6txPkzf54cDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>, git <git@vger.kernel.org>
To: Subho Banerjee <subs.zero@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 22:55:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSaOR-00085g-Tw
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 22:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757589Ab2EJUzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 16:55:19 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:28425 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757018Ab2EJUzQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2012 16:55:16 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120510205513.QIPQ28930.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Thu, 10 May 2012 21:55:13 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120510205513.NJXU13318.aamtaout03-winn.ispmail.ntl.com@[192.168.0.2]>;
          Thu, 10 May 2012 21:55:13 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <CAB3zAY3VHtUobJfJ7=nSKb_6uJOXLGVHzR18qV6txPkzf54cDw@mail.gmail.com>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=yXtjXN6ItgYA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=eNcD7ojaAAAA:8 a=N8CWN-2w2J1voUHUPqMA:9 a=qiw_mmVru794j0xgKxAA:7 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197633>

Try::Tiny is an increasingly standard part of Perl - for example, it's
used extensively in Moose.  There's a good list of arguments about why
you should use it instead of eval in the Try::Tiny documentation:
http://search.cpan.org/~nuffin/Try-Tiny-0.01/lib/Try/Tiny.pm

Now I've got that talking point done, here's what I really think :)

Try::Tiny is designed on the assumption that throwing and catching
objects is something people should do all the time, and it can cause
subtle errors that are only worth the hassle if you get a lot of benefit
from doing so.  It's easy enough to come up with ideas for where they
might be useful, but in the real world advanced uses for exceptions are
usually a sign you're doing it wrong.  Three of the most common reasons
for frequent/complex exceptions are handling errors further up the call
stack, recovering from operations that fail, and clever error-handling.


If you want exceptions to be caught by code further up the call stack
than the immediate caller, you're likely to be disappointed.  This is
one of the places where "separation of concerns" applies - if I use a
module that uses a module that uses your module, then catching
exceptions from your code will just cause my program to break when some
module in the middle obscures your error by adding its own layer of
error handling.


If you have an operation that really might fail, and you want to
encourage most people to handle it most of the time, it's better to have
a function with a meaningful name and good documentation.  This puts the
burden on the calling function to handle the error instead of letting
them think "oh well, if it dies someone else will handle it".  It also
forces you to split functions along boundaries that make your code
readable, instead of falling for the temptation to make something that
"just works"... until it doesn't, and the maintainer has to go
spelunking through code they don't know.  So instead of:

   try {
       Foo::frobnicate( widgets => 3 );
   } catch {
      if (ref($_) eq 'Error::Widget') {
          die "Could not add 3 widgets";
      }
   }

It's better to ask the people using your module to write:

   my $foo = Foo->new;
   $foo->add_widgets(3) or die "could not add 3 widgets"
   $foo->frobnicate;

This is easier to document, easier to write and easier to read.


If you have an operation where calling code is supposed to do something
more complicated than give up, it's better to use a callback.  This
gives you an opportunity to document what's needed, and to check that
the calling code is doing the right thing before it's too late.  So
instead of:

    my $widgets = 3;
    while ( $widgets ) {

        try {
            Foo::frobnicate($widgets);
            $widgets = 0;
        } catch {
            if ( $_->{remaining_widgets} < 2 ) {
                die $_->{error};
            } elsif ( $_->{remaining_widgets} == 2 ) {
                $widgets = 0;
            }
        }

    }

It's better to ask people using your module to write:

    Foo::Frobnicate(
        widgets => 3,
        error_handler => sub {
             my ( $remaining_widgets, $error ) = @_;
             die $error if $broken_widgets < 2;
             return "give up" if $remaining_widgets == 2;
             return "continue";
        },
    );

Again, this is more readable and easier to document.


Aside from the philosophical angle, Try::Tiny is particularly hard to
maintain because it looks like a language extension, but is actually
just an ordinary module.  The try {} and catch {} blocks are anonymous
subroutines, which lead to some wonderfully unintuitive behaviour.  See
what you think these do, then run the code to find out:


    sub foo {
        try {
            return 1;
        }
        return 0;
    }

    sub bar {

        our @args = @_;
        our @ret;

        try {
            @ret =
                wantarray
                    ?   grep( /blah/, @args )
                    : [ grep( /blah/, @args ) ]
        };

        return @ret;
    }

    my $foo = "bar";
    sub baz {
        my $foo = "baz";
        try {
            print $foo;
        }
    }

    sub qux {
        my $ret;
        try {
            $ret = "value";
        }
        return $ret;
    }

    print foo, "\n";
    print bar( "blah", "blip" ), "\n";
    baz;
    print qux, "\n";


In short, Try::Tiny looks like a lot of gain for not much pain, but
actually it's the other way around.

	- Andrew
