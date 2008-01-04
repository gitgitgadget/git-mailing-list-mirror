From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] git-filter-branch could be confused by similar names
Date: Fri, 4 Jan 2008 18:51:15 +0300
Message-ID: <20080104155114.GS3373@dpotapov.dyndns.org>
References: <Pine.LNX.4.64.0712301700580.14355@wbgn129.biozentrum.uni-wuerzburg.de> <1199040667-31850-1-git-send-email-dpotapov@gmail.com> <7v7iiqppkw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 16:51:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAopp-0004Ac-GN
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 16:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbYADPvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 10:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbYADPvU
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 10:51:20 -0500
Received: from smtp03.mtu.ru ([62.5.255.50]:60009 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752204AbYADPvT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 10:51:19 -0500
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id D890F1870D93;
	Fri,  4 Jan 2008 18:51:17 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-188-25.pppoe.mtu-net.ru [85.141.188.25])
	by smtp03.mtu.ru (Postfix) with ESMTP id 9C9FD1870D5C;
	Fri,  4 Jan 2008 18:51:15 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JAopH-00077i-8s; Fri, 04 Jan 2008 18:51:15 +0300
Content-Disposition: inline
In-Reply-To: <7v7iiqppkw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69578>

On Thu, Jan 03, 2008 at 01:27:27PM -0800, Junio C Hamano wrote:
> Dmitry Potapov <dpotapov@gmail.com> writes:
> >  		ref="$(git for-each-ref --format='%(refname)' |
> > -			grep /"$ref")"
> > +			grep '^refs/\([^/]\+/\)\?'"$ref"'$')"
> >  	esac
> 
> Do we assume everybody's grep groks ERE these days?  I had an
> impression that we try to stick to a subset of BRE (namely, no
> \{m,n\}, [::], [==], nor [..]).

I was not aware about this policy, and I am not aware about
existing any grep that does not grok the expressions I used
above. So, I thought they are commonly accepted, but I might
be wrong.

> 
> Also as a general rule when dealing with refname, we use
> fileglob not regex.

Actually, refname was not meant to be used as regex here, and
it was written in the hope that there will be no special regex
symbols in the refname, but, yes, this use looks like hack.

BTW, accordingly to man, git filter-branch has <rev-list options>,
and git rev-list described as <commit(s)>, so fileglob may not
be used here. I look also at git for-each-ref and git show-ref,
and though they could have <pattern> as arguments, they meant
completely different by that. git for-each-ref requires the
full specification starting with refs but allows fileglob, while
git-show-ref does not allow fileglob, but it goes deeper in
refs, so it will match with those refs that are inside origin,
which git ref-list does not do. Here are a few examples:

===
$ git rev-list -1 master
257f3020f69f3222cdefc1d84b148fb35b2c4f5b
$ git rev-list -1 heads/master
257f3020f69f3222cdefc1d84b148fb35b2c4f5b
$ git rev-list -1 refs/heads/master
257f3020f69f3222cdefc1d84b148fb35b2c4f5b
$ git rev-list -1 'refs/heads/maste?'
fatal: ambiguous argument 'refs/heads/maste?': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
$ git rev-list -1 maint
fatal: ambiguous argument 'maint': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
===
$ git for-each-ref refs/heads/master
257f3020f69f3222cdefc1d84b148fb35b2c4f5b commit	refs/heads/master
$ git for-each-ref refs/heads/maste?
257f3020f69f3222cdefc1d84b148fb35b2c4f5b commit	refs/heads/master
$ git for-each-ref heads/master
$ git for-each-ref master
$ git for-each-ref maint
===
$ git show-ref refs/heads/master
257f3020f69f3222cdefc1d84b148fb35b2c4f5b refs/heads/master
$ git show-ref refs/heads/maste?
$ git show-ref heads/master
257f3020f69f3222cdefc1d84b148fb35b2c4f5b refs/heads/master
$ git show-ref master
257f3020f69f3222cdefc1d84b148fb35b2c4f5b refs/heads/master
257f3020f69f3222cdefc1d84b148fb35b2c4f5b refs/remotes/origin/master
$ git show-ref maint
4f3d37035a7c735a3b69f962656819f4ff7e4927 refs/remotes/origin/maint
===

> 
> What's the goal here?  Is it to make sure given refname is
> unambiguous by being a unique suffix of tags or heads, as in
> 
> 	test $(git show-ref "$ref" | wc -l) = 1

Because, I am not the author of this script, I can't be sure,
but it seems to me, the goal is to select among all parameters
only those that represents tops of branches, for example,
being given: A..B ^C D, we should choose only B and D and
convert them into the full refname in the same way as rev-list
does that.

> 
> or is there anything more going on?
> 
> Ah, it also wants the full name of the ref.  How about...
> 
> 	ref=$(git show-ref "$ref" | sed -e 's/^.* //')

It works only if the name "unambiguous" for git show-ref, which
interprets refname differently than rev-list as I wrote above.
Nevertheless, I believe we can use 'git show-ref' if we try
something like this:

for prefix in refs refs/tags refs/heads refs/remote; do
  fullref=$(git show-ref "$prefix/$ref" | sed -e 's/^.* //')
  test -n "$fullref" && break
done
ref="$fullref"

If this idea does not raise any objection, I will test it a bit
and then send the patch.

Dmitry
