From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] transport: drop "int cmp = cmp" hack
Date: Mon, 25 Mar 2013 17:06:25 -0400
Message-ID: <20130325210625.GA16386@sigill.intra.peff.net>
References: <20130321110338.GA18552@sigill.intra.peff.net>
 <20130321111333.GD18819@sigill.intra.peff.net>
 <CAPc5daVOksx56js_ascEr348PTLAZB9OeBrf3sELJUpdyB_kMg@mail.gmail.com>
 <20130324093212.GA28234@sigill.intra.peff.net>
 <7vfvzjxnq9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 22:06:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKEbZ-0007Dd-TA
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 22:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758671Ab3CYVG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 17:06:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39395 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab3CYVG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 17:06:28 -0400
Received: (qmail 28357 invoked by uid 107); 25 Mar 2013 21:08:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Mar 2013 17:08:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2013 17:06:25 -0400
Content-Disposition: inline
In-Reply-To: <7vfvzjxnq9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219090>

On Mon, Mar 25, 2013 at 12:50:54PM -0700, Junio C Hamano wrote:

> >> transport.c: In function 'get_refs_via_rsync':
> >> transport.c:127:29: error: 'cmp' may be used uninitialized in this
> >> function [-Werror=uninitialized]
> >> transport.c:109:7: note: 'cmp' was declared here
> >> 
> >> gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
> >
> > Right, that's the same version I noted above. Is 4.6.3 the default
> > compiler under a particular release of Ubuntu, or did you use their
> > gcc-4.6 package?
> 
> I'll check later with one of my VMs.  The copy of U 12.04 I happened
> to have handy has that version installed.

Ah, if you didn't explicitly run "gcc-4.6", then it was probably the
default version in 12.04 (as it was for a while in Debian testing, but
they never actually made a release with it, so everybody is now on 4.7
by default).

> By the way, I find this piece of code less than pleasant:
> 
>  * It uses "struct ref dummy = { NULL }, *tail = &dummy", and then
>    accumulates things by appending to "&tail" and then returns
>    dummy.next.  Why doesn't it do
> 
> 	struct ref *retval = NULL, **tail = &retval;
> 
>    and pass tail around to append things, like everybody else?  Is
>    this another instance of "People do not understand linked list"
>    problem?  Perhaps fixing that may unconfuse the compiler?

Ugh, that is horrible. At first I thought it was even wrong, as we pass
&tail and not &dummy.next to read_loose_refs. But two wrongs _do_ make a
right, because read_loose_refs, rather than do:

  *tail = new;
  tail = &new->next;

does:

  (*tail)->next = new;
  *tail = new;

>    Later, the tail of the same list is passed to insert_packed_refs(),
>    which does in-place merging of this list and the contents of the
>    packed_refs file.  These two data sources have to be sorted the
>    same way for this merge to work correctly, but there is no
>    validating the order of the entries it reads from the packed-refs
>    file.  At least, it should barf when the file is not sorted.  It
>    could be lenient and accept a mal-sorted input, but I do not think
>    that is advisable.

Actually, it is the head of the loose list (though it is hard to
realize, because it is called tail!).

> I'll apply the attached on 'maint' for now, as rsync is not worth
> spending too many cycles on worrying about; I need to go to the
> bathroom to wash my eyes after staring this code for 20 minutes X-<.

Yeah, it's quite ugly. I really wonder if it is time to drop rsync
support. I'd be really surprised if anybody is actively using it.

I wonder, though, what made you look at this. It did not come up in my
list of -Wuninitialized warnings. Did it get triggered by one of the
other gcc versions?

> diff --git a/transport.c b/transport.c
> index 87b8f14..e6f9346 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -106,7 +106,8 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
>  		return;
>  
>  	for (;;) {
> -		int cmp, len;
> +		int cmp = 0; /* assigned before used */
> +		int len;
>  
>  		if (!fgets(buffer, sizeof(buffer), f)) {
>  			fclose(f);

I think that's fine.

-Peff
