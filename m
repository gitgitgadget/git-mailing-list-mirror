From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2 1/4] Refactoring: remove duplicated code from
 builtin-send-pack.c and transport.c
Date: Tue, 16 Feb 2010 10:16:13 +0800
Message-ID: <20100216101613.4ce36ee1.rctay89@gmail.com>
References: <1266276411-5796-1-git-send-email-michael.lukashov@gmail.com>
	<1266276411-5796-2-git-send-email-michael.lukashov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 03:16:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhCzM-0002NG-2i
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 03:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501Ab0BPCQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 21:16:25 -0500
Received: from mail-gx0-f224.google.com ([209.85.217.224]:36107 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932489Ab0BPCQY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 21:16:24 -0500
Received: by gxk24 with SMTP id 24so5416896gxk.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 18:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=KiB3hhXMvkLTFiPFgjj2N6cl3xR6ahQsjm33RQmsQaY=;
        b=fznYpq/Ar191UfaSZrVZ2uCS3MliOWT6exbprenXtyqaTxaSp6X8H5AZtDxOkyNl9L
         JGnPLdyf0iTi8PqRl+8KRUa9NCFYJNQmwvaZ1PZOL0rVlBt/y7t0yh1/Qz6g7SX6ADSQ
         zaKUa17QkaHIF1Mkae36TZBNdXnXS0ldLD8u4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=wRGighfBMF0zoiMwhvZ4lmreNWJHMAXLbiWwP9j3FgLDJ7GuRWDwYldRoKMEPjtWOc
         zfKlvjORCN6DjzyeEX2DUQHZRoH2hfy/awxQWcYjsiTyJmMPoZP/eKIsP5+OHou/LU7J
         V1mmGpR8FGQc28za8JqnfzEgWYH9Lpa3YUgl0=
Received: by 10.100.224.19 with SMTP id w19mr3289595ang.208.1266286583514;
        Mon, 15 Feb 2010 18:16:23 -0800 (PST)
Received: from your-cukc5e3z5n (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 13sm4888230gxk.13.2010.02.15.18.16.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Feb 2010 18:16:22 -0800 (PST)
In-Reply-To: <1266276411-5796-2-git-send-email-michael.lukashov@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140058>

Hi,

On Mon, 15 Feb 2010 23:26:47 +0000
Michael Lukashov <michael.lukashov@gmail.com> wrote:

> The following functions are (almost) identical:
> 
>   verify_remote_names
>   update_tracking_ref
>   print_ref_status
>   status_abbrev
>   print_ok_ref_status
>   print_one_push_status
>   refs_pushed
>   print_push_status
> 
> Move common versions of these functions to transport.c and rename them,
> as suggested by Jeff King and Junio C Hamano

this is misleading. This list should the 4 functions added to
transport.h. Some of the functions have been removed entirely from
builtin-send-pack.c and aren't renamed at all (eg. print_ref_status,
print_one_push_status).

For these, you could put them in another list, and say that "they have
been removed entirely and will not be made public, since they are only
used internally by print_push_status()."

> diff --git a/transport.c b/transport.c
> index 3846aac..0924288 100644
> --- a/transport.c
> +++ b/transport.c
> [snip]
> @@ -609,9 +609,8 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref, int verb
>  	}
>  }
>  
> -#define SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
> -
> -static void print_ref_status(char flag, const char *summary, struct ref *to, struct ref *from, const char *msg, int porcelain)
> +static void print_ref_status(char flag, const char *summary, struct ref *to,
> +		  struct ref *from, const char *msg, int porcelain)
>  {
>  	if (porcelain) {
>  		if (from)

Unrelated whitespace change in the method signature.

> @@ -687,7 +686,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
>  		break;
>  	case REF_STATUS_UPTODATE:
>  		print_ref_status('=', "[up to date]", ref,
> -						 ref->peer_ref, NULL, porcelain);
> +				 ref->peer_ref, NULL, porcelain);
>  		break;
>  	case REF_STATUS_REJECT_NONFASTFORWARD:
>  		print_ref_status('!', "[rejected]", ref, ref->peer_ref,

Unrelated whitespace change.

> @@ -711,8 +710,8 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
>  	return 1;
>  }
>  
> -static void print_push_status(const char *dest, struct ref *refs,
> -			      int verbose, int porcelain, int * nonfastforward)
> +void transport_print_push_status(const char *dest, struct ref *refs,
> +		  int verbose, int porcelain, int *nonfastforward)
>  {
>  	struct ref *ref;
>  	int n = 0;

Unrelated whitespace change for the second line of the signature.

-- 
Cheers,
Ray Chuan
