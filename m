Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1FB15442C
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740465265; cv=none; b=bKSCTypQ0gbQF41hcFy64UjsjcHthQIyy/j71tugsWBvZfe40J5ostjhrA5ZoIAHmqYBIL6tOFLecgu97Z0JjMfDcoChTb2342xcajMz+uh67ZJ9g52/yTcRzY9g2VO2aksUNLL+vpeniJuYGks+cpvOvCSanMqEO4aSK+ZXxIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740465265; c=relaxed/simple;
	bh=ik2SPWNnMWrhYMZDC2w353MyLwsMuZ3iZ8SlNDXW0Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdTmUOgCp900MNhL9V2vRBXWUryuRzWPLdFV/EvbuQ9UqVm+VcamLod08qFHCWkKMGLYdtkgLsqwMpZJro8uJdWtwEwiCd5gUtTXvwTZBVeqrFsVwDXBXkOj/KeQXZvHHBCpqHoj49lRNIdiAYyUkqzuV1GpeJPrXmnhsTM9IKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EnAklLml; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EnAklLml"
Received: (qmail 24682 invoked by uid 109); 25 Feb 2025 06:34:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ik2SPWNnMWrhYMZDC2w353MyLwsMuZ3iZ8SlNDXW0Ao=; b=EnAklLmlfR6lJcKRHH8cNC/ZEOwPclhlidmWuFS4YBn6fgzeb69dNLfoDYcAnBUCEzy5CGT06DL/fhl4e+BY+wTX0HfjRiRBT/f+R54IGHmPtFNxjtNtAa08mmJ7jyV+m1FjkbLZ6WOmgY8bWEasm5nlZH0wU7KG7nu6q7Hx734bsw0avr7IwoOUBZEKB+vm8XNyhPUTERlPdi0aVErLDOoTTUDHgBeWcoGF+3YcGWnVj5NCWTI3nw9RrZWld8K3gZcpF185c1NrS3kMkCCJlNk2mlSewAzltpargi9dBHoXytjF4WfMdUe4KoDMq3oTBrw8zqZGZvNvOdKYGFsXdA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Feb 2025 06:34:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2809 invoked by uid 111); 25 Feb 2025 06:34:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Feb 2025 01:34:22 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 25 Feb 2025 01:34:21 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 10/10] unpack_loose_rest(): rewrite return handling for
 clarity
Message-ID: <20250225063421.GJ1293961@coredump.intra.peff.net>
References: <20250225062518.GA1293854@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225062518.GA1293854@coredump.intra.peff.net>

We have a pattern like:

  if (error1)
     ...handle error 1...
  else if (error2)
     ...handle error 2...
  else
     ...return buf...
  ...free buf and return NULL...

This is a little subtle because it is the return in the success block
that lets us skip the common error handling. Rewrite this instead to
free the buffer in each error path, marking it as NULL, and then all
code paths can use the common return.

This should make the logic a bit easier to follow. It does mean
duplicating the buf cleanup for errors, but it's a single line.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously could be squashed into the previous one, but I thought the
sequence of diffs made it easier to understand what was being changed.

 object-file.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index b7928fb74e..1df8870578 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1437,16 +1437,16 @@ static void *unpack_loose_rest(git_zstream *stream,
 		}
 	}
 
-	if (status != Z_STREAM_END)
+	if (status != Z_STREAM_END) {
 		error(_("corrupt loose object '%s'"), oid_to_hex(oid));
-	else if (stream->avail_in)
+		FREE_AND_NULL(buf);
+	} else if (stream->avail_in) {
 		error(_("garbage at end of loose object '%s'"),
 		      oid_to_hex(oid));
-	else
-		return buf;
+		FREE_AND_NULL(buf);
+	}
 
-	free(buf);
-	return NULL;
+	return buf;
 }
 
 /*
-- 
2.48.1.709.gf47ae731ff
