From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: submodules, was Re: RFC: display dirty submodule working 	directory
 in git gui and gitk
Date: Mon, 04 Jan 2010 20:14:34 +0100
Message-ID: <4B423E1A.7070504@web.de>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> 	<61083.85.16.196.198.1262601871.squirrel@archive.darksea.de> 	<alpine.DEB.1.00.1001041157020.3695@intel-tinevez-2-302> <32541b131001041029t5adc535bt9681d33174042871@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Lars Hjemli <hjemli@gmail.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 20:14:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRsO2-0004Mz-2R
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 20:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816Ab0ADTOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 14:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753789Ab0ADTOh
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 14:14:37 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:56560 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520Ab0ADTOg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 14:14:36 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id C7FCE1442AA31;
	Mon,  4 Jan 2010 20:14:35 +0100 (CET)
Received: from [80.128.60.62] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NRsNv-0002ok-00; Mon, 04 Jan 2010 20:14:35 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <32541b131001041029t5adc535bt9681d33174042871@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18RN5zlLRYLFODl96aP1BZ0zU4zvnIQOlimYVc2
	KuT0DRF7wpu0dWRyCJUq7rJ8jQ9ePu35WSmE00zxyP7RJIozXm
	rfgS37iWtf4idxC1lTFA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136138>

Am 04.01.2010 19:29, schrieb Avery Pennarun:
> For me one big problem comes down to producing accurate output for
> 'git log'.  git submodules assume that the history inside the module
> is entirely separate (you need to run multiple 'git log' instances to
> see the full history); git-subtree assumes that it's entirely
> integrated.  In that sense, git-subtree is somewhat more in line with
> the core principle of git (we track the history of "the content", not
> any particular file or subdir).  Unfortunately, it also exposes a
> problem with that core principle: taken to its extreme, "the content"
> includes all data in the universe.  And while git could branch and
> merge the universe very efficiently in about O(log n) time, 'git log'
> output gets less useful about O(n) with the size of the tree.
> 
> Neither git-subtree nor git submodules seem to help with this "log
> pollution" problem very much - but I don't know what to do that would
> be better.

I think this depends extremely on the use case and may even differ
from submodule to submodule. It might be desirable to be able to
specify which submodule logs you want to see, because only the user
knows what is important for him. But you should be able to ask "git
log" directly without forking it in every submodule you care about,
no?

There has been a thread between Junio and Heiko about group mappings
for submodules. Maybe the configuration could be extended to contain
information about what submodule should add to the superprojects log?
http://thread.gmane.org/gmane.comp.version-control.git/130928/


> Outside of this, my major problem with submodules is they use separate
> work trees and repositories, and thus require lots of extra
> housekeeping to get anything done.  I'd be much happier if submodules
> would share the same objects/packs/.gitdir/refs/indexfile as the
> superproject, and the *only* thing special about them would be that
> the superproject's tree points at a commit object instead of a tree
> object.  In other words, I think the actual repo format is correct
> as-is, but the tools surrounding it cause a lot of confusion.

I don't care deeply where the objects live but agree about the repo
format and the confusion ;-)


> Imagine if cloning a superproject also checked out the subproject
> transparently,

That would be great (at least at checkout time, after clone you
might wanna decide which submodules to initialize first - unless
group mappings are working). Right now we use post-checkout hooks
to do that.


> and committing dirty data inside the subproject's tree
> created a new commit object for the subproject, then tacked that
> commit object into the superproject's index for a later commit
> (exactly as changing a subdir creates a new tree object that the
> parent directory can refer to).

That would be a nice feature.


> This doesn't solve some use cases, however, such as ones where people
> really don't want to check out (or even fetch) the contents of some
> submodules, even when they check out the superproject.  The current
> implementation *does* handle that situation.  I'm not sure how many
> people rely on that behaviour, though.  (And maybe the correct
> solution to *that* is proper support for sparse clone/checkout
> regardless of submodules.)

We do rely on this behavior. But sparse clone or group mappings
could replace that need.
