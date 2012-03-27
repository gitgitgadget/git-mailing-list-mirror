From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Use SHELL_PATH to fork commands in
 run_command.c:prepare_shell_cmd
Date: Mon, 26 Mar 2012 23:26:20 -0500
Message-ID: <20120327042620.GA22547@burratino>
References: <20120326182427.GA10333@sigill.intra.peff.net>
 <1332816078-26829-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, gitster@pobox.com, git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Tue Mar 27 06:27:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCO00-0005A3-5T
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 06:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947Ab2C0E0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 00:26:37 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48693 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab2C0E0g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 00:26:36 -0400
Received: by iagz16 with SMTP id z16so9238755iag.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 21:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=22JzlviaG+zXOMrLo+CpGpViq5vHw7vGRkDPduN4lic=;
        b=Jo8cIcvKQhwiZzwbrNSjo7eZWqXwjXybqNpXXyZqvcqYIXGrNFn7hlnhiO+/gVpgxH
         33BWZ4jnwBAX8g1CSyKCpBcxb9f0Iz0lkmCabMRmHm5MVlGy7sNw9d1Yyp2wgz9NkNRT
         AdcGAoNxOvDukFjhpN4sN2pYKforAtgnC7zNolN5FHOw60jz+OD8LDE/uHip2IYszKYU
         ImsMqlAfvX4HY/B0ODVYfl29wLLu3UZNPT47p426gy0CCAWCs9/BGjQGYXL8ClUHgEjD
         6NYSxgnxoZWsQ/JMqbenmNvuJGVpRsy3rnCo8TuDAmjODDBnKPAYAq75wmdwoXDLdwjq
         /wQg==
Received: by 10.50.6.225 with SMTP id e1mr7408449iga.34.1332822395964;
        Mon, 26 Mar 2012 21:26:35 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ut8sm16726521igc.11.2012.03.26.21.26.32
        (version=SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 21:26:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1332816078-26829-1-git-send-email-bwalton@artsci.utoronto.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194003>

Hi again,

Ben Walton wrote:

> The shell spawned in run-command.c:prepare_shell_cmd was hard coded to
> "sh."  This was breaking "t7006-pager:command-specific pager" when the
> "sh" found in the PATH happened to be a broken one such as Solaris'
> /usr/bin/sh.  (The breakage in this case was due to ^ being
> interpreted the same as | which was seeing two processes forked
> instead of a single sed process.)

Better.  But the above is still focusing on what you changed rather
than the intended impact and potential fallout.  Remember, the commit
log is where most of git's design documents are stored.

Isn't it something more like this?

	Ever since <date or version>, the "command-specific pager" test
	from t7006-pager has not been passing on Solaris with the
	default value of PATH.

	The cause: that test (and some subsequent ones) sets the pager
	command used by git log to "sed s/^/foo:/ >actual" which is fine
	in a POSIX-compliant sh, but not in Solaris' sh.  The
	run_command machinery uses plain "sh" as a shell and if the user
	PATH at runtime happens to put the ancient system sh before any
	modern POSIX-style sh, the ^ is interpreted the same as | and
	chaos results.

	Or to put it another way, t7006 expects that the shell used to
	interpret GIT_PAGER is a POSIX-style shell and run_command's
	shell feature fails to deliver.

	To fix this:

	a. instead of launching a shell on its own, run_command could
	   call system() or popen().  This launches a POSIX shell on
	   Solaris as long as _POSIX_SOURCE is defined.

	b. the git wrapper could prepend SANE_TOOL_PATH to $PATH for
	   builtin commands for consistency with scripted commands that
	   do that using git-sh-setup.  If we're lucky, the first "sh"
	   command found in the new PATH would be a suitable shell,
	   though git's current scripts do not rely on that.

	c. the run_command machinery could use the same SHELL_PATH
	   shell that is used by the git filter-branch script and in
	   all script's #! lines.

	However:

	- (a) means losing the ability to open a bidirectional pipe to a
	  filter script.  It would also break git for Windows, where
	  system() uses cmd.exe instead of a POSIX-style shell (see
	  v1.7.5-rc0~144^2, "alias: use run_command api to execute
	  aliases, 2011-01-07).

	- On Solaris systems with schilyutils in /opt/csw/bin at the
	  beginning of SANE_TOOL_PATH, (b) finds /opt/csw/bin/sh which
	  is another ancient Bourne-style shell with the same problem.

	So let's go with (c).

	After this patch, $GIT_PAGER is interpreted by the same shell
	in scripted commands which use the git_pager function that uses
	"eval" and builtins which use the run_command machinery to
	launch the interpreter specified as SHELL_PATH when git was built.

Just my two cents,
Jonathan
