From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] lookup_object: prioritize recently found objects
Date: Thu, 02 May 2013 09:05:01 +0200
Message-ID: <5182101D.4050807@viscovery.net>
References: <20130501203449.GA12535@sigill.intra.peff.net> <51820B37.8010503@viscovery.net> <20130502064630.GA15208@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 02 09:07:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXnbz-0006ia-Jn
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 09:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130Ab3EBHHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 03:07:22 -0400
Received: from so.liwest.at ([212.33.55.13]:50606 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130Ab3EBHFE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 03:05:04 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UXnZd-0000Gy-6v; Thu, 02 May 2013 09:05:01 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id EBF9F1660F;
	Thu,  2 May 2013 09:05:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <20130502064630.GA15208@sigill.intra.peff.net>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223180>

Am 5/2/2013 8:46, schrieb Jeff King:
> On Thu, May 02, 2013 at 08:44:07AM +0200, Johannes Sixt wrote:
>> Am 5/1/2013 22:34, schrieb Jeff King:
>>>  struct object *lookup_object(const unsigned char *sha1)
>>>  {
>>> -	unsigned int i;
>>> +	unsigned int i, first;
>>>  	struct object *obj;
>>>  
>>>  	if (!obj_hash)
>>>  		return NULL;
>>>  
>>> -	i = hashtable_index(sha1);
>>> +	first = i = hashtable_index(sha1);
>>>  	while ((obj = obj_hash[i]) != NULL) {
>>>  		if (!hashcmp(sha1, obj->sha1))
>>>  			break;
>>> @@ -85,6 +85,11 @@ struct object *lookup_object(const unsigned char *sha1)
>>>  		if (i == obj_hash_size)
>>>  			i = 0;
>>>  	}
>>> +	if (obj && i != first) {
>>> +		struct object *tmp = obj_hash[i];
>>> +		obj_hash[i] = obj_hash[first];
>>> +		obj_hash[first] = tmp;
>>> +	}
>>>  	return obj;
>>>  }
>>
>> This is one of the places where I think the code does not speak for itself
>> and a comment is warranted: The new if statement is not about correctness,
>> but about optimization:
> 
> I figured the lengthy description in the commit message would be
> sufficient,

It's absolutely sufficient *if* one reads the commit message. In this
case, though it goes more like "this function should be trivial, and it is
-- up to this if statement; what the heck is it good for?" and the reader
is forced to dig the history.

BTW, do you notice that the function is now modifying an object (the hash
table) even though this is rather unexpected from a "lookup" function?

-- Hannes
