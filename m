From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: [BUG (maybe)] git rev-parse --verify --quiet isn't quiet
Date: Thu, 4 Sep 2014 11:20:45 +0000 (UTC)
Message-ID: <loom.20140904T131954-274@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 13:21:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPV6I-0003X8-EH
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 13:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411AbaIDLVJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Sep 2014 07:21:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:50184 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753335AbaIDLVI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 07:21:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XPV69-0003QB-Ls
	for git@vger.kernel.org; Thu, 04 Sep 2014 13:21:06 +0200
Received: from 46.19.18.182 ([46.19.18.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 13:21:05 +0200
Received: from oystwa by 46.19.18.182 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 13:21:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 46.19.18.182 (Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Firefox/31.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256438>

Hi,

I noticed this while writing a small script for myself:

    $ git rev-parse --verify --quiet '@{u}'
    fatal: No upstream configured for branch 'local'

The functions that get run when rev-parse does its thing all return a
pointer to a strbuf, return the length of the modified buf or something
to that effect. However get_upstream_branch() calls die() which writes
to stderr unconditionally.

Call hierarchy in the above case:=20

die()
  get_upstream_branch()
    interpret_upstream_mark()
      interpret_branch_name()
        substitute_branch_name()
          dwim_ref()
            get_sha1_basic()
              get_sha1_1()
                get_sha1_with_context_1()
                  get_sha1_with_context()
                    get_sha1()
                      cmd_rev_parse()

Passing quiet =3D 1 all the way down I assume isn't feasible. Changing
get_upstream_branch() to not die but rather signify an error could work=
=2E
But interpret_branch_name() has four different callers belonging to
different parts of Git.

I marked this as "maybe" because I guess it's fair to say that rev-pars=
e
'@{u}' is not the correct way to check whether a branch as a configured
upstream. Furthermore even if it writes to stderr the exit status is
still non-zero so the only way to get bitten by this is if you doing
something like:

    foo=3D$(git rev-parse --verify --quiet $bar 2>&1) # pointless redir=
ection

*and* you check whether the exit code is equal to 1, not unequal to zer=
o.

On the other hand, it does break the expectations that the documentatio=
n
and the other uses of git rev-parse one encounters give. At least for
me. It should be able to verify that $foo is valid, and it should do so
quietly.

On a related note:

    $ git branch origin/master
    $ git rev-parse --verify --quiet origin/master
    warning: refname 'origin/master' is ambiguous.
    7c07808349fd0fc2c61a169833eeb55163cf3df4  =20


Best regards,
=C3=98sse
