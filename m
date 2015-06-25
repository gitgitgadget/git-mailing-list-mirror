From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/3] convert "enum date_mode" into a struct
Date: Thu, 25 Jun 2015 18:03:28 +0100
Message-ID: <20150625170328.GV18226@serenity.lan>
References: <20150625165341.GA21949@peff.net>
 <20150625165501.GB23503@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 25 19:04:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8AZD-0001pC-RP
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 19:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbbFYRDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 13:03:50 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:37233 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbbFYRDt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 13:03:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id B512986602E;
	Thu, 25 Jun 2015 18:03:48 +0100 (BST)
X-Quarantine-ID: <u4ZD2i2eSTtk>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id u4ZD2i2eSTtk; Thu, 25 Jun 2015 18:03:44 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 47393CDA659;
	Thu, 25 Jun 2015 18:03:30 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20150625165501.GB23503@peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272700>

On Thu, Jun 25, 2015 at 12:55:02PM -0400, Jeff King wrote:
> In preparation for adding date modes that may carry extra
> information beyond the mode itself, this patch converts the
> date_mode enum into a struct.
> 
> Most of the conversion is fairly straightforward; we pass
> the struct as a pointer and dereference the type field where
> necessary. Locations that declare a date_mode can use a "{}"
> constructor.  However, the tricky case is where we use the
> enum labels as constants, like:
> 
>   show_date(t, tz, DATE_NORMAL);
> 
> Ideally we could say:
> 
>   show_date(t, tz, &{ DATE_NORMAL });
> 
> but of course C does not allow that.

Yes it does, e.g. in 6.5.2.5 of C11, example 3 shows:

	drawline(&(struct point){.x=1, .y=1},
		&(struct point){.x=3, .y=4});

The cast is required, but if the argument is pointer-to-const you can
construct a temporary in the function call.

Of course, whether all of the compilers we target support it is a
different question.  If they do, perhaps something like:

#define SIMPLE_DATE(f)		&(struct date_mode) { DATE_NORMAL }

would allow the callers to remain reasonably sane.

>                                      Likewise, we cannot
> cast the constant to a struct, because we need to pass an
> actual address. Our options are basically:
> 
>   1. Manually add a "struct date_mode d = { DATE_NORMAL }"
>      definition to each caller, and pass "&d". This makes
>      the callers uglier, because they sometimes do not even
>      have their own scope (e.g., they are inside a switch
>      statement).
> 
>   2. Provide a pre-made global "date_normal" struct that can
>      be passed by address. We'd also need "date_rfc2822",
>      "date_iso8601", and so forth. But at least the ugliness
>      is defined in one place.
> 
>   3. Provide a wrapper that generates the correct struct on
>      the fly. The big downside is that we end up pointing to
>      a single global, which makes our wrapper non-reentrant.
>      But show_date is already not reentrant, so it does not
>      matter.
> 
> This patch implements 3, along with a minor macro to keep
> the size of the callers sane.
