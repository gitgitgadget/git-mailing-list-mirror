From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Mon, 2 Apr 2012 18:04:53 -0500
Message-ID: <20120402230452.GE13969@burratino>
References: <11292500.AVmZFUUvNi@flobuntu>
 <CALkWK0nW91PE2810qrZUbL0x-_YTTA_2tLFVhvXBJ2NFGvVxog@mail.gmail.com>
 <2148933.pnpYo0xMAP@flomedio>
 <2487557.B8qfnaixh3@flomedio>
 <20120402205659.GA13725@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Florian Achleitner <florian.achleitner@student.tugraz.at>
X-From: git-owner@vger.kernel.org Tue Apr 03 01:06:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEqK0-0000OO-IV
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 01:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505Ab2DBXFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 19:05:15 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50269 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab2DBXFN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 19:05:13 -0400
Received: by iagz16 with SMTP id z16so4734452iag.19
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 16:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=X8Mh1K1x2RYrq+TAvTEzAqCAmc97J1MZ3caCvPK494Y=;
        b=dnw0U1uQhNixALPWRsVpuqTj78vRPPdpKB8YMAYexcKoJAsSAblNcFSCfvl3tG28sP
         QU2RCp7FkbkEtSUPETcIa0uXqie+rfoD85ZCV1YWxg7dLXOYGdjHIL7tJpQkMc3B6wWs
         8HblRItTTT04gICZLkbISg+9gYkjDwcO/6DuvA9Gxs9y+aFRgxe1KhE8Cj9Bbmjp++HB
         3qU7B5wIFIvr6Rkp6oYYd4Ywweod1nTtzTkJ1KMbt0aKUgYUBaHpUNsXwWOy+QbBA62T
         bfEXZvRKfsX0zwtQN96Y00crxpG8NYnja12qSaffDQphhIamFzbmlMKUBXfzkBX0CDts
         xInQ==
Received: by 10.50.42.134 with SMTP id o6mr7030720igl.72.1333407912444;
        Mon, 02 Apr 2012 16:05:12 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id hq3sm26953910igc.0.2012.04.02.16.05.10
        (version=SSLv3 cipher=OTHER);
        Mon, 02 Apr 2012 16:05:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120402205659.GA13725@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194575>

Jonathan Nieder wrote:

>  - Importing <rev, path> pairs that have multiple parents.  In the
>    subversion model, path nodes have only one (copyfrom) parent,
>    but repositories can use the svn:mergeinfo property to indicate
>    that changes made in certain revs to another patch have been

The above should say "... changes made in certain revs to another
_path_ ...".

>    incorporated.  Under what circumstances is that enough
>    justification to add a second parent on the git side?

One subtlety here is that sometimes people merge almost everything
from some branch but leave a few revisions out.  Imagine the following
history:

 o --- B1 --- B2 --- B3 ---- B4 -- F' ---- B6 --- B7 --- B8 [branch]
  \                                 \                     \
   \                                 \                     \
    T1 --- F ------------------------ M1 ------------------ M2 [trunk]

The bugfix F was applied to the trunk first and then applied to the
branch as rev F'.  Then the maintainer merged the remaining changes
B1, B2, B3, B4 from the branch to trunk.  In git this operation would
be carried out by running "git merge branch".  Finally some more
changes were made on the branch and the maintainer merged those to
trunk, too.

In subversion, this could be done like so:

 1. Make commit T1 on trunk.
 2. Make commit F on trunk.
 3. Make commits B1, B2, B3, B4 on branch.
 4. Make commit F' on branch, either using "svn merge" or by hand.
 5. Merge changes B1, B2, B3, B4 from branch to trunk using
    "svn merge -r o:B4 <url for branch>" and commit.
 6. Make commits B6, B7, B8 on branch.
 7. Merge changes B6, B7, B8 from branch to trunk using
    "svn merge -r F':B8 <url for branch>" and commit.

The resulting svn:mergeinfo property on trunk in revision M1 would
look like this:

	/branches/branch:B1-B4

To a naive importer, this looks like a merge of B4.  The svn:mergeinfo
property on trunk in revision M2 would look like this:

	/branches/branch:B1-B4,B6-B8

which looks like a bunch of cherry-picks rather than a merge, since
it looks like this almost-merge leaves out F'.

If the maintainer used "svn merge --reintegrate" instead, the
svn:mergeinfo properties are a little simpler, so maybe I am worrying
for no good reason.  Anyway, hopefully that makes the setup a little
clearer.
