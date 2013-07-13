From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] http.c: fix parsing of http.sslCertPasswordProtected variable
Date: Sat, 13 Jul 2013 12:28:15 -0700
Message-ID: <35166ba04d1ce901e0fb63a5c522970@f74d39fa044aa309eaea14b9f57fe79>
References: <7v38rjlif4.fsf@alter.siamese.dyndns.org> <20130712190531.GD8482@google.com>
Cc: git@vger.kernel.org, Mark Lodato <lodatom@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 13 21:28:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uy5Up-0000qg-EO
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 21:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758204Ab3GMT2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 15:28:25 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:35601 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab3GMT2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 15:28:25 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so9981354pbc.2
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fs86FvXErn6zze3I5WhHtNOPcn66kTGmnMpgmpnJWAU=;
        b=iZAngZSQyZDsGmn4I99yQhGHP2GDYqKuNNd++ZToc5x6rWRbBhRHI1eRfN+qqxu1sI
         ZZUOFYYdbmebeDYvcXoWQnpCeyC6MB7VEQgg0uCRlZbiVFg0wGl4Uf0dUTvTPXf2R4tR
         3KLdPyXCplb1x3xwmLB3Gqmktvx4ynSgSE+Rg+0XRHQ+N8rzok+YQF9saVJCv94IrO8Q
         ZyZsd9zSz61aZrMtyFxvcUs6EJgY/AY61EWhS/vtP/xOiMKNkIUFbpSN794613BGCNge
         SHA3Ncnou1vKvdd3fZQ4VCFm7qwHkU2195AlS8Rv0/KO/16HTmYyMZ3fq1ut2Yw7HAw8
         7wEA==
X-Received: by 10.66.249.202 with SMTP id yw10mr48395683pac.145.1373743704256;
        Sat, 13 Jul 2013 12:28:24 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id qu10sm52051682pbb.12.2013.07.13.12.28.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 13 Jul 2013 12:28:23 -0700 (PDT)
In-Reply-To: <20130712190531.GD8482@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230287>

On Jul 12, 2013, at 12:05, Jonathan Nieder wrote:
> Junio C Hamano wrote:
>
>> The existing code triggers only when the configuration variable is
>> set to true.  Once the variable is set to true in a more generic
>> configuration file (e.g. ~/.gitconfig), it cannot be overriden to
>> false in the repository specific one (e.g. .git/config).
> [...]
>> --- a/http.c
>> +++ b/http.c
>> @@ -160,8 +160,7 @@ static int http_options(const char *var, const  
>> char *value, void *cb)
>> 	if (!strcmp("http.sslcainfo", var))
>> 		return git_config_string(&ssl_cainfo, var, value);
>> 	if (!strcmp("http.sslcertpasswordprotected", var)) {
>> -		if (git_config_bool(var, value))
>> -			ssl_cert_password_required = 1;
>> +		ssl_cert_password_required = git_config_bool(var, value);
>
> Thanks for catching it.  The documentation doesn't say anything about
> this "can only enable and cannot disable" behavior and the usual
> pattern is to allow later settings to override earlier ones, so this
> change looks good.
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Looks good to me too.

> FWIW the GIT_SSL_CERT_PASSWORD_PROTECTED envvar has a similar "can
> only enable" behavior, but since it's documented, that's not as big
> of a problem.

Hmmm.  git help config says:

> Can be overridden by the GIT_SSL_CERT_PASSWORD_PROTECTED environment
> variable.

in the http.sslCertPasswordProtected section of the help.  It doesn't
say it can only be overridden to on.  Is there some other documentation
for that somewhere I'm missing about being can-only-enable?

If not, perhaps a change something like the following could be added
to the patch:

diff --git a/http.c b/http.c
index 2d086ae..83fc6b4 100644
--- a/http.c
+++ b/http.c
@@ -404,11 +404,10 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 		curl_ftp_no_epsv = 1;
 
 	if (url) {
+		int pwdreq = git_env_bool("GIT_SSL_CERT_PASSWORD_PROTECTED", -1);
 		credential_from_url(&http_auth, url);
-		if (!ssl_cert_password_required &&
-		    getenv("GIT_SSL_CERT_PASSWORD_PROTECTED") &&
-		    !prefixcmp(url, "https://"))
-			ssl_cert_password_required = 1;
+		if (pwdreq != -1 && !prefixcmp(url, "https://"))
+			ssl_cert_password_required = pwdreq;
 	}
 
 #ifndef NO_CURL_EASY_DUPHANDLE
-- 
