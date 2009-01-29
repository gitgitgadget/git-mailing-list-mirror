From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Appropriateness of git for digital video production versioning
Date: Thu, 29 Jan 2009 07:45:36 -0800
Message-ID: <20090129154536.GC26880@spearce.org>
References: <8c4a72800901290736p4952e53byddca243f300dd8af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Charles Earl <charles.cearl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 16:47:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSZ6f-0000zf-Ee
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 16:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbZA2Ppi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 10:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbZA2Pph
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 10:45:37 -0500
Received: from george.spearce.org ([209.20.77.23]:33800 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbZA2Pph (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 10:45:37 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 80A0438210; Thu, 29 Jan 2009 15:45:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <8c4a72800901290736p4952e53byddca243f300dd8af@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107696>

Charles Earl <charles.cearl@gmail.com> wrote:
> Are there past instances of git having been adapted to support version
> control of digital media production workflow?

You are going to run into scaling problems.  Git works under the
assumption that it can malloc() at least 2 complete copies of a
file at once, in the same process.

Last time I mucked around with digital media production, the volume
of data in a video file was *huge*.  Its workable on modern systems
with terabyte disk arrays and so forth, but modern systems still
can't afford the 100 GB of RAM necessary to allow Git to malloc()
up two blocks of a single 40 GB video file.

Also, since clients pretty much grab the entire repository when they
clone it for working access, its going to suck down the entire media
archive, *all* versions.  That could be well into the hundreds of
TB range and may never complete.

> The bulk of content stored is binary data -- there have been posts on
> this about integration of various binary diff implemetations with git.

You mention later about using S3 or BlockStore to hold the binary
content.  Maybe the large binary data should be stored in S3, and
the Git repository just holds the metadata and scripts, including
scripts to perform downloads/uploads through S3.

> The versioning of metadata, scripts, project structure seems to argue
> for applicability of system such as git -- these fit the paradigm of
> traditional scm.

Yea, that's more typical of what Git was designed and built to store.

> Example content is from media production suites such as Adobe After
> Effects/Premier: video, compositions, etc.
> I'd also like the object storage to be in S3/Amazon BlockStore or
> similar remote stores.

My suggestion?

Use Git for your metadata and scripts.  Include a few scripts that
can download the large media files from S3 when they are needed,
and upload new versions when they are modified.

If you want to store versions over time of the files, sha1sum
the media file and use that as the key name in the S3 bucket,
and store the output of sha1sum into a file within Git.  E.g. a
".media" text file just listing out sha1sum and path names:

  ceba7222551c722836564535697947e8a9b3e7ce big_file.mpg
  75c8f5ecb97ec67c1ec949b16c72e6ba1361a528 other_file.mpg

and use a simple script to edit/read that file, accessing S3 as
necessary for the operations.

-- 
Shawn.
