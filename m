From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 05/32] refs: add a backend method structure with
 transaction functions
Date: Fri, 26 Feb 2016 23:06:44 -0500
Message-ID: <20160227040643.GB10829@sigill.intra.peff.net>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
 <1456354744-8022-6-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com,
	Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 05:07:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZW9k-0003xJ-D7
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 05:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755935AbcB0EGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 23:06:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:50530 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755533AbcB0EGr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 23:06:47 -0500
Received: (qmail 22091 invoked by uid 102); 27 Feb 2016 04:06:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 23:06:46 -0500
Received: (qmail 10174 invoked by uid 107); 27 Feb 2016 04:06:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 23:06:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 23:06:44 -0500
Content-Disposition: inline
In-Reply-To: <1456354744-8022-6-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287656>

On Wed, Feb 24, 2016 at 05:58:37PM -0500, David Turner wrote:

> +int set_ref_storage_backend(const char *name)
> +{
> +	struct ref_storage_be *be;
> +
> +	for (be = refs_backends; be; be = be->next)
> +		if (!strcmp(be->name, name)) {
> +			the_refs_backend = be;
> +			return 0;
> +		}
> +	return 1;
> +}

So we search through the list and assign the_refs_backend if we find
something, returning 0 for success, and 1 if we found nothing. OK
(though our usual convention is that if 0 is success, -1 is the error
case).

> +int ref_storage_backend_exists(const char *name)
> +{
> +	struct ref_storage_be *be;
> +
> +	for (be = refs_backends; be; be = be->next)
> +		if (!strcmp(be->name, name)) {
> +			the_refs_backend = be;
> +			return 1;
> +		}
> +	return 0;
> +}

Here we do the same thing, but we get "1" for exists, and "0"
otherwise. That makes sense if this is about querying for existence. But
why does the query function still set the_refs_backend?

I'm guessing the assignment in the second one is just copy-pasta, but
maybe the whole thing would be simpler if they could share the
implementation, like:

  struct ref_storage_be *find_ref_storage_backend(const char *name)
  {
	struct ref_storage *be;
	for (be = refs_backends; be; be = be->next)
		if (!strcmp(be->name, name))
			return be;
	return NULL;
  }

  int set_ref_storage_backend(const char *name)
  {
	struct ref_storage *be = find_ref_storage_backend(name);
	if (!be)
		return -1;
	the_refs_backend = be;
	return 0;
  }

You don't really need an "exists", as you can check that "find" doesn't
return NULL, but you could wrap it, of course.

-Peff
