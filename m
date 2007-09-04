From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Calculating tree nodes
Date: Tue, 4 Sep 2007 16:21:47 +1200
Message-ID: <46a038f90709032121v54454c6fi500ee15497eec85c@mail.gmail.com>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com>
	 <20070904025153.GS18160@spearce.org>
	 <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
	 <Pine.LNX.4.64.0709040439070.28586@racer.site>
	 <9e4733910709032054y4407ce62o6b21935502bfacdb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 06:21:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISPvG-000102-Eb
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 06:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbXIDEVu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 00:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbXIDEVu
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 00:21:50 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:29005 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbXIDEVt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 00:21:49 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1540344fkz
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 21:21:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YBSdZ3fpUzePo5RkV387khk3Ea//nFkkNf/2/Y+/JOCCr54C8eGkcZPw5uED6YLJ1EkNxMJVKrQZmTwN1g9+YfG9kT95Mt8BcAJL3Shc7/kffR98JmLQY2c+l09i4wt94pbIlqBZa9+UEwFSGz46E5l/hKLbbrQ1oEnY015PrGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B5OypDwzvq6prg0SEAtJB85qnYVxEoLljuA/Dz+PagSHASWpXZrzJjHhqkMSaNyd+Q+ZpY8C+Fi61HwZT2Eg+zDGOzWjhp4RPZ9sMJIWqdxq2Gxbt897XFCZDBFvPdb6iuq9mvjaUrtlS9Cir/llJ///FvVLiG3ZC8MKZJDw2c8=
Received: by 10.82.106.14 with SMTP id e14mr5414018buc.1188879707986;
        Mon, 03 Sep 2007 21:21:47 -0700 (PDT)
Received: by 10.67.40.9 with HTTP; Mon, 3 Sep 2007 21:21:47 -0700 (PDT)
In-Reply-To: <9e4733910709032054y4407ce62o6b21935502bfacdb@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57519>

On 9/4/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > Yes.  For performance reasons, since a simple commit would kill you in any
> > reasonably sized repo.
>
> That's not an obvious conclusion. A new commit is just a series of

Hi Jon!

If you search the archives you'll find Linus explaining that the
initial git had all the directory structure in one single "tree"
object that held all the paths, not matter how deep. The problem with
that was taht every commit generated a huge new tree object, so he
switched to the current "nested trees" structure, which also has the
nice feature of speeding up diffs/merges if whole subtrees haven't
changed.

> edits to the previous commit. Start with the previous commit, edit it,
> delta it and store it. Storing of the file objects is the same. Why
> isn't this scheme fast than the current one?

I think you're a bit confused between 2 different things:

 - git is _snapshot_ based, so every commit-tree-blob set is
completely independent. The "canonical" storage is each of those
gzipped in .git/objects
 - however, for performance and on-disk-footprint, we delta them (very
efficiently I hear)

So if you ask the GIT APIs about a tree, you end up dealing with the
nested trees I describe. Similarly, if you ask for a blob, you get the
blob. But internally git _is_ delta-compressing them.

It's not compressing them immediately -- only when you run git gc. But
from an API perspective, you don't have to worry about that.

HTH


martin
