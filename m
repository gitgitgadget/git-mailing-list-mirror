From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI
	script
Date: Fri, 14 May 2010 19:36:36 +0400
Organization: '
Message-ID: <20100514153636.GB17443@screwed.box>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <201005111551.21316.jnareb@gmail.com> <20100513131016.GA5250@screwed.box> <201005141253.46956.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 17:37:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCwwd-0006ti-Uo
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 17:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536Ab0ENPgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 11:36:55 -0400
Received: from ns1.skyriver.ru ([89.108.118.221]:62436 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793Ab0ENPgy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 11:36:54 -0400
Received: from localhost (spftor1.privacyfoundation.de [87.118.104.203])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id 252385AAB;
	Fri, 14 May 2010 19:25:18 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <201005141253.46956.jnareb@gmail.com>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L (~u 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147093>

God love is hard to find. You got lucky Jakub!
2010/05/14 12:53:42 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :
JN> legitimate uses of 'goto' that make the program simpler to understand,
JN> and not harder,... among those is handling exceptions.

so did you change the exception-related exit()s on your patch to the last()s ?

JN> >>>> I know this from painful experience of trying to find bug in a
JN> >>>> test... when the error was in parsing file in 'do $file;'.
JN> >>> 
JN> >>> I handle them just fine like in any other CGI program using
JN> >>> CGI::Carp:fatalsToBrowser. Are you about to 'make test' via the http? ;-)
JN> >> 
JN> >> I don't think you understand what I wanted to say there.
JN> >> 
JN> >> If you don't check if there were parse errors from 'do $file;', you can
JN> >> get later some error message which is totally unrelated to the parsing
JN> >> error.  If you don't know or forget that you should check $@ after 
JN> >> 'do $file;', and are unlucky, you can chase elusive error from there
JN> >> to kingdom come...
JN> > 
JN> > Got it, it's about the inclusion failure via the do() which is the
JN> > development, not a production, situation.
JN> 
JN> Yes, it is a problem mainly in developemtn, where changes to the file
JN> included via "do <file>" might introduce parsing errors.
JN> 
JN> > I think this should be an adjective noun to use the both strict and
JN> > the warnings?
JN> 
JN> The problem is that "do <file>;" is similar to "eval `cat <file>`;"
JN> (except that it's more efficient and concise), it that it silences
JN> parsing errors.  From `perldoc -f do`:
JN> 
JN>   If "do" cannot read the file, it returns undef and sets $! to the error.
JN>   If "do" can read the file but cannot compile it, it returns undef and sets
JN>   an error message in $@.   If the file is successfully compiled, "do"
JN>   returns the value of the last expression evaluated.
JN> 
JN> > And yes, since it's about development but not production use, die is just fine
JN> > in the inclusion code like this:
JN> > 
JN> > eval( 'use Module;' ); die $@ if $@;
JN> 
JN> Wrong!

The problem was you can't see the reason of the inclusion-via-do() parsing
failure.
But you may see it with use warnings; right?
Is there any applied example of do()-caused failures?

JN> > as always, require() can do the trick, not to mention usual 
JN> > 
JN> > use Module;
JN> > 
JN> > This all will cause die() when it's necessary as only the application developer
JN> > knows how strict is the dependence on the Module. In some cases, application
JN> > can work without some Module but it's just better with it.
JN> 
JN> First, both "use Module;" and "require Module;" (and "require '<file>';")
JN> do automatic error checking and raise an exception if there is problem.

for web applications, half of exceptions or more are generated when the user
isn't the develioper.
Notifications() via the logs are just enough and more than it: should be the
prefered way of exceptions' notifications in a production.
Why worry about return code then?

JN> Second, "use Module <LIST>;" is equivalent to
JN>   BEGIN { require Module; import Module <LIST>; }
JN> and therefore it doesn't make sense to use it for conditional inclusion.

eval() is used there.

JN> Therefore, to load Perl module / file, if you can 'die' you can simply
JN> use
JN> 
JN>   require "<file>";
JN> 
JN> If you don't want to die, but want to know if loading and parsing file
JN> succeeded or not, you should use the following syntax:
JN> 
JN>   if (eval { require "<file>"; 1 }) {
JN>     ...
JN>   } else {
JN>     ...
JN>   }
JN> 
JN> If you want to use 'do "<file>";' (it is preferred in some
JN> circumstances), you really should check for error conditins:
JN> 
JN>   unless (my $return = do "<file>") {
JN>     if ($@) {
JN>        # couldn't parse <file>
JN>     } elsif (!defined $return) {
JN>        # couldn't do <file> (e.g. couldn't find <file>)
JN>     }
JN>     ...
JN>   }

So you propose to use the return code either way. Is it a key point?
And what is the real difference from $@ usage?
You mention 'The subroutine was defined, but there was a bug in parsing
included file' just where is the code? How come file was not parsed but sub was
defined?

JN> [...]
JN> >> PSGI is interface, Plack is reference implementation.  You can run PSGI
JN> >> app on any supported web server; this includes running PSGI apps on
JN> >> FastCGI.
JN> > 
JN> > Existing problem FCGI::Spawn for is not the PSGI applications to be run as a
JN> > FastCGI, but the bunch of existing CGI.pm applications (even gitorious) need
JN> > to be more effective with the widest-spread protocol FastCGI. Best without any
JN> > patching of the application, deployed the same simple way as with apache's cgi
JN> > implementation.
JN> 
JN> Gitorious is in Ruby, therefore is not a CGI.pm application, as it is
JN> not even in Perl.

It was Girocco you mentioned earlier

JN> By using Plack::App::CGIBin you can load CGI scripts from a directory
JN> and convert them into a <persistent> PSGI application.  You can use

Such a conversion is more than a compilation? Does it mean converted CGI app
should be stored before to become a persistent application?

JN> Plack::App::WrapCGI to convert single CGI script into PSGI application.
JN> You can use Plack::Buuilder's domain specific language to join (map)
JN> together a bunch of PSGI applications (in different paths) in a single
JN> app (via Plack::App::URLMap).

And can the same process of that application server run for the several
applications depending on the FastCGI request?

JN> You can then run PSGI application (for example the PSGI app which loads
JN> CGI apps via Plack::App::CGIBin) on any supported web server, which
JN> includes FCGI (FastCGI).


73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 6627)
-- 
http://vereshagin.org
