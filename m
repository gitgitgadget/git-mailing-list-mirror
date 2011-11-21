From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: [RFC] deprecating and eventually removing "git relink"?
Date: Mon, 21 Nov 2011 17:09:23 -0500
Message-ID: <4ECACC13.7050507@cfl.rr.com>
References: <7v4ny7mtbx.fsf@alter.siamese.dyndns.org> <buomxbzutjm.fsf@dhlpc061.dev.necel.com> <CAD=rjTXgH+AivmK+zLurQVC+=p1UYqFy_p=wBF-1-TOQ=Cqjtw@mail.gmail.com> <20111114103451.GA10847@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Simon Brenner <olsner@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 21 23:09:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSc3P-0002yL-42
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 23:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591Ab1KUWJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 17:09:26 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.123]:50310 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab1KUWJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 17:09:25 -0500
X-Authority-Analysis: v=2.0 cv=JsJzXbEC c=1 sm=0 a=/DbS/tiKggfTkRRHPZEB4g==:17 a=zQGhUK9Iw4MA:10 a=PZujzOpSkYQA:10 a=IkcTkHD0fZMA:10 a=y_r5Q6YkxNdqF2FIh4MA:9 a=o_RFelVURKoZy-pQe4QA:7 a=QEXdDO2ut3YA:10 a=/DbS/tiKggfTkRRHPZEB4g==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.78.168.186
Received: from [67.78.168.186] ([67.78.168.186:50948] helo=[10.1.1.230])
	by cdptpa-oedge04.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id F3/B2-04648-31CCACE4; Mon, 21 Nov 2011 22:09:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <20111114103451.GA10847@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185764>

On 11/14/2011 5:34 AM, Jeff King wrote:
> One issue with this scheme (or most similar schemes) is that child repos
> are uniquely identified by their directory name. In the absence of
> alternates, it's perfectly reasonable to do:
>
>    git init; hack hack hack; commit commit commit
>    cd .. ; mv project new-project-name
>
> but here it would break the shared repo's link to the child (which is
> not just inconvenient, but dangerous, as we will not respect its refs
> when pruning). Probably the "warning" above should actually error out
> and force the user to say "yes, I deleted this child" or "no, I moved it
> here".

I hacked together a setup a few weeks ago that doesn't suffer from that 
problem.  I had two repos that had considerable shared history ( one 
forked from the other ), so I created a temporary repository and pointed 
its alternates to the other two.  I then did some shell magic to 
generate a list of all objects shared by both repos, and sent that list 
to git-pack-objects.  This gave me a pack file in the temp repo that 
contained all of the shared objects.  I then made a .keep file and hard 
linked this pack file ( and index, and .keep file ) into both original 
repos, deleted the temp repo, and then repacked both original repos. 
This left them both with two pack files: one that is shared, and one 
that is all of the objects specific to that repo.

Because the shared objects are in a pack file that both repos hard link 
to, neither one will break if I (re)move the other.  It would be nice if 
git relink could be enhanced to do this, then you can just periodically 
run relink with a list of repos and it could hard link all of the shared 
data into a big shared pack file, with no need to have a "master" repo 
that requires special handling.
