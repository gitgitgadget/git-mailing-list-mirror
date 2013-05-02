From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] lookup_object: prioritize recently found objects
Date: Thu, 02 May 2013 08:44:07 +0200
Message-ID: <51820B37.8010503@viscovery.net>
References: <20130501203449.GA12535@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 02 08:44:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXnFa-0005c3-Ve
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 08:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062Ab3EBGoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 02:44:15 -0400
Received: from so.liwest.at ([212.33.55.13]:31171 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769Ab3EBGoO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 02:44:14 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UXnFP-0003vA-R8; Thu, 02 May 2013 08:44:08 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 921311660F;
	Thu,  2 May 2013 08:44:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <20130501203449.GA12535@sigill.intra.peff.net>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223178>

Am 5/1/2013 22:34, schrieb Jeff King:
>  struct object *lookup_object(const unsigned char *sha1)
>  {
> -	unsigned int i;
> +	unsigned int i, first;
>  	struct object *obj;
>  
>  	if (!obj_hash)
>  		return NULL;
>  
> -	i = hashtable_index(sha1);
> +	first = i = hashtable_index(sha1);
>  	while ((obj = obj_hash[i]) != NULL) {
>  		if (!hashcmp(sha1, obj->sha1))
>  			break;
> @@ -85,6 +85,11 @@ struct object *lookup_object(const unsigned char *sha1)
>  		if (i == obj_hash_size)
>  			i = 0;
>  	}
> +	if (obj && i != first) {
> +		struct object *tmp = obj_hash[i];
> +		obj_hash[i] = obj_hash[first];
> +		obj_hash[first] = tmp;
> +	}
>  	return obj;
>  }

This is one of the places where I think the code does not speak for itself
and a comment is warranted: The new if statement is not about correctness,
but about optimization:

		/*
		 * Move object to where we started to look for it
		 * so that we do not need to walk the hash table
		 * the next time we look for it.
		 */

or something.

-- Hannes
