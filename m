From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support "core.excludesfile = ~/.gitignore"
Date: Fri, 22 Aug 2008 14:10:42 -0700
Message-ID: <7vsksw92nh.fsf@gitster.siamese.dyndns.org>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Fri Aug 22 23:12:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWdvE-0005n7-GH
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 23:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbYHVVKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 17:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753147AbYHVVKs
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 17:10:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbYHVVKr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 17:10:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0FA4863D21;
	Fri, 22 Aug 2008 17:10:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 40F4463D1F; Fri, 22 Aug 2008 17:10:44 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CA2C2150-708E-11DD-A2FC-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93366>

Karl Chen <quarl@cs.berkeley.edu> writes:

> Another idea is to have a non-absolute path be interpreted
> relative to the location of .gitconfig.

If we were to support relative paths, I think it would be useful and
consistent if a relative path found in ".git/config" is relative to the
work tree root, in "config" in a bare repository relative to the bare
repository, and in "$HOME/.gitconfig" relative to $HOME.  I am not sure
what a relative path in "/etc/gitconfig" should be relative to, though.

However, this has a technical difficulty.  When configuration values are
read, the code that knows what the value means does not in general know
which configuration file is being read from.

> Below is a sample patch that works for me.  We could also use
> getpwuid(getuid()) instead of getenv("HOME") to be consistent with
> user_path() but this is simpler and arguably more likely what the
> user wants when it matters.

It is quite likely that somebody would want you to interpret "~name/" if
you advertize that you support "~/", so you would need to call getpwuid()
eventually if you go down this path.  I wonder how this would affect
Windows folks.

What are the paths valued configuration variables other than excludesfile
that we would want to support?  There was a topic to allow mail-aliases
lookup for parameters given to the "--author" option today, and send-email
takes aliasfile configuration.  Because the latter is a script, we would
need a "--path" option to "git config" (the idea is similar to existing
"--bool" option) so that calling scripts can ask the same "magic"
performed to configuration variables' values before being reported.
