From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cloning from sites with 404 overridden
Date: Wed, 22 Mar 2006 11:05:50 -0800
Message-ID: <7vslpa8fld.fsf@assigned-by-dhcp.cox.net>
References: <20060322025921.1722.qmail@science.horizon.com>
	<20060322172227.GO3997@reactrix.com>
	<20060322183621.GP3997@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 22 20:06:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FM8eo-0008IE-T3
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 20:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWCVTFx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 14:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWCVTFx
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 14:05:53 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:15330 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932342AbWCVTFw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 14:05:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060322190147.PWKR17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Mar 2006 14:01:47 -0500
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20060322183621.GP3997@reactrix.com> (Nick Hengeveld's message of
	"Wed, 22 Mar 2006 10:36:21 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17819>

Nick Hengeveld <nickh@reactrix.com> writes:

> Some HTTP server environments return a 200 status and text/html error
> document or a redirect to one rather than a 404 status if a loose
> object does not exist.  This patch detects and reports this condition
> to differentiate between a misconfigured server and an actual corrupt
> object on the server.

> 61069cc348640fef2b8c503b8b8f00f689872cab
> diff --git a/http-fetch.c b/http-fetch.c
> index dc67218..ee5b585 100644
> --- a/http-fetch.c
> +++ b/http-fetch.c
> @@ -41,6 +41,7 @@ struct object_request
>  	CURLcode curl_result;
>...
> +	char *content_type;
>  	unsigned char real_sha1[20];
>...

You probably need only one bit here,...

> @@ -258,9 +259,15 @@ static void finish_object_request(struct
>  
>  static void process_object_response(void *callback_data)
>...  
> +	curl_easy_getinfo(obj_req->slot->curl, CURLINFO_CONTENT_TYPE,
> +			  &content_type);
> +	if (content_type)
> +		obj_req->content_type = strdup(content_type);
> +

... and note if that is an HTML document or not.

We do bend backwards to support ISP HTTP servers, but this might
be going a bit too far.  Also I wonder if ISP runs a really
dumb-friendly configured server that defaults to text/html
unless the mimemap says otherwise.  Loose object files do not
have suffixes and I am expecting these servers would give
whatever the server default is.
