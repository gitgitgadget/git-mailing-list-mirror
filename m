From: Eran Tromer <git2eran@tromer.org>
Subject: Re: [PATCH] unpack-trees.c: assume submodules are clean during check-out
Date: Mon, 06 Aug 2007 14:42:20 -0400
Message-ID: <46B76B8C.9050905@tromer.org>
References: <20070717182828.GA4583MdfPADPa@greensroom.kotnet.org> <7vy7he6ufj.fsf@assigned-by-dhcp.cox.net> <20070801140532.GC31114MdfPADPa@greensroom.kotnet.org> <7v643vj316.fsf@assigned-by-dhcp.cox.net> <46B4A350.9060806@tromer.org> <20070805144632.GB999MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon Aug 06 20:42:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II7XW-0000r9-Iv
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 20:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765349AbXHFSmq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 14:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760994AbXHFSmp
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 14:42:45 -0400
Received: from rozz.csail.mit.edu ([128.30.2.16]:55364 "EHLO
	rozz.csail.mit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759593AbXHFSmo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 14:42:44 -0400
Received: from c-66-30-26-80.hsd1.ma.comcast.net ([66.30.26.80] helo=moby.tromer.org)
	by rozz.csail.mit.edu with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <git2eran@tromer.org>)
	id 1II7XC-00080t-Qo; Mon, 06 Aug 2007 14:42:30 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.5) Gecko/20070719 Fedora/2.0.0.5-1.fc7 Thunderbird/2.0.0.5 Mnenhy/0.7.5.0
In-Reply-To: <20070805144632.GB999MdfPADPa@greensroom.kotnet.org>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55166>

On 2007-08-05 10:46, Sven Verdoolaege wrote:
>> $ git checkout experimental-death-ray
>> $ git submodules update
>> (return a week later, woozy from the vacation.)
>> $ git checkout master
> 
> Here, it'll warn that your submodule isn't up-to-date.
> 
>> (hack hack hack)
>> $ git commit -a -m "fixed typos"
> 
> And if you run "git status" first, it'll tell you that the submodule
> (still) isn't up-to-date.
> 
>> $ git push
>> (Oops. You've just accidentally committed the wrong submodule heads.)
> 
> You always have to be careful when doing "git commit -a".

Exactly. You now have to be very careful, whereas previously
$ git checkout master && vi foo && git commit -a -m "fixed typos"
was perfectly safe.

Worse yet, it could also be a script making similar assumptions. For
example, consider the tree filter in git-filter-branch. It used to be
fine, but will now corrupt the rewritten trees when submodules are
involved. Here's the relevant code from git-filter-branch.sh:

-----------------------------------------------------------------
while read commit parents; do
...
		git read-tree -i -m $commit
...
		git checkout-index -f -u -a ||
			die "Could not checkout the index"
...
		eval "$filter_tree" < /dev/null ||
			die "tree filter failed: $filter_tree"

		git diff-index -r $commit | cut -f 2- | tr '\n' '\0' | \
			xargs -0 git update-index --add --replace --remove
...
	sh -c "$filter_commit" "git commit-tree" \
		$(git write-tree) $parentstr < ../message > ../map/$commit
done <../revs
-----------------------------------------------------------------


>> Another approach is for pull, checkout etc. to automatically update the
>> submodule' head ref, but no more.
> 
> Then everything, including "git submodule update", would assume
> that the submodule is up-to-date.

With that approach, "git submodule update" would fetch the submodule's
head commit (which could be missing), and then check it against the
submodule's index (and maybe its work tree).

  Eran
