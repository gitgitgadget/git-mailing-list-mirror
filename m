From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 01/12] Introduce Git.pm (v4)
Date: Sat, 24 Jun 2006 13:52:27 +0200
Message-ID: <20060624115227.GS21864@pasky.or.cz>
References: <20060624023429.32751.80619.stgit@machine.or.cz> <7vr71f5kzs.fsf@assigned-by-dhcp.cox.net> <7vu06bymtr.fsf@assigned-by-dhcp.cox.net> <20060624111657.GR21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 13:52:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu6gi-00067X-Sr
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 13:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWFXLwa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 07:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWFXLw3
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 07:52:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:12691 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964773AbWFXLw3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 07:52:29 -0400
Received: (qmail 27471 invoked by uid 2001); 24 Jun 2006 13:52:27 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060624111657.GR21864@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22509>

Dear diary, on Sat, Jun 24, 2006 at 01:16:57PM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> $(patsubst %.perl,%,$(SCRIPT_PERL)) : % : %.perl
> 	rm -f $@ $@+
> 	sed -e '1s|#!.*perl\(.*\)|#!$(PERL_PATH_SQ)\1 -I'"$$(make -s -C perl instlibdir)"'|' \
> 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
> 	    $@.perl >$@+
> 	chmod +x $@+
> 	mv $@+ $@
> 
> (This is also why I was a bit confused by your make test patch - it does
> not "fix" anything per se since no tests directly use Git.pm.)

And this makes the Perl scripts work even without make install:

Signed-off-by: Petr Baudis <pasky@suse.cz>

diff --git a/Makefile b/Makefile
index 7842195..d614f18 100644
--- a/Makefile
+++ b/Makefile
@@ -509,7 +509,9 @@ common-cmds.h: Documentation/git-*.txt
 
 $(patsubst %.perl,%,$(SCRIPT_PERL)) : % : %.perl
 	rm -f $@ $@+
-	sed -e '1s|#!.*perl\(.*\)|#!$(PERL_PATH_SQ)\1 -I'"$$(make -s -C perl instlibdir)"'|' \
+	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
+	    -e '2i\
+	        use lib qw ('"$$(make -s -C perl instlibdir)"' '"$$(pwd)"'/perl/blib/lib);' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $@.perl >$@+
 	chmod +x $@+
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 54e8b20..2cbd227 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -2,6 +2,9 @@ use ExtUtils::MakeMaker;
 
 sub MY::postamble {
 	return <<'MAKE_FRAG';
+all::
+	cp blib/arch/auto/Git/* blib/lib/auto/Git/
+
 instlibdir:
 	@echo $(INSTALLSITELIB)
 

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
