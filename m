From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sha1_name: support sha1^{note} to return note sha-1
Date: Tue, 8 May 2012 12:11:26 -0400
Message-ID: <20120508161126.GB26838@sigill.intra.peff.net>
References: <1336482870-30842-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 18:11:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRn0f-0005ub-4X
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 18:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144Ab2EHQL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 12:11:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34147
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755900Ab2EHQL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 12:11:28 -0400
Received: (qmail 4604 invoked by uid 107); 8 May 2012 16:11:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 May 2012 12:11:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2012 12:11:26 -0400
Content-Disposition: inline
In-Reply-To: <1336482870-30842-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197381>

On Tue, May 08, 2012 at 08:14:30PM +0700, Nguyen Thai Ngoc Duy wrote:

>  It may be useful for scripting, and looks nice. Though may be not
>  worth adding if there are no actual users.

There can be many notes refs. So I think to do this right, you would
want something like:

  foo^{note:bar}

which would look in refs/notes/bar (this logic is handled by
expand_notes_ref). And "foo^{note}" would be a synonym for the default
note ref.

> @@ -473,7 +474,19 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
>  		expected_type = OBJ_NONE;
>  	else if (sp[0] == '/')
>  		expected_type = OBJ_COMMIT;
> -	else
> +	else if (!strncmp("note}", sp, 5)) {
> +		const unsigned char *note;
> +		struct notes_tree t;
> +		if (get_sha1_1(name, sp - name - 2, outer))
> +			return -1;
> +		memset(&t, 0, sizeof(t));
> +		init_notes(&t, NULL, NULL, 0);
> +		note = get_note(&t, outer);
> +		if (note)
> +			hashcpy(sha1, note);
> +		free_notes(&t);
> +		return note ? 0 : -1;
> +	} else

The notes code is relatively expensive to initialize, with the
assumption that the effort will be amortized across multiple lookups
(which are made faster). Is it possible to cache this initialized notes
structure in case many lookups are done?

It may not be as important as it used to be, either. I think more recent
versions of the code will progressively load the notes tree rather than
filling it all in at initialization time. But it has been a while since
I've done anything with notes.

-Peff
