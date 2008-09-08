From: "Jaap Suter" <git@jaapsuter.com>
Subject: Storing Large Flat Namespaces
Date: Sun, 7 Sep 2008 18:58:30 -0700
Message-ID: <21d738060809071858p703149ccmbec0276ad4ad8f88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 04:03:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcW5m-0007TS-DK
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 04:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbYIHB6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 21:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbYIHB6d
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 21:58:33 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:49014 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbYIHB6c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 21:58:32 -0400
Received: by yx-out-2324.google.com with SMTP id 8so690267yxm.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 18:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=ybJBGoDsxYc0kftLG3pNbKy3IesF4hwHgGjGWh4Kh4c=;
        b=RG90hZepctbcPZmb8PYm9LZQVfuQxUXUX3gT8iQ8NjZgV0F5qcRLc76fOaicqNHeOt
         iqkayess+Q9lyMNVG+vIyjdze7+xhrAeyMmyb7aHX9lJ8Xs9S9o+9RF9+URoqaCB3me+
         +Y7lzEX7hSzrFpR70IW6zZMdpmzwFTOxmYok0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=PJKFDEIYCmn+zW6yQG4N8sqAMQhh3CRy0MCyZ+5XmeRwTp1gNdk1XnDphukepOh7yV
         E8IQimHYQiJ3PcIpsvOx0GWWFreFg5pqDIHWjdVJRK6en2n5l5NNcVV4uItPuDF7aCIR
         8UW7ghTdq682Ikm2ATg6VIwBNq5qyXLPE4/Co=
Received: by 10.150.197.8 with SMTP id u8mr11059658ybf.193.1220839110335;
        Sun, 07 Sep 2008 18:58:30 -0700 (PDT)
Received: by 10.150.152.10 with HTTP; Sun, 7 Sep 2008 18:58:30 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 7d19377c91c6aaea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95205>

Hello,

I'm investigating the possibility of using Git to store a large flat
namespace. As an example, imagine a single directory containing
thousands or millions of files, each named using a 16-byte guid,
evenly distributed.

I'm aware that the Git object model makes various trade-offs,
typically in favor of managing source-tree layouts - which it does
extremely well. However, perhaps it is possible to carry some of Git's
features as a content revision tracker over to other storage
applications?

Currently, tree objects for large flat directories are quite large.
Doing a git-init, git-add, git-push on a flat directory with 10,000
files creates a tree object that is 24 kilobytes compressed. Any
change to a single file would create a whole new tree object, 24
kilobytes every time.

The obvious thought is to "virtualize" or "tree-ify" the namespace,
similar to how Git stores its own loose objects. (Is there a proper
name for this technique?)

This archive thread touches on that idea:

   http://kerneltrap.org/mailarchive/git/2006/2/8/200585

In particular (quoting Linus):

   "Final note: this means, for example, that git is relatively bad at
tracking a "hashed" nested file directory (like the one git itself
uses), because new files will end up randomly appearing in every
directory, and no directory is ever "stable".

I wonder how bad it is, so I did some calculations. What if Git could
"virtualize" the namespace when going from the working directory to
the object store, without the user ever realizing it. In other words,
Git would insert "fake" tree nodes to split apart large directories.
This leaves the question of how useful a working directory with a
million loose files is, but pretend for a moment that I have a Git
frontend that doesn't do full check-outs to a file system but allows a
user to grab single objects from the object store straight into
memory.

Ok, this is all back-of-the-napkin:

   H = sizeof(hash) = 20 bytes.
   G = sizeof(name) =  16 bytes.

   N = number of assets = let's say one million (hypothetical)

That means the theoretical minimum size of a tree object (without
virtualization) is:

  (H + G) * N = 36 megabytes

If we virtualize, using these parameters:

   B = number of bits we chop from the head of the filename, to create
the tree prefix (i.e., internal nodes)
   D = depth of virtualization (number of internal nodes we need to
traverse before we hit a bucket)

   (...in git's loose object store, B equals 8 and D equals 1.)

We get the following formulas:

                      2^(B*D)  = number of buckets (leaf tree objects)
                N / (2^(B*D)) = number of files per bucket
   (H+G) *  N / (2^(B*D)) = size of a bucket

     2^B * H = size of an internal node

The storage overhead of a single file commit then becomes the size of
a new bucket plus the size of the internal nodes back to the root.
I.e.,

    (D * (2^B) * H)     +     (H+G) * N / (2^(B*D))

The other interesting parameter is the total number of objects
involved in just virtualization overhead. For simplicity's sake, the
number of leaf objects is a good metric.

For different values of B and D, this leads to the following overhead
on a million-file directory.

    B = 0, D = 0 (how git treats large flat directories today)
        number of buckets: 1
        single change commit overhead: 36 megabyte

    B = 8, D = 1:
        number of buckets: 256
        single change commit overhead: 145736 bytes

    B = 8, D = 1:
        number of buckets: 65536
        single change commit overhead: 10780 bytes

    B = 3, D = 4:
        number of buckets: 4096
        single change commit overhead: 9424 bytes

Ultimately, the trade-off is between how may objects are involved in
the tree-ification, how many lookups need to be done to get an object,
and the storage overhead of commits.

The more I think about it, the less certain I am this kind of
data-structure is suitable for my application. I guess Linus's quote
at the top summed it up.

I'm wondering if anybody else has put any thought into this kind of
thing, and has suggestions for alternate data structures that could
enable Git to store large flat namespaces.

Thoughts are welcome. Or am I out to lunch?

Thanks,

Jaap Suter - http://jaapsuter.com
