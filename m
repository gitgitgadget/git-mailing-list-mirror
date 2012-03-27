From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Use SHELL_PATH to fork commands in
 run_command.c:prepare_shell_cmd
Date: Tue, 27 Mar 2012 00:01:10 -0500
Message-ID: <20120327050109.GC22547@burratino>
References: <20120326182427.GA10333@sigill.intra.peff.net>
 <1332816078-26829-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120327032917.GB17338@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, gitster@pobox.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 07:01:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCOXE-00071M-J8
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 07:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364Ab2C0FBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 01:01:22 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47260 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561Ab2C0FBU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 01:01:20 -0400
Received: by iagz16 with SMTP id z16so9277989iag.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 22:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eP6/ygxT20J3ghZ0UO1pxbGF0K1KHxhh48A/FlwpBvU=;
        b=OqVzctVoYXBX3BbLgqNFzeAWHVVf2KQlFbn4c66Dw0qg3i6k12m/PAEZhNjfGNp9JL
         jrWNJSCtKeEBw9s+aM1rQA3GuWmC3IM07wInaW0/jE7v45xk4k3lah8rQjVx+m9u96zU
         WZwd5tzNO6EkpzOCji0h3Pb5j1zyA2wu23MJdMu8dNPe5BThdBlItKtG/LNLI5ldTaTB
         nDr14UhiCOcnHA3xVpwllHeqVyh/9G1zJdJhYtdqj3lPBX4ZwAP4tJBdgS4aY3IVR1d8
         79EDzORtVA8mYm68hXcVLzGAqaRiqWBfqFm7bro/Y3CwHkpTMdyzwbU+Fc4f5Xahm9BR
         FPYA==
Received: by 10.42.18.71 with SMTP id w7mr14404618ica.4.1332824479980;
        Mon, 26 Mar 2012 22:01:19 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gw10sm11837580igb.5.2012.03.26.22.01.18
        (version=SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 22:01:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120327032917.GB17338@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194005>

Jeff King wrote:

> Does this default ever kick in? The Makefile defaults SHELL_PATH to
> /bin/sh, so we will always end up with at least that.
>
> Doing so at least makes us consistent across builds, but I wonder if we
> should leave it as "sh" on systems that do not set SHELL_PATH manually.
> Executing "sh" via the PATH is the normal system() thing to do.

It's more common for system() to default to /bin/sh.

I noticed the Makefile already doesn't do this sort of thing for
mandir and htmldir, but do you think changes to SHELL_PATH should be
tracked to force a rebuild when it changes?

	GIT-SHELL-PATH: FORCE
		@FLAGS='$(SHELL_PATH_SQ)'; \
		    if test x"$$FLAGS" != x"`cat GIT-SHELL-PATH 2>/dev/null`" ; then \
			echo 1>&2 "    * new shell path"; \
			echo "$$FLAGS" >GIT-SHELL-PATH; \
		    fi

	$(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh GIT-SHELL-PATH
		...

	$(SCRIPT_LIB) : % : %.sh GIT-SHELL-PATH
		...

	run_command.sp run_command.o: GIT-SHELL-PATH
	exec_cmd.sp exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
		'-DSHELL_PATH="$(SHELL_PATH_SQ)"'
