From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 4/6 (v2)] administrative functions for rev-cache, and 
	start of integration into git
Date: Tue, 11 Aug 2009 11:49:49 +0200
Message-ID: <c77435a80908110249y1ce82dd4n77b3b81e532daeea@mail.gmail.com>
References: <op.uyb1vcvytdk399@sirnot.private>
	 <7vtz0g7s1p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:32:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaqWu-0007WR-5I
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986AbZHKMcb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 08:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753983AbZHKMcb
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:32:31 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:34739 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbZHKMca convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 08:32:30 -0400
Received: by ewy10 with SMTP id 10so3730846ewy.37
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 05:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zxs8jEDt5m2jq5anyNae3nU3vGOBDE4xkpsvJrMDvOc=;
        b=KZDtDvrWEskQv9cesv5jgPTwfs6T7bHio+Pr6VKfn8rNVEpEj4cRxT5BvCvBfWM9hZ
         iruzMGOFwdhxMJS6Ny9Ss4J9LC0mi7/WycxpLr9ezd6sYAnyU43z3N2R8gQWTOX0daIf
         QXUVh/TGuhlXmvcgToHVA0BoPEKHwzwpoa5dQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=erEVLN3H7I7ARJSHIERSyi4Eakny5zcodqzJQSRyJtKch7VFDcw6uA3kkcrRs7ZNHx
         RvKWIca7Km1CQ166I25enDn7/PKXlUIfftUqlMgFKFENGnzOaG2zawM/N4RZU2VkIG/c
         8AOLW3KuNr7BeDbCrHVGyMNUF+A3PPW5SJODU=
Received: by 10.216.89.138 with SMTP id c10mr1275824wef.47.1249984189902; Tue, 
	11 Aug 2009 02:49:49 -0700 (PDT)
In-Reply-To: <7vtz0g7s1p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125537>

> It is unclear which "size" this field refers to without comment.
>
> I do not know if this change is justifiable. =A0We (mostly Linus) spe=
nt
> considerble effort to shrink the memory footprint of struct commit (a=
nd
> struct object in general) exactly because revision traversal needs to
> inspect tons of them.

I originally added a `size` field to objects, a `unique` field to
commits and `name` ones to blobs/trees.  This was (I reasoned) partly
for applications to take fuller advantage of rev-cache's abilities,
but largely to ease re-use of its information in slice regeneration.

However, in retrospect I think you're probably right.  Not only do I
not really need to load the information into memory to re-use it, but
applications using rev-cache would probably have sufficiently
specialized needs to warrant direct access.  In light of this I've
rewritten the fuse command to re-use data directly from the slice,
rather than requiring it to be loaded into memory first (hence
eliminating the all those extra fields).  Furthermore I'll put all the
(renamed) structures and definitions in a seperate header, to allow
easy direct access to slices by third-parties.

> Looks vaguely familiar.
>
> The configuration parser already knows about these size suffixes when=
 told
> to read "int". =A0Can't that code, e.g. git_parse_ulong(), be reused =
here?

You're also right here.  I wrote it fast and hadn't checked if git had
already implemented it.  I've changed it to use git_parse_ulong().

Sorry I haven't uploaded anything yet.  I keep seeing new things that
could updated or revised; so far I've
 - rewritten and added much to the documentation
 - added support for an alternates-like mechanism
 - changed --noobjects to --no-objects
 - changed init_rci to init_rev_cache_info
 - modified make_cache_slice to return actual start/end commits
 - changed coagulate_ to fuse_
 - added an (admittedly crude) escape plan in case of obscenely large
merges/branches
 - cleaned up path generation
 - replace parse_size with git_parse_ulong
 - rewritten fuse to reuse objects verbatim, rather than via memory acc=
ess

And on my todo list I've still got things such as renaming all the
structures/definitions, adding a more portable _ondisk version of
bitfield'ed structs and obviously cleanup the patchset (eliminating
fixes of earlier patches, etc.).

I hope to get everything finished in the next couple days, and upload
a v3 by friday at the latest.

 - Nick
