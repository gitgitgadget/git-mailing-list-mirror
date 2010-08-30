From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3?] Add global and system-wide gitattributes
Date: Mon, 30 Aug 2010 10:26:16 +0200
Message-ID: <vpqvd6sik0n.fsf@bauges.imag.fr>
References: <vpqy6bqr3ep.fsf@bauges.imag.fr>
	<1283020870-24888-1-git-send-email-Matthieu.Moy@imag.fr>
	<87fwxxhfpp.fsf_-_@gmail.com>
	<7vzkw4edc5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
	git@vger.kernel.org, Petr Onderka <gsvick@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 10:26:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpzhR-00084S-0y
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 10:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786Ab0H3I0Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 04:26:25 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46711 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867Ab0H3I0Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 04:26:24 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o7U8MnsA025409
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 30 Aug 2010 10:22:49 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Opzh2-0005WR-Mu; Mon, 30 Aug 2010 10:26:16 +0200
In-Reply-To: <7vzkw4edc5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 30 Aug 2010 01\:04\:10 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 30 Aug 2010 10:22:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7U8MnsA025409
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1283761373.0996@PSyH7V9JkDYArHQ5SBOh/g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154776>

Junio C Hamano <gitster@pobox.com> writes:

> =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com> writes:
>
>> Thanks, Matthieu!
>>
>> Petr's original patch doesn't apply cleanly due to a bogus context l=
ine
>> after a recent change in Makefile. For convenience, below is the upd=
ated
>> patch including Matthieu's changes applicable to current master.
>>
>> And FWIW (I didn't try to build the documentation, though):
>>
>> Tested-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>
>
> Thanks, but this seems to break t8005 for whatever reason.

The guilty line is

  git_config(git_default_config, NULL);

(t8005 passes if I remove it).

I don't understand why this breaks the test. It seems blame
--encoding=3DUTF-8 relies on the fact that the i18n section of the
configuration is not loaded.

An obvious fix on our side is to squash the patch below into the
previous ones, to make sure the attributes code loads only the core
configuration. OTOH, it seems to me that the blame code is very
fragile, but I'm not familiar with this code to say whether and how it
should be fixed.

Any other thoughts?

diff --git a/attr.c b/attr.c
index 342791a..793a835 100644
--- a/attr.c
+++ b/attr.c
@@ -500,7 +500,7 @@ static void bootstrap_attr_stack(void)
                        }
                }
=20
-               git_config(git_default_config, NULL);
+               git_config(git_core_config, NULL);
                if (git_attr_global() && attributes_file) {
                        elem =3D read_attr_from_file(attributes_file, 1=
);
                        if (elem) {
diff --git a/cache.h b/cache.h
index 28d9497..2d0bfa0 100644
--- a/cache.h
+++ b/cache.h
@@ -972,6 +972,7 @@ extern int update_server_info(int);
=20
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
+extern int git_core_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
 extern int git_config_parse_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
diff --git a/config.c b/config.c
index f602cd4..a2d1df9 100644
--- a/config.c
+++ b/config.c
@@ -602,6 +602,14 @@ static int git_default_core_config(const char *var=
, const char *value)
        return 0;
 }
=20
+/*=20
+ * Wrapper around git_default_core_config, with type acceptable as
+ * argument to git_config(...)
+ */
+int git_core_config(const char *var, const char *value, void *dummy) {
+       return git_default_core_config(var, value);
+}
+
 static int git_default_user_config(const char *var, const char *value)
 {
        if (!strcmp(var, "user.name")) {


--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
