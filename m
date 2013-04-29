From: Adam Spiers <git@adamspiers.org>
Subject: improvements to checks for core.notesRef / GIT_NOTES_REF / --ref
Date: Mon, 29 Apr 2013 17:39:09 +0100
Message-ID: <20130429163909.GA19014@pacific.linksys.moosehall>
References: <20130427132118.GA25295@pacific.linksys.moosehall>
 <20130429133205.GA4672@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 29 18:39:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWr6p-0002FT-W3
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 18:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758457Ab3D2QjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 12:39:12 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:40376 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757872Ab3D2QjL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 12:39:11 -0400
Received: from localhost (4.3.1.2.f.7.0.2.5.1.9.5.4.a.0.0.0.d.3.7.6.a.1.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:11a6:73d0:a4:5915:207f:2134])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 07E1A2EAD2
	for <git@vger.kernel.org>; Mon, 29 Apr 2013 17:39:10 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130429133205.GA4672@pacific.linksys.moosehall>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222812>

On Mon, Apr 29, 2013 at 02:32:05PM +0100, Adam Spiers wrote:
> I've just written another quick wrapper around 'git notes' which makes
> it less painless to share notes to and from remote repositories:
> 
>     https://github.com/aspiers/git-config/blob/master/bin/git-rnotes
> 
> This makes sharing of notes as easy as:
> 
>     git rnotes $remote push
>     git rnotes $remote fetch
>     git rnotes $remote merge
>     git rnotes $remote pull
> 
> and was born from this discussion:
> 
>     http://stackoverflow.com/questions/12055303/merging-git-notes-when-there-are-merge-conflicts-in-them/
> 
> Once the Great Refs Namespace Debate is resolved[0], would this kind
> of UI would be a candidate for pushing into git-notes itself?

I just had a discussion on #git IRC with Thomas about how the above
wrapper uses refs/notes/$remote/commits or similar to simulate a
remote tracking branch for notes, and we agreed that it's not ideal
due to potential collisions if --ref=$remote or refs/notes/* are ever
used.  As has probably been discussed already in the Great Debate,
something like refs/remote-notes/ might be a better namespace; however
the current implementation of git notes prevents this:

    static struct notes_tree *init_notes_check(const char *subcommand)
    {
            struct notes_tree *t;
            init_notes(NULL, NULL, NULL, 0);
            t = &default_notes_tree;

            if (prefixcmp(t->ref, "refs/notes/"))
                    die("Refusing to %s notes in %s (outside of refs/notes/)",
                        subcommand, t->ref);
            return t;
    }

Can we relax this to "refs/", to allow better isolation of namespaces
for remote notes?  Also, the check is applied for GIT_NOTES_REF and
core.notesRef, but not for values passed via --ref.  Therefore I would
propose that init_notes_check() is not only relaxed but also moved
from builtin/notes.c to notes.c, so that it can be consumed by
default_notes_ref().  Thoughts?

Also, are there any plans in the future for making "git notes merge"
provide an index, so that a proper 3-way merge with ancestor can be
done using git mergetool?

Cheers,
Adam
