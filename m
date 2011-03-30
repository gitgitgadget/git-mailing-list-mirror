From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Fix potential local deadlock during fetch-pack
Date: Wed, 30 Mar 2011 11:50:45 +0200
Message-ID: <AANLkTinyok+UnR8pOpp43v5EHEN8_YDCC0MFcBfC1LRY@mail.gmail.com>
References: <7vtyelsvp0.fsf@alter.siamese.dyndns.org> <AANLkTikCRRftjExdhMgFGFMy-Dc1UCMdW1nTYV2bK1-T@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	msysGit <msysgit@googlegroups.com>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 11:51:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4s3W-0000II-MK
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 11:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755691Ab1C3JvI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2011 05:51:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35384 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754951Ab1C3JvG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2011 05:51:06 -0400
Received: by fxm17 with SMTP id 17so895864fxm.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 02:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=hUoeGf4Hr7/GZzeHdEQ09uyIYv0HdoNfQfrty9hZrXY=;
        b=Xt7yFSQz0u8haw7vkJAVdwzdpse06SehqHRoZNkXOqfoESs0sEJgsHiynRgNkCYYZ6
         h3Ko8UAeEuzMy+RDoS1oYd/YFUcstHqH0F6j+Od5t9NYc/6xwI/u0m7DP9pjP0LkV3L7
         julJVg3kDi7ZeW5bvndSuPpC0udFEBO+XWdgg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=eT/YqV/iSRcrE4NDCGesZytD/YEW4UlqQQ/cHpUc6PYHy280Yj3vXtIk9FX+3cl0k8
         lu1A8PbVpFIhlyDqyv02+1cBlU5apS4SQRLj8dZaHihtbavYntylqQ79hInOQeN1VCCt
         Sf3kDJ4p+jZymdRkHj+YUaYm9w+YnDpHV/LLc=
Received: by 10.223.73.133 with SMTP id q5mr993067faj.127.1301478665114; Wed,
 30 Mar 2011 02:51:05 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Wed, 30 Mar 2011 02:50:45 -0700 (PDT)
In-Reply-To: <AANLkTikCRRftjExdhMgFGFMy-Dc1UCMdW1nTYV2bK1-T@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170372>

On Wed, Mar 30, 2011 at 11:42 AM, Erik Faye-Lund <kusmabite@gmail.com> =
wrote:
> On Tue, Mar 29, 2011 at 7:06 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> The fetch-pack/upload-pack protocol relies on the underlying transpo=
rt
>> (local pipe or TCP socket) to have enough slack to allow one window =
worth
>> of data in flight without blocking the writer. =A0Traditionally we a=
lways
>> relied on being able to have a batch of 32 "have"s in flight (roughl=
y 1.5k
>> bytes) to stream.
>>
>
> Hmm, this explanation makes me wonder: Could this be related to the
> deadlock we're experiencing with git-push over the git-protocol on
> Windows when side-band-64k is enabled?
>

No, It doesn't seem like that's it. The socket buffers appears to be
8k by default on Windows, which should be plenty, right?

---8<---
diff --git a/compat/mingw.c b/compat/mingw.c
index d527562..985c271 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1404,7 +1404,7 @@ int mingw_getnameinfo(const struct sockaddr *sa,
socklen_t salen,

 int mingw_socket(int domain, int type, int protocol)
 {
-	int sockfd;
+	int sockfd, val, len;
 	SOCKET s;

 	ensure_socket_initialization();
@@ -1428,6 +1428,12 @@ int mingw_socket(int domain, int type, int proto=
col)
 		return error("unable to make a socket file descriptor: %s",
 			strerror(errno));
 	}
+
+	len =3D sizeof(val);
+	if (!getsockopt(s, SOL_SOCKET, SO_RCVBUF, (char *)&val, &len))
+		fprintf(stderr, "SO_RCVBUF: %d\n", val);
+	len =3D sizeof(val);
+	if (!getsockopt(s, SOL_SOCKET, SO_SNDBUF, (char *)&val, &len))
+		fprintf(stderr, "SO_SNDBUF: %d\n", val);
 	return sockfd;
 }

---8<---

$ git push git://localhost
SO_RCVBUF: 8192
SO_SNDBUF: 8192
=2E..
