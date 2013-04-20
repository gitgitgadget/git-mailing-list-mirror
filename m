From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] grep: obey --textconv for the case rev:path
Date: Sat, 20 Apr 2013 00:24:46 -0400
Message-ID: <20130420042445.GD24970@sigill.intra.peff.net>
References: <cover.1366389739.git.git@drmicha.warpmail.net>
 <717ec305e9bd056a44b1da5cc478d314db2920e5.1366389739.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 20 06:25:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTPME-0005mN-Qp
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 06:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487Ab3DTEYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 00:24:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:44588 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823Ab3DTEYt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 00:24:49 -0400
Received: (qmail 7954 invoked by uid 102); 20 Apr 2013 04:24:54 -0000
Received: from 99-108-225-125.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.225.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 19 Apr 2013 23:24:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Apr 2013 00:24:46 -0400
Content-Disposition: inline
In-Reply-To: <717ec305e9bd056a44b1da5cc478d314db2920e5.1366389739.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221835>

On Fri, Apr 19, 2013 at 06:44:49PM +0200, Michael J Gruber wrote:

> @@ -820,12 +820,13 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  	for (i = 0; i < argc; i++) {
>  		const char *arg = argv[i];
>  		unsigned char sha1[20];
> +		struct object_context oc;
>  		/* Is it a rev? */
> -		if (!get_sha1(arg, sha1)) {
> +		if (!get_sha1_with_context(arg, 0, sha1, &oc)) {
>  			struct object *object = parse_object_or_die(sha1, arg);
>  			if (!seen_dashdash)
>  				verify_non_filename(prefix, arg);
> -			add_object_array(object, arg, &list);
> +			add_object_array_with_context(object, arg, &list, xmemdupz(&oc, sizeof(struct object_context)));

Hrm. I'm not excited about the extra allocation here. Who frees it?

> +void add_object_array(struct object *obj, const char *name, struct object_array *array)
> +{
> +	add_object_array_with_mode(obj, name, array, S_IFINVALID);
> +}
> +
> +void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode)
> +{
> +	add_object_array_with_mode_context(obj, name, array, mode, NULL);
> +}
> +
> +void add_object_array_with_context(struct object *obj, const char *name, struct object_array *array, struct object_context *context)
> +{
> +	if (context)
> +		add_object_array_with_mode_context(obj, name, array, context->mode, context);
> +	else
> +		add_object_array_with_mode_context(obj, name, array, S_IFINVALID, context);
> +}

And this mass of almost-the-same functions is gross, too, especially
given that the object_context contains a mode itself.

Unfortunately, I'm not sure if I have a more pleasant suggestion. I seem
to recall wrestling with this issue during the last round, too.

-Peff
