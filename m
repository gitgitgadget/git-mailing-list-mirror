From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [RFC/PATCH] Make --full-history consider more merges
Date: Fri, 26 Apr 2013 22:18:28 +0300
Message-ID: <517AD304.6020807@bracey.fi>
References: <7v4nfcj2kq.fsf@alter.siamese.dyndns.org> <1366658602-12254-1-git-send-email-kevin@bracey.fi> <7vzjwqny64.fsf@alter.siamese.dyndns.org> <5176B854.2000707@bracey.fi> <7va9ona77d.fsf@alter.siamese.dyndns.org> <7v61zb8j5d.fsf@alter.siamese.dyndns.org> <5179505F.2000108@bracey.fi> <7vtxmu4kq2.fsf@alter.siamese.dyndns.org> <517963B4.30801@bracey.fi> <7v1u9y4gnq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 21:27:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVoIy-0003yz-Cq
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 21:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210Ab3DZT1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 15:27:32 -0400
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:37997 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757373Ab3DZT1b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 15:27:31 -0400
Received: from mail422.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 63A36FF8F97
	for <git@vger.kernel.org>; Fri, 26 Apr 2013 21:18:31 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 26 Apr 2013 21:18:42 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 26 Apr 2013 21:18:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.3 (mo3.mail-out.ovh.net)
In-Reply-To: <7v1u9y4gnq.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 15208655942386225368
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrgeejucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.500002/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrgeejucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222560>

On 25/04/2013 21:19, Junio C Hamano wrote:
> How many decorations are we talking about here? One for each merge 
> commit in the entire history? Do we have a cue that can tell us when 
> we are really done with a commit that lets us discard the associated 
> data as we go on digging, keeping the size of our working set somewhat 
> bounded, perhaps proportional to the number of commits in our 
> rev_info->commits queue? 

As it stands, it's one decoration per interesting merge commit that's 
processed by try_to_simplify_commit(), if simplify_merges is set. (Only 
simplify_merges needs the information at present - conceivably 
limit_to_ancestry could use it too). I don't know how to go about 
discarding the data, or when it could be done - I'm not clear enough on 
the wider sequencing machinery in revision.c yet.

I have a first draft of a set of patches, which will follow this message.

1/3 addresses the initial "get simplify_merges right", passing your 
test. That patch is written to make it easy to extend with the next two, 
which add a "never eliminate all our TREESAME parents" rule, and 
reinstate your reverted"eliminate irrelevant side branches". The error I 
spotted in that was that you weren't checking that you were eliminating 
root commits - with that fixed it seems sound to me.

I need to create a new test for patch 2, but this version passes the 
full test suite, including fixing the known failure in t6012, and it 
also gets the examples in the manual right. (I've extended the examples 
to include the irrelevant side branch - not sure this is worthwhile, as 
it's such an unusual case, and I think that section is confusing enough 
for newbies...)

Kevin
