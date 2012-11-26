From: David Michael Barr <b@rr-dav.id.au>
Subject: Re: [RFC] pack-objects: compression level for non-blobs
Date: Mon, 26 Nov 2012 23:35:48 +1100
Message-ID: <575D346F7B9B41D4848315209DF07302@rr-dav.id.au>
References: <1353911154-23495-1-git-send-email-b@rr-dav.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: David Michael Barr <b@rr-dav.id.au>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 13:36:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcxv0-0001oC-Aa
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 13:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424Ab2KZMfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 07:35:55 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37393 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755357Ab2KZMfy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 07:35:54 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so5019240pad.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 04:35:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject:x-mailer
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:x-gm-message-state;
        bh=kkvNk0KXbgDCDmHG2yZG0bQHf6ElyfyDgP+sZ0mEXM8=;
        b=gBncvhJxUZ7O+PqNKLYNAaHNKa3dOox8+w6FLqu0GgZb2E1lTyGIgnHni3/ls1w6p7
         RTJuKZ4c8+fH7/nXxlxN1/pwFjFuZNJu+hdYmEXdDKn/C7GkiEVhUXpiay01nndjJPEn
         bPjj+31oivwqMrWLAybqvewS4ApNVIsgLukVcSh6fPEIPn0PLf4j318uJSmJxzwseu7V
         cN/g/73+ured1bnUpWfZVhwQYC1zS5O4D9ZvS6E5GwjVecUXTFE1QTPUIwWSgiI4ga35
         fAS7XkeobIG8ipfTkE0uYwbnEcYGjjYAnbK+EBr40jgozvSNyhjnpIaFWflWRqrEdvWf
         e8lw==
Received: by 10.66.89.9 with SMTP id bk9mr32233348pab.67.1353933353469;
        Mon, 26 Nov 2012 04:35:53 -0800 (PST)
Received: from [192.168.0.12] (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id z10sm7449178pax.38.2012.11.26.04.35.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Nov 2012 04:35:52 -0800 (PST)
In-Reply-To: <1353911154-23495-1-git-send-email-b@rr-dav.id.au>
X-Mailer: sparrow 1.6.4 (build 1176)
Content-Disposition: inline
X-Gm-Message-State: ALoCoQnh9C8m9HTILzmk41rJlDPAFVabUGGXw3vf876qg/18dmJPORM9bs98YaUM9nCkynY62V6n
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210435>

> Add config pack.graphcompression similar to pack.compression.
> Applies to non-blob objects and if unspecified falls back to pack.compression.
> 
> We may identify objects compressed with level 0 by their leading bytes.
> Use this to force recompression when the source and target levels mismatch.
> Limit its application to when the config pack.graphcompression is set.
> 
> Signed-off-by: David Michael Barr <b@rr-dav.id.au (mailto:b@rr-dav.id.au)>
> ---
> builtin/pack-objects.c | 49 +++++++++++++++++++++++++++++++++++++++++++++----
> 1 file changed, 45 insertions(+), 4 deletions(-)
> 
> I started working on this just before taking a vacation,
> so it's been a little while coming.
> 
> The intent is to allow selective recompression of pack data.
> For small objects/deltas the overhead of deflate is significant.
> This may improve read performance for the object graph.
> 
> I ran some unscientific experiments with the chromium repository.
> With pack.graphcompression = 0, there was a 2.7% increase in pack size.
> I saw a 35% improvement with cold caches and 43% otherwise on git log --raw.

I neglected to mention that this is a WIP. I get failures with certain repositories: 

    fatal: delta size changed

--
David Michael Barr
