From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] Use new compress helpers in builtin-pack-objects.c
Date: Thu, 10 Jan 2008 23:26:09 -0800
Message-ID: <7vir204ycu.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550801101334p5df5adaerf0eeae02ddf28334@mail.gmail.com>
	<e5bfff550801102210g181a091s28725e24922b9b12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 08:26:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDEHu-0004ps-UP
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 08:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757280AbYAKH0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 02:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754581AbYAKH0T
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 02:26:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbYAKH0S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 02:26:18 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 34CF349E5;
	Fri, 11 Jan 2008 02:26:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F07649E3;
	Fri, 11 Jan 2008 02:26:11 -0500 (EST)
In-Reply-To: <e5bfff550801102210g181a091s28725e24922b9b12@mail.gmail.com>
	(Marco Costalba's message of "Fri, 11 Jan 2008 07:10:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70128>

"Marco Costalba" <mcostalba@gmail.com> writes:

> On Jan 10, 2008 10:34 PM, Marco Costalba <mcostalba@gmail.com> wrote:
>>
>> -               while (deflate(&stream, Z_FINISH) == Z_OK)
>> -                       /* nothing */;
>> -               deflateEnd(&stream);
>> -               datalen = stream.total_out;
>> -               deflateEnd(&stream);
>
>
> One thing I would like someone to clarify is why deflateEnd(&stream)
> is called two times ?

I'd call it an insufficient reviewing while accepting

    http://thread.gmane.org/gmane.comp.version-control.git/45996

In fact, the second deflateEnd() has always been returning
Z_STREAM_ERROR.  We just never checked the error return from
that particular deflateEnd().

The first one returns 0 for success.  We might want to tighten
the check even more to check that.

-- >8 --
pack-objects: remove redundant call to deflateEnd()

We somehow called deflateEnd() on a stream that we have called
deflateEnd() on already.

Noticed by Marco.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-pack-objects.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index a39cb82..ec10238 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -445,7 +445,7 @@ static unsigned long write_object(struct sha1file *f,
 			/* nothing */;
 		deflateEnd(&stream);
 		datalen = stream.total_out;
-		deflateEnd(&stream);
+
 		/*
 		 * The object header is a byte of 'type' followed by zero or
 		 * more bytes of length.
