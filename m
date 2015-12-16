From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Help debugging git-svn
Date: Tue, 15 Dec 2015 22:00:48 -0600
Message-ID: <CAOc6etaOKSN0KyB9v2caiQbaQBEGrHxi3NmFy3aJkFxczGdqHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Eric Wong <normalperson@yhbt.net>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 16 05:00:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a93Gr-0007wN-6t
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 05:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965728AbbLPEAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 23:00:51 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34144 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631AbbLPEAt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 23:00:49 -0500
Received: by mail-pf0-f169.google.com with SMTP id 68so5044054pfc.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 20:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=rhst0f1beSc+uTlAYtENoarjfliD3HHq+U2mDZoutF4=;
        b=N9lBaHRI/P3Ks47CnBwSylLYSvGGF6fcrtnrKgG6iLpgVAbfidTuht4DqTmwuu/qKz
         5og9TfQuijrBttNeiC/qLRMpBounCNC/gaeXLaWVlsQ8HcYhI9G2qoISBOsNgn6SrsQK
         Sh8huZPsDhrJWWolzsfDjNXjf0P06Kct6Om0NJNJrTrf3vOj/AAVPKYWCxaL2ZadFoXf
         7ySDJ7IrHMGPu/yqzQJFJIwIrYUdT1jIZPo6kY0jDsii1CIQdhcz4vcDfYnr2xrtMvt1
         kzPJByb7dwTYpfnkjk//3inKjQJ1NMeOzw/a1hskMX5C46zBqDUefGVg+HEsE4nKLftB
         hf1A==
X-Received: by 10.98.68.20 with SMTP id r20mr2326091pfa.108.1450238448864;
 Tue, 15 Dec 2015 20:00:48 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Tue, 15 Dec 2015 20:00:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282533>

Hello, Eric, Everybody!

I need your help getting git-svn to clone a repository.

I had already cloned it once but then a few months ago I discovered
the authors map file and it's like the first time I did a checkout
using git.... well, perhaps not that much, but close. Seeing the real
names of people when using log, blame, etc is a major difference...
so, back to my tale of sorts.

The thing is that I have already tried to clone it _several_ times and
it always breaks at one point or another (or rather, at one revision
of a branch or another). I have come to think that it's more or less
at the same revisions that it breaks but I'm not 100% certain.

What I _think_ is the cause of most of the problems is that in our
repo people have misplaced branches _inside_ other branches, at least
for a few revisions before realizing their mistake and deleting it.

So.... say I have a standard layout.

trunk
branches
tags

Then at one point I copy trunk to branches/a

Later on I copy trunk to branches/b

Later on I copy trunk to branches/b/c (instead of branches/c)

And a few revisions later I realize my mistake and copy branches/b/c
to branches/c and remove branches/b/c

I infer this because I'm seeing that on one of the revisions where git
svn usually breaks when fetching has the content of the project inside
a directory, like, say I have directories A, B and C in the project
and I'm seeing that git svn is fetching a revision where the all the
paths of the files are prepended by a directory that looks like a
branch, like this:

branch_name/A/filea.txt
branch_name/A/fileb.txt
etc etc

Instead of
A/filea.txt
A/fileb.txt

So... throw some ideas around that... and then, could you tell a
non-perl developer how to debug it? Perhaps increase verbosity?

One of the errors I see often when fetching (my memory tells me that
it's associated to the branch-in-branch problem but I'm not completely
sure right now), looks like this:

1 [main] perl 5652 cygwin_exception::open_stackdumpfile: Dumping stack
trace to perl.exe.stackdump

And then, in the file:

Exception: STATUS_ACCESS_VIOLATION at rip=0048360C10C
rax=0000000601E4BFF8 rbx=000000005219E248 rcx=000000060003A590
rdx=0000000000000000 rsi=000000000000A950 rdi=0000000000000004
r8 =0000000000000000 r9 =0000000000000000 r10=0000000000230000
r11=000000048D78607A r12=0000000000000003 r13=000006FFFFF54A98
r14=0000000601E18030 r15=000006FFFFF54AB0
rbp=0000000000054A88 rsp=000000000022B810
program=C:\Program Files\Git\usr\bin\perl.exe, pid 5652, thread main
cs=0033 ds=002B es=002B fs=0053 gs=002B ss=002B


With my very flawed knowledge of perl I have seen that the process is
getting to Ra.pm around here:

our $AUTOLOAD;
sub AUTOLOAD {
    my $class = ref($_[0]);
    $AUTOLOAD =~ s/^${class}::(SUPER::)?//;
    return if $AUTOLOAD =~ m/^[A-Z]/;

    my $self = shift;
    no strict 'refs';

    my $method = $self->can("invoke_$AUTOLOAD")
        or die "no such method $AUTOLOAD";

    no warnings 'uninitialized';
    $method->(@$self, @_);
}

The value of $AUTOLOAD there is 'finish_report' but I don't know (or
at least see) where $method->(@$self, @_) is going.

Well... I think that's enough of a mess of a mail (sorry about that).
Hope I was able to provide enough information to at least move a
little bit forward.

Thanks in advance.
