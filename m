From: Jeff King <peff@peff.net>
Subject: Re: bug: git-stash save and symbolic links
Date: Mon, 20 Oct 2008 13:55:17 -0400
Message-ID: <20081020175517.GA18539@coredump.intra.peff.net>
References: <df1390cc0810200134x68a8eb1fyc7f24650c8c9c5d3@mail.gmail.com> <20081020151715.GA13553@coredump.intra.peff.net> <df1390cc0810200832i4fa974fx1d70ed489aa1be02@mail.gmail.com> <df1390cc0810200839q5eddad1cp4bc14762724d8848@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Simon Strandgaard <neoneye@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 23:58:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KryzY-0004Ug-Ku
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 19:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbYJTRzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 13:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855AbYJTRzU
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 13:55:20 -0400
Received: from peff.net ([208.65.91.99]:4476 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837AbYJTRzT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 13:55:19 -0400
Received: (qmail 14515 invoked by uid 111); 20 Oct 2008 17:55:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 20 Oct 2008 13:55:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Oct 2008 13:55:17 -0400
Content-Disposition: inline
In-Reply-To: <df1390cc0810200839q5eddad1cp4bc14762724d8848@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98719>

On Mon, Oct 20, 2008 at 05:39:31PM +0200, Simon Strandgaard wrote:

>      mkdir test &&
>      echo content >test/file2 &&
>      git add test/file2 &&
>      git commit -m two &&
>    cd .. &&
>      ln -s repo/test linked &&

Ah, OK. You have a symlink into a subdirectory of the repository. Git
correctly finds the repository's .git directory, but then when we
attempt to 'cd' to the top-level of the working tree, we end up outside
of the repository. The culprit is actually "git rev-parse --show-cdup".
This demonstrates it more simply:

  mkdir repo &&
  (cd repo && git init) &&
  mkdir repo/dir &&
  ln -s repo/dir linked &&
  cd linked && git rev-parse --show-cdup

which prints "../". But that's not right; we actually need to go to
"../repo".

I think the right solution in this situation is that we should _not_ be
setting is_inside_work_tree in setup_git_directory_gently, so that we
chdir to its absolute path. But I don't think we ever actually detect
the symlink during this setup, so I'm not sure how best to realize we
are _in_ this situation.

-Peff
