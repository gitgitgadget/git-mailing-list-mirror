From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH decompress BUG] Fix decompress_next_from() wrong argument value
Date: Fri, 11 Jan 2008 21:47:04 +0100
Message-ID: <e5bfff550801111247l1ccf171ene5b53b8d6841a864@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 21:47:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDQms-00021g-5p
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 21:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759555AbYAKUrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 15:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759335AbYAKUrF
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 15:47:05 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:27371 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759264AbYAKUrE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 15:47:04 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1046832rvb.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 12:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=qoSBrXaF5hP6SGsr6Jvqro6MlPP1YcCaK3r1ABtc1K0=;
        b=G1RUnsiS7yApftUBfoD8WFPDvuhnHH2JuOm+VU8bIxM8s94a/2f4BfsiY7GlFsme5dJf8ORU0c0s4uc8mrYkpgcM/1u5lo0SXGBU1ldAeic0tiFoyhqoVikQNegWS0ixu49W5WXVkDrDYQu5pnDDX/2/NTbv42dZPa9PeJ1uMEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=c88wPqQIgDHfa/+lS5Y3lk8BmSqs0NoLMeTZPyoBdBeY9P7KnTMLQKKRzCPsJi/MY9NjSav82xXzOg7ZEN3ANuNmYG6mSF5cRFzQrBx0n0VC1mILpQuve5UkG0K2SudKw2HlSqnMY+9tY/fWLPz9ORlH4VAWEkkmQONghOgZE34=
Received: by 10.140.169.4 with SMTP id r4mr2285318rve.131.1200084424321;
        Fri, 11 Jan 2008 12:47:04 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Fri, 11 Jan 2008 12:47:04 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70198>

Function decompress_next_from() needs a pointer to a buffer
and the buffer size as arguments.

Interesting enough the function fill() that returns the
buffer pointer happens to modify also the buffer size,
stored in a variable at file scope.

So we need to guarantee fill() is called before to use buffer
size as argument in decompress_next_from()

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
Patch to be applied above decompress helper series.

Not to be pedantic, but have a function that gives two really
coupled values, as a buffer pointer and the size, the first as return
value and the second through a variable at file scope is not something
you are going to see advertised in the programming books!

Sorry for this little rant but this bug really made me crazy.

With this patch 'make test' runs with success!


 builtin-unpack-objects.c |    3 ++-
 index-pack.c             |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index f1a4883..72293ec 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -68,7 +68,8 @@ static void *get_data(unsigned long size)
 	decompress_into(&stream, buf, size);

 	for (;;) {
-		int ret = decompress_next_from(&stream, fill(1), len, Z_NO_FLUSH);
+		void* tmp = fill(1); // fill() modifies len, so be sure is evaluated as first
+		int ret = decompress_next_from(&stream, tmp, len, Z_NO_FLUSH);
 		use(len - stream.avail_in);
 		if (stream.total_out == size && ret == Z_STREAM_END)
 			break;
diff --git a/index-pack.c b/index-pack.c
index 30d7837..13b308d 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -173,7 +173,8 @@ static void *unpack_entry_data(unsigned long
offset, unsigned long size)
 	decompress_into(&stream, buf, size);

 	for (;;) {
-		int ret = decompress_next_from(&stream, fill(1), input_len, Z_NO_FLUSH);
+		void* tmp = fill(1); // fill() modifies input_len, so be sure is
evaluated as first
+		int ret = decompress_next_from(&stream, tmp, input_len, Z_NO_FLUSH);
 		use(input_len - stream.avail_in);
 		if (stream.total_out == size && ret == Z_STREAM_END)
 			break;
-- 
1.5.4.rc2.95.g0eaa-dirty
