From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Can I checkout a single file without altering index?
Date: Fri, 15 Oct 2010 14:32:52 -0500
Message-ID: <20101015193252.GA23082@burratino>
References: <loom.20101012T114900-532@post.gmane.org>
 <AANLkTinnYEnCwpTh45N69n73JQm=ndXH-SUJ5b1piUYv@mail.gmail.com>
 <loom.20101014T095743-275@post.gmane.org>
 <i9a6kn$d7o$1@dough.gmane.org>
 <20101015184302.GA22990@burratino>
 <20101015185539.GA30380@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 15 21:36:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6q4u-00005j-JM
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 21:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377Ab0JOTgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 15:36:24 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:47930 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756579Ab0JOTgX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 15:36:23 -0400
Received: by qyk2 with SMTP id 2so1210864qyk.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 12:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6ihdjdL7aVinrCPB6tvedM+d4X9qsa9kSZG3enD8Fd0=;
        b=A+aVCmu464zI55BM6hjSkbunJOaUpXzikT/xqg9q69B9u0SdHw0zi3zhhggigb0j+l
         Lnof8D5sLNjTmQi6RHHIIIpc5yxm9eKyl9Hl4ivQ3u0OTyPqdX2pB4u6BW/Rx2LMoMGW
         q5nISOBcVCwM0n4wsULldSXhdSj35wMq3fMAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SNnVUuZK7ryErAhECDtTdb9DiGAQSVtTxU8Sm7VkGHBI/X4SPpyQg5ZjhVGeq+KbuO
         +LIVlFJdi1X+2v9VAPj/qtcnOaz+YWbTO3UorQPRHHrPSN0QUWMH5ExYc+T6p8I83DS5
         pB02ZOpUbvUaky7S7gFZLStauNbYQbPX92rJs=
Received: by 10.229.224.137 with SMTP id io9mr1064449qcb.206.1287171382598;
        Fri, 15 Oct 2010 12:36:22 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id nb14sm10378917qcb.24.2010.10.15.12.36.20
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 12:36:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101015185539.GA30380@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159134>

Jeff King wrote:
> On Fri, Oct 15, 2010 at 01:43:02PM -0500, Jonathan Nieder wrote:
>> Neal Kreitzinger wrote:

>>> However, there is an option in git-commit to copy files directly from the 
>>> working-tree to the object-store by totally bypassing the index
>>
>> What option is this?  I thought "git commit --include" added content
>> to the index.
>
> git commit -o|--only, which is the same as "git commit <paths>". Of
> course it still uses an index, to create the tree, but it uses a
> temporary one based on HEAD instead of the current index contents.

Ah, it's stranger than that.

	 * A partial commit.
	 *
	 * (0) find the set of affected paths;
	 * (1) get lock on the real index file;
	 * (2) update the_index with the given paths;
	 * (3) write the_index out to the real index (still locked);
	 * (4) get lock on the false index file;
	 * (5) reset the_index from HEAD;
	 * (6) update the_index the same way as (2);
	 * (7) write the_index out to the false index file;
	 * (8) return the name of the false index file (still locked);

The net effect being that the index will match the work tree for the
listed paths when the operation is over, while other files are
untouched.
-- 8< --
Subject: Documentation: clarify "commit --only" description

>From the current description, one might imagine that "git commit
<pathspec>" bypasses the index completely.  Clarify what it does
do to the index:

 - paths matching <pathspec> are updated to match the work tree
 - paths not matching <pathspec> are left alone

so readers can have a better idea of what the index represents
before and after such an operation.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 I'm not so happy with the wording.  Hopefully this gives the idea...

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 42fb1f5..6bb3eff 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -191,9 +191,10 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 --only::
 	Make a commit only from the paths specified on the
 	command line, disregarding any contents that have been
-	staged so far. This is the default mode of operation of
-	'git commit' if any paths are given on the command line,
-	in which case this option can be omitted.
+	staged so far.  The state of other files in the index is
+	preserved and will not affect the commit.  This is the
+	default mode of operation of 'git commit' if any paths are given
+	on the command line, in which case this option can be omitted.
 	If this option is specified together with '--amend', then
 	no paths need to be specified, which can be used to amend
 	the last commit without committing changes that have
