From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2 3/3] pack-objects: honor '.keep' files
Date: Thu, 06 Nov 2008 17:22:41 -0600
Message-ID: <HBFmgmcvgPzZ0xq-fRUt98ZOBXGCvwxHGyEwF9bNcgpDgS-t-D3viw@cipher.nrlssc.navy.mil>
References: <-RiFxYEd9Wiq2fWX74zYGUiEwrzLeoFDb1KuG3-Xo-s@cipher.nrlssc.navy.mil> <LSyxMgVV7zAWRvSezvxyUc6-kz2gK6MRVKonKSf1pAmdqO-jeuMFIw@cipher.nrlssc.navy.mil> <GV8cY3fn8l5UV5cNoPN8bHchWt9u2tbZ8j_ypkiY-ZLfO1tx9d7ebA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 00:25:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyEEa-0002WZ-Vd
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 00:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbYKFXXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 18:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbYKFXXB
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 18:23:01 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57586 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbYKFXXA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 18:23:00 -0500
Received: by mail.nrlssc.navy.mil id mA6NMf7A012733; Thu, 6 Nov 2008 17:22:41 -0600
In-Reply-To: <GV8cY3fn8l5UV5cNoPN8bHchWt9u2tbZ8j_ypkiY-ZLfO1tx9d7ebA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 06 Nov 2008 23:22:41.0594 (UTC) FILETIME=[90BD59A0:01C94066]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100271>

Brandon Casey wrote:
> Junio,
> 
> Please leave this in pu for now, I have some concerns that I haven't
> had time to write down yet.

I've been thinking about pack-objects and repack.

Here's how I think the semantics of repack should be defined:

repack:

  <no-options>
    -incremental repack which does not repack any object currently packed
     in any accessible pack.

    Works (it currently works this way).

  <-a>
    -create a new pack containing all objects required by the repository
     including those accessible through alternates, but excluding objects
     in _local_ packs with .keep

    Flawed, even with my recent patches.

    If there are no local packs (or they all have .keep files), then the
    pack-objects call will use --incremental which will exclude objects
    packed in alt object store, even though -l was not used.
 
    My patches do not differentiate local .keep files from remote .keep files,
    which a user may have no control over.

  <-A>
     -Like -a, but local unreferenced objects which were previously packed
      are made to be loose.

    Ditto.

  <-a -l>
     -Restrict operation to only local objects. Only has any effect with -a|-A.
     -Like -a, but additionally exclude objects in packs accessible through
      alternates.

     Works with my recent patches.

  <-A -l>
     -Like '-a -l', but loosen unreferenced local packed objects.

     Ditto.



That set of repack operations needs to map to a combination of pack-objects
options:

  <no-options>
     -Create a pack with _all_ specified objects

  <--unpacked>
     -Exclude from packing any object already in an accessible pack.

     (Ahh, this came from rev-list interface, and rejects objects at an
      earlier stage than --incremental)

  <--unpacked=sha1>
     -Like '--unpacked', exclude already packed objects, but treat the objects
      in the pack with specified sha1 as unpacked.

  <--incremental>
     -Exclude from packing any object already in an accessible pack,
      regardless of whether it is in a pack specified by --unpacked=

      (How is this different from --unpacked, even though the exclusion
       operation is performed at a different stage? See my epiphany above
       about the source of the --unpacked option)

  <--unpacked --incremental>
     -seems redundant, is there any functional difference?

  <--local>
     -Exclude objects from being packed that are not in the local object store.


The issue is how to provide my described 'repack -a' functionality.
There does not seem to be a mapping between the above options and the
required functionality.

I see two solutions, both require introducing a new option to pack-objects.
  1) allow specifying a set of packs such that if an object resides
     in any of the set, the object will not be included in the produced
     pack.

     Benefits:
     -allows keeping pack-objects ignorant of .keep mechanism
     -repack can easily be modified to produce the set of packs to ignore

     Drawback:
     -very round-about way just to have functionality to skip packs with
      .keep file

  2) New option telling pack-objects to skip objects in local .keep'd packs

     Benefits:
     -easy to implement in pack-objects
     -easy to modify repack

     Drawbacks:
     -introduces new concept to pack-objects


Questions aside:
  1) Are both --incremental and --unpacked still necessary pack-objects options?
  2) Can --incremental become an alias for --unpacked, and go away?


patch(es) will follow.

-brandon
