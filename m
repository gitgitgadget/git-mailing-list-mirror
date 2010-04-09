From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Makefile: Remove excess backslashes from sed
Date: Fri, 9 Apr 2010 01:02:57 -0700
Message-ID: <20100409080256.GA12527@gmail.com>
References: <1270783330-35215-1-git-send-email-brian@gernhardtsoftware.com> <7vvdc12mmz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 10:03:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O09BL-0007Yh-LW
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 10:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706Ab0DIIDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 04:03:10 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52928 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab0DIIDG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 04:03:06 -0400
Received: by gwb19 with SMTP id 19so1651352gwb.19
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 01:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZzOEPkKiczcaE2gK/uh34RMJ0Ma72wlhlmdn26lTJpI=;
        b=i1W6N0c7CEFBO9xVAUfEKKVDGCieGvfGSNiV6/aXED6p/LeODRD8QqE1KFw4okI36p
         ebByKJE+9/eNSBnSoC9/W0zDEiP/SsLz3UjkmlYwVsatcan2908vOnDuxRojfM9YcJ6A
         AhohoeEL49cU3anAHG6eqM9H1JJEiR6sloqmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=whFwZH3cS2/qaBhkg2nSVq5rIvSLa8AIU7UFgVxrqUCK//M4wnvA8UO502AmP+iPUa
         KvQwyfgdB+FmQqcQZa537FQfNkCTe7atdUpYPGGsl8YO2SlsX9FjLXxXv0zGsK8D/GvC
         0XSd4IemRq3tnfGeF2p7Jrf50iXWi9xTxMosk=
Received: by 10.150.208.15 with SMTP id f15mr1479833ybg.8.1270800184089;
        Fri, 09 Apr 2010 01:03:04 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 21sm261241ywh.32.2010.04.09.01.03.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 01:03:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vvdc12mmz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144415>

On Thu, Apr 08, 2010 at 10:57:56PM -0700, Junio C Hamano wrote:
> Brian Gernhardt <brian@gernhardtsoftware.com> writes:
> 
> > The sed script that was intended to add lines altering the sys.path
> > had extra backslashes in them.  Instead resulting in
> >
> >   import sys;  import os;  sys.path.insert( ... )
> >
> > It output
> >
> >   import sys; \ import os; \ sys.path.insert( ... )
> >
> > Unfortunately this caused python (2.6.1 on OS X 10.6.3) to error
> >
> >   SyntaxError: unexpected character after line continuation character
> >
> > Removing two of the backslashes solves this problem.
> 
> Traditionally, multi-line sed statements written in the Makefile were
> portability nightmare, as the line folding rules (especially how the
> backslash is treated in the output) in make implementations were subtly
> different, and implementations of sed also got multi-line statement often
> wrong.  These days, things might have gotten much better, but in olden
> days (back when BSD vs SysV war was still raging), the trick to write
> things like this portably was to invoke a shell script that has multi-line
> sed statement from the Makefile.  It was painful.
> 
> I wonder if we can make this a lot simpler to avoid multi-line sed script.
> For example, we could write the source Python script to always begin with:
> 
> 	#!/usr/bin/python
>         import sys;
>         import os;
>         sys.path.insert(0, os.getenv("GITPYTHONLIB","."));
> 
> and then do something like this in the Makefile:
> 
> 	INSTLIBDIR=... && \
> 	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
>         -e 's|\(os\.getenv("GITPYTHONLIB"\)[^)]*)|\1,"'"$$INSTLIBDIR"'")|' \
>         <$@.py >$@+
> 	mv $@+ $@
> 
> Contributors can then run things in-place while developing the scripts,
> perhaps setting GITPYTHONLIB to the source area.

Here's what I cooked up so far...:

$(patsubst %.py,%,$(SCRIPT_PYTHON)): GIT-CFLAGS
$(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
	$(QUIET_GEN)$(RM) $@ $@+ && \
	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C git_remote_helpers -s \
		--no-print-directory prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' \
		instlibdir` && \
	sed -e '1{' \
	    -e '	s|#!.*python|#!$(PYTHON_PATH_SQ)\n@@STARTUP@@\n|' \
	    -e '}' \
	    -e 's|@@STARTUP@@|import os, sys; sys.path.insert(0, @@ENV@@)|' \
	    -e 's|@@ENV@@|os.getenv("GITPYTHONLIB", "@@INSTLIBDIR@@")|' \
	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
	    $@.py >$@+ && \
	chmod +x $@+ && \
	mv $@+ $@

It avoids the multi-line portability concerns by substituting variables
along each step.

This is also nicer in that we don't need to start scripts with
"import sys" or os.getenv() anything...  all we require is a
shebang line.  We inject @@STARTUP@@ when we rewrite the
shebang.

That seems nicer then the old expression which searched for
"import sys.*" when doing the replacements.

Is the \n@@STARTUP\n thing portable?

-- 
		David
