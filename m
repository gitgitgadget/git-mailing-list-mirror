From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] Add the tag.gpgsign option to sign annotated tags
Date: Mon, 21 Mar 2016 15:42:38 -0400
Message-ID: <20160321194237.GA28301@sigill.intra.peff.net>
References: <20160319182310.GA23124@spk-laptop>
 <20160320042912.GD18312@sigill.intra.peff.net>
 <20160320150703.GB5139@spk-laptop>
 <xmqq7fgwnzuv.fsf@gitster.mtv.corp.google.com>
 <20160321193207.GD20083@spk-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Laurent Arnoud <laurent@spkdev.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:42:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai5iv-00081N-Oo
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 20:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756437AbcCUTmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 15:42:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:35472 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754735AbcCUTml (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 15:42:41 -0400
Received: (qmail 3776 invoked by uid 102); 21 Mar 2016 19:42:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Mar 2016 15:42:40 -0400
Received: (qmail 8595 invoked by uid 107); 21 Mar 2016 19:42:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Mar 2016 15:42:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Mar 2016 15:42:38 -0400
Content-Disposition: inline
In-Reply-To: <20160321193207.GD20083@spk-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289447>

On Mon, Mar 21, 2016 at 08:32:07PM +0100, Laurent Arnoud wrote:

> The `tag.gpgsign` config option allows to sign all
> annotated tags automatically.
> 
> Support `--no-sign` option to countermand configuration `tag.gpgsign`.
> 
> Signed-off-by: Laurent Arnoud <laurent@spkdev.net>
> Reviewed-by: Jeff King <peff@peff.net>

The meaning of "Reviewed-by" in this project is generally that the
mentioned person has read and approved of the change. But in this case,
I have not seen v3 at all yet, and I am also not sure that the ones I
_did_ review are ready for merging.

So you should probably drop that.

> +tag.gpgSign::
> +	A boolean to specify whether annotated tags created should be GPG signed.
> +	If `--no-sign` is specified on the command line, it takes
> +	precedence over this option.

I take this to mean that we _only_ kick in signing if the created tag
would otherwise be annotated (and I thought that's what you meant in
your other mail, too). But that's not what happens with this patch, and
your tests check for the opposite:

> +get_tag_header config-implied-annotate $commit commit $time >expect
> +./fakeeditor >>expect
> +echo '-----BEGIN PGP SIGNATURE-----' >>expect
> +git config tag.gpgsign true
> +test_expect_success GPG \
> +	'git tag -s implied if configured with tag.gpgsign' \
> +	'GIT_EDITOR=./fakeeditor git tag config-implied-annotate &&
> +	get_tag_msg config-implied-annotate >actual &&
> +	test_cmp expect actual
> +'
> +git config --unset tag.gpgsign

That's a lightweight tag that becomes an annotated one due to the config
variable.

So I think there may be some design-level issues to work out here, but
I'll comment on a few more code-specific things, in case that code does
get carried through:

> +	if (!strcmp(var, "tag.gpgsign")) {
> +		sign_tag_config = git_config_bool(var, value) ? 1 : 0;
> +		return 0;
> +	}

git_config_bool() already converts to 0/1, you can just say:

  sign_tag_config = git_config_bool(var, value);

> +get_tag_header config-implied-annotate-disabled $commit commit $time >expect
> +echo "A message" >>expect
> +git config tag.gpgsign true
> +test_expect_success GPG \
> +	'git tag --no-sign disable configured tag.gpgsign' \
> +	'git tag --no-sign -m "A message" config-implied-annotate-disabled &&
> +	get_tag_msg config-implied-annotate-disabled >actual &&
> +	test_cmp expect actual &&
> +	test_must_fail git tag -v config-implied-annotate-disabled
> +'
> +git config --unset tag.gpgsign

Here (and in the other tests), you can use:

  test_config tag.gpgsign true &&
  ...

inside the test_expect_success block. That has two advantages:

  1. If setting the config fails for some reason, we'll notice and the
     test will fail.

  2. At the end of the test block, it will automatically clean up the
     variable for us.

-Peff
