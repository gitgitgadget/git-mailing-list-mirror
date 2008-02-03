From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH 1/2][Perlers?] git-send-email: ssh/login style password requests
Date: Sun, 3 Feb 2008 12:59:21 -0500
Message-ID: <87CDEC9F-8153-48D0-AD1C-A3B3CEF6FDAE@MIT.EDU>
References: <7vve586tbz.fsf@gitster.siamese.dyndns.org> <1201925161-9864-1-git-send-email-mfwitten@mit.edu> <7vve5711wa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 19:02:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLjAy-0001l2-9a
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 19:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757575AbYBCSCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 13:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756883AbYBCSCM
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 13:02:12 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:44808 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757510AbYBCSCL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Feb 2008 13:02:11 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m13HxMOc006784;
	Sun, 3 Feb 2008 12:59:22 -0500 (EST)
Received: from MACGREGOR-FIVE-TWENTY-TWO.MIT.EDU (MACGREGOR-FIVE-TWENTY-TWO.MIT.EDU [18.239.7.11])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m13HxL0s008445
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 3 Feb 2008 12:59:22 -0500 (EST)
In-Reply-To: <7vve5711wa.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72386>

The crux of my conclusion comes after the ---------------------------- .

On 2 Feb 2008, at 4:31 PM, Junio C Hamano wrote:

> Actually, I just tried this myself:
>
>    #!/usr/bin/perl -w
>
>    use Term::ReadLine;
>    my $term = new Term::ReadLine 'foobar';
>
>    my ($user, $password);
>    while (!defined $user) {
>            $user = $term->readline("User: ");
>    }
>    system 'stty -echo';
>    while (!defined $password) {
>            $password = $term->readline("Password: ");
>    }
>    system 'stty echo';
>    print "You said <$user><$password>\n";
>    print "ReadLine backend used was ", $term->ReadLine, "\n";
>
> In my case, the backend was "Term::ReadLine::Perl".  A few
> problems:
>
> * After typing "junio <Enter>" to "User:", an extra newline is
>   left before "Password:" prompt;

I didn't have this problem.

> * "Password:" prompt still echoed password "abc".  There was no
>   extra newline before "You said <junio><abc>".

Indeed. I tested your code and my git-send-email code with all three
backend implementations (Term::ReadLine::Stub, Term::ReadLine::Gnu, and
Term::ReadLine::Perl). The problem with echoing seems to be a fault of
the Term::ReadLine::Perl implementation.

> * In either case, typing <Enter> returns an empty string from
>   $term->readline() so the "while (!defined)" loop does not buy
>   us anything.

Frankly, I wrote that readline code according to the other uses of  
readline,
as I am not well versed in these things.

Because all other uses of readline are wrapped in such while loops, I  
assume
that they are meant to cover systems with non-blocking (unbuffered)  
IO, rather
than to continue to prompt the user due to empty strings.

Should empty-string passwords not be allowed?

-------------------------------------------------

> Another example which appears in PerlFAQ #8 uses ReadKey with
> its ReadLine, like this:
>
>    use Term::ReadKey;
>    ReadMode('noecho');
>    $password = ReadLine(0);
>
> which is different from Term::ReadLine's "ReadLine".  An earlier
> example you cited from perlfunc.pod's crypt() entry does:
>
>    system "stty -echo";
>    print "Password: ";
>    chomp($word = <STDIN>);
>    print "\n";
>    system "stty echo";
>
> In either case, I was worried about the interaction between the
> Term::ReadLine backend implementation and "stty".

This got me thinking: At first I wanted to use readline for the  
password prompt,
because I figured it would allow the user better editing facilities,  
especially
with regard to the arrow keys. However, it occurred to me that perhaps  
this should
not be the case; perhaps arrow keys are meant to be useable in  
passwords, etc.

Well, this turns out to be the case! (which may not be a surprise to  
most people,
but it was to me). Passwords can actually contain some of the keycodes  
that read-
line converts into editing commands (now you know which characters you  
don't have
to test when cracking my password). Therefore, we shouldn't even  
bother using the
readline backend for password prompting; neither passwd nor ssh use  
readline, for
example.

I support the 'crypt' method, because the Term::ReadKey approach  
requires another
module dependency.

Sincerely,
Michael Witten
