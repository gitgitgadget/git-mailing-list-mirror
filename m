From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH decompress BUG] Fix decompress_next_from() wrong argument value
Date: Sat, 12 Jan 2008 08:06:35 +0100
Message-ID: <e5bfff550801112306g6b8127dft80484c9fd8554992@mail.gmail.com>
References: <e5bfff550801111247l1ccf171ene5b53b8d6841a864@mail.gmail.com>
	 <7vfxx3290v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 08:07:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDaSY-0005N5-0h
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 08:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756846AbYALHGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 02:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753740AbYALHGi
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 02:06:38 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:47742 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbYALHGi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 02:06:38 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1163518rvb.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 23:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kA6SY1QOQ7cDr0gNJZEzqnOMCGF2kcZL9ygBQVhMmmA=;
        b=bmjmTrK2+/ptfSat9iFK3MLBlZyFgKPjQd1j0AzUVJtpnJR0HHpAqQR1oy9er5LL+Ef26aRUbYi21zCo94tqIpZXjaWtIuoiN1kZxzqjEXbgzjl+dzPIfzFds+OUjiFVyS5lMbbXXEQQbsr2owy5GdNA/flU3xPvaZ/hZvCA19c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XGFhyXRNmU1Sy4bWxjso91SnSR5LaZFDT9wkezUCET+Zqvrw/lbfmT7dOGw9i9fGCc8KcgOxx1dVYRncm2ixkm1Ys/qD5w1eMre3UOn5VMwe4CxmfEQ6IbDfPaGvBgMnFk0vWngZFYjbAfuApLO8EmoMZKurfbvvR8pK0Csy5/Q=
Received: by 10.141.42.10 with SMTP id u10mr2517323rvj.256.1200121595755;
        Fri, 11 Jan 2008 23:06:35 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Fri, 11 Jan 2008 23:06:35 -0800 (PST)
In-Reply-To: <7vfxx3290v.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70278>

On Jan 12, 2008 1:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Next time around, please mark the patch on the Subject: line to
> be squashed to your earlier [PATCH 5/6] before [PATCH 6/6].
>

Very sorry for wasting your time I should have been more clear that it
was a bug in the new series. And of course this series is not to be
applied to stable git.

The only two points in the current code in master that I would like to
report to you are a _possible_ missing inflateEnd() before a new
inflateInit(), but I am not confident with that part of code to judge
if is a bug or not, anyway that's the _possible_ diff.

diff --git a/http-push.c b/http-push.c
index 55d0c94..e0a4cc6 100644
--- a/http-push.c
+++ b/http-push.c
@@ -307,6 +307,7 @@ static void start_fetch_loose(struct
transfer_request *request)
 	/* Reset inflate/SHA1 if there was an error reading the previous temp
 	   file; also rewind to the beginning of the local file. */
 	if (prev_read == -1) {
+		inflateEnd(&request->stream);
 		memset(&request->stream, 0, sizeof(request->stream));
 		inflateInit(&request->stream);
 		SHA1_Init(&request->c);
diff --git a/http-walker.c b/http-walker.c
index 2c37868..a18067c 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -182,6 +182,7 @@ static void start_object_request(struct walker *walker,
 	/* Reset inflate/SHA1 if there was an error reading the previous temp
 	   file; also rewind to the beginning of the local file. */
 	if (prev_read == -1) {
+		inflateEnd(&obj_req->stream);
 		memset(&obj_req->stream, 0, sizeof(obj_req->stream));
 		inflateInit(&obj_req->stream);
 		SHA1_Init(&obj_req->c);



I have not created a proper patch becuase I don't know if the missing
inflateEnd(), it is a bug or not. The above diff it's just a way to
point you quickly and hopefully clearly to the interested code .


Sorry again for the trouble I had caused to you. For sure I will be
much more careful in the future to be clear in the subjects. And also
sorry for my rant but it was very late and I was tired after fighting
with that _my_ bug.

Marco
