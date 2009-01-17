From: "Ray Chuan" <rctay89@gmail.com>
Subject: Re: [PATCH 1/2] http-push: send opaquelocktoken in If: for PUT requests
Date: Sat, 17 Jan 2009 20:14:47 +0000
Message-ID: <be6fef0d0901171214h44b80a5drd2dd11f2bd65cf53@mail.gmail.com>
References: <be6fef0d0901171210o97a24carf902e82848d48b5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 21:16:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOHaW-00083C-4W
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 21:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763137AbZAQUOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 15:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765936AbZAQUOt
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 15:14:49 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:51046 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763655AbZAQUOs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 15:14:48 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1158959wah.21
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 12:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=t0N7mEXdagj+sReEsjx1FPTm4UD+P5O/BZy0fjgaFT4=;
        b=uiuzBcFEyTxWjm+ATuxizBjGznNOY42xQTHgUypT1Uh2T+EDu6739RQQgoZXj/5e9e
         4+/evc6oxipwydJJVIq97wFJdoVsRH+PXPZbATTwvQPfOKmy/ogZqLYTs4/Gs5th1C4V
         PBwwVHhODIIfKghvn830g69v/ihXfS/dMKUJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=LJPKpsxesGlfGYwRmW7GPTtU5rjyrLzBdvsZCye/P4QJiCXPhwc47M9WPgI3U5a4fp
         mCYvA23jQfqT6NsJLJK8UfrIgSQmu8ZDtrgDS0d9FcjSFrdyDZHx7yBncE6Zj8shhJha
         f5n30XrkZW4n63wdiC6GvLyB4sw74A7xvch9Q=
Received: by 10.114.145.1 with SMTP id s1mr2781473wad.223.1232223287433;
        Sat, 17 Jan 2009 12:14:47 -0800 (PST)
Received: by 10.114.196.2 with HTTP; Sat, 17 Jan 2009 12:14:47 -0800 (PST)
In-Reply-To: <be6fef0d0901171210o97a24carf902e82848d48b5d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106102>

oops, i incorrectly stated in the commit message that the request URL
for PUT was modified; i apologize for that error.

On 1/17/09, Ray Chuan <rctay89@gmail.com> wrote:
> Currently, git PUTs to
>
>   /repo.git/objects/1a/1a2b...9z_opaquelocktoken:1234-....
>
> On some platforms, ':' isn't allowed in filenames so the PUT fails.
> This seems to be an (faulty) implementation of the opaquelocktoken URI
> scheme (http://www.webdav.org/specs/rfc4918.html#RFC2518).
>
> PUT now sends the object to the url
>
>   /repo.git/objects/1a/1a2b...9z
>
> , without the trailing '_opaquelocktoken:1234-....', with an
> additional "If: (<opaquelocktoken:1234-....>)" header.
>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>  http-push.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/http-push.c b/http-push.c
> index c9ba07e..4517cf2 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -480,7 +480,9 @@ static void start_put(struct transfer_request *request)
>  {
>  	char *hex = sha1_to_hex(request->obj->sha1);
>  	struct active_request_slot *slot;
> +	struct curl_slist *dav_headers = NULL;
>  	char *posn;
> +	char *if_header;
>  	enum object_type type;
>  	char hdr[50];
>  	void *unpacked;
> @@ -535,6 +537,10 @@ static void start_put(struct transfer_request *request)
>  	*(posn++) = '_';
>  	strcpy(posn, request->lock->token);
>
> +	if_header = xmalloc(strlen(request->lock->token) + 25);
> +	sprintf(if_header, "If: <%s>", request->lock->token);
> +	dav_headers = curl_slist_append(dav_headers, if_header);
> +
>  	slot = get_active_slot();
>  	slot->callback_func = process_response;
>  	slot->callback_data = request;
> @@ -546,6 +552,7 @@ static void start_put(struct transfer_request *request)
>  	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
>  	curl_easy_setopt(slot->curl, CURLOPT_PUT, 1);
>  	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
> +	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
>  	curl_easy_setopt(slot->curl, CURLOPT_URL, request->url);
>
>  	if (start_active_slot(slot)) {
> --
> 1.5.6.3
>


-- 
Cheers,
Ray Chuan
