From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: A look at some alternative PACK file encodings
Date: Wed, 6 Sep 2006 20:04:02 -0400
Message-ID: <9e4733910609061704s429c449etcf0475841556c26b@mail.gmail.com>
References: <44FF41F4.1090906@gmail.com>
	 <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com>
	 <44FF5C27.2040300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 02:04:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL7NU-00025q-E0
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 02:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWIGAEH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 20:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWIGAEH
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 20:04:07 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:8533 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030265AbWIGAED (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 20:04:03 -0400
Received: by py-out-1112.google.com with SMTP id n25so29652pyg
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 17:04:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JptGNCbV/4UP8Ge9ltbZkQYLqY51pvhUmX/Q4+A2i1EVnaqhrEVAGaHCRbQdqVPm3tPEyCPalg6mfbSCXmHku8Ab1QsKJyM8KCCAfZoK9A/oUDwkhthHlX+d0tZDpjWdSTZQaecenp18EassxFrO9a0KNS6DbLYZMiYK7k4sKKM=
Received: by 10.35.46.6 with SMTP id y6mr102900pyj;
        Wed, 06 Sep 2006 17:04:02 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Wed, 6 Sep 2006 17:04:02 -0700 (PDT)
To: gitzilla@gmail.com
In-Reply-To: <44FF5C27.2040300@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26573>

On 9/6/06, A Large Angry SCM <gitzilla@gmail.com> wrote:
> Jon Smirl wrote:
> > On 9/6/06, A Large Angry SCM <gitzilla@gmail.com> wrote:
> >> TREE objects do not delta or deflate well.
> >
> > I can understand why they don't deflate, the path names are pretty
> > much unique and the sha1s are incompressible. By why don't they delta
> > well? Does sorting them by size mess up the delta process?
>
> My guess would be the TREEs would only delta well against other TREE
> versions for the same path.

I would have thought that the TREE delta code would have already taken
this into account. Is there enough info around to match up all of the
TREEs for a specific path into a delta chain?

The repack code could build a model of the tree as it is repacking,
that is what fast-import does. If you have a model of the tree then
when you change a TREE node you track the last sha1 that corresponded
to that directory path. Now you know what to diff to.

> > Shawn is doing some prototype work on true dictionary based
> > compression. I don't know how far along he is but it has potential for
> > taking 30% off the Mozilla pack.
>
> Just looking at the structures in non-BLOBS, I see a lot of potential
> for the use of a set dictionaries when deflating TREEs and another set
> of dictionaries when deflating COMMITs and TAGs. The low hanging fruit
> is to create dictionaries of the most referenced IDs across all TREE or
> COMMIT/TAG objects.

Doing this will get 4-7% according to our small tests, to get more you
need a different type of compression algorithm. For true dictionary
based compression you parse all of the input documents into words. The
words are put into a single giant huffman table. Then the huffman
codes for the words are concatenated together to form the compressed
document. This is one of the highest possible compression methods
since it takes into account you are compressing something that is
human readable. gzip is sort of like this but the dictionary is
limited to 32KB.

Search engines use true dictionary compression since it is easy to add
on search indices to the compressed data. For a search index you make
a bit vector that corresponds to each word in the dictionary and then
set a bit if that document number contains the word. The vectors and
dictionary are stored compressed. There are algorithms for doing
and/or on the compressed vectors. The and/or stage lets you identify
likely hits, you retrieve those and then do an exact match on the
search terms to be sure.

-- 
Jon Smirl
jonsmirl@gmail.com



-- 
Jon Smirl
jonsmirl@gmail.com
