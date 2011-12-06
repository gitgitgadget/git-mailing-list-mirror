From: Bill Zaumen <bill.zaumen@gmail.com>
Subject: Re: Suggestion on hashing
Date: Mon, 05 Dec 2011 19:47:03 -0800
Message-ID: <1323143223.1745.67.camel@yos>
References: <1322813319.4340.109.camel@yos>
	 <CACsJy8CO1GtpZVo-oA2eKbQadsXYBEKVLfUH0GONR5jovuvH+Q@mail.gmail.com>
	 <alpine.DEB.2.00.1112060146121.15104@hoki.goeswhere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Chris West (Faux)" <faux@goeswhere.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 04:47:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXlzv-0005LP-7W
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 04:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932889Ab1LFDrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 22:47:10 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52232 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932878Ab1LFDrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 22:47:09 -0500
Received: by iakc1 with SMTP id c1so3035905iak.19
        for <git@vger.kernel.org>; Mon, 05 Dec 2011 19:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=HGW9yBQWR9ZCMbxrNdbpa+F5j+4j2atTtq0zUvJk9U4=;
        b=lweaUgHKcwSYRB1nlxzlETx8j3wZGYM9aQDg8df0feshKelucVzKoT+Ul/1qqMbwSc
         vamsZgC4mfNBzeC1Mka2IVnxoU1Uz4lsbS/8+nZ4wi2lXgEBGJ1At/U0cx2srPn5aYpc
         aHE0Q54VIU1zpVfcUiYEtT4yFd6AgnmtD4dgs=
Received: by 10.50.192.197 with SMTP id hi5mr13199673igc.16.1323143228535;
        Mon, 05 Dec 2011 19:47:08 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id eb23sm84352726ibb.2.2011.12.05.19.47.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Dec 2011 19:47:07 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1112060146121.15104@hoki.goeswhere.com>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186309>

When I went through the code, I noted that SHA-1 hashes are
currently used for the following:

   * object IDs
   * authentication (something to sign using public-key encryption)
   * data integrity (basically a really good checksum).

While there are lot of 20-byte arrays of unsigned char, many of those
are associated with lookups.  You might want to look at the
number of places that git_SHA1_Init is called (there aren't all that
many of those, and that function indicates the points where SHA-1
hashes are being created).

While a few things I tried were complete false starts (kept those
out of the preliminary patches I sent), I managed to store
a CRC (which you can treat as a place-holder for a real message
digest) for each SHA-1 hash in a pack file, but I did it by
creating a separate file (extension ".mds") and that worked.
I looked into modifying pack files, and that was too messy given
that you'd want older version to still work with newer remote
repositories.  The other factor is that the "mds" files are
computed locally, and at the same time that you create an "idx" file.
The formats of the "pack" and "idx" files don't change.

I've just started on replacing the CRC I used with real message
digests, making new digests easy to add. The plan is to initially
make it work with both a CRC and SHA-1 (the CRC so I can test it
easily by comparing new and old versions to show that nothing
changed when it shouldn't have), and because Git already implements
SHA-1.

I should complete my changes.  If we are lucky, maybe the changes I'm
trying would solve some of the problems you mentioned with pack files.
At least I can store the digests in a way that doesn't break the log
and fsck operations (it went through all the test suites, with only
minor modifications for things like counting the number of files in
particular directories).

If you make changes to commit objects, fixing the test scripts is a 
pain - there are a number of places where SHA-1 values are hard-
coded, and those have to be replaced.

Bill

On Tue, 2011-12-06 at 01:56 +0000, Chris West (Faux) wrote:
> Nguyen Thai Ngoc Duy wrote:
> > SHA-1 charateristics (like 20 byte length) are hard coded everywhere
> > in git, it'd be a big audit.
> 
> I was planning to look at this anyway.  My branch[1] allows
>   init/add/commit with SHA-256, SHA-512 and all the SHA-3 candidates.
> 
> log/fsck/etc. are all broken.  Don't even dare try packs.  Fixing things
>   is painful but not impossible.  I'm not convinced the task is even
>   remotely insurmountable.
> 
> (This is not a request-for-comments, just an informational notification.
>   It does not even attempt to address compatability or the like.)
