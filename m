From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit --only -- $path when $path already has staged content
Date: Fri, 07 Nov 2014 11:54:17 -0800
Message-ID: <xmqq8ujmg51y.fsf@gitster.dls.corp.google.com>
References: <545CA118.6040500@atlas-elektronik.com>
	<xmqqmw83gd94.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 20:54:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmpc0-0002SQ-1U
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbaKGTyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:54:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52197 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752509AbaKGTyU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:54:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 40DFF1CEAE;
	Fri,  7 Nov 2014 14:54:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cY3WVMPVfcf5s7zPVolTjfMHbo8=; b=ACXhCB
	cvNO7EsnBqYLjixA/QTM3BCJMeFdbQEthNmelAipxFu032nkddD1WpLJFzn88dsL
	c4rE6eqRvsyFPV3Am3snJ4Y4+AE/mZ3yJKJpjNRVHUK/le6JLKnFXvCNjsvrimxC
	kD+lmA45F/1h8fqGOdvPoouwQll+cRxpvsmaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qswVX7E5Z7Q/jmRtMhxu0ePwqQNhCeLD
	kftrokQ23oY5xiRWzryvFpQa0G3AXPKggY8TiBcogtnLdh0t+DvZW3XgVuzl0CsC
	H0Q6fYgiwGGYgY5sN2dTfvZUyz8PdMhbhRsMxjM81m/BdyHY/kYDUdo1M/fXyBJD
	PfvoFhjSqBE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 383681CEAD;
	Fri,  7 Nov 2014 14:54:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BBB521CEAC;
	Fri,  7 Nov 2014 14:54:18 -0500 (EST)
In-Reply-To: <xmqqmw83gd94.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 07 Nov 2014 08:57:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DC3A02C4-66B7-11E4-9224-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> In other words, you give paths from the command line to tell the
> command that you want to record the contents of them in the working
> tree as a whole to be recorded in the resulting commit.

... and --only/--include only makes difference wrt what happens to
contents from the other paths.

Perhaps the attached would clarify it better, but there may have to
be some tutorial material to teach users that fundamentally there
are two ways to use Git, one to prepare what to be committed in the
index and run "git commit" without any paths, and the other to
pretty much ignore the index and run "git commit" with paths (or
with "-a"), and mixing two are considered to be rare exception.

You would (1) work with an elaborate sequence to build the next
commit in the index using "add path" and "add -p", (2) notice a
change that can go before what you are building (e.g. trivial
typofix) outside the paths you are touching, and (3) edit that path
and do "git commit <path>".  That is the only scenario that makes
some sense to mix the two modes.

Imagine the change (2) you want to jump over your changes in (1)
happens to be in a path you are working with the index, e.g. after
running:

	git add -p hello.rb

and picking only parts of changes you made to hello.rb into the
index, you found a trivial typo in the same file but in an unrelated
place (i.e. "git diff hello.rb" at that point would not show the
typo either in the preimage or the context).  There is no way to
make the typofix first without disrupting what you did so far, and
"git commit -o" would not help (you would instead do a "git stash"
to save away the work in progress, make _only_ the typofix in the
same file, commit and then unstash, or something).

So in short, stick to either work with the index or ignore the
index; do not mix the two workflows and you would not have to worry
about "-o" or "-i".


 Documentation/git-commit.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0bbc8f5..d6c4af1 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -250,7 +250,7 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 
 -o::
 --only::
-	Make a commit only from the paths specified on the
+	Make a commit only from the working tree contents of the paths specified on the
 	command line, disregarding any contents that have been
 	staged so far. This is the default mode of operation of
 	'git commit' if any paths are given on the command line,
