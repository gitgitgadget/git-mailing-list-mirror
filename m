From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line
 lengths)
Date: Mon, 09 Mar 2009 23:34:25 -0700
Message-ID: <7v63ihdgy6.fsf@gitster.siamese.dyndns.org>
References: <49B5AF67.6050508@gmail.com>
 <7v1vt6dxg9.fsf@gitster.siamese.dyndns.org> <49B5F0BA.3070806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Gaffney <mr.gaffo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 07:36:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgvZL-00061g-JO
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 07:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbZCJGef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 02:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbZCJGee
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 02:34:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53436 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbZCJGed (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 02:34:33 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5ECA84F02;
	Tue, 10 Mar 2009 02:34:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 345904F01; Tue,
 10 Mar 2009 02:34:27 -0400 (EDT)
In-Reply-To: <49B5F0BA.3070806@gmail.com> (Mike Gaffney's message of "Mon, 09
 Mar 2009 23:46:50 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 82A62050-0D3D-11DE-B984-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112782>

Mike Gaffney <mr.gaffo@gmail.com> writes:

>>> +static const char *curl_http_username = NULL;
>>> +static const char *curl_http_password = NULL;
>>> +
>> Please do not introduce new initializations of static variables to 0 or
>> NULL.  As a clean-up, before your patch, you can send in a patch to fix
>> existing such initializations.
> ...
> Or do you mean that I can send in a patch to fix other static variables
> (not mine) which are being initialized to NULL?

Yeah, a preparatory patch to clean things up, like the one I sent out
earlier this evening, was what I meant.

> 2) Being that I'm not a big C guy, I'm not sure the best way to go about 
> parsing the username out of the URL to pull it into a variable to pass
> to CURLOPT_USERPASS. Any advice from the community would be greatly
> appreciated.

I am sort of a C guy, but I am by no means a libcurl person.  A quick and
dirty patch is attached, which is partly based on yours, but is stripped
of version dependency and also I suspect it handles only the http-walker
side.  It is on top of the two clean-up patch I sent this evening.

It hasn't seen any test, but I just ran this once:

    $ git clone http://junio@my.private.machine/test-repo.git/

from a repository that requires authentication but I have no .netrc and no
http.password configuration; I was asked for the password once, of course.

> 3) From my experience with curl, many of the options do
> not work the same across versions or platforms. For example, the new
> CURLOPT_USERNAME/PASSWORD options worked fine in 7.19.4 on cygwin but not
> on FC9, which is why I used the older USERPWD. Also, my curl never prompted
> me for the password when I supplied a username in the URL which is what 
> prompted me to do this patch in the first place. As such, I think it is
> better to pull the username & password prompting logic into git make this 
> stable and fix the bug. 

Heh, 7.19.4 was only released on a few days ago if I am reading its
download page correctly.

The version of libcurl on my box is 7.18.something, and it does not seem
to ask for password when the URL has only username but not colon-password.
I also expected it to ask for password when $HOME/.netrc has login but not
password for a given machine, but that does not seem to happen either.
Perhaps the version is too old.

> 4) I'm not really impressed that file permissions actually make the .netrc
> file a secure option. However, it's already in there and would break
> backwards compatibility to take it out. I also realize that there is a need
> for automated builds to be able to pull the source. So I would like to add a nice 
> warning section to the http docs explaining the repercussions of using it.

I agree with the first two sentences and am not happy with http.password
because of it.


---
 http.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index f4f0bf6..3d5caa6 100644
--- a/http.c
+++ b/http.c
@@ -25,6 +25,7 @@ static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
+static char *user_name, *user_pass;
 
 static struct curl_slist *pragma_header;
 
@@ -135,6 +136,20 @@ static int http_options(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+static void init_curl_http_auth(CURL *result)
+{
+	if (!user_name)
+		curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
+	else {
+		struct strbuf up = STRBUF_INIT;
+		if (!user_pass)
+			user_pass = xstrdup(getpass("Password: "));
+		strbuf_addf(&up, "%s:%s", user_name, user_pass);
+		curl_easy_setopt(result, CURLOPT_USERPWD,
+				 strbuf_detach(&up, NULL));
+	}
+}
+
 static CURL *get_curl_handle(void)
 {
 	CURL *result = curl_easy_init();
@@ -153,6 +168,8 @@ static CURL *get_curl_handle(void)
 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 #endif
 
+	init_curl_http_auth(result);
+
 	if (ssl_cert != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
 #if LIBCURL_VERSION_NUM >= 0x070902
@@ -190,6 +207,46 @@ static CURL *get_curl_handle(void)
 	return result;
 }
 
+static void http_auth_init(const char *url)
+{
+	char *at, *colon, *cp, *slash;
+	int len;
+
+	cp = strstr(url, "://");
+	if (!cp)
+		return;
+
+	/*
+	 * Ok, the URL looks like "proto://something".  Which one?
+	 * "proto://<user>:<pass>@<host>/...",
+	 * "proto://<user>@<host>/...", or just
+	 * "proto://<host>/..."?
+	 */
+	cp += 3;
+	at = strchr(cp, '@');
+	colon = strchr(cp, ':');
+	slash = strchrnul(cp, '/');
+	if (!at || slash <= at)
+		return; /* No credentials */
+	if (!colon || at <= colon) {
+		/* Only username */
+		len = at - cp;
+		user_name = xmalloc(len + 1);
+		memcpy(user_name, cp, len);
+		user_name[len] = '\0';
+		user_pass = NULL;
+	} else {
+		len = colon - cp;
+		user_name = xmalloc(len + 1);
+		memcpy(user_name, cp, len);
+		user_name[len] = '\0';
+		len = at - (colon + 1);
+		user_pass = xmalloc(len + 1);
+		memcpy(user_pass, colon + 1, len);
+		user_pass[len] = '\0';
+	}
+}
+
 void http_init(struct remote *remote)
 {
 	char *low_speed_limit;
@@ -252,6 +309,9 @@ void http_init(struct remote *remote)
 	if (getenv("GIT_CURL_FTP_NO_EPSV"))
 		curl_ftp_no_epsv = 1;
 
+	if (remote && remote->url && remote->url[0])
+		http_auth_init(remote->url[0]);
+
 #ifndef NO_CURL_EASY_DUPHANDLE
 	curl_default = get_curl_handle();
 #endif
