From: Junio C Hamano <gitster@pobox.com>
Subject: two-way merge corner case bug
Date: Tue, 26 Feb 2013 12:06:42 -0800
Message-ID: <7v7glun8kt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 21:07:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAQnw-00072Q-8Z
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 21:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683Ab3BZUGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 15:06:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45705 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759830Ab3BZUGp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 15:06:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0CF6AB0D;
	Tue, 26 Feb 2013 15:06:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=H
	nsIR/dF7fXdNNNZyHVE19eQg1c=; b=FYtRTkchI36uCqrE4ISXxDeEzu8oiS+D8
	RpwM1la3GE7E6w7NMytaGUrjtQaF76hsf34ZuxFoXK/LE1mX0+/1gkRJOyng5BFJ
	9rpEVPBJuEiNK+qFwzIHr5nK2avwA9iAdxIhujbGQChmnmw2yAmaIdUJg+5QGdkQ
	8XA8QxpKUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=ONBvnXFAXLvP9y/rym/icBTWzhsjs1FbtDBxgixDJdwHa7GkUz5XXO8N
	fOXq8dG1fBfutaRLhSL4jAZBzIJZJGQYynmb3ur5DrFo3uEw3eSrNWfsaAI2vjqd
	U7ZW9rK7Zkj4i4CDpBZ48/TYaWjjMF2hb9Z9QHe9jIgQ9RVphvQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5190AB0C;
	Tue, 26 Feb 2013 15:06:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41B3DAB06; Tue, 26 Feb 2013
 15:06:44 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0AE0A010-8050-11E2-8D05-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217172>

It seems that we have a corner case bug in two-way merge to reset
away the conflicts with "read-tree -u --reset HEAD ORIG_HEAD".

In a freshly created repository:

    rm -f A Z
    for i in $(seq 100)
    do
            echo hello
    done >Z
    git add Z
    git commit -m initial
    git branch side
    echo goodbye >>Z
    git commit -a -m changed
    git checkout side
    git mv Z A
    echo kitty >>A
    git commit -a -m side

if you do one of these:

	git checkout master && git merge side
	git checkout side && git merge master

you will get three stages for path A, and nothing for path Z.

With the former, you are starting from a tree with Z (and not A),
and "resetting" should give you A that is the same as 'master' in
the working tree.  With the latter, you are starting from a tree
with A, and "resetting" should give you Z and remove conflicted A
from the working tree.

	git read-tree -u --reset ORIG_HEAD

does the right thing in either case, but

	git read-tree -u --reset HEAD ORIG_HEAD

dies with "cache entry has null sha1: A" for both cases.

The direct symptom comes from 4337b5856f88 (do not write null sha1s
to on-disk index, 2012-07-28), but I think the root cause is
somewhere else.  When we start from 'side', we should notice that
our HEAD has Z, and conflicted A we see in the index came from a
conflicted merge that we are resetting away and should disappear
from the working tree.  When we start from 'master', we should
notice that we do not want to keep the cache entry that is
"modified" in the index, and write the one taken from the "going to"
tree (ORIG_HEAD).
