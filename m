From: Jeff King <peff@peff.net>
Subject: Re: Re-Transmission of blobs?
Date: Thu, 12 Sep 2013 15:56:54 -0400
Message-ID: <20130912195654.GE32069@sigill.intra.peff.net>
References: <20130910130837.GA14259@raven.wolf.lan>
 <xmqqsixcy395.fsf@gitster.dls.corp.google.com>
 <20130911112758.GB14259@raven.wolf.lan>
 <xmqqsixbth4h.fsf@gitster.dls.corp.google.com>
 <20130912074241.GC14259@raven.wolf.lan>
 <20130912092339.GA30702@sigill.intra.peff.net>
 <871B6C10EBEFE342A772D1159D132085571A7A1B@umechphj.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Josef Wolf <jw@raven.inka.de>
To: "Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>
X-From: git-owner@vger.kernel.org Thu Sep 12 21:57:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKD0g-0001Q8-KT
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 21:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097Ab3ILT46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 15:56:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:57560 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883Ab3ILT46 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 15:56:58 -0400
Received: (qmail 7481 invoked by uid 102); 12 Sep 2013 19:56:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Sep 2013 14:56:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Sep 2013 15:56:54 -0400
Content-Disposition: inline
In-Reply-To: <871B6C10EBEFE342A772D1159D132085571A7A1B@umechphj.easf.csd.disa.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234685>

On Thu, Sep 12, 2013 at 12:45:44PM +0000, Pyeron, Jason J CTR (US) wrote:

> If the rules of engagement are change a bit, the server side can be release from most of its work (CPU/IO).
> 
> Client does the following, looping as needed:
> 
> Heads=server->heads();
> KnownCommits=Local->AllCommits();
> Missingblobs=[];
> Foreach(commit:heads) if (!knownCommits->contains(commit)) MissingBlobs[]=commit;
> Foreach(commit:knownCommit) if (!commit->isValid()) MissingBlobs[]=commit->blobs();
> If (missingBlobs->size()>0) server->FetchBlobs(missingBlobs);

That doesn't quite work. The client does not know the set of missing
objects just from the commits. It knows the sha1 of the root trees it is
missing. And then if it fetches those, it knows the sha1 of any
top-level entries it is missing. And when it gets those, it knows the
sha1 of any 2nd-level entries it is missing, and so forth.

You can progressively ask for each level, but:

  1. You are spending a round-trip for each request. Doing it per-object
     is awful (the dumb http walker will do this if the repo is not
     packed, and it's S-L-O-W). Doing it per-level would be better, but
     not great.

  2. You are losing opportunities for deltas (or you are making the
     state the server needs to maintain very complicated, as it must
     remember from request to request which objects you have gotten that
     can be used as delta bases).

  3. There is a lot of overhead in this protocol. The client has to
     mention each object individually by sha1. It may not seem like a
     lot, but it can easily add 10% to a clone (just look at the size of
     the pack .idx files versus the packfiles themselves).

-Peff
