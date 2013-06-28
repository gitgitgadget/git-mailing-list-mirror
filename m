From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] status: really ignore config with --porcelain
Date: Thu, 27 Jun 2013 21:40:11 -0400
Message-ID: <20130628014011.GA620@sigill.intra.peff.net>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
 <1372077912-18625-2-git-send-email-artagnon@gmail.com>
 <vpqhagnwraj.fsf@anie.imag.fr>
 <CALkWK0=F_i95S+53eZmOAJtA+jG=jvi5-sDc3BgW3rNQo=n3Ng@mail.gmail.com>
 <vpqhagnv9xq.fsf@anie.imag.fr>
 <7vk3ljbh5r.fsf@alter.siamese.dyndns.org>
 <vpq7ghjtpv1.fsf@anie.imag.fr>
 <7vk3lj9xwn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 03:40:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsNfh-0006p9-BL
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 03:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743Ab3F1BkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 21:40:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:43753 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753249Ab3F1BkO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 21:40:14 -0400
Received: (qmail 689 invoked by uid 102); 28 Jun 2013 01:41:19 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Jun 2013 20:41:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Jun 2013 21:40:11 -0400
Content-Disposition: inline
In-Reply-To: <7vk3lj9xwn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229172>

On Mon, Jun 24, 2013 at 11:16:56AM -0700, Junio C Hamano wrote:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 0da944f..a535eb2 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -111,12 +111,14 @@ static int show_ignored_in_status;
>  static const char *only_include_assumed;
>  static struct strbuf message = STRBUF_INIT;
>  
> -static enum {
> +static enum status_format {
>  	STATUS_FORMAT_NONE = 0,
>  	STATUS_FORMAT_LONG,
>  	STATUS_FORMAT_SHORT,
> -	STATUS_FORMAT_PORCELAIN
> -} status_format;
> +	STATUS_FORMAT_PORCELAIN,
> +
> +	STATUS_FORMAT_UNSPECIFIED
> +} status_format = STATUS_FORMAT_UNSPECIFIED;

I'm not sure why you need to add UNSPECIFIED here; the point of NONE is
that no format had yet been specified.

It looks like the only difference is that finalize_deferred_config
converts unspecified into NONE. But I think you can just use NONE for
both cases, and drop this hunk:

>  static int opt_parse_m(const struct option *opt, const char *arg, int unset)
>  {
> @@ -457,6 +459,9 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
>  	case STATUS_FORMAT_PORCELAIN:
>  		wt_porcelain_print(s);
>  		break;
> +	case STATUS_FORMAT_UNSPECIFIED:
> +		die("BUG: finalize_deferred_config() should have been called");
> +		break;
>  	case STATUS_FORMAT_NONE:
>  	case STATUS_FORMAT_LONG:
>  		wt_status_print(s);

You lose the assertion that finalize_deferred_config has been called,
but I think the resulting code would be simpler, as it drops this
die("BUG") state entirely. Am I missing something?

-Peff
