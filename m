From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Splitting gitweb (was: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff)
Date: Fri, 10 Feb 2012 23:52:41 +0100
Message-ID: <201202102352.42101.jnareb@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com> <201202101555.20163.jnareb@gmail.com> <20120210183319.2f56ff88@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 23:56:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvzOV-0004o3-1L
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 23:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933269Ab2BJWwq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 17:52:46 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44925 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933265Ab2BJWwm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 17:52:42 -0500
Received: by eaah12 with SMTP id h12so1076357eaa.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 14:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=FkN14HTsjDYNBU41VjOXZZkAR3BpQgIcwC2Wivk3Cy0=;
        b=S6Gfi/E7WgNdEQ1v0rN+hzyzT99LXvDaTVliboRyKVp8fBzvZgcQZagizGw1w6CdNI
         HpZBONZvnMCPh9rDHOjZ8y7PUdfayYbYasoP/w2RbYv1ShenAarIfu8luhRuHfmfXLCA
         mgOP2athK0GWo/0SJcTPnRm6z2ZnXb6ScyJ2k=
Received: by 10.14.127.16 with SMTP id c16mr2618157eei.35.1328914361545;
        Fri, 10 Feb 2012 14:52:41 -0800 (PST)
Received: from [192.168.1.13] (abwh187.neoplus.adsl.tpnet.pl. [83.8.231.187])
        by mx.google.com with ESMTPS id w60sm9225132eeb.4.2012.02.10.14.52.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 14:52:41 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20120210183319.2f56ff88@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190472>

Micha=C5=82 Kiedrowicz wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:

> > Well, except the fact
> > that I'm rather wary about adding more code to gitweb when it is st=
ill
> > single monolithic script, rather than split into packages.
> >=20
>=20
> Yeah, jumping between 2k'th and 5k'th line isn't a great fun. Do you

There is an easy part, an almost easy part, and a hard part.

The easy part of splitting gitweb is creating infrastructure for it,
at least in the basic case.  The 'gitweb/split' branch in my git forks:

  http://repo.or.cz/w/git/jnareb-git.git
  https://github.com/jnareb/git

contains changes to gitweb and gitweb/Makefile, and splitting off
Gitweb::Util as an example; I'd have to update this branch to current
state of gitweb.

The almost easy part is to come up with a way to split gitweb.  Do we
follow SVN::Web (Subversion web interface in Perl), or maybe Gitalist
(git web interface in Perl, using Catalyst MVC framework)?  Do we use
MVC paradigm?  Or do we split on functionality: diffs, blobs, trees,
logs, etc.?


The hard part is about splitting main parts of gitweb.  It is easy to
put generic subroutines that are not specific to git or gitweb in
Gitweb::Util (or Gitweb::Util::* submodules).  It would be almost as
easy to put parsing of git command output in Gitweb::Parse (or=20
Gitweb::Parse::* submodules).

The problem is with putting actual actions in separate submodules.
=46or that we would need to replace our hacky "longjmp"-based error han=
dling
(nonlocal goto in Perl is roughly equivalent to longjmp() in C) to
exception-based one, as I don't think going back to exit-based error
ahndling is a good idea.  We would need exception-based error handling
if we want to implement HTTP output caching anyway, I think.

Not to not reimplement the wheel, badly, we will do better to use some
non-core Perl modules, namely Try::Tiny for capturing exceptions, and
HTTP::Exception (based on Exception::Class) for throwing exceptions.
So we would have to add a way to handle such non-core modules, perhaps
bundling them with gitweb, like Error is bundled with Git.pm and used
if it is not present on install.

Maybe Module::Install would help us there with bundling of such
dependencies for install; maybe "push @INC, __DIR__.'/inc' would be
a good idea.

It needs thinking about.
--=20
Jakub Narebski
Poland
