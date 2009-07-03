From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: unexpected empty commit after checkout with uncommitted index
Date: Fri, 3 Jul 2009 06:28:27 -0500
Message-ID: <B98E6930-01E8-4A14-9C09-CC2BACC3389C@pobox.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 03 13:29:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMgxe-0007Sd-Nb
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 13:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbZGCL3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 07:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752810AbZGCL3g
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 07:29:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49719 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbZGCL3g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 07:29:36 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5165424E0D;
	Fri,  3 Jul 2009 07:29:39 -0400 (EDT)
Received: from [192.168.1.241] (unknown [76.222.27.125]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EAA5524E0B; Fri, 
 3 Jul 2009 07:29:37 -0400 (EDT)
X-Mailer: Apple Mail (2.753.1)
X-Pobox-Relay-ID: CB816406-67C4-11DE-9B5E-DC021A496417-07245699!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122696>

The following test script fails after 83ae209 (checkout branch: prime  
cache-tree fully, 2009-04-20).

-- 
Chris

#!/usr/bin/env dash
abort() {
     printf "$@"
     exit 128
}
failed=0
fail() {
     failed=1
     printf "$@"
}

set -e

GIT="${1:-git}"
case "$GIT" in
./*|../*) GIT="$PWD/$GIT"
esac
type "$GIT" > /dev/null ||
     abort 'bad git command?: %s\n' "$GIT"

tn=checkout-with-changed-index
td="$(mktemp -d -t "$tn")"
if test -z "$td"; then
     td="/tmp/$tn"
     mkdir "$td" ||
         abort 'unable to create test dir: %s\n' "$td"
     test -d "$td"/.git &&
         abort '.git already exists in test dir: %s\n' "$td"
fi
trap 'rm -rf "$td"' 0

cd "$td"
"$GIT" --version
"$GIT" init
echo foo > foo
echo bar > bar
"$GIT" add foo bar
"$GIT" commit -m 'add foo, bar'
echo BAR > bar
echo baz > baz
"$GIT" rm foo
"$GIT" add bar baz
"$GIT" checkout -b new
"$GIT" commit -m 'rm foo, change bar, add baz'

# After 83ae209 the commit on "new" (or even a detached HEAD if
# we use "HEAD@{0}" instead of "-b new") appears to be an empty
# commit. The same thing happens whether the changes (add new, rm
# existing, add edited) are done in a group, as above, or
# individually.  Both before and after the commit, [git status]
# seems to show that the changes are properly staged, but they
# never make it into the committed tree. [git reset] and then
# [git add --all] resolves the strange state and allows the
# expected commit to take place.

test -z "$("$GIT" ls-tree HEAD foo)" ||
     fail '*** foo was not removed\n'
test "$("$GIT" cat-file blob HEAD:bar)" = "BAR" ||
     fail '*** bar was not changed\n'
test "$("$GIT" cat-file blob HEAD:baz)" = "baz" ||
     fail '*** baz was not added\n'
exit $failed
