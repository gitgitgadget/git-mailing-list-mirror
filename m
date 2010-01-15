From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2 13/14] daemon: use select() instead of poll()
Date: Sat, 16 Jan 2010 00:23:46 +0100
Message-ID: <40aa078e1001151523o538b44c7x95def3447650eea4@mail.gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
	 <1263591033-4992-14-git-send-email-kusmabite@gmail.com>
	 <201001152349.06418.j6t@kdbg.org>
	 <40aa078e1001151508j208fa50boc5565a3be6bef893@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jan 16 00:23:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVvWD-0007hm-EU
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 00:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758617Ab0AOXXu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jan 2010 18:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758600Ab0AOXXu
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 18:23:50 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:32789 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758603Ab0AOXXt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jan 2010 18:23:49 -0500
Received: by ewy1 with SMTP id 1so690145ewy.28
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 15:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4kRwHpAvEyH+bMWAB9MpRW0az0vZinV1DB/CCUNQpug=;
        b=v4e+tACye/vjDEaz11BG5JSzO0ienes6/YeWoeCMKOLShqn72WBkcKQIKaNqGX1ZXK
         VwJn4EuQxRr57yQvQgYs4WXOP716ah+B6/QCCKcbHPMynDY4q117k6DXq9KC4xKu4sqb
         EkEbBaishD1p9X4m+6EZ828CAAytucnFaioZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=mEfz7ZFqbmR4v3evcuvU6MKqzwCRBlgU4nF0kwbdF9d+dNt/dN51/oncVETLXG+Tto
         TQDnOrboEvX0qXXftIlj63Lq67y49Gyrnx1P0epU7PBIEGrI0LJcy6HkxPIbQfkUyoZO
         zaigs6gSjq0Cj7eztHMbj395tGIoHqUipzwBA=
Received: by 10.216.86.66 with SMTP id v44mr1080412wee.163.1263597826907; Fri, 
	15 Jan 2010 15:23:46 -0800 (PST)
In-Reply-To: <40aa078e1001151508j208fa50boc5565a3be6bef893@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137160>

On Sat, Jan 16, 2010 at 12:08 AM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
> On Fri, Jan 15, 2010 at 11:49 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> On Freitag, 15. Januar 2010, Erik Faye-Lund wrote:
>>> +#undef FD_SET
>>> +#define FD_SET(fd, set) do { \
>>> + =A0 =A0 ((fd_set*)(set))->fd_array[((fd_set *)(set))->fd_count++]=
 =3D
>>> _get_osfhandle(fd); \ + =A0 =A0 =A0 } while(0)
>>> +#undef FD_ISSET
>>> +#define FD_ISSET(fd, set) __WSAFDIsSet(_get_osfhandle(fd), (fd_set
>>> *)(set)) +
>>
>> I'm worried about the internals that you have to use here. Isn't it =
possible
>> save the original macro text and use it in the new definition, like =
(this is
>> for exposition only):
>>
>> #define ORIG_FD_SET(fd, set) FD_SET(fd, set)
>> #undef FD_SET
>> #define FD_SET(fd, set) ORIG_FD_SET(_get_osfhandle(fd), set)
>>
>
> Redefining it is indeed fishy - I guess I should also have noted that
> I even stripped the code down slightly (compared to the original).
>
> I'm no preprocessor wizard, but I'll give it a stab.
>

The following worked for me:

diff --git a/compat/mingw.h b/compat/mingw.h
index e515726..ea15967 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -269,10 +269,13 @@ int mingw_accept(int sockfd, struct sockaddr
*sa, socklen_t *sz);
 int mingw_rename(const char*, const char*);
 #define rename mingw_rename

+static inline void mingw_fd_set(int fd, fd_set *set)
+{
+	FD_SET(_get_osfhandle(fd), set);
+}
 #undef FD_SET
-#define FD_SET(fd, set) do { \
-	((fd_set*)(set))->fd_array[((fd_set *)(set))->fd_count++] =3D
_get_osfhandle(fd); \
-	} while(0)
+#define FD_SET(a,b) mingw_fd_set(a,b)
+
 #undef FD_ISSET
 #define FD_ISSET(fd, set) __WSAFDIsSet(_get_osfhandle(fd), (fd_set *)(=
set))


--=20
Erik "kusma" Faye-Lund
