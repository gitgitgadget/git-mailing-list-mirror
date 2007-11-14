From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't allow fast-import tree delta chains to exceed maximum depth
Date: Tue, 13 Nov 2007 21:46:01 -0800
Message-ID: <7vhcjpnzvq.fsf@gitster.siamese.dyndns.org>
References: <20071114044842.GA6876@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 14 06:46:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsB5P-0004k8-JS
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 06:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761197AbXKNFqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 00:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761271AbXKNFqP
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 00:46:15 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59151 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761041AbXKNFqO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 00:46:14 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 78F872F0;
	Wed, 14 Nov 2007 00:46:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C6B6F917D1;
	Wed, 14 Nov 2007 00:46:31 -0500 (EST)
In-Reply-To: <20071114044842.GA6876@spearce.org> (Shawn O. Pearce's message of
	"Tue, 13 Nov 2007 23:48:42 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64949>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>  Junio, this patch is against maint.  It will apply cleanly to maint
>  but is also crafted to ensure it should apply to next with git-am -3.
>  Its a real bug that's lasted a long time in fast-import.  I think
>  it is maint material.

Thanks.

> diff --git a/fast-import.c b/fast-import.c
> index c07e3d8..7544949 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -154,13 +154,16 @@ Format of STDIN stream:
>  
>  #define PACK_ID_BITS 16
>  #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
> +#define DEPTH_BITS 13
> +#define MAX_DEPTH ((1<<DEPTH_BITS)-1)
>  
>  struct object_entry
>  {
>  	struct object_entry *next;
>  	uint32_t offset;
> -	unsigned type : TYPE_BITS;
> -	unsigned pack_id : PACK_ID_BITS;
> +	uint32_t type : TYPE_BITS,
> +		pack_id : PACK_ID_BITS,
> +		depth : DEPTH_BITS;
>  	unsigned char sha1[20];
>  };

uint32_t with bit-width specifiers look somewhat funny here...

>  
> @@ -1105,7 +1108,7 @@ static int store_object(
>  		unsigned pos = sizeof(hdr) - 1;
>  
>  		delta_count_by_type[type]++;
> -		last->depth++;
> +		e->depth = ++last->depth++;

"lvalue required as increment operand"?

Wouldn't it be easier to read like this?

diff --git a/fast-import.c b/fast-import.c
index 7544949..d32c412 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -161,7 +161,7 @@ struct object_entry
 {
 	struct object_entry *next;
 	uint32_t offset;
-	uint32_t type : TYPE_BITS,
+	unsigned type : TYPE_BITS,
 		pack_id : PACK_ID_BITS,
 		depth : DEPTH_BITS;
 	unsigned char sha1[20];
@@ -1108,7 +1108,7 @@ static int store_object(
 		unsigned pos = sizeof(hdr) - 1;
 
 		delta_count_by_type[type]++;
-		e->depth = ++last->depth++;
+		e->depth = last->depth + 1;
 
 		hdrlen = encode_header(OBJ_OFS_DELTA, deltalen, hdr);
 		write_or_die(pack_data->pack_fd, hdr, hdrlen);
@@ -1121,8 +1121,6 @@ static int store_object(
 		pack_size += sizeof(hdr) - pos;
 	} else {
 		e->depth = 0;
-		if (last)
-			last->depth = 0;
 		hdrlen = encode_header(type, datlen, hdr);
 		write_or_die(pack_data->pack_fd, hdr, hdrlen);
 		pack_size += hdrlen;
@@ -1138,6 +1136,7 @@ static int store_object(
 			free(last->data);
 		last->data = dat;
 		last->offset = e->offset;
+		last->depth = e->depth;
 		last->len = datlen;
 	}
 	return 0;
