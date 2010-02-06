From: Junio C Hamano <gitster@pobox.com>
Subject: imap.preformattedHTML and imap.sslverify
Date: Sat, 06 Feb 2010 11:26:35 -0800
Message-ID: <7v7hqqxj10.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremy White <jwhite@codeweavers.com>,
	Robert Shearman <robertshearman@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 20:26:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdqIy-0002eo-LI
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 20:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868Ab0BFT0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 14:26:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356Ab0BFT0p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 14:26:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E1BD697832;
	Sat,  6 Feb 2010 14:26:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=9LTL
	PIAiriHI2L8KVqhc+WHCMz0=; b=Lw7tYqwu67xwB7/xraAjqe4tZ/G+aS9eaOup
	MYTCI7lvjPSJODTYl1CNE1faLXAloaajoCkXoGcJU5oBxn0ocBWJ/NRGlrXIewv5
	z9uZTjap7mfRBxe2rhif8ePCLNYjeHRel13Sb4NE/sE3k2R/cy67/JEtz8nRZYfb
	dpqRll4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	dE4P1jNIYMugMKtcL2T+0rQlatMhMG+0v3j0y7vekQe/Su7MAYCuyaqUFr05YrQQ
	H9Mo1f+AdWEYWMznPlROq4Sv5sB2sN8R0CEcN5lfIkGI0tl5G/3RLRorf2S8tf2q
	Gq4IcfZ1yXbydLxyedF2E3oSeGjFP3kzjm9HHqrJ9MI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A74589782B;
	Sat,  6 Feb 2010 14:26:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACC619782A; Sat,  6 Feb
 2010 14:26:36 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8D330D20-1355-11DF-9BAF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139186>

I hate to bring up a topic that is almost a year old, but has either of
these configuration variables ever worked?

The code does this while reading its configuration file:

        static int git_imap_config(const char *key, const char *val, void *cb)
        {
                char imap_key[] = "imap.";

                if (strncmp(key, imap_key, sizeof imap_key - 1))
                        return 0;

                if (!val)
                        return config_error_nonbool(key);
                ...
                else if (!strcmp("sslverify", key))
                        server.ssl_verify = git_config_bool(key, val);
                else if (!strcmp("preformattedHTML", key))
                        server.use_html = git_config_bool(key, val);

Two issues:

 - The body of the function is protected by "nonbool" written back in the
   days when there was no boolean variables in imap.* namespace.  Hence,
   a user cannot write

           [imap]
                sslverify

   and turn it on.  The user needs to write


           [imap]
                sslverify = True

   which is against the parsing rules for boolean variables.

 - The config parser downcases the key before calling the parse callback
   function, so !strcmp("preformattedHTML", key) will never trigger.

The fix is obvious (see below), but I am far more disturbed by the
apparent lack of testing.  Especially, preformattedHTML one would have
never worked as setting the configuration is the only way to trigger this.

Could peole _test_ this patch and report, as I don't use this program at
all.

Thanks.

 imap-send.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index de8114b..ea769a9 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1335,11 +1335,16 @@ static int git_imap_config(const char *key, const char *val, void *cb)
 	if (strncmp(key, imap_key, sizeof imap_key - 1))
 		return 0;
 
-	if (!val)
-		return config_error_nonbool(key);
-
 	key += sizeof imap_key - 1;
 
+	/* check booleans first, and barf on others */
+	if (!strcmp("sslverify", key))
+		server.ssl_verify = git_config_bool(key, val);
+	else if (!strcmp("preformattedhtml", key))
+		server.use_html = git_config_bool(key, val);
+	else if (!val)
+		return config_error_nonbool(key);
+
 	if (!strcmp("folder", key)) {
 		imap_folder = xstrdup(val);
 	} else if (!strcmp("host", key)) {
@@ -1360,10 +1365,6 @@ static int git_imap_config(const char *key, const char *val, void *cb)
 		server.port = git_config_int(key, val);
 	else if (!strcmp("tunnel", key))
 		server.tunnel = xstrdup(val);
-	else if (!strcmp("sslverify", key))
-		server.ssl_verify = git_config_bool(key, val);
-	else if (!strcmp("preformattedHTML", key))
-		server.use_html = git_config_bool(key, val);
 	return 0;
 }
 
