From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 00/17] Clean up how fetch_pack() handles the heads list
Date: Thu, 23 Aug 2012 20:13:29 +0100
Organization: OPDS
Message-ID: <49DEA56853C64B9B900D3C7F886D4FA6@PhilipOakley>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu> <20120823092624.GG6963@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>, <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 23 21:13:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4cqU-0008Oq-Q2
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 21:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195Ab2HWTN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 15:13:29 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:52425 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751960Ab2HWTN1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 15:13:27 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AucKAM5/NlBcGncX/2dsb2JhbABFDoVzhT+uDQQBA3mBCIIbBQEBBAEIAQEZFR4BASEFBgIDBQIBAw4HAQICAgUhAgIUAQQaBgcXBgESCAIBAgMBh3YKpmmTLoEhiWcUAQ1whG0yYAONXJEmhmaCKTuBVwE
X-IronPort-AV: E=Sophos;i="4.80,301,1344207600"; 
   d="scan'208";a="401750707"
Received: from host-92-26-119-23.as13285.net (HELO PhilipOakley) ([92.26.119.23])
  by out1.ip01ir2.opaltelecom.net with SMTP; 23 Aug 2012 20:13:25 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204166>

From: "Jeff King" <peff@peff.net>
Sent: Thursday, August 23, 2012 10:26 AM
> On Thu, Aug 23, 2012 at 10:10:25AM +0200, mhagger@alum.mit.edu wrote:
>
>> There were various confusing things (and a couple of bugs) in the way
>> that fetch_pack() handled the list (nr_heads, heads) of references to
>> be sought from the remote:
>
> Aside from the minor comments I made to individual patches, this all
> looks good. As usual, thanks for breaking it down; I wish all series
> were as easy to review as this.
>
>> I'm still suspicious about the logic related to args.fetch_all and
>> args.depth, but I don't think I've made anything worse.
>
> I think the point of that is that when doing "git fetch-pack --all
> --depth=1", the meaning of "--all" is changed from "all refs" to
> "everything but tags".
>

There is a comment in \git\Documentation\technical\shallow.txt that
"- If you deepen a history, you'd want to get the tags of the
  newly stored (but older!) commits. This does not work right now."
which may be the source of this restriction. That is, how is the depth
of the tag fetching to be restricted to the requested depth count?
[assuming I've undestood the problem correctly]

It may be (?) that it is a good time to think about a 'datedepth' 
capability to bypass the current counted-depth shallow fetch that can 
cause so much trouble. With a date limited depth the relevant tags could 
also be fetched.

> Which I kind of see the point of, because you don't want to grab 
> ancient
> tags that will be expensive. But wouldn't it make more sense to limit 
> it
> only to the contents of refs/heads in that case? Surely you wouldn't
> want refs/notes, refs/remotes, or other hierarchies.
>
> I suspect this code is never even run at all these days. All of the
> callers inside git should actually provide a real list of refs, not
> "--all". So it is really historical cruft for anybody who calls the
> fetch-pack plumbing (I wonder if any third-party callers even exist;
> this is such a deep part of the network infrastructure that any sane
> scripts would probably just be calling fetch).
>
> -Peff
> --
> 
