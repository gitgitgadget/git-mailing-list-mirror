From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git http-push and MKCOL error (22/409)
Date: Mon, 17 Aug 2009 17:09:43 +0800
Message-ID: <20090817170943.180dbedd.rctay89@gmail.com>
References: <200908161557.26962.thomas.schlichter@web.de>
 <7veirb5z9a.fsf@alter.siamese.dyndns.org>
 <be6fef0d0908162158y429c4b5fgb9138151446e39ef@mail.gmail.com>
 <200908170725.09592.thomas.schlichter@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	willievu <willievu@dev.java.net>,
	Sean Davis <sdavis2@mail.nih.gov>, git@vger.kernel.org
To: Thomas Schlichter <thomas.schlichter@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 11:10:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McyEK-0003Ui-Mt
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 11:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757526AbZHQJJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 05:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757502AbZHQJJ6
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 05:09:58 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:9312 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757467AbZHQJJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 05:09:57 -0400
Received: by rv-out-0506.google.com with SMTP id f6so751995rvb.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=EturgONosn3Q8ps0+Aw6Jq7gvpxKAFz1FlJP0w0L6qw=;
        b=VpFA27jvjVpDylFeEF+3i5LT6ZLLu3t3MtodJCIrA/Ad+LEWlfbROsOdJeZ58t76Pa
         PxbB/w0TzBrjDrOcKGgJeHzW+f2pwoR83Yq4UQRtsZ8aJuAQ+8L9yUllWzEK0SuX88hc
         9Nynw0Gl1EvImAUBKqY0UrRr4ya3HyuxV3Z4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=ouKx0m8attSus+HCzkpoeIDjCsYILtabmIioPrMZPpiHkToFKxYysheOp6ajBznHk8
         aasi+q4WuA9J4IudBv3LtrhxK0RWKh5vTvOmWOfUo7uddte1uVBP88UWAJXzU7xonwBN
         aqH6pMQt66bCb8acdetU3TWx7TvHHdjntrG5I=
Received: by 10.141.41.11 with SMTP id t11mr1399594rvj.259.1250500199238;
        Mon, 17 Aug 2009 02:09:59 -0700 (PDT)
Received: from your-cukc5e3z5n (cm219.zeta152.maxonline.com.sg [116.87.152.219])
        by mx.google.com with ESMTPS id k37sm24219889rvb.7.2009.08.17.02.09.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 02:09:58 -0700 (PDT)
In-Reply-To: <200908170725.09592.thomas.schlichter@web.de>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126146>

Hi,

On Mon, Aug 17, 2009 at 1:25 PM, Thomas Schlichter<thomas.schlichter@web.de> wrote:
> Hmm. I hope you won't take this as an argument for not fixing it, because it
> is a clear regression! I tried git version 1.6.3.4, and it works flawlessly
> with exactly this server! Even during bisecting, some versions worked, some
> didn't (these after the mentioned commit...)
>
> So I think this commit didn't only refactor things, but unintentionally
> changed the behavior. And this must be the problem. As I'm not into this code,
> and the refactoring was not completely trivial, I was not able to quickly find
> the place where the behavior was changed...

Thomas, indeed you're right about this, the commit you noted in your
earlier email (5424bc5) was indeed at fault.

The commit changed how urls was handled, and resulted (incorrectly) in
an extra slash being added to the url. In other words, urls now look
like this:

  http://server/repo.git//objects/2a/

This problem occurs only in http-push.c, because repo urls
(http://server/repo.git) are always made to end with a slash there.

Btw, on my Apache 2.2.x server, this didn't crop up when I tested,
while Thomas worked with a 2.0.x.

I've attached a patch below that hopefully fixes it.

-- >8 --

Subject: [PATCH] http.c: don't assume that urls don't end with slash

Make append_remote_object_url() (and by implication,
get_remote_object_url) use end_url_with_slash() to ensure that the url
ends with a slash.

Previously, they assumed that the url did not end with a slash and
as a result appended a slash, sometimes errorneously.

This fixes an issue introduced in 5424bc5 ("http*: add helper methods
for fetching objects (loose)"), where the append_remote_object_url()
implementation in http-push.c, which assumed that urls end with a
slash, was replaced by another one in http.c, which assumed urls did
not end with a slash.

The above issue was raised by Thomas Schlichter:

  http://marc.info/?l=git&m=125043105231327

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index 14d5357..eb0c669 100644
--- a/http.c
+++ b/http.c
@@ -719,7 +719,9 @@ void append_remote_object_url(struct strbuf *buf, const char *url,
 			      const char *hex,
 			      int only_two_digit_prefix)
 {
-	strbuf_addf(buf, "%s/objects/%.*s/", url, 2, hex);
+	end_url_with_slash(buf, url);
+
+	strbuf_addf(buf, "objects/%.*s/", 2, hex);
 	if (!only_two_digit_prefix)
 		strbuf_addf(buf, "%s", hex+2);
 }
--
1.6.4.dirty
