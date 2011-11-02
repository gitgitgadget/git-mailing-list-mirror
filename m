From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: [RFC/PATCH] http-push: don't always prompt for password (Was Re:
 [ANNOUNCE] Git 1.7.8.rc0)
Date: Wed, 02 Nov 2011 09:52:58 +0100
Message-ID: <4EB104EA.2040001@atlas-elektronik.com>
References: <7vfwi9rc0g.fsf@alter.siamese.dyndns.org> <4EAEAE13.50101@atlas-elektronik.com> <4EAFC18A.1070502@atlas-elektronik.com> <7vmxcfn23i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 09:53:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLWZD-0001bL-0E
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 09:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127Ab1KBIw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 04:52:58 -0400
Received: from mail96.atlas.de ([194.156.172.86]:27228 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752504Ab1KBIw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 04:52:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 7E66B100C2;
	Wed,  2 Nov 2011 09:52:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id aBczxAfCO2TP; Wed,  2 Nov 2011 09:52:54 +0100 (CET)
Received: from mgsrv01.atlas.de (mailrelay-atlas.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Wed,  2 Nov 2011 09:52:54 +0100 (CET)
Received: from [141.200.19.108] (as112671.atlas.de [141.200.19.108])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 82F5427186;
	Wed,  2 Nov 2011 09:52:54 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <7vmxcfn23i.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184617>

Am 01.11.2011 19:12, schrieb Junio C Hamano:
> 
> There are only handful of commits that even remotely touch http related
> codepath between v1.7.7 and v1.7.8-rc0:
> 
>   * deba493 http_init: accept separate URL parameter
> 
>   This could change the URL string given to http_auth_init().
> 
>   * 070b4dd http: use hostname in credential description
> 
>   This only changes the prompt string; as far as I understand it, the
>   condition the password is prompted in the callsites of git_getpass()
>   has not changed.
> 
>   * 6cdf022 remote-curl: Fix warning after HTTP failure
>   * be22d92 http: avoid empty error messages for some curl errors
>   * 8abc508 http: remove extra newline in error message
>   * 8d677ed http: retry authentication failures for all http requests
>   * 28d0c10 remote-curl: don't retry auth failures with dumb protocol
> 
>   These shouldn't affect anything wrt prompting, unless you are somehow
>   internally reauthenticating.
> 
> Could you try reverting deba493 and retest, and then if the behaviour is
> the same "need ENTER", further revert 070b4dd and retest?

I did a little more testing.
This WIP makes it work for me (i.e. "need ENTER" is gone, works with
and without .netrc, with 'https://host/repo.git' and 
'https://user@host...' URL). Needs testing, of course.

---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---
diff --git a/http.c b/http.c
index a4bc770..008ad72 100644
--- a/http.c
+++ b/http.c
@@ -279,8 +279,6 @@ static CURL *get_curl_handle(void)
        curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
 #endif

-       init_curl_http_auth(result);
-
        if (ssl_cert != NULL)
                curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
        if (has_cert_password())
@@ -846,7 +844,7 @@ static int http_request(const char *url, void *result, int target, int options)
                else if (missing_target(&results))
                        ret = HTTP_MISSING_TARGET;
                else if (results.http_code == 401) {
-                       if (user_name) {
+                       if (user_name && user_pass) {
                                ret = HTTP_NOAUTH;
                        } else {
                                /*
@@ -855,7 +853,8 @@ static int http_request(const char *url, void *result, int target, int options)
                                 * but that is non-portable.  Using git_getpass() can at least be stubbed
                                 * on other platforms with a different implementation if/when necessary.
                                 */
-                               user_name = xstrdup(git_getpass_with_description("Username", description));
+                               if (!user_name)
+                                       user_name = xstrdup(git_getpass_with_description("Username", description));
                                init_curl_http_auth(slot->curl);
                                ret = HTTP_REAUTH;
                        }
---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---


Regards,
  Stefan
-- 
----------------------------------------------------------------
/dev/random says: Efficiency takes time! Frugality: who can afford it?
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')"
