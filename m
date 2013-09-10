From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Regression in e02ca72: git svn rebase is broken on Windows
Date: Tue, 10 Sep 2013 22:17:17 +0000 (UTC)
Message-ID: <loom.20130911T001650-550@post.gmane.org>
References: <17231378818848@web5m.yandex.ru> <xmqq38pczjw6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 00:20:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJWIA-00080g-VE
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 00:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706Ab3IJWUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 18:20:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:47299 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145Ab3IJWUI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 18:20:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VJWHz-0007jt-HG
	for git@vger.kernel.org; Wed, 11 Sep 2013 00:20:03 +0200
Received: from ns.dcon.de ([77.244.111.149])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 00:20:03 +0200
Received: from karsten.blees by ns.dcon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 00:20:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 77.244.111.149 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:23.0) Gecko/20100101 Firefox/23.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234492>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Tvangeste <i.4m.l33t <at> yandex.ru> writes:
> 
> > Hi,
> >
> > After bisecting this problem I ended up with the mentioned commit that
completely breaks git-svn for me on
> Windows (mingw/msys version).
> >
> > ==========
> > #> git svn rebase
> > warning: unable to access '': Invalid argument
> > warning: unable to access '': Invalid argument
> > fatal: unable to access '../../../../w:/work/my/repo.git/.git/config':
Invalid argument
> > fatal: index file open failed: Invalid argument
> > Cannot rebase: You have unstaged changes.
> > Please commit or stash them.
> > rebase refs/remotes/trunk: command returned error: 1
> > ==========
> >
> > Please note that I use the official git repository as-is, this one (no
additional patches):
> > git://git.kernel.org/pub/scm/git/git.git
> >
> > e02ca72f70ed8f0268a81f72cb3230c72e538e77 is the first bad commit
> > commit e02ca72f70ed8f0268a81f72cb3230c72e538e77
> > Author: Jiang Xin
> > Date:   Tue Jun 25 23:53:43 2013 +0800
> >
> >     path.c: refactor relative_path(), not only strip prefix
> >
> > Thanks,
> >   --Tvangeste
> 
> The suspect commit and symptom look consistent.  You started from a
> directory whose absolute path is "w:/work/..." and the updated code
> mistakenly thoguht that something that begins with "w" (not '/') is
> not an absolute, so added a series of ../ to make it relative, or
> something silly like that.
> 
> Jiang?
> 

Indeed, this patch seems to change relative_path in a way that breaks git
initialization, not just on Windows.

Previously, relative_path was always called with two absolute paths, and it
only returned a relative path if the first was a subdir of the second (so a
better name would probably have been 'relative_path_if_subdir'). The purpose
was to improve performance by making GIT_DIR shorter if it was a subdir of
GIT_WORK_TREE.

After this patch, relative_path always tries to return a relative path, even
if both absolute paths are completely disjunct. This not only defeats the
purpose (by making GIT_DIR longer, thus hurting performance), it is also not
possible in general. POSIX explicitly allows for '//hostname' notation
referring to network resources that are not explicitly mounted under '/'.
I.e. given two absolute paths '//hostname1/a' and '//hostname2/b', there is
no relative path from a to b or vice versa.

Additionally, GIT_DIR now may or may not have a trailing slash, which gives
me a slightly uneasy feeling...
