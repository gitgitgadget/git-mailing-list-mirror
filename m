From: Richard Peterson <richard@rcpeterson.com>
Subject: [Tagging Commits] feedback / discussion request
Date: Tue, 3 May 2011 19:36:51 -0400
Message-ID: <BANLkTik5-Ygh0YwN=j+ibLhP6==ots_MXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 01:37:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHP9I-0006hr-6F
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 01:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093Ab1ECXgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 19:36:55 -0400
Received: from edgy.cirtexhosting.com ([75.126.140.58]:38200 "EHLO
	edgy.cirtexhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976Ab1ECXgy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 19:36:54 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51031)
	by edgy.cirtexhosting.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.69)
	(envelope-from <richard@rcpeterson.com>)
	id 1QHP9S-0007sL-PP
	for git@vger.kernel.org; Tue, 03 May 2011 19:37:10 -0400
Received: by ywj3 with SMTP id 3so232697ywj.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 16:36:51 -0700 (PDT)
Received: by 10.147.1.11 with SMTP id d11mr412994yai.14.1304465811953; Tue, 03
 May 2011 16:36:51 -0700 (PDT)
Received: by 10.147.98.11 with HTTP; Tue, 3 May 2011 16:36:51 -0700 (PDT)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - edgy.cirtexhosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - rcpeterson.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172703>

This is a different idea from that discussed in
http://marc.info/?t=123879411100002&r=1&w=2.

I'm going to present some use cases for signing commits (instead of just
tags). Then I'll present an idea for implementation. I hope to implement
this as described, along with Eric Ritz. We would appreciate any insight you
may have - we want to help, not waste our time or anybody else's.

First, Linus has argued against signing commits in this thread:
http://marc.info/?t=123879411100002&r=1&w=2.  He claims it is pointless to
sign individual commits, as opposed to signing just the tip of the tree
(tags). For many use cases, that's true. But read on.


Here are some possible semantics you could assign to signing a commit hash:

* Making a verifiable claim of authorship of a commit
* Making a verifiable claim to have reviewed a commit or set of commits
* Making a verifiable claim to have approved a commit or set of commits for
some purpose
* Making some other verifiable claim about a commit TBD by your workflow
* Making a verifiable claim to have reviewed or approved the entire tree
under the commit

Claiming to have reviewed or approved the entire tree is useful in many
cases. It's great for something like the Linux kernel.  If you've got a tip
signed by Linus, you've got the kernel. You don't need to care what's merged
in under that, as long as it's signed at the top. It's like an MD5 checksum
on a download. You don't care what mirror you download an ISO from, as long
as the computed hash matches the authoritative hash.

Semantically, someone who signs a tree takes responsibility for everything
included in that tree, to whatever degree that applies in their project.

Now *technically* signing the tree may be equivalent to signing an
individual commit, but don't get wrapped up in that. Stick to the semantics
with me.

Imagine the following scenario to help justify the other use cases above.

There are 200 developers working on a financial trading system, and each of
them has the opportunity to slip malicious code into the project. When the
final release is prepared, the project lead signs the tip commit, thus
signing the whole tree. Now it is discovered that someone did slip some
malicious code in.  How do you audit the system? Could higher levels of
individual accountability have discouraged this scenario?

I've seen it argued that a proper SSH setup and user management are the key.
These are good for security and access control, but not for some durable
form of accountability.

If each commit is individually signed, the authorship claims have teeth. In
our scenario above, a single signature at the tip of the tree did no good in
terms of accountability. You can blame the guy on top, but is it really
reasonable that he review every line? However, if each commit were signed,
tracing the malicious code would be simple. If a reviewer had been required
to sign every commit, or maybe every range of commits (signing
186fa861..8645b061, for instance), then there could be a double layer of
accountability. This kind of "hard" accountability can be valuable in
sensitive projects. I work on such projects.

Some people might not see the use of this kind of auditability. I'll tell
you though - I work in a large organization that uses SVN because of some
kind of perceived auditability. They shy away from Git because it's
"distributed" and therefore not auditable.  Of course that's a
phony-baloney, ignorant argument, but the point is that the need for
auditability is there.


So how do these semantics line up with Git?

It seems that creating a signed tag is the same as signing a commit.  There
are a few problems, though.  Tags don't provide a secure means of asserting
the type of signature being applied to the commit hash. That is - is the
hash signed because someone is claiming authorship? Because they are
asserting the integrity of the entire tree? Because they have reviewed the
code? Because they reviewed a certain subset of the tree? Of course there's
also the issue that tags live in a cluttered namespace. Signing a commit is
essentially a different thing from providing a name for a commit. Using tags
just to sign commits requires a glut of tag names.

I propose expanding the concept of tags, or alternately creating a new
concept which subsumes the existing tag concept. I'll call this new concept
a "sig" for the purposes of this discussion. The concept of a sig cross-cuts
the concept of a tag.

A tag signs the commit hash. A sig signs a SHA1-based absolute commit
reference with a (possibly null) string concatenated to it. For instance, a
sig might sign the following string:

"0b9deecf625677cf44058a42c2abd7add5167e81^0 author"
which would mean that the signor is claiming authorship of that individual
commit. (Suggestions for notating a single commit are welcome. "^0" seemed
natural.)

or

"5ae6f5ca2f70bd7d5ca88c20f2be62bf3844af73..0b9deecf625677cf44058a42c2abd7add5167e81
reviewer"
which means the signor has reviewed that particular chain of commits.

Signing the string
"0b9deecf625677cf44058a42c2abd7add5167e81"
would be the same as signing the entire tree for that hash, which is what
happens in a tag.

A signed tag would essentially be a name associated with a sig - not too far
off from how it works now. A lightweight tag would be a name not associated
with a sig - again, about how it is now.


This strategy has several benefits:

* It is separable from the commit tree.  Linus argued against including
commit signatures within commits. This solution doesn't do that. If someone
wants to ditch all signatures and publish the tree, they can.

* It is extensible. Standard strings like "author" and "reviewer" might get
built-in support, but there is nothing preventing adding custom signature
types to meet your workflow needs.  Someone could even add something like a
datestamp, if the need arose. In addition, there would be no limit to the
number of "author" or "reviewer" sigs that could point to a single commit.
Great for pair programming, group code reviews, or other workflows.

* It can probably be implemented cleanly without breaking the existing tags.

I see a few potential issues:

* What on earth does it mean to tag a range of commits? With commit ranges
being siggable, and tags containing sigs, what does it mean to tag a range
of 10 commits, for instance? Is that desirable? Does it make any sense
whatsoever? Does it hurt anything if it happens?

* Performance? I think it would be extremely quick to verify a bunch of
sigs, but I don't know. Maybe I'm not thinking clearly about it.
Fortunately, sigs can be ignored entirely and need not affect things.

* Any others issues?

Thank you, and please give feedback. I'm no git pro - just a guy with an
idea. Based on your feedback, Eric and I will steer our implementation.

Richard Peterson
