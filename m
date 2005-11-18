From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add test case for git-config-set
Date: Thu, 17 Nov 2005 22:09:53 -0800
Message-ID: <7vd5kypjv2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511172249410.18285@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Nov 18 07:53:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EczSK-0007r8-60
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 07:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbVKRGJz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 01:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbVKRGJz
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 01:09:55 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:32403 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S964896AbVKRGJy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 01:09:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118060854.LCSX26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 01:08:54 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511172249410.18285@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 17 Nov 2005 22:50:08 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12203>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> +test_expect_failure 'ambiguous unset' \
> +	'git-config-set --unset nextsection.nonewline'

I am not so sure about this case.  Shouldn't this remove both?

For example, if a Porcelain wants to force pull.twohead to be
resolve and nothing else, and it wants to do it unconditionally,
it would first want to empty whatever multivalue there are
currently, and then insert its own, and I'd imagine the way to
say that would be like this:

	git-config-set --unset pull.twohead '^'
        git-config-set pull.twohead resolve

More simply (I do not think you have a test case for this):

        git-config-set pull.twohead resolve '^'

I think it is the easiest to explain and understand the
semantics of config_set_multivalue if it were to first remove all
existing key-value for matching ones, and then insert what was
provided by the user.

Extending that multivalue example a bit more, I think it is a
bit cumbersome for a Porcelain to set pull.twohead to recursive
and then resolve, with your interface.  Even if you had the
emptying behaviour I suggested above, you would have to say
something awkard like this:

	git-config-set --unset pull.twohead '^'
        git-config-set pull.twohead recursive
        git-config-set pull.twohead resolve no-such-value-should-be-there

Maybe we could have the shell-level interface like this:

	git-config-set [--remove rx] section.key [value...]

When --remove rx is specified, the command first removes
existing multivalue for the given section.key that match rx, and
then insert given value(s); not giving any values amounts to
--unset.  Not giving --remove rx is the same as giving a regexp
that matches all multivalues.  So the simplest:

	git-config-set section.key value

becomes a single-value assignment (insert-or-replace),

	git-config-set section.key

confusingly enough is --unset (we probably would want to require
an explicit command line noise-word "--unset" in this case).
And "replacing with two values regardless of whatever there are
currently" naturally becomes:

	git-config-set pull.twohead recursive resolve

The C-level interface would become something like:

	git_config_set_multivar(const char *key,
        			const char *remove_value_regex,
                                const char **values)

where values is a NULL terminated list of values.

BTW, do we want to remove the section after removing the last
key and making it empty?
