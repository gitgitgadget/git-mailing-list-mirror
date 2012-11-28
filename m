From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2012, #09; Wed, 28)
Date: Wed, 28 Nov 2012 15:38:26 -0500
Message-ID: <20121128203826.GA9383@sigill.intra.peff.net>
References: <7v38ztv6z0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 21:38:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdoP7-0001oL-1L
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 21:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315Ab2K1Ui3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 15:38:29 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34033 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932085Ab2K1Ui2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 15:38:28 -0500
Received: (qmail 11870 invoked by uid 107); 28 Nov 2012 20:39:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Nov 2012 15:39:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2012 15:38:26 -0500
Content-Disposition: inline
In-Reply-To: <7v38ztv6z0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210775>

On Wed, Nov 28, 2012 at 11:54:27AM -0800, Junio C Hamano wrote:

> * jk/fsck-dot-in-trees (2012-11-28) 1 commit
>  - fsck: warn about '.' and '..' in trees
> 
>  Will merge to 'next'.

Do you have an opinion on warning about '.git', as well? It probably
would make more sense as a patch on top, but I thought I'd ask before
this got merged to next.

> * pf/editor-ignore-sigint (2012-11-11) 5 commits
>  - launch_editor: propagate SIGINT from editor to git
>  - run-command: do not warn about child death by SIGINT
>  - run-command: drop silent_exec_failure arg from wait_or_whine
>  - launch_editor: ignore SIGINT while the editor has control
>  - launch_editor: refactor to use start/finish_command
> 
>  Avoid confusing cases where the user hits Ctrl-C while in the editor
>  session, not realizing git will receive the signal. Since most editors
>  will take over the terminal and will block SIGINT, this is not likely
>  to confuse anyone.
> 
>  Some people raised issues with emacsclient, which are addressed by this
>  re-roll. It should probably also handle SIGQUIT, and there were a
>  handful of other review comments.
> 
>  Expecting a re-roll.

I'm slowly going through my post-travel/vacation/illness backlog. I hope
to re-roll this one today or tomorrow.

> * jn/warn-on-inaccessible-loosen (2012-10-14) 4 commits
>  - config: exit on error accessing any config file
>  - doc: advertise GIT_CONFIG_NOSYSTEM
>  - config: treat user and xdg config permission problems as errors
>  - config, gitignore: failure to access with ENOTDIR is ok
> 
>  An RFC to deal with a situation where .config/git is a file and we
>  notice .config/git/config is not readable due to ENOTDIR, not
>  ENOENT; I think a bit more refactored approach to consistently
>  address permission errors across config, exclude and attrs is
>  desirable.  Don't we also need a check for an opposite situation
>  where we open .config/git/config or .gitattributes for reading but
>  they turn out to be directories?

I am not sure about the refactored approach you mention. We
fundamentally need to treat in-tree attributes and exclude files more
leniently, because we may find arbitrary paths in the tree. Whereas if
something in $GIT_DIR is inaccessible, it's probably a serious problem.
So I think we have to manually use access_or_{warn,die} from each
callsite.

As far as the opposite situation, I do not know if it is worth worrying
about. If $GIT_DIR/config or $HOME/.config/git/config is a directory,
that is an error and we should flag it[1]. In-tree is more hazy, but I
think complaining is still the right thing. You cannot expect to store
arbitrary crap at .gitattributes inside your tree. If you have crap in a
file at such a path, we would read it and complain when its syntax is
not that of a .gitattributes file. We should similarly complain when it
is a directory.

-Peff

[1] We might want to eventually allow "config directories" where we
    would read all files in lexical order or something. So it is
    tempting to think of ignoring such entries as a
    forward-compatibility thing. But ignoring is the wrong thing; you
    probably would not want an old version of git to _ignore_ your
    config; it is better if it says "I am too old to understand your
    config format".
