From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to merge by subtree while preserving history?
Date: Fri, 27 Mar 2009 10:20:36 -0700
Message-ID: <7veiwievbv.fsf@gitster.siamese.dyndns.org>
References: <A5C2B218-4E4F-4C05-959D-5B6E9C619DDB@gmail.com>
 <20090327073847.GE27459@genesis.frugalware.org>
 <BA69E81F-C93F-4AD8-8486-A27B0A284D9A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: David Reitter <david.reitter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 18:22:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnFl5-0005mI-Hj
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 18:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbZC0RUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 13:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbZC0RUs
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 13:20:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbZC0RUr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 13:20:47 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A1FDA581D;
	Fri, 27 Mar 2009 13:20:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 400EEA581C; Fri,
 27 Mar 2009 13:20:37 -0400 (EDT)
In-Reply-To: <BA69E81F-C93F-4AD8-8486-A27B0A284D9A@gmail.com> (David
 Reitter's message of "Fri, 27 Mar 2009 12:56:43 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9A0AE80C-1AF3-11DE-844A-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114914>

David Reitter <david.reitter@gmail.com> writes:

> ...  Is there a command that gives me
> the diff  for a revision pair, restricted to what happened to content
> in a given file in the current tree?

You can get a half of it from blame (and I presume the other half by
running the procedure in reverse).

"git blame" has an obscure switch -S that lets you lie about the ancestry
by allowing you to install a graft (this is primarily used by the annotate
operation of git-cvsserver).

Suppose you have revisions A and B, and a lot of code in a file F in the
original revision A migrated to many other places in a later revision B
over time.  You want to see where each and every line in F from A ended up
in B.

To compute this, you pretend as if the history originates at B (i.e. B is
the root commit), and A is a direct descendant of it, and blame each and
every line of F in A, with a very agressive setting.  E.g.

	{
		echo $(git rev-parse A) $(git rev-parse B)
                echo $(git rev-parse B)
	} >tmp-graft
        git blame -C -C -C -w -S tmp-graft A -- F

I'll leave it as an exercise to the readers how to compute "where did each
and every line in G in B came from A?"

Note that in order for this to work, it needs a fix to "blame -S" that I
posted about 10 days ago: aa9ea77 (blame: read custom grafts given by -S
before calling setup_revisions(), 2009-03-18); the fix is sitting in 'pu',
because as far as I know nobody has cared about the breakage other than I,
at least until now.

I've attached a script that uses this trick to compute "How much of what
Linus originally wrote still survives."  People who attended GitTogether'08
may have seen the result.

---

#!/bin/sh
# How much of the very original version from Linus survive?

_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"

initial=$(git rev-parse --verify e83c5163316f89bfbde7d9ab23ca2e25604af290) &&
this=$(git rev-parse --verify ${1-HEAD}^0) || exit

tmp="/var/tmp/Linus.$$"
trap 'rm -f "$tmp".*' 0

# We blame each file in the initial revision pretending as if it is a
# direct descendant of the given version, and also pretend that the
# latter is a root commit.  This way, lines in the initial revision
# that survived to the other version can be identified (they will be
# attributed to the other version).
graft="$tmp.graft" &&
{
	echo "$initial $this"
	echo "$this"
} >"$graft" || exit

opts='-C -C -C -w'

git ls-tree -r "$initial" |
while read mode type sha1 name
do
	git blame $opts --porcelain -S "$graft" "$initial" -- "$name" |
	sed -ne "s/^\($_x40\) .*/\1/p" |
	sort |
	uniq -c | {
		# There are only two commits in the fake history, so
		# there won't be at most two output from the above.
		read cnt1 commit1
		read cnt2 commit2
		if test -z "$commit2"
		then
			cnt2=0
		fi
		if test "$initial" != "$commit1"
		then
			cnt_surviving=$cnt1
		else
			cnt_surviving=$cnt2
		fi
		cnt_total=$(( $cnt1 + $cnt2 ))
		echo "$cnt_surviving $cnt_total	$name"
	}
done | {
	total=0
	surviving=0
	while read s t n
	do
		total=$(( $total + $t )) surviving=$(( $surviving + $s ))
		printf "%6d / %-6d	%s\n" $s $t $n
	done
	printf "%6d / %-6d	%s\n" $surviving $total Total
}
