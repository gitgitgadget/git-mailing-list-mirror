From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: clone breaks replace
Date: Tue, 11 Jan 2011 10:37:44 -0500
Message-ID: <4D2C7948.6080304@cfl.rr.com>
References: <4D262D68.2050804@cfl.rr.com> <20110106213338.GA15325@burratino> <4D276CD2.60607@cfl.rr.com> <20110107205103.GC4629@burratino> <4D278930.7010100@cfl.rr.com> <20110107214907.GA9194@burratino> <20110107220942.GB10343@sigill.intra.peff.net> <4D27B33C.2020907@cfl.rr.com> <20110111054735.GC10094@sigill.intra.peff.net> <20110111065244.GB8631@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 16:37:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcgHy-0007tN-4v
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 16:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209Ab1AKPhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 10:37:35 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.122]:63121 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858Ab1AKPhe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 10:37:34 -0500
Authentication-Results: cdptpa-omtalb.mail.rr.com smtp.user=psusi@cfl.rr.com; auth=pass (PLAIN)
X-Authority-Analysis: v=1.1 cv=pepdxKapwHuwCZNFD5uob2wvham6E+RljB0uXw08FdQ= c=1 sm=0 a=8nJEP1OIZ-IA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:17 a=7ePUphrNUwObuGoN0BYA:9 a=VUMU8CXy_GEeVay6XhEA:7 a=WfTpxnXu8-k9uJ9ZWc3tD3OXMjAA:4 a=wPNLvfGTeEIA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:117
X-Cloudmark-Score: 0
X-Originating-IP: 72.242.190.170
Received: from [72.242.190.170] ([72.242.190.170:1540] helo=[10.1.1.235])
	by cdptpa-oedge03.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTPA
	id 31/EE-19545-C397C2D4; Tue, 11 Jan 2011 15:37:33 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110111065244.GB8631@burratino>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164954>

On 1/11/2011 1:52 AM, Jonathan Nieder wrote:
> I have two worries:
> 
>  - first, how easily can the replacement be undone? (as you mention
>    below)

git replace -d id, or git --no-replace-objects.  It also might be nice
to add a new switch to git replace to disable a replace without deleting
it, so that it can later be enabled again.

>  - second, what happens if the two ends of transport have different
>    replacements?

Then you have a conflict, just like if the two ends have different tags
with the same name.

> That second worry is the more major in my opinion.  Shallow clones are
> a different story --- they do not fundamentally change the history and
> they have special support in git protocol.  It is possible to punt on
> both by saying that (1) replacements _cannot_ be undone --- a second
> replacement is needed --- and (2) the receiving end of a connection is
> not allowed to have any replacements for objects in common that the
> sending end does not have, but then does that buy you anything
> significant over a filter-branch?

One of the major advantages of replacements is that they can easily be
undone, so defeating that would be silly.  Just like with conflicting
tags, if the receiving end has conflicting replacements, they will be
kept instead of the remote version and a warning issued.  If you want
the remote version, delete your local one and fetch again.

What it buys you over filter-branch is:

1)  Those tracking your repo don't have breakage when they next fetch
because the chain of commits they were tracking has been destroyed and
replaced by a completely different one.

2)  It is obvious when a replace has been done, and the original is
still available.  This is good for auditing and traceability.  Paper
trails are good.

3)  Inserting a replace record takes a lot less cpu and IO than
filter-branch rewriting the entire chain.
