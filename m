From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/3] Gitweb caching v7
Date: Sat, 30 Oct 2010 01:58:29 -0700 (PDT)
Message-ID: <m3k4l0girs.fsf@localhost.localdomain>
References: <1288226574-19068-1-git-send-email-warthog9@eaglescrag.net>
	<7vbp6c63gt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 30 10:59:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PC7H9-0002NM-IW
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 10:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560Ab0J3I6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Oct 2010 04:58:34 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46660 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505Ab0J3I6c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 04:58:32 -0400
Received: by bwz11 with SMTP id 11so3211087bwz.19
        for <git@vger.kernel.org>; Sat, 30 Oct 2010 01:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=tpoQkzRzy7LTrRXVqeO6Igsf4lEITGEZmMPPj2nkKL4=;
        b=KViLHY0B4ay96kavFsRDXaZvSIOoiqZ0ybfAX5L8NrzoTVTLOhcFqT5/vISvmkQlYx
         FWIsGaZr8CSlmdxAClsxtDQZ1SXzaZ/k3Tui1PbDEFKznecCNBhHC6E+G4cmPNc0g+OU
         y4RxOgx3U+5u4lVw5av8mzisTASAI39OPm+VE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=mzZAgXqJAGtym25QlJedhpsr1bvuBnTMAFnWUqtUTPPNGQtGph+RgI5eSsp1UzGwEv
         pNpIibJrOvLTyGVB3Tm+esxNQX7IflyuB8eNKuMplqy6Vk5j30HU5ARvmyDvfhu8T+gx
         BLoIvA/vSH4zZq/52xh2od5YgBYB46AbC1Bwk=
Received: by 10.204.76.148 with SMTP id c20mr8903803bkk.118.1288429110768;
        Sat, 30 Oct 2010 01:58:30 -0700 (PDT)
Received: from localhost.localdomain (abvq193.neoplus.adsl.tpnet.pl [83.8.214.193])
        by mx.google.com with ESMTPS id g8sm1581624bkg.11.2010.10.30.01.58.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 Oct 2010 01:58:29 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9U8vowR007340;
	Sat, 30 Oct 2010 10:58:00 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9U8vSAo007336;
	Sat, 30 Oct 2010 10:57:28 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vbp6c63gt.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160395>

Junio C Hamano <gitster@pobox.com> writes:

> I am getting this in the gitweb.log:
> 
>     [Fri Oct 29 22:21:12 2010] gitweb.perl: Undefined subroutine 
>     &main::cache_fetch called at .../t/../gitweb/gitweb.perl line 1124.
> 
> which seems to cause t9500 to fail.

This is caused by three issues (bugs) in v7 caching code.

First is the reason why t9500 exhibits this bug.  The gitweb caching
v7 includes file with subroutines related to caching in the following
way:

  do 'cache.pm';

Note that the relative path is used; for t9500 it is relative from
somewhere witjin 't/', and not from 'gitweb/', so "do 'cache.pm';"
doesn't find it.

In my earlier rewrites I used

  do $cache_pm;

and 't/gitweb-lib.sh' set $cache_pm appriopriately.


Second is why this bug is bad.  There is no error checking that 
"do 'cache.pm';" succeeded.  It should be

  do $cache_pm;
  die $@ if $@;

at least.  Perhaps even better would be to simply turn off caching
support if there is an error in 'cache.pm' (which probably should be
called 'cache.pl', as it is not proper Perl module)... though on the
other hand side it would could hide the fact that caching is not
working.


Third is why this matters.  In v7 the cache_fetch() subroutine,
defined in 'cache.pm', is run *unconditionally*, and has test if the
caching is enabled *inside it*, instead of having gitweb (caller) use
it only if caching is disabled.

This coupled with the fact that 'make install-gitweb' would *not*
install 'cache.pm' alongside gitweb.cgi means that anybody upgrading
gitweb, whether he/she wants caching or not, would have gitweb stop
working after upgrade... unless he/she knows that he/she has to copy
'cache.pm' file manually.

On the other hand having test first if caching is enabled would make
t9500 tests pass (because they do not even test minimally cache
enabled / cache disabled cases, like in my rewrite), but would hide
problem when caching is enabled and 'cache.pm' is not installed...
(perhaps also in persistent environments; I don't know where pwd is
then).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
