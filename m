From: Kacper Kornet <kornet@camk.edu.pl>
Subject: Re: [PATCH] Respect definition of prefix from autotools in
 ETC_GITCONFIG and ETC_GITATTRIBUTES
Date: Thu, 28 Apr 2011 19:49:36 +0200
Message-ID: <20110428174935.GD4833@camk.edu.pl>
References: <20110428022922.GC4833@camk.edu.pl>
 <7v62py5nbp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 19:49:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFVLZ-0007fi-HZ
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 19:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756862Ab1D1Rto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 13:49:44 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:59215 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318Ab1D1Rtn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 13:49:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id BEA955F0047;
	Thu, 28 Apr 2011 19:49:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id EsOw0wdDlWH9; Thu, 28 Apr 2011 19:49:36 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 214EC5F0046;
	Thu, 28 Apr 2011 19:49:36 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 121D280A1F; Thu, 28 Apr 2011 19:49:36 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v62py5nbp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172379>

On Thu, Apr 28, 2011 at 09:54:02AM -0700, Junio C Hamano wrote:
> Kacper Kornet <kornet@camk.edu.pl> writes:

> > Definitions of ETC_GITCONFIG and ETC_GITATTRIBUTES depend on value of
> > prefix. As prefix can be changed in config.mak.autogen, all if blocks
> > with conditions based on prefix should be placed after the file is
> > included in Makefile.

> This is _not_ just about autogen, is it?  The same issue exists if the
> user wants to manually tweak prefix in config.mak, no?

> If so, perhaps the patch needs to be retitled to avoid confusion,
> something like:

>     Subject: Honor $(prefix) set in config.mak* when defining ETC_GIT* variables

You are right.

> > diff --git a/Makefile b/Makefile
> > index cbc3fce..5b4ae40 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -291,15 +291,8 @@ sharedir = $(prefix)/share
> >  gitwebdir = $(sharedir)/gitweb
> >  template_dir = share/git-core/templates
> >  htmldir = share/doc/git-doc
> > -ifeq ($(prefix),/usr)
> > -sysconfdir = /etc
> >  ETC_GITCONFIG = $(sysconfdir)/gitconfig
> >  ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
> > -else
> > -sysconfdir = $(prefix)/etc
> > -ETC_GITCONFIG = etc/gitconfig
> > -ETC_GITATTRIBUTES = etc/gitattributes
> > -endif
> >  lib = lib
> >  # DESTDIR=
> >  pathsep = :
> > @@ -1192,6 +1185,12 @@ endif
> >  -include config.mak.autogen
> >  -include config.mak

> > +ifeq ($(prefix),/usr)
> > +sysconfdir = /etc
> > +else
> > +sysconfdir = etc
> > +endif

Actually I have made a mistake here. I meant the last hunk to be:

@@ -1192,6 +1185,12 @@ endif
 -include config.mak.autogen
 -include config.mak

+ifeq ($(prefix),/usr)
+sysconfdir = /etc
+else
+sysconfdir = $(prefix)/etc
+endif

> But this part in the Makefile outside the context of the patch bothers
> me.  It seems to imply that sysconfdir is _not_ that variable you want to
> define later.

>    # Among the variables below, these:
>    #   gitexecdir
>    #   template_dir
>    #   mandir
>    #   infodir
>    #   htmldir
>    #   ETC_GITCONFIG (but not sysconfdir)
>    #   ETC_GITATTRIBUTES
>    # can be specified as a relative path some/where/else;

> So I have a suspicion that your patch as is will break when prefix is set
> to something other than /usr directory.  I don't think anybody in-tree
> currently uses sysconfdir, but that does not mean nobody will ever do.

See the corrected hunk above. I will be prepare the corrected patch.

-- 
  Kacper Kornet
