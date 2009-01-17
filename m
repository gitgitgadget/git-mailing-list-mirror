From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] http-push: when sending objects, don't PUT before
 MOVE
Date: Sat, 17 Jan 2009 07:13:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901170706450.3586@pacific.mpi-cbg.de>
References: <be6fef0d0901161859g4e5d749et78b6b0231eb915ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 07:13:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO4RF-0001G4-L4
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 07:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbZAQGMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 01:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbZAQGMV
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 01:12:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:50876 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751987AbZAQGMT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 01:12:19 -0500
Received: (qmail invoked by alias); 17 Jan 2009 06:12:18 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp010) with SMTP; 17 Jan 2009 07:12:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18taK44CZct5EpUHV1SAXyAwgLzfzT3IRlU4T9oxJ
	SQsZqgWwwdNKhT
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <be6fef0d0901161859g4e5d749et78b6b0231eb915ee@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106031>

Hi,

On Sat, 17 Jan 2009, Ray Chuan wrote:

> since 753bc911f489748a837ecb5ea4b5216220b24845, the opaquelocktocken

It would be nice to use the form <abbrev-sha1>(<oneline>) instead of a 
non-abbreviated SHA-1 that everybody who is interested has to look up, 
wasting time.

> URI isn't used, so it doesn't make sense to PUT then MOVE.
> 
> currently, git PUTs to
> 
> /repo.git/objects/1a/1a2b..._opaquelocktoken:1234-....

First you say that the opaquelocktoken URI is not used, but here it looks 
like one?

> on some platforms, ':' isn't allowed in filenames so this fails
> (assuming the server doesn't recognize it as opaquelocktoken scheme).
> in fact, i don't think this is the correct implementation of the
> scheme; 'opaquelocktoken: ' should come in front of the path.

It would be nice to make that a fact-backed commit message.  IOW there has 
to be some documentation about the subject which you can quote, and which 
would give you a definitive answer to the question if it should be a 
prefix or not.

> diff --git a/src/git-1.6.1/http-push.c b/src/git-1.6.1/http-push.c
> index a646a49..838ff6f 100644
> --- a/src/git-1.6.1/http-push.c
> +++ b/src/git-1.6.1/http-push.c
> @@ -31,7 +31,6 @@ enum XML_Status {
>  /* DAV methods */
>  #define DAV_LOCK "LOCK"
>  #define DAV_MKCOL "MKCOL"
> -#define DAV_MOVE "MOVE"
>  #define DAV_PROPFIND "PROPFIND"
>  #define DAV_PUT "PUT"
>  #define DAV_UNLOCK "UNLOCK"
> @@ -104,7 +103,6 @@ enum transfer_state {
>  	NEED_PUSH,
>  	RUN_MKCOL,
>  	RUN_PUT,
> -	RUN_MOVE,
>  	ABORTED,
>  	COMPLETE,
>  };
> @@ -528,11 +526,6 @@ static void start_put(struct transfer_request *request)
>  	posn += 2;
>  	*(posn++) = '/';
>  	strcpy(posn, hex + 2);
> -	request->dest = xmalloc(strlen(request->url) + 14);
> -	sprintf(request->dest, "Destination: %s", request->url);
> -	posn += 38;
> -	*(posn++) = '_';
> -	strcpy(posn, request->lock->token);
> 
>  	slot = get_active_slot();
>  	slot->callback_func = process_response;

Color me puzzled again.  Why is this code no longer needed?  Is this the 
lock you were talking about?

> @@ -705,23 +672,13 @@ static void finish_request(struct
> transfer_request *request)
>  		}
>  	} else if (request->state == RUN_PUT) {
>  		if (request->curl_result == CURLE_OK) {
> -			start_move(request);
> -		} else {
> -			fprintf(stderr,	"PUT %s failed, aborting (%d/%ld)\n",
> -				sha1_to_hex(request->obj->sha1),
> -				request->curl_result, request->http_code);
> -			request->state = ABORTED;
> -			aborted = 1;
> -		}

... and here comes my first doubt that it would be a good idea to avoid 
"put && move"; what if "put" fails?  Then you end up with a corrupt 
repository.

Ciao,
Dscho
