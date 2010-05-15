From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI
	script
Date: Sat, 15 May 2010 14:06:15 +0400
Organization: '
Message-ID: <20100515100615.GA3564@screwed.box>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <201005141253.46956.jnareb@gmail.com> <20100514153636.GB17443@screwed.box> <201005141958.16469.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 15 12:06:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODEGO-0000ZI-98
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 12:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896Ab0EOKG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 06:06:26 -0400
Received: from ns1.skyriver.ru ([89.108.118.221]:53290 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752870Ab0EOKGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 06:06:25 -0400
Received: from localhost (anonymous-relay.omegamicro.net [216.86.61.205])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id 125EB5AAD;
	Sat, 15 May 2010 13:54:51 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <201005141958.16469.jnareb@gmail.com>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L (~u 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147137>

You're face to face with man who sold the world, Jakub!
2010/05/14 19:58:15 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :
JN> You don't see the parsing failure because "do <file>;" functions like
JN> "eval", which traps exceptions.  You will see consequences of parsing
JN> failure (like not defined subroutine).
JN> 
JN> > But you may see it with "use warnings;" right?
JN> 
JN> "use warnings;" pragma doesn't help, because of the 'trapping
JN> exceptions' part.  That is why "require <file>" is recommended over 
JN> "do <file>".
JN> Checking $@ after "do <file>" would cover the situation where there were
JN> parsing errors, but wouldn't cover situation where file was not found,
JN> or there was error in executing code (but parsing was O.K.).

I just use it like many others, here are the examples of the code
http://www.jmarshall.com/tools/cgiproxy/ nph-proxy.cgi:
===
    if ($scheme eq 'https') {
  eval { require Net::SSLeay } ;  # don't check during compilation
  &no_SSL_warning($URL) if $@ ;
===
http://webgui.org lib/WebGUI/HTML.pm:
===
  } elsif ($type eq "thumb-if-form-thumb") {
      eval "use Image::Magick;";
      if ($@){
        WebGUI::ErrorHandler::warn("Image::Magick not loaded: ".$@);
===

are those lemmings wrong?
By far, people don't use to want the application should be trapped as inclusion fails and they are just sure to deal with the consequences. This is where the php is successful to offer include/include_once as well as its require* counterparters to offer such a choice to a developer.
Are those consequences any danger anyway for applications like a gitweb?

Whatever, I almost forgot to ask you again about your mysterious 'The subroutine was defined, but there was a bug in parsing included file'. Does Perl parser has a bug ( about 'bug in parsing' )? file was not included but the sub from it was successfully defined? file was about to include inside a sub but Perl reported the 'sub undefined' instead of 'file has failed to be included by the sub'? All of those seem just incredible to me ;-)

JN> >> Second, "use Module <LIST>;" is equivalent to
JN> >>   BEGIN { require Module; import Module <LIST>; }
JN> >> and therefore it doesn't make sense to use it for conditional inclusion.
JN> > 
JN> > eval() is used there.
JN> 
JN> It's the fact that "use Module" uses BEGIN block that is incompatibile
JN> with *conditional* using it from eval.

it works conditionally on those excerpts above.
At the moment of the compilation, Perl doesn't know in general case what code should be eval()'d as its argument may vary at the runtime.
Therefore Perl do not parse eval() string argument even if it is a constant. And thus it doesn't appear at the BEGIN{} execution moment.
This is e.g.,  how the FCGI::Spawn works with CGI::Fast that defines the socket in its BEGIN{}. You may define your socket communications preference, the FCGI_SOCKET_PATH,  on a shell before to start perl, or in the perl, before to eval "use CGI::Fast;" or eval "use FCGI::Spawn"; Both work just fine.

JN> This convertion is 
JN> a.) compiling CGI file into subroutine (taking care of things like DATA
JN>     filehandle) using CGI::Compile
JN> b.) converting between CGI interface and PSGI interface, using
JN>     CGI::Emulate::PSGI

Sounds to me like all of that can happen in-memory. Great!

JN> Yes, it can.  Depending on request it would run appropriate
JN> CGI-converted-to-PSGI application.
JN> I am not sure how Plack::App::CGIBin works internally; it migh cimpile
JN> all CGI applications upfront; but it might not.

Will challenge.

73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 6627)
-- 
http://vereshagin.org
