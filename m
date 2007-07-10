From: "David Frech" <david@nimblemachines.com>
Subject: Re: [PATCH] Support wholesale directory renames in fast-import
Date: Tue, 10 Jul 2007 12:55:46 -0700
Message-ID: <7154c5c60707101255k7fcd207fg62f1c59518ba5039@mail.gmail.com>
References: <7154c5c60707091809y7e0b67d5u3f94658b7e814325@mail.gmail.com>
	 <20070710031036.GA9045@spearce.org>
	 <7154c5c60707092116p70aaeb8l90cda9265311b999@mail.gmail.com>
	 <20070710140338.GA18450@informatik.uni-freiburg.de>
	 <20070710141442.GM4436@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=" 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 10 21:56:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8LoV-0007Cb-K9
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 21:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761298AbXGJTz4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 15:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761165AbXGJTz4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 15:55:56 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:59440 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761254AbXGJTzu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 15:55:50 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2002393wah
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 12:55:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=cYzKvgTecNm7+Tb2+7eqwi+5UHcJxy4HexXkKWSe/y226umxj2rVanuExsmT/R/A/JgHbC7MtliwaU70RqidhMMVwZj/HancJ3M4W9DnfN1EBbQ5WgBBZjPMTDdiqOHmkro4gscVzv9HwCrBDG7u7lUTT2UDihbU1844bfIr8FM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=bRzyk14RhDxr3a64CkjAhyNBLbPiy1k7QL/JXELUOt/M6t7NrbpmBs9DdgNgDFy08rx6Mbq7O8u5Tt2YyEM+kRdAxlCdMHBU4ifPO1gQN7BAk6EDPIV9psuBHBeWfBV25qXHeYvpL2zNh5RgpNFU+zcUm+qPr3OFl83qXECjtEU=
Received: by 10.114.126.1 with SMTP id y1mr4512460wac.1184097346509;
        Tue, 10 Jul 2007 12:55:46 -0700 (PDT)
Received: by 10.115.59.9 with HTTP; Tue, 10 Jul 2007 12:55:46 -0700 (PDT)
In-Reply-To: <20070710141442.GM4436@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: 4c9189bad9e9f293
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52109>

Hmm. I think Uwe is right. Copy is probably the "right" primitive, and
rename can always be synthesized from copy+delete.

Since Subversion is built around the idea of "cheap copies" there is
no incentive for them to represent renames other than as "copy, then
delete".

But isn't the same true in a way of git? If I copy a directory (a
tree), then the new tree is the same tree - it has the same SHA-1
hash, so I can simply refer to the existing object. Same for file
blobs.

Subversion dump files have *lots* of copies. Might be nice to be able
to feed these directly into fast-import and have it DTRT, esp if it
was smart about sharing identical data structures.

- David

On 7/10/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Uwe Kleine-K??nig <ukleinek@informatik.uni-freiburg.de> wrote:
> > David Frech wrote:
> > > Now my challenge is that the svn dump doesn't *actually* say "rename
> > > a/ to b/"; it says "copy a/ to b/; delete a/", so I have to infer the
> > > rename.
> >
> > I don't know fast-import very well, but why not doing exactly what the
> > dump file suggests:  copy a b; delete a ?
>
> Because there is no copy operator in fast-import.  So you cannot
> do "copy a b".  Apparently that's what I should have implemented,
> as rename in Git really is as simple as the copy/delete pair.  Ugh.
>
> Copy isn't really that hard, it just can't be nearly as efficient as
> rename, as copying a subtree will force me to either duplicate data
> in memory or reload trees from disk to duplicate data in memory.
> But its a copy, so data duplication is expected.  ;-)
>
> I'll implement a copy opertor soon.  Shouldn't be too difficult.
> Maybe someone else would like to take a shot at implementing it...
>
> --
> Shawn.
>


-- 
If I have not seen farther, it is because I have stood in the
footsteps of giants.
