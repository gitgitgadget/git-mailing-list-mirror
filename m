From: Federico Cuello <fedux@lugmen.org.ar>
Subject: Re: [PATCH] Fix git-apply with -p greater than 1
Date: Fri, 22 Oct 2010 15:51:12 -0300
Message-ID: <4CC1DD20.1080500@lugmen.org.ar>
References: <1287699122-26702-1-git-send-email-fedux@lugmen.org.ar> <7viq0urfbz.fsf@alter.siamese.dyndns.org> <20101022053140.GB786@burratino> <4CC194DF.9040803@lugmen.org.ar> <7v8w1qm5n2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 20:51:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9MiG-00050C-0O
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 20:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756924Ab0JVSvV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 14:51:21 -0400
Received: from 64-76-18-116.static.impsat.net.ar ([64.76.18.116]:40328 "EHLO
	mother.lugmen.org.ar" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1756886Ab0JVSvS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 14:51:18 -0400
Received: from mail.fedux.com.ar (unknown [186.18.64.224])
	by mother.lugmen.org.ar (Postfix) with ESMTPSA id 86B7C19E69F;
	Fri, 22 Oct 2010 15:51:15 -0300 (ART)
Received: from [192.168.8.5] (unknown [192.168.8.5])
	by mail.fedux.com.ar (Postfix) with ESMTPS id CC88910058;
	Fri, 22 Oct 2010 15:51:13 -0300 (ART)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.11) Gecko/20101020 Lightning/1.0b3pre Thunderbird/3.1.5
In-Reply-To: <7v8w1qm5n2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159730>

El 22/10/10 15:41, Junio C Hamano escribi=F3:
> Fede <fedux@lugmen.org.ar> writes:
>
>> There is a similar issue with renames and I'm working on that.
> I think I queued a fix-up in 'pu' on top of your patch last night.  D=
oes
> it work for you?

Yes, is almost what I got. I also checked p_value not to be 0.

Anyway, the whole thing is broken when -p 0 , and it requires a little
bit more work. Specially in apply.c:stop_at_slash().

I have this:

diff --git a/builtin/apply.c b/builtin/apply.c
index 14996f8..3197e38 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -919,28 +919,28 @@ static int gitdiff_newfile(const char *line,
struct patch *patch)
 static int gitdiff_copysrc(const char *line, struct patch *patch)
 {
        patch->is_copy =3D 1;
-       patch->old_name =3D find_name(line, NULL, 0, 0);
+       patch->old_name =3D find_name(line, NULL, p_value ? p_value - 1=
 :
0, 0);
        return 0;
 }
=20
 static int gitdiff_copydst(const char *line, struct patch *patch)
 {
        patch->is_copy =3D 1;
-       patch->new_name =3D find_name(line, NULL, 0, 0);
+       patch->new_name =3D find_name(line, NULL, p_value ? p_value - 1=
 :
0, 0);
        return 0;
 }
=20
 static int gitdiff_renamesrc(const char *line, struct patch *patch)
 {
        patch->is_rename =3D 1;
-       patch->old_name =3D find_name(line, NULL, 0, 0);
+       patch->old_name =3D find_name(line, NULL, p_value ? p_value - 1=
 :
0, 0);
        return 0;
 }
=20
 static int gitdiff_renamedst(const char *line, struct patch *patch)
 {
        patch->is_rename =3D 1;
-       patch->new_name =3D find_name(line, NULL, 0, 0);
+       patch->new_name =3D find_name(line, NULL, p_value ? p_value - 1=
 :
0, 0);
        return 0;
 }
