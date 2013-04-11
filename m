From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: Locating merge that dropped a change
Date: Thu, 11 Apr 2013 20:28:37 +0300
Message-ID: <5166F2C5.4020803@bracey.fi>
References: <51645749.8090402@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 19:28:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQLIm-0005Sp-EW
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 19:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935206Ab3DKR2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 13:28:43 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:44219 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934769Ab3DKR2m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 13:28:42 -0400
X-Greylist: delayed 167616 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Apr 2013 13:28:42 EDT
Received: from mail170.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 9DD99DC24EE
	for <git@vger.kernel.org>; Thu, 11 Apr 2013 19:28:40 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 11 Apr 2013 19:28:40 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 11 Apr 2013 19:28:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.2 (mo2.mail-out.ovh.net)
In-Reply-To: <51645749.8090402@bracey.fi>
X-Ovh-Tracer-Id: 17493669804426432734
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedruddtucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.500039/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedruddtucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220897>

On 09/04/2013 21:00, Kevin Bracey wrote:
>
> So, how to automatically find a merge that ignored a known change?

I think I've found the problem. It only doesn't work _if you specify the 
file_.

Specifically, if I was missing an addition, my first attempt to find it 
would be

   git log -p -m -S<addition> <file>

If the addition was lost in a merge, that doesn't even show the 
addition, which is surprising, but intentional. The addition isn't part 
of the HEAD version of <file>, so no point going down that path of the 
merge. Fine. However, I expected this to work:

   git log --full-history -p -m -S<addition> <file>

But it doesn't. It finds the addition, but _not_ the loss in the merge 
commit.

But this does work:

   git log -p -m -S<addition>

That really feels like a bug to me. By specifying a file, I've made it 
miss the change, and I can see no way to get the change without making 
it a full-tree operation.

Looking at try_to_simplify_commit() it appears the merge that removed 
the addition is excluded because it's TREESAME to its _other_ parent. 
But with --full-history, we should only be eliminating a merge if its 
TREESAME to all parents, surely? Otherwise we have this case that we 
show a commit but not its reversion.

And the code doing this looks broken, or at least illogical - the parent 
loop sets "tree_same" for a same parent in --full-history, rather than 
immediately setting the TREESAME flag, so maybe previous authors were 
thinking about this. But setting tree_same guarantees that TREESAME is 
always set on exit anyway, so it's pointless (unless I'm missing something).

It does appear this is documented behaviour in the manual: "full-history 
without parent rewriting" .. "P and M were excluded because they are 
TREESAME to _a_ parent." I would say that they should have been excluded 
due to being TREESAME to _all_ parents. I really don't want a merge 
where one version of my file was chosen over another excluded from its 
so-called "full history".

Now, obviously in a sane environment, most merges won't be that 
interesting, as they'll just be propagating wanted patches from the real 
commits already in the log. But I'd like some way to find merges that 
drop code in a specified file, and surely "--full-history" is it?

Kevin
