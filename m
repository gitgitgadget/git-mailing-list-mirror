From: Junio C Hamano <gitster@pobox.com>
Subject: What should "git submodule summary" give before an initial commit?
Date: Wed, 03 Mar 2010 13:58:58 -0800
Message-ID: <7vhboxf4nx.fsf_-_@alter.siamese.dyndns.org>
References: <4B8E5450.3040702@gmail.com>
 <7vhboxqje8.fsf@alter.siamese.dyndns.org>
 <20100303200239.GA28904@coredump.intra.peff.net>
 <7vhboxno38.fsf@alter.siamese.dyndns.org>
 <20100303204257.GA5501@coredump.intra.peff.net>
 <7v3a0hktga.fsf@alter.siamese.dyndns.org>
 <7vzl2phz8e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	A Large Angry SCM <gitzilla@gmail.com>,
	git <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>, Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 22:59:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmwbC-0006Yk-2i
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 22:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756810Ab0CCV7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 16:59:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347Ab0CCV7P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 16:59:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A34E09ECF3;
	Wed,  3 Mar 2010 16:59:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W/kgwMMRwiVNvUWF31zUwXgqvgU=; b=pY76AQ
	495Bf1TQheFbJglCOfMICakX8r3pG3+PRF8WvUKrMwBnK9fKep4EYi+KoxrQ8Cyj
	54rMmTgAc6f3nNBEI09MxSnrh7Z98TdpI+JPE/mqluqpAezWJQ9tMw6AHkUAJ8BD
	zg+EmJ3ccCrBOfzyaP+ZYh+x+aaiy75AT0vVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Aobdzsie7Gh6/25Yx8uLKl1DCgKGHXqA
	SdqY64A2jpEumTC3qKg9DnRd1XNdgchmWXj6YtnDD2SlAwhW2T2ah+h74ZmXn7SG
	RBnV8NmF9KPVV+IzhydbRo1QgLB7FrX/KBh34Um5lM1n/8jV+7AzUkIHtcRKZmZN
	wjp2ur5YKRk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 25C8E9ECED;
	Wed,  3 Mar 2010 16:59:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1BA69ECE8; Wed,  3 Mar
 2010 16:58:59 -0500 (EST)
In-Reply-To: <7vzl2phz8e.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 03 Mar 2010 13\:28\:01 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FD406D38-270F-11DF-94AD-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141484>

"git status" collects the changes for both the index (since HEAD) and the
working tree files (since the index), summarizes and shows them.  When it
is run before the first commit is made, it uses a logic different from the
one used in the normal case to gather the information on the index, as we
don't have HEAD yet, i.e. instead of "diff-index HEAD", we would run
"diff-index emtpy-tree".

How should status.submodulesummary integrate into this framework?

Currently, it blindly runs "git submodule summary", and it gives an extra
error message about HEAD not being a commit, and people (me included)
misguidedly have spent time on squelching the message.

But I think that was _all wrong_.  I do not think "git submodule summary"
should fail even when you haven't made your first commit.

If you are before the first commit, we say everything you have in the
index is a change you are adding with your next commit (which will be your
initial one).  If you added a submodule commit to the index, shouldn't
"git submodule summary" say "you'll be committing the addition of this
subproject"?  IOW, shouldn't we be comparing an empty tree to find added
submodules, like this, when we haven't made the first commit?

 git-submodule.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5869c00..0397f9d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -556,10 +556,10 @@ cmd_summary() {
 	if rev=$(git rev-parse -q --verify --default HEAD ${1+"$1"})
 	then
 		head=$rev
-		shift
+		test $# = 0 || shift
 	elif test -z "$1" -o "$1" = "HEAD"
 	then
-		return
+		head=4b825dc642cb6eb9a060e54bf8d69288fbee4904
 	else
 		head="HEAD"
 	fi
