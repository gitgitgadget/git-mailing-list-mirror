From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2] pull: merge into unborn by fast-forwarding from empty tree
Date: Thu, 20 Jun 2013 15:33:34 +0200
Message-ID: <87mwqk6h5d.fsf@linux-k42r.v.cablecom.net>
References: <20130620124758.GA2376@sigill.intra.peff.net>
	<aca810600b895ed3f0a3fc575e0f6861e591de5b.1371733403.git.trast@inf.ethz.ch>
	<20130620131547.GA11073@sigill.intra.peff.net>
	<87zjuk6hr2.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan =?utf-8?B?U2Now7zDn2xlcg==?= <mail@stefanschuessler.de>,
	<git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 20 15:33:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upeze-0004q6-Fc
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 15:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757866Ab3FTNdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 09:33:37 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:48394 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757596Ab3FTNdh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 09:33:37 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 20 Jun
 2013 15:33:27 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 20 Jun 2013 15:33:35 +0200
In-Reply-To: <87zjuk6hr2.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Thu, 20 Jun 2013 15:20:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228502>

Thomas Rast <trast@inf.ethz.ch> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Thu, Jun 20, 2013 at 03:06:01PM +0200, Thomas Rast wrote:
>>
>>> +test_expect_success 'pulling into void does not overwrite staged files' '
>>> +	git init cloned-staged-colliding &&
>>> +	(
>>> +		cd cloned-staged-colliding &&
>>> +		echo "alternate content" >file &&
>>> +		git add file &&
>>> +		test_must_fail git pull .. master &&
>>> +		echo "alternate content" >expect &&
>>> +		test_cmp expect file &&
>>> +		git cat-file blob :file >file.index &&
>>> +		test_cmp expect file.index
>>> +	)
>>> +'
>>
>> I naively would have expected this to leave us in a conflicted state
>> over "file".  But I guess read-tree just rejects it, because we are not
>> doing a real three-way merge.  I'm not sure it is that big a deal; this
>> is more about safety than about creating a conflicted/resolvable state.
>
> Note that the test_must_fail essentially tests that the merge is rejected.

Bah, no it doesn't, a conflicting merge also returns a nonzero status.
Sigh.

If you meant we should actually conflict, I'm not sure what options
there would be other than actually calling a merge driver.  And we could
actually do this like so (it'll obviously break the tests):

diff --git i/git-pull.sh w/git-pull.sh
index 1f84383..b3d36a8 100755
--- i/git-pull.sh
+++ w/git-pull.sh
@@ -276,7 +276,7 @@ then
 	# lose index/worktree changes that the user already made on
 	# the unborn branch.
 	empty_tree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
-	git read-tree -m -u $empty_tree HEAD || exit 1
+	git merge-recursive $empty_tree -- $(git write-tree) HEAD || exit 1
 	exit
 fi
 


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
