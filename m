From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] fix repack with --max-pack-size
Date: Thu, 31 May 2007 17:01:38 -0700
Message-ID: <56b7f5510705311701i7f76f06cq82617f0cd1dfc562@mail.gmail.com>
References: <alpine.LFD.0.99.0705302114430.11491@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 02:01:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtuaT-00041s-8G
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 02:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498AbXFAABl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 20:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758351AbXFAABl
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 20:01:41 -0400
Received: from ik-out-1112.google.com ([66.249.90.179]:26777 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498AbXFAABk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 20:01:40 -0400
Received: by ik-out-1112.google.com with SMTP id b32so328343ika
        for <git@vger.kernel.org>; Thu, 31 May 2007 17:01:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bgFMvQtbbPuvJFdxhaJYLRN0STetYy+axT4DR87NcDnmrieEAPYvFa6lVEbusStuN9BEMc97Jyi34J4LzE9znKKkOermxsW3Z4yG4RxnhaWH5nhbXH9t+zl/BKOOL9matHOXQz5e+leW3ayW45ca9EST+sT5GdcVtPqFl2wYNww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rV0oreWvVkm8Awt4AkNrT0oE4yWnOU1g7xF50mWhwN51ROKp/ZwKlGKy2xfAUvYrW9pjKIj8DNo2TnLPO+Gxa1t7VFdirNFX/Zg02Jg0NR8p+/AVoy1K5zEDkIZmCs7uhUBs47NIHQfcjR5DYAN0nYwgVbn7b5f4ZkgA45fsjwk=
Received: by 10.78.172.20 with SMTP id u20mr805705hue.1180656098763;
        Thu, 31 May 2007 17:01:38 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Thu, 31 May 2007 17:01:38 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.99.0705302114430.11491@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48833>

On 5/30/07, Nicolas Pitre <nico@cam.org> wrote:
> Two issues here:
>
> 1) git-repack -a --max-pack-size=10 on the GIT repo dies pretty quick.
>    There is a lot of confusion about deltas that were suposed to be
>    reused from another pack but that get stored undeltified due to pack
>    limit and object size doesn't match entry->size anymore.  This test
>    is not really worth the complexity for determining when it is valid
>    so get rid of it.

This is very real.  A smaller fix would have been the hunk
@@ -408,7 +407,7 @@ static unsigned long write_object(struct sha1file *f,
>               buf = read_sha1_file(entry->sha1, &type, &size);
>               if (!buf)
>                       die("unable to read %s", sha1_to_hex(entry->sha1));
>-               if (size != entry->size)
>+               if (size != entry->size && type == obj_type)
>                       die("object %s size inconsistency (%lu vs %lu)",
>                           sha1_to_hex(entry->sha1), size, entry->size);
>               if (usable_delta) {
from the max-blob-size patch that hasn't converged yet.

Both pack splitting and blob-size limiting could cause a delta base
not to appear in the pack containing a delta using the base.
Then you get the size mismatch Nicolas discussed
when the real object must be used and its size doesn't match
the delta sized stored in the size field.
I first saw this with max-blob-size,  but only realized recently
that it also applied to max-pack-size.  Sorry I didn't post a patch;
we are swamped at the moment.

ACK [but I didn't review (2)].

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
