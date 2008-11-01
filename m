From: Andreas Ericsson <ae@op5.se>
Subject: Re: libgit2 - a true git library
Date: Sat, 01 Nov 2008 20:18:05 +0100
Message-ID: <490CAB6D.90209@op5.se>
References: <20081031170704.GU14786@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 20:19:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwM0Q-0004Ao-FT
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 20:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbYKATSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 15:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbYKATSQ
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 15:18:16 -0400
Received: from mail.op5.se ([193.201.96.20]:42271 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbYKATSP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 15:18:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 056821B800A4;
	Sat,  1 Nov 2008 20:13:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[AWL=0.000, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q29GQUqY2lvT; Sat,  1 Nov 2008 20:12:59 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id DA20A1B8010D;
	Sat,  1 Nov 2008 20:12:57 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081031170704.GU14786@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99761>

Shawn O. Pearce wrote:
> During the GitTogether we were kicking around the idea of a ground-up
> implementation of a Git library.  This may be easier than trying
> to grind down git.git into a library, as we aren't tied to any
> of the current global state baggage or the current die() based
> error handling.
> 
> I've started an _extremely_ rough draft.  The code compiles into a
> libgit.a but it doesn't even implement what it describes in the API,
> let alone a working Git implementation.  Really what I'm trying to
> incite here is some discussion on what the API looks like.
> 
> API Docs:
> http://www.spearce.org/projects/scm/libgit2/apidocs/html/modules.html
> 
> Source Code Clone URL:
> http://www.spearce.org/projects/scm/libgit2/libgit2.git
> 

Having looked briefly at the code, I've got a couple of comments:
* GIT_EXTERN() does nothing. Ever. It's noise and should be removed.
  Instead it would be better to have GIT_PRIVATE(), which could
  set visibility to "internal" or "hidden", meaning the symbol it's
  attached to can be used for lookups when creating a shared library
  but won't be usable from programs linking to that shared library
  (visibility-attributes have zero effect on static libraries). At
  least on all archs anyone really cares about.
* Prefixing the files themselves with git_ is useless and only leads
  to developer frustration. I imagine we'd be installing any header
  files in a git/ directory anyway, so we're gaining absolutely
  nothing with the git_ prefix on source-files.

Apart from that, it seems you've been designing a lot rather than
trying to use the API to actually do something. It would, imo, be
a lot better to start development with adding functionality shared
between all programs and then expand further on that, such as
incorporating all functions needed for manipulating tags into the
library and then modify existing code to use the library to get
tag-ish things done. That would also mean that the library would
quickly get used by core git, as once a certain part of it is
complete patches can be fitted to the library rather than to the
current non-libish dying() functions.


I also think it's quite alright to not strive *too* hard to make
all functions thread-safe, as very few of them will actually need
that. It's unlikely that a user program will spawn one thread to
write a lot of tags while another is trying to parse them, for
example.

By adding an init routine that determines the workdir and the
gitdir, one could start using the library straight away.

int git_init(const char *db, const char *worktree)
{
    if (git_set_db_dir(db))
        return -1;
    git_set_worktree((worktree))
        return -1;

    return 0;
}

and already you have a some few small helpers that are nifty to
to have around:
int git_is_gitdir(const char *path);  /* returns 1 on success */
int git_has_gitdir(const char *path); /* returns 1 on success */
const char *git_mkpath(const char *fmt, ...)

This way one will notice rather quickly what's needed (making it
easy to keep a more-or-less public TODO available, with small stuff
on it for the most part), and one can then go look for it in the
existing git code and, if possible, convert stuff or, best case
scenario, steal it straight off so that more apps can benefit from
tried and tested code.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
