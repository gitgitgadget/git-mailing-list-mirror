From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Index format v5
Date: Mon, 21 May 2012 22:30:18 +0200
Message-ID: <20120521203018.GA57389@tgummerer.unibz.it>
References: <20120510121911.GB98491@tgummerer>
 <4FAC0633.90809@alum.mit.edu>
 <20120511171230.GA2107@tgummerer>
 <4FB01080.6010605@alum.mit.edu>
 <20120514150113.GD2107@tgummerer>
 <4FB1746A.6090408@alum.mit.edu>
 <20120515134916.GA2074@tgummerer.unibz.it>
 <4FB334C7.2070201@alum.mit.edu>
 <20120516215407.GA1738@tgummerer.surfnet.iacbox>
 <4FB73268.4020204@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	peff@peff.net, spearce@spearce.org, davidbarr@google.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 21 22:31:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWZG3-0006K5-RF
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 22:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758497Ab2EUUa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 16:30:29 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:40028 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758465Ab2EUUaX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 16:30:23 -0400
Received: by wibhj8 with SMTP id hj8so2739566wib.1
        for <git@vger.kernel.org>; Mon, 21 May 2012 13:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dTxozoCLUegXWeGOlOQJ1aT1ibrC3UVVM4mlApl5Hf4=;
        b=pRuUbNXPsGG3e3glJ9US15mkKo+qjXU8vr2On+1Q8gQ3Ofqrb7OuqIRg/zfb3QP0f0
         KBVxUx4FGobWjL51+hEpw5MNkvYzL+VmnOcv9pLTVha09vDfWPuA1UqnXXnmzCWScJcm
         jpyFveEp7tdjCKzzDsc39gtIC5O5NRKCkvN+yEzdbV0CrjvT0l8zgbrnep/At7hZ9oxG
         Zg5+THWKHzfh4dItIpPQnJTNnmEHx9axVf7V+o/XWBr8Ka3c9RWLXe55mZ3hOEGC6g1c
         IX57lQaOaQnJR2NP87RJ5idGmOAqJVRE+bsQqVOxRjT3O8r56oGosV2Rl2Zm9ZmLU7mZ
         9FQQ==
Received: by 10.216.196.218 with SMTP id r68mr280046wen.122.1337632221363;
        Mon, 21 May 2012 13:30:21 -0700 (PDT)
Received: from localhost (host84-52-dynamic.14-87-r.retail.telecomitalia.it. [87.14.52.84])
        by mx.google.com with ESMTPS id dg2sm43482657wib.4.2012.05.21.13.30.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 May 2012 13:30:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FB73268.4020204@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198126>



On 05/19, Michael Haggerty wrote:
> I think it is possible to remove the last magic number and also to
> make the CRC handling easier.  I have pushed some suggested changes
> to github [1]:
> 
> 1. With the current code, trying to read a file that is less than 24
> bytes long would result in a struct.error (because it would try to
> unpack a string that is shorter than the struct) whereas the
> underlying error in this case should almost always be reported as a
> signature error.  So it is correct to read the signature separately
> from the rest of the header, but it is even more correct to check
> the signature (including its length) before reading on.

I looked at the current git code, and the filesize is used for
checking if the index size is big enough. I'll implement it that way
in the prototype for now.

> 2. I introduce a class CRC to hold checksums, so that (a) the code
> for handling checksums can be encapsulated, and (b) an instance of
> this class can be passed into functions and mutated in-place, which
> is less cumbersome than requiring functions to return (data, crc)
> tuples.  This, in turn, makes possible...
> 
> 3. ...a new function read_struct(f, s, crc), which reads the data
> for a struct.Struct from f, checksums it, and returns the unpacked
> data.  This function is more convenient to use than the old
> read_calc_crc().
> 
> 4. The checksum instance can also be made responsible for verifying
> that the next four bytes in the file agree with the expected
> checksum.  This removes some more code duplication.  (See
> CRC.matches().)
>
> 5. You read the extension offsets using CRC_STRUCT.size, which is
> technically correct but misleading.  In fact, the extension offsets
> should be documented using their own EXTENSION_INDEX_STRUCT.  Also,
> it makes more sense to store the unpacked integer offsets to
> extoffsets rather than the raw 4-byte strings.
> 
> 6. With a couple of more minor changes it is possible to replace the
> magic number "24" in read_index_entries().  With this change the
> computation is documented very explicitly and is also (somewhat)
> robust against future changes in the format.
> 
> Look over my changes and take whatever you want.

Thanks, I didn't merge them directly, but I took the basics out and
merged them with my code.

--
Thomas
