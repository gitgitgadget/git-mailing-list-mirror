From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Wed, 27 Mar 2013 23:02:28 -0700
Message-ID: <7v7gksjc3v.fsf@alter.siamese.dyndns.org>
References: <1364446721-13351-1-git-send-email-jkoleszar@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Josh Triplett <josh@joshtriplett.org>,
	John Koleszar <jkoleszar@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 07:03:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UL5vP-0004KI-8I
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 07:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280Ab3C1GCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 02:02:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39201 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074Ab3C1GCb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 02:02:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A766B7544;
	Thu, 28 Mar 2013 02:02:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PjWEn2lRxnX+Qe/9qdhLJ3kTWuM=; b=jS+f0V
	Pr1awX87sNfkqehIOTfpsJ/+rKv9WuC2e19b9Z8VlxoAUwaWlQenLeEB6pNLPsBK
	8CMxqEFqUpelwj4WGX9Bk2xT9bkf7YARq0yf4P8sp8aZDREnGC2mIYEb5NO7uDUM
	ia7pGYtZqvoWUUfLHStC51GsQWq+QEeyOcvrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=htXHi+Nipy2dkZzmpwbgp7VNDCS+1pLJ
	88hpyAaInWCD0Uwtt/4dfnmXUu6nDc00Ppual60t0vjxQHdCniTX0+F5M8DAjk/1
	b5zSg+8BUfH2GxvuFkdCoWZp6v6/n3kWBxTveCaYExeau04N/3Wee+/2SkGw8ufx
	yilbGEwZ7h4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C50C7543;
	Thu, 28 Mar 2013 02:02:30 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D234D753F; Thu, 28 Mar 2013
 02:02:29 -0400 (EDT)
In-Reply-To: <1364446721-13351-1-git-send-email-jkoleszar@google.com> (John
 Koleszar's message of "Wed, 27 Mar 2013 21:58:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12E3F7BA-976D-11E2-B043-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219368>

John Koleszar <jkoleszar@google.com> writes:

> Filter the list of refs returned via the dumb HTTP protocol according
> to the active namespace, consistent with other clients of the
> upload-pack service.
>
> Signed-off-by: John Koleszar <jkoleszar@google.com>
> ---

Looks sane from a cursory read---thanks.

Josh, any comments?

>  http-backend.c          |  8 +++++---
>  t/lib-httpd/apache.conf |  5 +++++
>  t/t5561-http-backend.sh |  4 ++++
>  t/t556x_common          | 16 ++++++++++++++++
>  4 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/http-backend.c b/http-backend.c
> index f50e77f..b9896b0 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -361,17 +361,19 @@ static void run_service(const char **argv)
>  static int show_text_ref(const char *name, const unsigned char *sha1,
>  	int flag, void *cb_data)
>  {
> +	const char *name_nons = strip_namespace(name);
>  	struct strbuf *buf = cb_data;
>  	struct object *o = parse_object(sha1);
>  	if (!o)
>  		return 0;
>  
> -	strbuf_addf(buf, "%s\t%s\n", sha1_to_hex(sha1), name);
> +	strbuf_addf(buf, "%s\t%s\n", sha1_to_hex(sha1), name_nons);
>  	if (o->type == OBJ_TAG) {
>  		o = deref_tag(o, name, 0);
>  		if (!o)
>  			return 0;
> -		strbuf_addf(buf, "%s\t%s^{}\n", sha1_to_hex(o->sha1), name);
> +		strbuf_addf(buf, "%s\t%s^{}\n", sha1_to_hex(o->sha1),
> +		            name_nons);
>  	}
>  	return 0;
>  }
> @@ -402,7 +404,7 @@ static void get_info_refs(char *arg)
>  
>  	} else {
>  		select_getanyfile();
> -		for_each_ref(show_text_ref, &buf);
> +		for_each_namespaced_ref(show_text_ref, &buf);
>  		send_strbuf("text/plain", &buf);
>  	}
>  	strbuf_release(&buf);
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index 938b4cf..ad85537 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -61,6 +61,11 @@ Alias /auth/dumb/ www/auth/dumb/
>  	SetEnv GIT_COMMITTER_NAME "Custom User"
>  	SetEnv GIT_COMMITTER_EMAIL custom@example.com
>  </LocationMatch>
> +<LocationMatch /smart_namespace/>
> +	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
> +	SetEnv GIT_HTTP_EXPORT_ALL
> +	SetEnv GIT_NAMESPACE ns
> +</LocationMatch>
>  ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
>  ScriptAlias /broken_smart/ broken-smart-http.sh/
>  <Directory ${GIT_EXEC_PATH}>
> diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
> index b5d7fbc..5a19d61 100755
> --- a/t/t5561-http-backend.sh
> +++ b/t/t5561-http-backend.sh
> @@ -134,6 +134,10 @@ POST /smart/repo.git/git-receive-pack HTTP/1.1 200 -
>  ###
>  GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
>  POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
> +
> +###  namespace test
> +###
> +GET  /smart_namespace/repo.git/info/refs HTTP/1.1 200
>  EOF
>  test_expect_success 'server request log matches test results' '
>  	sed -e "
> diff --git a/t/t556x_common b/t/t556x_common
> index 82926cf..cb9eb9d 100755
> --- a/t/t556x_common
> +++ b/t/t556x_common
> @@ -120,3 +120,19 @@ test_expect_success 'http.receivepack false' '
>  	GET info/refs?service=git-receive-pack "403 Forbidden" &&
>  	POST git-receive-pack 0000 "403 Forbidden"
>  '
> +test_expect_success 'backend respects namespaces' '
> +	log_div "namespace test"
> +	config http.uploadpack true &&
> +	config http.getanyfile true &&
> +
> +	GIT_NAMESPACE=ns && export GIT_NAMESPACE &&
> +	git push public master:master &&
> +	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +		git for-each-ref | grep /$GIT_NAMESPACE/ >/dev/null
> +	) &&
> +
> +	git ls-remote public >exp &&  
> +	curl "$HTTPD_URL/smart_namespace/repo.git/info/refs" >act &&
> +	test_cmp exp act &&
> +	(grep /ns/ exp && false || true)
> +'
