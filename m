From: Jeff King <peff@peff.net>
Subject: Re: New directory lost by git am
Date: Wed, 5 Mar 2014 12:13:34 -0500
Message-ID: <20140305171334.GA31252@sigill.intra.peff.net>
References: <531690A3.3040509@ubuntu.com>
 <53169549.10309@gmail.com>
 <53169868.3010401@ubuntu.com>
 <5316DBEC.3020208@gmail.com>
 <53173423.6050708@ubuntu.com>
 <20140305163415.GA28908@sigill.intra.peff.net>
 <53175510.7020000@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Packham <judge.packham@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 18:13:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLFO1-0002iR-65
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 18:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791AbaCERNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 12:13:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:33496 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751630AbaCERNg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 12:13:36 -0500
Received: (qmail 12029 invoked by uid 102); 5 Mar 2014 17:13:36 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Mar 2014 11:13:36 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Mar 2014 12:13:34 -0500
Content-Disposition: inline
In-Reply-To: <53175510.7020000@ubuntu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243445>

On Wed, Mar 05, 2014 at 11:47:12AM -0500, Phillip Susi wrote:

> > I can't get Chris's script to fail on any version of git. Can you
> > show us an example of a patch that does not behave (or better yet,
> > a reproduction recipe to generate the patch with "format-patch")?
> 
> AHA!  It requires a conflict.  There were simple conflicts in the NEWS
> file so I applied the patch with git am --reject and fixed up the
> NEWS, and ran git am --resolved.  The git am --reject fails to add the
> new directory to the index.

Thanks, I can reproduce here. I do not think it has anything to do with
being in a subdirectory; any new file does not get added to the index.
In fact, I do not think we update the index at all with "--reject". For
example, try this:

    git init repo &&
    cd repo &&

    echo base >conflict &&
    echo base >modified &&
    git add . &&
    git commit -m base &&

    echo master >conflict &&
    git add . &&
    git commit -m master &&

    git checkout -b other HEAD^ &&
    echo other >conflict &&
    echo other >modified &&
    echo other >new &&
    git add . &&
    git commit -m other &&

    git checkout master &&
    git format-patch other -1 --stdout >patch &&
    git am --reject patch

Running "git status -s" shows:

   M modified
   ?? conflict.rej
   ?? new
   ?? patch

We apply the changes to "modified" and "new" to the working tree, but we
do not stage anything in the index. I suspect this is because our
invocation of "apply --index" (which is what is doing the real work with
"--reject" here) bails before touching the index. In theory it should be
able to update the index for files that applied cleanly and leave the
other ones alone.

But I have not thought hard about it, so maybe there is a good reason
not to (it is a little weird just because the resulting index is a
partial application of the patch).  The "am -3" path does what you want
here, but it is much simpler: it knows it can represent the 3-way
conflict in the index. So the index represents the complete state of the
patch application at the end, including conflicts.

-Peff
