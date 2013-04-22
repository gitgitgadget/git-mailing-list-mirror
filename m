From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 15:15:56 +0200
Message-ID: <87ppxmogdv.fsf@linux-k42r.v.cablecom.net>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 15:16:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUGbF-0001o0-4Y
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 15:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232Ab3DVNQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 09:16:00 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:53607 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752542Ab3DVNP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 09:15:59 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 22 Apr
 2013 15:15:56 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 22 Apr 2013 15:15:56 +0200
In-Reply-To: <1366632487-28153-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Mon, 22 Apr 2013 17:38:07 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222013>

Ramkumar Ramachandra <artagnon@gmail.com> writes:
>

So after a long IRC discussion trying to hash out what you *want* it to
do, here's the summary for everyone else.  This test is wrong on several
counts.  For simplicity I'll denote by M the subtree merge, called
$new_h in the actual test.

> +test_expect_failure 'log pathspec in tree read into prefix' '
> +	git checkout --orphan subtree &&
> +	git rm -rf . &&
> +	echo foodle >ichi &&

'ichi' also exists in M^1 because you reused a name from another test.
So rename detection will never pair the eventual 'bar/ichi' with this
'ichi', because the 'ichi' path was *modified*, not deleted, w.r.t. M^1.

Just to clarify, rename detection is based on seeing

  A foo
  D bar

and changing that to

  R bar -> foo

assuming the blobs were reasonably similar.  And indeed, *copy*
detection (-C) is able to figure it out, because it considers all paths
that were modified as possible candidates for a copy source.

But --follow only uses rename detection.

> +	git add ichi &&
> +	test_tick &&
> +	git commit -m foom &&
> +	echo moodle >unrelated &&
> +	git add unrelated &&
> +	test_tick &&
> +	git commit -m quux &&
> +	subtree_h=$(git rev-parse HEAD) &&
> +	git checkout master &&
> +	orig_h=$(git rev-parse HEAD) &&
> +	git read-tree --prefix=bar $subtree_h &&

You need to supply a trailing / for the prefix, it's not implied.

> +	new_t=$(git write-tree) &&
> +	new_h=$(echo "new subtree" |
> +	git commit-tree $new_t -p $orig_h -p $subtree_h) &&
> +	git reset --hard $new_h &&
> +	(
> +		cd bar &&
> +		git log --oneline ichi >../actual

You need to use --follow, as otherwise the pathspec filtering is
considered fixed.

Note that as discussed in the rest of the thread, --follow is fairly
limited and doesn't *really* solve the problem.  But it does work
assuming the filenames are different and you only have one subtree
merge, like in this case.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
