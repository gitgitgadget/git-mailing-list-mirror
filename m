From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bizarro race conditions in the Git Makefile
Date: Fri, 6 Aug 2010 16:14:07 -0500
Message-ID: <20100806211407.GB6495@burratino>
References: <AANLkTim2NMi3Vf-EGbFwy370q-YseQoGj=QLGMAq6N=B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 23:15:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhUGV-0003ml-VU
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 23:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970Ab0HFVPj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 17:15:39 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56245 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964832Ab0HFVPh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 17:15:37 -0400
Received: by vws3 with SMTP id 3so6548338vws.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 14:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qIl283CufOo9rugvhpHezDUpLEkTnfYr1SDYGY+R8aU=;
        b=xB9JbADOYZq8Mgyrapydyj0rBIefhz3JoRnLOchfG6TQKSTUuCAspec0t4XGjyH6bo
         PjfP1sZzV4qXQz3icRiYQI88FONxjoQltFUI3P2gTD3nEkhx0owPn1e+2fVGQCUr0wu9
         98irvMiPFWZ3+oR7emLGdvGXpDZ2GWn/tKA0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=MhWqLbSAoFec1yqySCdFKjVaLQrwEfdLNEGtjJfgMuviU/Ulwq8zMli6IqeA6nANXC
         SpfUl4TwsY3QCY57uSoo0WabbbSCzk+rZPHZVRqB85lN2N9xgT4nRHskk7GBr9DEu+KG
         uCaOfAurYyFw3Q7MhFIBYWXyIAsfugnS1YTUk=
Received: by 10.220.161.201 with SMTP id s9mr8615384vcx.137.1281129336661;
        Fri, 06 Aug 2010 14:15:36 -0700 (PDT)
Received: from burratino ([66.99.1.133])
        by mx.google.com with ESMTPS id i17sm760407vcr.3.2010.08.06.14.15.33
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 14:15:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim2NMi3Vf-EGbFwy370q-YseQoGj=QLGMAq6N=B@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152813>

=C6var Arnfj=F6r=F0 Bjarmason wrote:

> Those interested in
> poking their eyes can try:
>
>     while nice -n 30 make -j 15 clean all CFLAGS=3D-O0 CC=3Dgcc; do 1=
; done

You are asking make to simultaneously build and unbuild everything.
It does not really surprise me that it gets confused.

Does

 while
	nice -n 30 make -j 15 clean CFLAGS=3D-O0 CC=3Dgcc &&
	nice -n 30 make -j 15 all CFLAGS=3D-O0 CC=3Dgcc
 do
	:
 done

behave better?

>     Writing perl.mak for Git
>     Writing perl.mak for Git
>     rename MakeMaker.tmp =3D> perl.mak: No such file or directory at

Maybe something like the following is needed to protect against
interrupted builds (not the problem you reported, but this reminds
me).

diff --git a/perl/Makefile b/perl/Makefile
index 4ab21d6..eef7ee5 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -22,20 +22,21 @@ clean:
 ifdef NO_PERL_MAKEMAKER
 instdir_SQ =3D $(subst ','\'',$(prefix)/lib)
 $(makfile): ../GIT-CFLAGS Makefile
-	echo all: private-Error.pm Git.pm > $@
-	echo '	mkdir -p blib/lib' >> $@
-	echo '	$(RM) blib/lib/Git.pm; cp Git.pm blib/lib/' >> $@
-	echo '	$(RM) blib/lib/Error.pm' >> $@
+	echo all: private-Error.pm Git.pm > $@+
+	echo '	mkdir -p blib/lib' >> $@+
+	echo '	$(RM) blib/lib/Git.pm; cp Git.pm blib/lib/' >> $@+
+	echo '	$(RM) blib/lib/Error.pm' >> $@+
 	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
-	echo '	cp private-Error.pm blib/lib/Error.pm' >> $@
-	echo install: >> $@
-	echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)"' >> $@
-	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Git.pm"; cp Git.pm "$$(DESTDIR=
)$(instdir_SQ)"' >> $@
-	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
+	echo '	cp private-Error.pm blib/lib/Error.pm' >> $@+
+	echo install: >> $@+
+	echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)"' >> $@+
+	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Git.pm"; cp Git.pm "$$(DESTDIR=
)$(instdir_SQ)"' >> $@+
+	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@+
 	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
-	echo '	cp private-Error.pm "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
-	echo instlibdir: >> $@
-	echo '	echo $(instdir_SQ)' >> $@
+	echo '	cp private-Error.pm "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@=
+
+	echo instlibdir: >> $@+
+	echo '	echo $(instdir_SQ)' >> $@+
+	mv $@+ $@
 else
 $(makfile): Makefile.PL ../GIT-CFLAGS
 	$(PERL_PATH) $< PREFIX=3D'$(prefix_SQ)'
--=20
