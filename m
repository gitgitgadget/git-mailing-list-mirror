From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI
	script
Date: Mon, 10 May 2010 11:13:40 +0400
Organization: '
Message-ID: <20100510071340.GA3382@screwed.box>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <201005091439.26310.jnareb@gmail.com> <20100509164723.GA4638@screwed.box> <201005092018.54580.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Petr Baudis <pasky@suse.cz>, Petr Baudis <pasky@ucw.cz>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 09:13:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBNBc-0001QW-SJ
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 09:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314Ab0EJHNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 03:13:51 -0400
Received: from ns1.skyriver.ru ([89.108.118.221]:54878 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753916Ab0EJHNv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 03:13:51 -0400
Received: from localhost (gpftor2.privacyfoundation.de [87.118.101.175])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id 771EB5A81;
	Mon, 10 May 2010 11:02:15 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <201005092018.54580.jnareb@gmail.com>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L (~u 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146765>

Hey Jakub don't wanna cause you pain but the big boys feel no sorrow!
2010/05/09 20:18:52 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :

Great! I was just about to ask on caching, etc. What a complex history on all
of that, will be on those tracks after some of my whiles. ;-)

JN> What are required changes to gitweb to use FCGI::Spawn to run gitweb as
JN> a FastCGI script?  Alternatively, how the wrapper script for gitweb 
JN> (gitweb.fcgi) to be run as FastCGI should look like to use FCGI::Spawn?


By far it's only an exit() of the what I use (1.6.0.6):

--- /usr/local/share/examples/git/gitweb/gitweb.cgi     2010-02-25 13:49:30.068287112 +0300
+++ www/gitweb.cgi      2010-03-13 14:28:45.326244103 +0300
@@ -933,7 +933,7 @@
        die_error(400, "Project needed");
 }
 $actions{$action}->();
-exit;
+#      exit;
 
 ## ======================================================================
 ## action links
@@ -3371,7 +3371,7 @@
 </div>
 EOF
        git_footer_html();
-       exit;
+#              exit;
 }
 
 ## ----------------------------------------------------------------------


but it's probably even not necessary with -e parameter:
http://search.cpan.org/~veresc/FCGI-Spawn-0.16.1/fcgi_spawn#Command_line_options
which is definitely required for bugzilla, the worst boy in that sandbox. The
parameter does just this: 
===
my $cref = sub {
  if( 'FCGI::ProcManager' eq scalar caller ){
    CORE::exit @_;
  } else {
    no warnings;
    last CALLED_OUT;
  }
};
*CORE::GLOBAL::exit = $cref;
*CORE::GLOBAL::exit;
===
so this requires configuration 
( $PREFIX/etc/fcgi_spawn/preload_nonprepared_01.pl, in my case ) for fcgi_spawn
daemon like this:
===
  $spawn->{ callout } =  sub{ do shift;
  CALLED_OUT: 
  };
===
all of that is not needed without exit() in gitweb, now.

I didn't mean FCGI::PM is a problem by itself. The standalone gitweb daemon is
great thing for those who need such a choice. FCGI::Spawn is just for some
different task: to put several ( wish to say: any CGI app ) applications inside
the same fork()ed processes. It should be just obviously documented for a user
as a dependency for implementation of a gitweb fastcgi daemon. Although I'm not
sure if the FCGI::PM package should be a dependency for git package for any OS:
for those modules use()d in eval() my guess is: particular user's choice to be
offered.

So FCGI::PM usage I think makes a flavor taste for any daemon and thus should
be explicit. YMMV for those uninvolved in daemonizing, of course. ;-)

Is it probable that gitweb doesn't take any POSTs requests? The main trick
around FCGI::Spawn is the need to patch the CGI.pm but if that is the case...
I'd try to redefine the STDIN to /dev/null or zero so FCGI.Spawn.CGI.pm.patch
should be unnecessary for one who only wants to run the gitweb in FCGI::Spawn.
If switch to FCGI.pm will be way complicated to me.

73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 6627)
-- 
http://vereshagin.org
