From: Jeff King <peff@peff.net>
Subject: Re: Minor bug, git ls-files -o aborts because of broken submodules
Date: Fri, 22 Jan 2016 16:18:03 -0500
Message-ID: <20160122211803.GA17071@sigill.intra.peff.net>
References: <CACsJy8BpCc6sNKUs3TsMnA_8dk+uFvZy1T_UmfQMxcm2bpg2uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 22:18:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMj5w-0000kv-CP
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 22:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbcAVVSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 16:18:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:58899 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753361AbcAVVSH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 16:18:07 -0500
Received: (qmail 14141 invoked by uid 102); 22 Jan 2016 21:18:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jan 2016 16:18:06 -0500
Received: (qmail 5759 invoked by uid 107); 22 Jan 2016 21:18:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jan 2016 16:18:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jan 2016 16:18:03 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8BpCc6sNKUs3TsMnA_8dk+uFvZy1T_UmfQMxcm2bpg2uw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284592>

On Fri, Jan 22, 2016 at 04:17:29PM +0700, Duy Nguyen wrote:

> $ git init abc
> $ cd abc
> $ mkdir def
> $ echo 'gitdir: blah blah' >def/.git
> $ git ls-files -o
> fatal: Not a git repository: def/blah blah
> 
> If some directory looks like a submodule but turns out not, that's not
> a fatal error. The stack trace is something like this. I suspect
> do_submodule_path should use the gently version..
> 
> #1  0x0000000000588a78 in die
> #2  0x0000000000558ded in read_gitfile_gently
> #3  0x000000000051e2f6 in do_submodule_path
> #4  0x000000000051e484 in git_pathdup_submodule
> #5  0x00000000005340ac in resolve_gitlink_ref_recursive
> #6  0x00000000005342cf in resolve_gitlink_ref
> #7  0x00000000004dd20d in treat_directory
> #8  0x00000000004dd760 in treat_one_path
> #9  0x00000000004dd971 in treat_path
> #10 0x00000000004de038 in read_directory_recursive

I think we'd have to change the semantics going up the stack, as
do_submodule_path has no way to report failure.

But I think this is another case of

  http://thread.gmane.org/gmane.comp.version-control.git/265560/focus=281253

There the question was about performance (lots of these clog up the
linear ref_cache list), but I think the root cause is the same: going
too far into ref resolution without realizing we don't have a real
submodule.

Andreas posted some patches, but they didn't make it to the list. Here
are my replies, which did:

  http://article.gmane.org/gmane.comp.version-control.git/282028

  http://article.gmane.org/gmane.comp.version-control.git/282029

  http://thread.gmane.org/gmane.comp.version-control.git/282030

However, from going over them, I think there was a problem in the series;
we really do need to know the sha1 in some of these cases. So I think
maybe the simplest thing would be to catch this case in
resolve_gitlink_ref(), before we go deeper. Let me see if I can come up
with something.

-Peff
