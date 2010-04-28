From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Multiblobs
Date: Wed, 28 Apr 2010 14:07:02 -0400
Message-ID: <k2y32541b131004281107u6d15ed4ex54b5e5c138cc0e24@mail.gmail.com>
References: <loom.20100428T164432-954@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 20:07:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7Bfk-0006y4-BO
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 20:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228Ab0D1SHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 14:07:38 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:38895 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756201Ab0D1SHh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 14:07:37 -0400
Received: by ywh32 with SMTP id 32so8629113ywh.33
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=lEtXHbUSRaNWcmaslHm4eFFIENr/Lsuq6NDAH1Qxpeg=;
        b=xf7GI2Scx2I3DqxYdIdVEKwzC50vXOEV3Vt45uPuu7+89zYp/WE5vHDUvYYfdqH2TE
         8X5wqxCWon55UlpjS1esx2UoIq0GhPkyLptMc/2a/YhARzPTqGa/nQAAoTrLARt9IV2G
         D3kv7tV8HRCC3TjGR8nRWxgk/YsDvQ9LY+hBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=PotDaNCc2kZY6Y5C2h8vqc2eeKElCplKenwUd1/wPC5o4IqZ5SRdMpoCtUezZWzKBM
         FVUQVl9uwV7bQrY9ze9OdOhAjvbowCWyAnwKsZqOHLRNr2nZq70W0ykUpOnsjpIagGIH
         xdpuEn799k7xyOigrz/lN/3DeDfRiGTMylRc8=
Received: by 10.151.4.8 with SMTP id g8mr126662ybi.40.1272478043831; Wed, 28 
	Apr 2010 11:07:23 -0700 (PDT)
Received: by 10.151.109.5 with HTTP; Wed, 28 Apr 2010 11:07:02 -0700 (PDT)
In-Reply-To: <loom.20100428T164432-954@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146001>

On Wed, Apr 28, 2010 at 11:12 AM, Sergio Callegari
<sergio.callegari@gmail.com> wrote:
> - storing "structured files", such as the many zip-based file formats
> (Opendocument, Docx, Jar files, zip files themselves), tars (including
> compressed tars), pdfs, etc, whose number is rising day after day...

I'm not sure it would help very much for these sorts of files.  The
problem is that compressed files tend to change a lot even if only a
few bytes of the original data have changed.

For things like opendocument, or uncompressed tars, you'd be better
off to decompress them (or recompress with zip -0) using
.gitattributes.  Generally these files aren't *so* large that they
really need to be chunked; what you want to do is improve the deltas,
which decompressing will do.

> - storing binary files with textual tags, where the tags could go on a separate
> blob, greatly simplifying their readout without any need for caching them on a
> note tree.

That sounds complicated and error prone, and is suspiciously like
Apple's "resource forks," which even Apple has mostly realized were a
bad idea.

> - help the management of upstream trees. This could be simplified since the
> "pristine tree" distributed as a tar.gz file and the exploded repo could share
> their blobs making commands such as pristine-tree unnecessary.

Sharing the blobs of a tarball with a checked-out tree would require a
tar-specific chunking algorithm.  Not impossible, but a pain, and you
might have a hard time getting it accepted into git since it's
obviously not something you really need for a normal "source code"
tracking system.

> - help projects such as bup that currently need to provide split mechanisms of
> their own.

Since bup is so awesome that it will soon rule the world of file
splitting backup systems, and bup already has a working implemention,
this reason by itself probably isn't enough to integrate the feature
into git.

> - be used to add "different representations" to objects... for instance, when
> storing a pdf one could use a fake split to store in a separate blob the
> corresponding text, making the git-diff of pdfs almost instantaneous.

Aie, files that have different content depending how you look at them?
 You'll make a lot of enemies with such a patch :)

> From Jeff's post, I guess that the major issue could be that the same file could
> get a different sha1 as a multiblob versus a regular blob, but maybe it could be
> possible to make the multiblob take the same sha1 of the "equivalent plain blob"
> rather than its real hash.

I think that's actually not a very important problem.  Files that are
different will still always have differing sha1s, which is the
important part.  Files that are the same might not have the same sha1,
which is a bit weird, but it's unlikely that any algorithm in git
depends fundamentally on the fact that the sha1s match.

Storing files as split does have a lot of usefulness for calculating
diffs, however: because you can walk through the tree of hashes and
short entire circuit subtrees with identical sha1s, you can diff even
20GB files really rapidly.

> For the moment, I am just very curious about the idea and the possible pros and
> cons... can someone (maybe Jeff himself) tell me a little more? Also I wonder
> about the two possibilities (implement it in git vs implement it "on top of"
> git).

"on top of" git has one major advantage, which is that it's easy: for
example, bup already does it.  The disadvantage is that checking out
the resulting repository won't be smart enough to re-merge the data
again, so you have a bunch of tiny chunk files you have to concatenate
by hand.

Implementing inside git could be done in one of two ways: add support
for a new 'multiblob' data type (which is really more like a tree
object, but gets checked out as a single file), or implement chunking
at the packfile level, so that higher-level tools never have to know
about multiblobs.

The latter would probably be easier and more backward-compatibility,
but you'd probably lose the ability to do really fast diffs between
multiblobs, since diff happens at the higher level.

Overall, I'm not sure git would benefit much from supporting large
files in this way; at least not yet.  As soon as you supported this,
you'd start running into other problems... such as the fact that
shallow repos don't really work very well, and you obviously don't
want to clone every single copy of a 100MB file just so you can edit
the most recent version.  So you might want to make sure shallow repos
/ sparse checkouts are fully up to speed first.

Have fun,

Avery
