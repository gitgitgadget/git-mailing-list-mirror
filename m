From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 3/3] Add filter-objects command
Date: Fri, 19 Jun 2015 11:33:24 +0100
Message-ID: <20150619103324.GA4093@hashpling.org>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434705059-2793-4-git-send-email-charles@hashpling.org>
 <20150619101010.GA15802@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 19 12:41:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5tjU-0003q6-8d
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 12:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747AbbFSKlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 06:41:08 -0400
Received: from avasout06.plus.net ([212.159.14.18]:56912 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510AbbFSKlG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 06:41:06 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jun 2015 06:41:06 EDT
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout06 with smtp
	id iAZQ1q00A2iA9hg01AZREp; Fri, 19 Jun 2015 11:33:29 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=foEhHwMf c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10
 a=Ew9TdX-QAAAA:8 a=XAFQembCKUMA:10 a=bt8f3QUhMxDYXkthstsA:9 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1Z5tbw-00015i-JH; Fri, 19 Jun 2015 11:33:24 +0100
Content-Disposition: inline
In-Reply-To: <20150619101010.GA15802@peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272122>

On Fri, Jun 19, 2015 at 06:10:10AM -0400, Jeff King wrote:
> On Fri, Jun 19, 2015 at 10:10:59AM +0100, Charles Bailey wrote:
> 
> > filter-objects is a command to scan all objects in the object database
> > for the repository and print the ids of those which match the given
> > criteria.
> > 
> > The current supported criteria are object type and the minimum size of
> > the object.
> > 
> > The guiding use case is to scan repositories quickly for large objects
> > which may cause performance issues for users. The list of objects can
> > then be used to guide some future remediating action.
> 
> I've had to perform this exact same task. You can already do the
> "filtering" part pretty easily and efficiently with cat-file and a perl
> script, like:
> 
>   magically_generate_all_objects |
>   git cat-file --batch-check='%(objectsize) %(objectname)' |
>   perl -alne 'print $F[1] if $F[0] > 1234'
> 
> That's not as friendly as your filter-objects, but it's a lot more
> flexible (since you can ask cat-file for all sorts of information).
> 
> Obviously I've glossed over the "how to get a list of objects" part.
> If you truly want all objects (not just reachable ones), or if "rev-list
> --objects" is too slow [...]

So, yes, performance is definitely an issue and I could have called this
command "git magically-generate-all-object-for-scripts" but then, as it
was so easy to provide exactly the filtering that I was looking for in
the C code, I thought I would do that as well and then "filter-objects"
("filter-all-objects"?) seemed like a better name.

It's about an order of magnitude faster on the systems I've checked to
do a parameterless filter-objects then rev-list --all --objects,
although I understand they do different things.

I am also thinking about another piece that answers the question: "which
commits introduce any of (or the first of) this list of objects?". This
can be done by parseing a diff --raw for commits but I think it should
be possible to do this faster, too.

Charles.
