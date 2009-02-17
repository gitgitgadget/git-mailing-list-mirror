From: Elijah Newren <newren@gmail.com>
Subject: Re: fast-import, merges, and file changes -- lack of clarity in docs, 
	possible minor bug, or PEBKAC?
Date: Mon, 16 Feb 2009 22:47:09 -0700
Message-ID: <51419b2c0902162147y588ad4dfk58271f3434dea66c@mail.gmail.com>
References: <51419b2c0902161628x7a3475e6p2a70310e5b294444@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 06:48:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZIox-0002f9-6K
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 06:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbZBQFrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 00:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbZBQFrL
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 00:47:11 -0500
Received: from mail-gx0-f222.google.com ([209.85.217.222]:48547 "EHLO
	mail-gx0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbZBQFrL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 00:47:11 -0500
Received: by gxk22 with SMTP id 22so3823396gxk.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 21:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QzZjXLgq3zEYJhER2AcUHI38vuIG5svsvungfPKAn4o=;
        b=Bmu7LGUKIEqch+1a+oLWpolZg9a+e1Xf53w+CtGp8jcPvYW8Wa+1lTL3WRLmGbEs+F
         UaIANPvmnHXlOW96pnzetcWjOwd1QHSlWDWDJJWjr2wyoq4U+lk7adNgyZjg76RC5UYK
         F156hmQpw6yaB9L6t7GRJB6bhN3pIrSfHzqAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RPJ8RwSfgM5FQ5ZDQAHOigyX1tWvap9p7DlwZaU5hX01AuT78aeIe0pRpHkU21orIC
         cOu5eFTIYhft47H9aEmL6EMv82b8fPs6f5WV9McbrqSWiH1GVk5ArI2j6IUaYMirBz9l
         IIrBLSjJqbTQM9PObBKtyakFJe4+kDtTS6eDI=
Received: by 10.150.52.2 with SMTP id z2mr689978ybz.236.1234849629329; Mon, 16 
	Feb 2009 21:47:09 -0800 (PST)
In-Reply-To: <51419b2c0902161628x7a3475e6p2a70310e5b294444@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110311>

I think I've at least partially discovered the answer my own
question(s), so I figured I'd document them in case anyone else was
wondering...

On Mon, Feb 16, 2009 at 5:28 PM, Elijah Newren <newren@gmail.com> wrote:
> It appears the documentation for fast-import does not specify the
> basis on which a commit command's file changes (filemodify,
> filedelete, filecopy, or filerename) are relative to.
<snip>
> Is this intentional?  I believe we could change this behavior without
> breaking backward compatibility with older fast-export output streams,
> since such older streams would simply be providing redundant
> information.  But is there a reason for this behavior that I'm
> missing?

It is documented...though implicitly in discussion of other commands.
In particular, "...a `merge` command may be used instead of `from` to
start the commit with an empty tree" and later "If the `from` command
is omitted when creating a new branch, the first `merge` commit will
be the first ancestor of the current commit, and the branch will start
out with no files."  This implies that the files of a `merge` parent
are ignored and any content must from that parent that is contained in
the commit must be explicitly spelled out to be included.

Also, as far as backward compatibility, my suggestion would not be
compatible; deletions involved in such merges would be handled by
current fast-export streams by simply omitting the file in the list of
file changes in the merge commit.  My suggestion would require
explicitly specified file deletion to ensure its removal.

So, it appears this is intentional, any behavior change such as I
suggested would require different/new syntax, and would require
support in fast-export too for my purposes.  That certainly makes my
git-fast-filter script (a script in a pipeline between fast-export and
fast-import designed to act somewhat like filter-branch but with
better performance on my large repositories) much harder.  Oh, well.


Elijah
