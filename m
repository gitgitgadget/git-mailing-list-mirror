From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] rewrite `git_default_config()` using config-set API functions
Date: Mon, 21 Jul 2014 17:37:50 +0200
Message-ID: <vpqzjg2204x.fsf@anie.imag.fr>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
	<53CCFD02.6010704@gmail.com> <vpqha2addyn.fsf@anie.imag.fr>
	<53CD2273.3000600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 17:38:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9Ff7-000798-AK
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 17:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932806AbaGUPh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 11:37:57 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48444 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932322AbaGUPh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 11:37:56 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6LFbmPS014919
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jul 2014 17:37:48 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6LFboHC026953;
	Mon, 21 Jul 2014 17:37:50 +0200
In-Reply-To: <53CD2273.3000600@gmail.com> (Tanay Abhra's message of "Mon, 21
	Jul 2014 19:53:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 21 Jul 2014 17:37:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6LFbmPS014919
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406561869.65521@nW2WNEVemQHX/8FJEjKStQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253972>

Tanay Abhra <tanayabh@gmail.com> writes:

>> 
>>> +	if > +	git_config_get_string("core.notesref", (const char**)&notes_ref_name);
>> 
>> This cast is needed only because notes_ref_name is declared as
>> non-const, but a better fix would be to make the variable const, and
>> remove the cast.
>
> Same casts had to be used in imap-send.c patch, I will have to use an
> intermediate variable there to remove the cast thus destroying the one
> liners or will have to update the variable declarations.

Updating the declaration like this should just work:

--- a/imap-send.c
+++ b/imap-send.c
@@ -1324,7 +1324,7 @@ static int split_msg(struct strbuf *all_msgs, struct strbuf *msg, int *ofs)
        return 1;
 }
 
-static char *imap_folder;
+static const char *imap_folder;
 
 static void git_imap_config(void)
 {
@@ -1332,7 +1332,7 @@ static void git_imap_config(void)
 
        git_config_get_bool("imap.sslverify", &server.ssl_verify);
        git_config_get_bool("imap.preformattedhtml", &server.use_html);
-       git_config_get_string("imap.folder", (const char**)&imap_folder);
+       git_config_get_string("imap.folder", &imap_folder);
 
        if (!git_config_get_value("imap.host", &val)) {
                if(!val)

In general, most strings one manipulates are "const char *", it's
frequent to modify a pointer to a string, but rather rare to modify the
string itself.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
