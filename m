From: Johan Herland <johan@herland.net>
Subject: Re: git notes primer?
Date: Wed, 11 Aug 2010 11:52:03 +0200
Message-ID: <201008111152.03982.johan@herland.net>
References: <201008101040.07172.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: thomas@koch.ro
X-From: git-owner@vger.kernel.org Wed Aug 11 12:37:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj8ga-0003SG-Bi
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 12:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122Ab0HKKhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 06:37:11 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:60591 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029Ab0HKKhK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 06:37:10 -0400
X-Greylist: delayed 2703 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Aug 2010 06:37:09 EDT
Received: from 59.81-166-95.customer.lyse.net ([81.166.95.59] helo=epsilon.localnet)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Oj7yf-000G8f-2Y; Wed, 11 Aug 2010 11:52:05 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.32-24-generic; KDE/4.4.2; i686; ; )
In-Reply-To: <201008101040.07172.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153224>

On Tuesday, August 10, 2010 10:40:06 am Thomas Koch wrote:
> Hi,
> 
> I'm working on a patch management system as topgit, but without the
> complexity:
> http://koch.ro/blog/index.php?/archives/139-tnt-is-not-topgit.html
> 
> Before I continue with my current design, I wanted to have a look at git
> notes, whether it would provide better mechanisms then tracking my meta
> informations in a hidden background branch. (Much like pristine-tar does.)
> 
> However I couldn't get a grip on git notes:
> 
> - Is git notes the only command that works on notes?

Primarily, yes, although there are some exceptions:

- There is a special fast-import command for quickly building notes trees

- There is some code in log/rev-list for displaying notes

- Recently, commands like 'rebase' and 'commit --amend' have learned options 
to enable copying of notes from the original object to the rewritten object

There may be more integration between notes and other git commands added in 
the future.

> - How are notes saved inside GIT?

Notes are kept in 'notes refs' (refs/notes/*) which point into a history that 
is separate/disconnected from your "regular" commit history. core.notesRef (or 
$GIT_NOTES_REF, or the --ref option to 'git notes') determines which notes ref 
you're currently working on (defaults to 'refs/notes/commits').

Every command that manipulates notes adds a commit to your current notes ref. 
Thus, you can review your notes editing history by running 'git log' on a 
notes ref.

The tree associated with each notes commit has a special form: All tree 
entries are named after the SHA1 of the Git object they annotate. As such, the 
notes for a given Git object (with a given SHA1 "1234567890abcdef...") is 
found at "refs/notes/$NOTES_REF:1234567890abcdef...".

Unfortunately, this doesn't scale when you get thousands of notes, so there is 
some automatic fan-out happening when the number of notes exceed certain 
thresholds. We then start making subtrees to limit the number of entries at 
each tree level. Your notes objects are then relocated to live at 
"refs/notes/$NOTES_REF:12/34567890abcdef..." (note the extra slash), and if 
even more notes are added, more slashes are added to limit the number of 
entries at each level (e.g. "refs/notes/$NOTES_REF:12/34/56/78/90abcdef...")

Fortunately, this is all encapsulated by the internal notes API (in notes.h/c) 
and by the 'git notes' command, so as long as you use them, you shouldn't need 
to care about the implementation details.

> - Is git notes and it's implementation stable now?

Yes, the current APIs and commands are as stable as any other in 'master'. 
However, 'git notes' is still a young feature, and expect new functionality to 
be added in the future. For example, I'm currently working on 'git notes 
merge' for auto-merging notes trees (needs special code to handle the fan-
outs). 'git notes merge' is needed so that we can more easily share notes 
between repos.

> - Are there any tutorials on workflows with git notes?

Not really. I don't think there are any workflows where git notes is an 
integral part of the workflow.

> - What different use cases of git notes do you know?

- Extra annotations to commit messages

- Implementing a textconv cache (already done by Jeff King in notes-cache.h/c)

- Notes could be used to communicate bug status changes in a (distributed) bug 
tracker (e.g. adding notes like "Causes-Bug: #12345" to a commit, and then 
"Fixes-Bug: #12345" to a later bugfix commit)

- Notes could be used to implement a storage backend for a code review system 
(reviews to a given commit are kept as notes on that commit)

- When synchronizing with foreign version control systems (e.g. git-svn), 
notes could be used to keep track of cross-VCS relations, e.g. adding a "SVN-
commit: #12345" note to the corresponding Git commit.

- Any other use case where you need to keep some metadata associated with 
objects in the git database.

> - What use cases triggered the development of git notes in the first place?

As has already been stated, we wanted to allow extra annotations to be added 
to existing commit messages without rewriting the commit objects.

Hope this helps,


...Johan
