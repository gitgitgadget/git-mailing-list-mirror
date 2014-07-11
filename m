From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/2] alloc.c: remove the alloc_raw_commit_node()
 function
Date: Thu, 10 Jul 2014 20:09:56 -0400
Message-ID: <20140711000956.GA11360@sigill.intra.peff.net>
References: <53BF28A7.7000903@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 11 02:10:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5OPc-00057N-Kq
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 02:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbaGKAKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 20:10:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:59737 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751279AbaGKAJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 20:09:59 -0400
Received: (qmail 25496 invoked by uid 102); 11 Jul 2014 00:09:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Jul 2014 19:09:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jul 2014 20:09:56 -0400
Content-Disposition: inline
In-Reply-To: <53BF28A7.7000903@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253240>

On Fri, Jul 11, 2014 at 12:58:31AM +0100, Ramsay Jones wrote:

>  #define DEFINE_ALLOCATOR(name, type)				\
> -static unsigned int name##_allocs;				\
> +static struct alloc_state name##_state;				\
>  void *alloc_##name##_node(void)					\
>  {								\
> -	static int nr;						\
> -	static type *block;					\
> -	void *ret;						\
> -								\
> -	if (!nr) {						\
> -		nr = BLOCKING;					\
> -		block = xmalloc(BLOCKING * sizeof(type));	\
> -	}							\
> -	nr--;							\
> -	name##_allocs++;					\
> -	ret = block++;						\
> -	memset(ret, 0, sizeof(type));				\
> -	return ret;						\
> +	return alloc_node(&name##_state, sizeof(type));		\
>  }

Yay. Not only does this solve the problem, but it gets rid of nasty
multi-line macro. In fact, I kind of wonder if we should just do away
with the macro entirely, and write out:

  static struct alloc_state blob_state;
  void alloc_blob_node(void)
  {
	return alloc_node(&blob_state, sizeof(struct blob));
  }

It's more lines, but it is probably less obfuscated to a reader.

-Peff
