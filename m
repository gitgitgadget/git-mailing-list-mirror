From: "David Frech" <david@nimblemachines.com>
Subject: Re: Another question about importing SVN with fast-import
Date: Thu, 19 Jul 2007 00:09:41 -0700
Message-ID: <7154c5c60707190009r6d460debs71158d4db9a028d4@mail.gmail.com>
References: <Pine.LNX.4.64.0707162204480.14971@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Julian Phillips" <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Jul 19 09:09:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBQ91-0003FU-10
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 09:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757408AbXGSHJp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 03:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757391AbXGSHJp
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 03:09:45 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:55303 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756766AbXGSHJo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 03:09:44 -0400
Received: by nz-out-0506.google.com with SMTP id s18so406821nze
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 00:09:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Bryg/854D5lKImKH65XP85h1PkEIdUwY7MGInzj0/8F424LIesVyJyCSA8bki3R1VOxqA0cSID9MdxVdl1TDoyPdf+GPnR3v7Yv3FF4hfxb1J1fvcx2d6brX7Cpy2DY5AKzrIpRBNGyZp4Njnkr1W/74lt1z3vN1upU33yKh9QM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=odkN3cpxBWqjZiyXqTjJAotNoH9LjXLpK29jz0hYeJydYFqS46dxubLmXoUXWlY6hEAtWGNJotMJQ1k8u9U2ivhP1rDzlev4b+1vqr1+P2hQHaQoWqk/fiK/WK2cZ2sARgPXnUpYwBJPTQnf9WMg4f7K7nCVBUwuYDWLZn3xgkk=
Received: by 10.114.177.1 with SMTP id z1mr1395256wae.1184828981900;
        Thu, 19 Jul 2007 00:09:41 -0700 (PDT)
Received: by 10.115.59.9 with HTTP; Thu, 19 Jul 2007 00:09:41 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707162204480.14971@reaper.quantumfyre.co.uk>
Content-Disposition: inline
X-Google-Sender-Auth: 16db17aa539d880e
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52946>

On 7/16/07, Julian Phillips <julian@quantumfyre.co.uk> wrote:
> Now the question.  Shawn recently added C and R operations - almost as
> soon as they were asked for too.  However, how do you copy a file from a
> particular revision?  I have just hit a point where someone deleted a
> directory, and then copied one of the files from that directory back from
> an old revision (as two separate commits).  Since I'm not tracking any
> branch contents in my front-end, and the copy operation only works from
> the current branch head I seem to be stuck ... or have I missed something?

I have to second Julian's question.

The only things I have left to implement (in my svn dump to
fast-import translator) before I can call my code "complete"  are
branch copies (which will generate "from" lines in commits so
fast-import can properly initialize the new branch) and a generic
"copy <path> from <rev>" that Julian also needs.

I mark my commits and keep track of the mapping from svn revs to git
commits, so when the svn dump asks for a <path> from a specific <svn
rev> I can correlate that to a mark (ie, a git commit). But I can't
tell fast-import to *do* anything with it.

This is kind of a request and a comment/question. The request is:
there is no way to do *reasonably* in the front end what fast-import
can do somewhat reasonably: namely, copy a <path> (file or directory!)
from an arbitrary previously committed revision/mark to the current
branch.

The comment/question is: how different is this, really, from being
able to  specify a "from" line in a commit? In both cases I'm asking
fast-import to reach into its memory (or the repo) and pull out a
tree, and to add (some or all of it) to my current branch. Isn't the
kind of generic C command that Julian and I are asking for the same
thing, only instead of taking the whole tree (from the specified
commit) it takes a single file or directory?

I hope I haven't missed the point entirely.

Lastly, do we really need "R"? With this generic copy - and I think
there should be *only* a generic version, not a "streamlined local
copy" version and a "reach into history arbitrarily" version - we can,
as an earlier poster pointed out, do R by doing a C and then a D. This
is, in fact, how svn dump files represent file and directory renames.

It would be nice to keep the fast-import command set small and orthogonal.

My few cents.

Cheers,

- David

-- 
If I have not seen farther, it is because I have stood in the
footsteps of giants.
