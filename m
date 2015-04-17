From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] type_from_string_gently: make sure length matches
Date: Fri, 17 Apr 2015 17:07:13 -0400
Message-ID: <20150417210713.GA7403@peff.net>
References: <20150417145247.GA2421@peff.net>
 <xmqqd232pjb0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Karthik Nayak <karthik.188@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 23:07:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjDTt-00025H-Rz
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 23:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbbDQVHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 17:07:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:46958 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751664AbbDQVHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 17:07:16 -0400
Received: (qmail 20308 invoked by uid 102); 17 Apr 2015 21:07:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Apr 2015 16:07:16 -0500
Received: (qmail 6056 invoked by uid 107); 17 Apr 2015 21:07:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Apr 2015 17:07:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Apr 2015 17:07:13 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd232pjb0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267392>

On Fri, Apr 17, 2015 at 01:54:27PM -0700, Junio C Hamano wrote:

> > Since the strings we are matching are literals, we could also record
> > their sizes in the object_type_strings array and check the length first
> > before even calling strncmp. I doubt this is a performance hot-spot,
> > though.
> >
> > You could also potentially just use strlen(object_type_strings[i]), but
> > I'm not sure if compilers will optimize out the strlen in this case,
> > since it is in a loop.
> 
> That thought crossed my mind while reading your patch.  It could
> even make it go faster if we made object_type_strings into an array
> of counted strings (i.e. "struct { const char *str; int len; }")
> and then took advantage of the fact that we have lengths of both.

Right, that was what I meant.

I'd be surprised if it appreciably speeds things up, but I guess it is
not too complicated to do.

> +static struct {
> +	const char *str;
> +	int len;
> +} object_type_name[] = {
> +	{ NULL, 0 },      /* OBJ_NONE = 0 */
> +	{ "commit", 6 },  /* OBJ_COMMIT = 1 */
> +	{ "tree", 4 },	  /* OBJ_TREE = 2 */
> +	{ "blob", 4 },    /* OBJ_BLOB = 3 */
> +	{ "tag", 3 },     /* OBJ_TAG = 4 */
>  };

I had envisioned a macro like:

  #define SIZED_STRING(x) { (x), (sizeof(x) - 1) }

though perhaps that is overkill for such a short list (that we don't
even expect to change).

-Peff
