From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] upload-pack: avoid parsing objects during ref
 advertisement
Date: Thu, 24 Jan 2013 02:50:08 -0500
Message-ID: <20130124075008.GA3249@sigill.intra.peff.net>
References: <7vipkpn87d.fsf@alter.siamese.dyndns.org>
 <20120106191740.GA12903@sigill.intra.peff.net>
 <7vehhiozkb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 08:50:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyHZy-0005K8-2A
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 08:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777Ab3AXHuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 02:50:13 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48056 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242Ab3AXHuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 02:50:11 -0500
Received: (qmail 14158 invoked by uid 107); 24 Jan 2013 07:51:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Jan 2013 02:51:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2013 02:50:08 -0500
Content-Disposition: inline
In-Reply-To: <7vehhiozkb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214410>

On Fri, Jan 18, 2013 at 03:12:52PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > When we advertise a ref, the first thing we do is parse the
> > pointed-to object. This gives us two things:
> >
> >   1. a "struct object" we can use to store flags
> >
> >   2. the type of the object, so we know whether we need to
> >      dereference it as a tag
> >
> > Instead, we can just use lookup_unknown_object to get an
> > object struct, and then fill in just the type field using
> > sha1_object_info (which, in the case of packed files, can
> > find the information without actually inflating the object
> > data).
> >
> > This can save time if you have a large number of refs, and
> > the client isn't actually going to request those refs (e.g.,
> > because most of them are already up-to-date).
> 
> This is an old news, but do you recall why this patch did not update
> the code in mark_our_ref() that gets "struct object *o" from parse_object()
> the same way and mark them with OUR_REF flag?
> 
> I was wondering about code consolidation like this.

It was just because I did my measuring on raw upload-pack, so I didn't
notice that mark_our_ref was doing the same potentially slow thing. We
only call mark_our_ref during the second half of the stateless-rpc
conversation, and I did not measure that (and it would be a pain to do
so in isolation).

But it should be able to get the exact same speedups that we get from
send_ref. It probably matters less in the long run, because the
advertising phase is going to be called more frequently (e.g., for every
no-op fetch), and once we are calling mark_our_ref, we are presumably
about to do do actual packing work. However, there's no reason not to
get what speed we can there, too.

> diff --git a/upload-pack.c b/upload-pack.c
> index 95d8313..609cd6c 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -722,15 +722,18 @@ static void receive_needs(void)
>  	free(shallows.objects);
>  }
>  
> +static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data);
> +
>  static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
>  {
>  	static const char *capabilities = "multi_ack thin-pack side-band"
>  		" side-band-64k ofs-delta shallow no-progress"
>  		" include-tag multi_ack_detailed";
> -	struct object *o = lookup_unknown_object(sha1);
>  	const char *refname_nons = strip_namespace(refname);
>  	unsigned char peeled[20];
>  
> +	mark_our_ref(refname, sha1, flag, cb_data);
> +
>  	if (capabilities)
>  		packet_write(1, "%s %s%c%s%s agent=%s\n",
>  			     sha1_to_hex(sha1), refname_nons,
> @@ -740,10 +743,6 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
>  	else
>  		packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname_nons);
>  	capabilities = NULL;
> -	if (!(o->flags & OUR_REF)) {
> -		o->flags |= OUR_REF;
> -		nr_our_refs++;
> -	}
>  	if (!peel_ref(refname, peeled))
>  		packet_write(1, "%s %s^{}\n", sha1_to_hex(peeled), refname_nons);
>  	return 0;

Right, I think this is a nice cleanup.

> @@ -751,7 +750,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
>  
>  static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
>  {
> -	struct object *o = parse_object(sha1);
> +	struct object *o = parse_object(sha1); /* lookup-unknown??? */
>  	if (!o)
>  		die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
>  	if (!(o->flags & OUR_REF)) {

And yeah, this should use lookup_unknown_object to extend the
optimization to mark_our_ref (and avoid removing it for the
ref-advertisement case, of course).

-Peff
