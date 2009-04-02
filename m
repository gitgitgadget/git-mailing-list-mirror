From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow curl to rewind the read buffers
Date: Thu, 02 Apr 2009 00:03:39 -0700
Message-ID: <7vwsa3h704.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0904011809080.5901@localhost.localdomain>
 <7vbprg1h3m.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0904011946510.5901@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>
To: Martin =?utf-8?Q?Storsj=C3=B6?= <martin@martin.st>
X-From: git-owner@vger.kernel.org Thu Apr 02 09:06:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpGzq-0004g4-A6
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 09:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934462AbZDBHDu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Apr 2009 03:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934436AbZDBHDt
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 03:03:49 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62229 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934356AbZDBHDr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2009 03:03:47 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9E5FEBAB2;
	Thu,  2 Apr 2009 03:03:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9860EBAAB; Thu, 
 2 Apr 2009 03:03:41 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0904011946510.5901@localhost.localdomain> (Martin
 =?utf-8?Q?Storsj=C3=B6's?= message of "Wed, 1 Apr 2009 19:48:24 +0300
 (EEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 685DE074-1F54-11DE-B941-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115448>

Martin Storsj=C3=B6 <martin@martin.st> writes:

> When using multi-pass authentication methods, the curl library may
> need to rewind the read buffers (depending on how much already has
> been fed to the server) used for providing data to HTTP PUT, POST or
> PROPFIND, and in order to allow the library to do so, we need to tell
> it how by providing either an ioctl callback or a seek callback.
>
> This patch adds an ioctl callback, which should be usable on older
> curl versions (since 7.12.3) than the seek callback (introduced in
> curl 7.18.0).
>
> Some HTTP servers (such as Apache) give an 401 error reply immediatel=
y
> after receiving the headers (so no data has been read from the read
> buffers, and thus no rewinding is needed), but other servers (such
> as Lighttpd) only replies after the whole request has been sent and
> all data has been read from the read buffers, making rewinding necess=
ary.
>
> Signed-off-by: Martin Storsjo <martin@martin.st>

Looks good, thanks.

Mike, how does this interact with your effort for defining a simplified
dependency rules on libcurl versions?=20

> Updated comment to better describe the potential need for this.
>
>  http-push.c |   24 ++++++++++++++++++++++++
>  http.c      |   19 +++++++++++++++++++
>  http.h      |    7 +++++++
>  3 files changed, 50 insertions(+), 0 deletions(-)
>
> diff --git a/http-push.c b/http-push.c
> index 6ce5a1d..7dc0dd4 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -567,6 +567,10 @@ static void start_put(struct transfer_request *r=
equest)
>  	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &request->buffer);
>  	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, request->buffer.bu=
f.len);
>  	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
> +#ifndef NO_CURL_IOCTL
> +	curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
> +	curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, &request->buffer);
> +#endif
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
>  	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PUT);
>  	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
> @@ -1267,6 +1271,10 @@ static struct remote_lock *lock_remote(const c=
har *path, long timeout)
>  	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
>  	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.buf.len=
);
>  	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
> +#ifndef NO_CURL_IOCTL
> +	curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
> +	curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, &out_buffer);
> +#endif
>  	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
>  	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
> @@ -1508,6 +1516,10 @@ static void remote_ls(const char *path, int fl=
ags,
>  	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
>  	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.buf.len=
);
>  	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
> +#ifndef NO_CURL_IOCTL
> +	curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
> +	curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, &out_buffer);
> +#endif
>  	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
>  	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
> @@ -1584,6 +1596,10 @@ static int locking_available(void)
>  	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
>  	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.buf.len=
);
>  	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
> +#ifndef NO_CURL_IOCTL
> +	curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
> +	curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, &out_buffer);
> +#endif
>  	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
>  	curl_easy_setopt(slot->curl, CURLOPT_URL, repo->url);
> @@ -1766,6 +1782,10 @@ static int update_remote(unsigned char *sha1, =
struct remote_lock *lock)
>  	curl_easy_setopt(slot->curl, CURLOPT_INFILE, &out_buffer);
>  	curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, out_buffer.buf.len=
);
>  	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
> +#ifndef NO_CURL_IOCTL
> +	curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
> +	curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, &out_buffer);
> +#endif
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
>  	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PUT);
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
> @@ -1910,6 +1930,10 @@ static void update_remote_info_refs(struct rem=
ote_lock *lock)
>  		curl_easy_setopt(slot->curl, CURLOPT_INFILE, &buffer);
>  		curl_easy_setopt(slot->curl, CURLOPT_INFILESIZE, buffer.buf.len);
>  		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, fread_buffer);
> +#ifndef NO_CURL_IOCTL
> +		curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
> +		curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, &buffer);
> +#endif
>  		curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
>  		curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PUT);
>  		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
> diff --git a/http.c b/http.c
> index eae74aa..3e8d548 100644
> --- a/http.c
> +++ b/http.c
> @@ -44,6 +44,25 @@ size_t fread_buffer(void *ptr, size_t eltsize, siz=
e_t nmemb, void *buffer_)
>  	return size;
>  }
> =20
> +#ifndef NO_CURL_IOCTL
> +curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
> +{
> +	struct buffer *buffer =3D clientp;
> +
> +	switch (cmd) {
> +	case CURLIOCMD_NOP:
> +		return CURLIOE_OK;
> +
> +	case CURLIOCMD_RESTARTREAD:
> +		buffer->posn =3D 0;
> +		return CURLIOE_OK;
> +
> +	default:
> +		return CURLIOE_UNKNOWNCMD;
> +	}
> +}
> +#endif
> +
>  size_t fwrite_buffer(const void *ptr, size_t eltsize, size_t nmemb, =
void *buffer_)
>  {
>  	size_t size =3D eltsize * nmemb;
> diff --git a/http.h b/http.h
> index 905b462..26abebe 100644
> --- a/http.h
> +++ b/http.h
> @@ -37,6 +37,10 @@
>  #define CURLE_HTTP_RETURNED_ERROR CURLE_HTTP_NOT_FOUND
>  #endif
> =20
> +#if LIBCURL_VERSION_NUM < 0x070c03
> +#define NO_CURL_IOCTL
> +#endif
> +
>  struct slot_results
>  {
>  	CURLcode curl_result;
> @@ -67,6 +71,9 @@ struct buffer
>  extern size_t fread_buffer(void *ptr, size_t eltsize, size_t nmemb, =
void *strbuf);
>  extern size_t fwrite_buffer(const void *ptr, size_t eltsize, size_t =
nmemb, void *strbuf);
>  extern size_t fwrite_null(const void *ptr, size_t eltsize, size_t nm=
emb, void *strbuf);
> +#ifndef NO_CURL_IOCTL
> +extern curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp);
> +#endif
> =20
>  /* Slot lifecycle functions */
>  extern struct active_request_slot *get_active_slot(void);
> --=20
> 1.6.0.2
