From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] lookup_object: prioritize recently found objects
Date: Thu, 2 May 2013 02:46:30 -0400
Message-ID: <20130502064630.GA15208@sigill.intra.peff.net>
References: <20130501203449.GA12535@sigill.intra.peff.net>
 <51820B37.8010503@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 02 08:46:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXnHq-0007MZ-Qt
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 08:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187Ab3EBGqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 02:46:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:54661 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339Ab3EBGqc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 02:46:32 -0400
Received: (qmail 1941 invoked by uid 102); 2 May 2013 06:46:48 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 May 2013 01:46:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 May 2013 02:46:30 -0400
Content-Disposition: inline
In-Reply-To: <51820B37.8010503@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223179>

On Thu, May 02, 2013 at 08:44:07AM +0200, Johannes Sixt wrote:

> Am 5/1/2013 22:34, schrieb Jeff King:
> >  struct object *lookup_object(const unsigned char *sha1)
> >  {
> > -	unsigned int i;
> > +	unsigned int i, first;
> >  	struct object *obj;
> >  
> >  	if (!obj_hash)
> >  		return NULL;
> >  
> > -	i = hashtable_index(sha1);
> > +	first = i = hashtable_index(sha1);
> >  	while ((obj = obj_hash[i]) != NULL) {
> >  		if (!hashcmp(sha1, obj->sha1))
> >  			break;
> > @@ -85,6 +85,11 @@ struct object *lookup_object(const unsigned char *sha1)
> >  		if (i == obj_hash_size)
> >  			i = 0;
> >  	}
> > +	if (obj && i != first) {
> > +		struct object *tmp = obj_hash[i];
> > +		obj_hash[i] = obj_hash[first];
> > +		obj_hash[first] = tmp;
> > +	}
> >  	return obj;
> >  }
> 
> This is one of the places where I think the code does not speak for itself
> and a comment is warranted: The new if statement is not about correctness,
> but about optimization:

I figured the lengthy description in the commit message would be
sufficient, but I don't mind adding something like your suggestion to
point readers of the code in the right direction when they see it.

-Peff
