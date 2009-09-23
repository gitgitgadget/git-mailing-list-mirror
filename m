From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Initial manually svn property setting support for
	git-svn
Date: Wed, 23 Sep 2009 01:58:12 -0700
Message-ID: <20090923085812.GA20673@dcvr.yhbt.net>
References: <1482075216.1261253084509966.JavaMail.root@klofta.sjsoft.com> <1927112650.1281253084529659.JavaMail.root@klofta.sjsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Moore <davidm@sjsoft.com>
To: David Fraser <davidf@sjsoft.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 10:58:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqNg4-00006e-DJ
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 10:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbZIWI6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 04:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754533AbZIWI6K
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 04:58:10 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49607 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754509AbZIWI6J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 04:58:09 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id A2B451F5F3;
	Wed, 23 Sep 2009 08:58:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1927112650.1281253084529659.JavaMail.root@klofta.sjsoft.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128974>

David Fraser <davidf@sjsoft.com> wrote:
> This basically stores an attribute 'svn-properties' for each file that
> needs them changed, and then sets the properties when committing.

Hi David,

Please wrap your commit messages and emails at 72 columns or less.
All git svn code should be wrapped at 80 or less, too.

> Issues remaining:
>  * The way it edits the .gitattributes file is suboptimal - it just
>  appends to the end the latest version

Consider using $GIT_DIR/info/attributes or having an option to use that
instead.  Keeping a .gitattributes file in the git working tree but
_out_ of SVN is important and required, but also difficult to get right.

There are users working on projects that frown upon using unsupported
clients like git svn, and accidentally checking .gitattributes into
the project would likely annoy non-git users.  It's best to keep
*.git* stuff outside of SVN projects unless they allow/want it.

But also you should not fail to consider the case that somebody else did
intentionally commit .gitattributes into svn and you have little choice
but to commit your modifications to .gitattributes.  Things like
maintaining a mapping between svn:ignore and .gitignore has never
happened because of the corner cases that could pop up.

>  * It could use the existing code to get the current svn properties to
>  see if properties need to be changed; but this doesn't work on add

>  * It would be better to cache all the svn properties locally - this
>  could be done automatically in .gitattributes but I'm not sure
>  everyone would want this, etc

It should be possible to infer/rebuild this by parsing unhandled.log
files git svn generates by default.  There are definitely people who
don't want .gitattributes being written to automatically.

>  * No support for deleting properties

What advantage(s) does having this feature in git svn this give over
using:

	svn prop(edit|set|del) ARGS $(git svn info --url)

In my experience, explicitly set properties are rarely-used so I
need to be convinced it's worth supporting in the future.

> Usage is:
>  git svn propset PROPNAME PROPVALUE PATH
> 
> Added minimal documentation for git-svn propset

We'll also need a test case to ensure it continues working as other
changes get made and refactoring gets done.

> +sub check_attr
> +{
> +    my ($attr,$path) = @_;

Please use formatting consistent with the rest of the file.  Always use
tabs for indent here.

> +    if ( open my $fh, '-|', "git", "check-attr", $attr, "--", $path )

Consider command_output_pipe for better portability/consistency in
Git.pm instead of open(my $fh, "-|", @args) which is Perl 5.8+-only.


Thanks for the effort and keep us informed of improvements you make.

-- 
Eric Wong
