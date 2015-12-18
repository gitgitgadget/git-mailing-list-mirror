From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [RFC] Malicously tampering git metadata?
Date: Fri, 18 Dec 2015 18:10:32 -0500
Message-ID: <20151218231032.GA16904@thunk.org>
References: <20151216032639.GA1901@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Sat Dec 19 00:10:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA4Ab-0008OE-Iw
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 00:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbbLRXKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 18:10:38 -0500
Received: from imap.thunk.org ([74.207.234.97]:47984 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbbLRXKh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 18:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=qgodWnqBs3o0DeKfZuox31Y7ix5Cq5t6spTMI1TMZIo=;
	b=tsXkiGnnyvAOptzA13s0wUIlMECY9xfMapt+6nkvcxdG+IXVw48ay5RKEWYTKx5dvwlHoewn8yTZw3ewC3qIYplDsZGb88ZLzn/EMltO+3L6XH27UPtOD+qJG41ax+U1uDBMa/9C/p0leAa1Vs0vIjj14jXdbekeGtfgvS8dboA=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84)
	(envelope-from <tytso@thunk.org>)
	id 1aA4AU-0006w6-1x; Fri, 18 Dec 2015 23:10:34 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id CF29B8200D0; Fri, 18 Dec 2015 18:10:32 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20151216032639.GA1901@LykOS>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282719>

On Tue, Dec 15, 2015 at 10:26:39PM -0500, Santiago Torres wrote:
> 4) The developer pushes to upstream. All the traffic can be re-routed
> back to the original repository. The target branch now contains a
> vulnerable piece of code.

I assume you are assuming here that the "push to upstream" doesn't
involve some kind of human verification?  If someone tried pushing
something like this to Linus, he would be checking the git diff stats
and git commit structure for things that might look like "developer
negligence".  He's been known to complain to subsystem developers in
his own inimitable when the git commit structure looks suspicious, so
I'm pretty sure he would notice this.

But normally that developnment process we don't talk about "pushing to
upstream" as much as "requesting a pull".  So it would be useful when
you describe the attack to explicit describe the development workflow
that is vulnerable to your attack.

For example, in my use case, I'm authorative over changes in fs/ext4.
So when I pull from Linus's repo, I examine (using "gitk fs/ext4") all
commits coming from upstream that modify fs/ext4.  So if someone tries
introducing a change in fs/ext4 coming from "upstream", I will notice.
Then when I request a pull request from Linus, the git pull request
describes what commits are new in my tree that are not in his, and
shows the diffstats from upstream.  When Linus verifies my pull, there
are multiple opportunities where he will notice funny business:

a) He would notice that my origin commit is something that is not in
his upstream tree.

b) His diffstat is different from my diffstat (since thanks to the
man-in-the middle, the conception of what commits are new in the git
pull request will be different from his).

c) His diffstat will show that files outside of fs/ext4 have been
modified, which is a red flag that will merit more close examination.
(And if the attacker had tried to introduce a change in fs/ext4, I
would have noticed when I pulled from the man-in-the-middle git
repo.)

Now, if there is zero checking when the user pushes to upstream, then
yes, there are all sorts of potential problems.  But that's one of the
reasons why it's generally considered a good thing for Linux
developers to use as the origin commit for their work official
releases (which can be demarked using GPG-signed git tags).

So for example, the changes for ext4 that were sent to Linus for v4.4
was based off of v4.3-rc2:

git tag  --verify v4.3-rc2
object 1f93e4a96c9109378204c147b3eec0d0e8100fde
type commit
tag v4.3-rc2
tagger Linus Torvalds <torvalds@linux-foundation.org> 1442784761 -0700

Linux 4.3-rc2
gpg: Signature made Sun 20 Sep 2015 05:32:41 PM EDT using RSA key ID 00411886
gpg: Good signature from "Linus Torvalds <torvalds@linux-foundation.org>" [full]


And the changes which I sent to Linus were also signed by a tag, and
better yet, someone can indepedently verify this after the fact:

% git show --oneline --show-signature f41683a204ea61568f0fd0804d47c19561f2ee39
f41683a merged tag 'ext4_for_linus_stable'
gpg: Signature made Sun 06 Dec 2015 10:35:27 PM EST using RSA key ID 950D81A3
gpg: Good signature from "Theodore Ts'o <tytso@mit.edu>" [ultimate]
gpg:                 aka "Theodore Ts'o <tytso@debian.org>" [ultimate]
gpg:                 aka "Theodore Ts'o <tytso@google.com>" [ultimate]

They can also verify that the chain of commits that I sent to Linus
were rooted in Linus's signed v4.3-rc2 tag, so this kind of
after-the-fact auditing means that if there *were* funny business, it
could be caught even if Linus slipped up in his checking.


Now, the crazy behavior where github users randomly and promiscuously
do pushes and pull without doing any kind of verification may very
well be dangerous.  But so is someone who saves a 80 patch series from
their inbox, and without reading or verifying all of the patches
applies them blindly to their tree using "git am" --- or if they were
using cvs or svn, bulk applied the patches without doing any
verification....

Cheers,

					- Ted
