From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: Re: [PATCH] Git.pm: do not break inheritance
Date: Sun, 19 Oct 2008 00:21:06 +0200
Message-ID: <48FA6152.6020006@jaeger.mine.nu>
References: <2980b5cead38d5ae3510e4ed9adc847c80be1075.1224360106.git.christian@jaeger.mine.nu> <7vabd1aaqx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 00:23:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrKCm-0008EC-4y
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 00:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbYJRWVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 18:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbYJRWVK
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 18:21:10 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:51932 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750812AbYJRWVK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 18:21:10 -0400
Received: (qmail 494 invoked from network); 18 Oct 2008 22:21:07 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 18 Oct 2008 22:21:07 -0000
Received: (qmail 25062 invoked from network); 18 Oct 2008 22:21:06 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 18 Oct 2008 22:21:06 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <7vabd1aaqx.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98577>

Junio C Hamano wrote:
> That's how you would write class methods, isn't it?  IOW, your callers
> can say:
>
> 	my $self = new Git();
>         $self->method(qw(a b c));
>         Git::method(qw(a b c))
>
> and you can start your method like this:
>
> 	sub method {
>         	my ($self, @args) = _maybe_self(@_)
>                 ...
> 	}
>
> and use @args the same way for either form of the call in the
> implementation.  

I see, a magic way to offer both an OO and procedural api. Well, partial 
procedural api, since not all of the methods can work without the $self.

> Two obvious pitfalls are:
>
>  - You cannot use $self if you set up your parameters with _maybe_self;
>
>  - The second form of the call would call directly into Git::method, never
>    your subclasses implementation, even if you write:
>
> 	use Git;
>         package CJGit;
>         our @ISA = qw(Git);
>
>         sub method {
>         	...
> 	}
>
>   

(This is no problem iff people are calling procedures in object notation 
if they actually have got an object at hands. I.e. if you've got some 
code which does:

my $repo= Git->repository(...);
$repo->foo;

then all is fine, and I would think it would be weird if people called 
Git::foo($repo, ... ) in such a case. Well for my purposes it's not a 
problem anyway, since if a user wants to use the extensions, he needs to 
actually do this:

my $repo= CJGit->repository(...);

and then it should be clear that one shouldn't call Git:: directly. The 
problem will only be in cases where an extended object is being fed to 
existing code which calls Git:: with objects in the hope that virtual 
method calls are going to the extended class; well, let's fix those bad 
call sites when they are being discovered... Maybe this warrants a 
warning somewhere.)

>>  sub _maybe_self {
>> -	# This breaks inheritance. Oh well.
>> -	ref $_[0] eq 'Git' ? @_ : (undef, @_);
>> +	UNIVERSAL::isa($_[0], 'Git') ? @_ : (undef, @_);
>>  }
>>  
>>  # Check if the command id is something reasonable.
>>     
>
> The patch looks Ok, as long as you have a working UNIVERSAL::isa() in your
> version of Perl.  My reading of perl561delta,pod says that Perl 5.6.1 and
> later should have a working implementation.
>   

 From http://perldoc.perl.org/perl561delta.html:

> UNIVERSAL::isa()
>
> A bug in the caching mechanism used by UNIVERSAL::isa() that affected 
> base.pm has been fixed. The bug has existed since the 5.005 releases, 
> but wasn't tickled by base.pm in those releases.

This looks like only a bug in some (corner?) cases; I've verified that 
I've been using the isa() method *or* function since perl 5.005_03, and 
haven't had issues with it. I can't easily verify though when I switched 
from

#if (Scalar::Util::blessed($value) and $value->isa("Eile::Html")) {
to
if (UNIVERSAL::isa($value,"Eile::Html")) {

(because it was simpler to write, once I discovered that I could just 
call the function directly instead of relying on method dispatch) but 
that might not have made a difference.

Christian.
