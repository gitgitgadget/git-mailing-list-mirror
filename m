From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v4 08/15] daemon: use run-command api for async serving
Date: Thu, 14 Oct 2010 12:18:21 +0200
Message-ID: <AANLkTikyxEB0VRg1jWd-AdR0uyxExw7O9YQfXJzu-f_M@mail.gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-9-git-send-email-kusmabite@gmail.com> <7vpqvdhfra.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 12:18:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6Ktc-0005dl-9k
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 12:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999Ab0JNKSm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 06:18:42 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42745 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680Ab0JNKSm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 06:18:42 -0400
Received: by vws2 with SMTP id 2so2488182vws.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=gIjkz8TXKHq550yoluDS68MzPmWFiAtkMUutQxo/nz0=;
        b=IXSXNtiBeW5qgSlAtPsw4fmjCO6xvbLpdhxfTTRnh0dL1tJOXLyrq1C/WSbj5rOQED
         6E2clUypVVeRVk2/XzwRtKXNtPcqjYH4K0eFHpIz1KUsVAnS4yhYcPQgvbdODz7W0Wmn
         25Mcz1NQTClMnxJj1i2HOS/V1iVLi7X5cWsT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=Gysi+UhbLzoOnUiQ5mUo3C88t+Vh9sqmnAJaZ81wmyhE+gcsfMm1OXYVYjP/TXsQtb
         99rHVXXLkEaFJth4ymkJI4wO3LKfvG9GsbS1T5KyDfiSl5cmiI+i3PJpeM7V1veOAEK3
         d9+5W7/hfZ44dU3fkbBz7rfHJqN29BIDWuZLg=
Received: by 10.220.199.75 with SMTP id er11mr2115242vcb.148.1287051521500;
 Thu, 14 Oct 2010 03:18:41 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Thu, 14 Oct 2010 03:18:21 -0700 (PDT)
In-Reply-To: <7vpqvdhfra.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159042>

On Thu, Oct 14, 2010 at 12:47 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> @@ -1017,7 +1005,12 @@ int main(int argc, char **argv)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(arg, "--serve")) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serve_mode =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(arg, "--inetd")) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serve_mode =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 inetd_mode =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 log_syslog =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> @@ -1161,12 +1154,12 @@ int main(int argc, char **argv)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("base-path '%s' does not exist or is=
 not a directory",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base_path);
>>
>> - =A0 =A0 if (inetd_mode) {
>> + =A0 =A0 if (serve_mode) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sockaddr_storage ss;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sockaddr *peer =3D (struct sockad=
dr *)&ss;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 socklen_t slen =3D sizeof(ss);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!freopen("/dev/null", "w", stderr))
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (inetd_mode && !freopen("/dev/null", "w=
", stderr))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die_errno("failed to red=
irect stderr to /dev/null");
>
> This is not particularly a good style. =A0Please make it more clear t=
hat we
> freopen in inetd mode by writing it like this:
>
> =A0 =A0 =A0 =A0if (inetd_mode) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!freopen(...))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die_errno(...)
> =A0 =A0 =A0 =A0}
>
>

Much nicer, yeah. Now I'm tempted to do this also:

---8<---
diff --git a/daemon.c b/daemon.c
index 7f5d72f..11a5e06 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1010,7 +1010,6 @@ int main(int argc, char **argv)
 			continue;
 		}
 		if (!strcmp(arg, "--inetd")) {
-			serve_mode =3D 1;
 			inetd_mode =3D 1;
 			log_syslog =3D 1;
 			continue;
@@ -1159,7 +1158,7 @@ int main(int argc, char **argv)
 			die_errno("failed to redirect stderr to /dev/null");
 	}

-	if (serve_mode) {
+	if (inetd_mode || serve_mode) {
 		struct sockaddr_storage ss;
 		struct sockaddr *peer =3D (struct sockaddr *)&ss;
 		socklen_t slen =3D sizeof(ss);
---8<---
