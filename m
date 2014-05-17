From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 08/10] replace: add tests for --edit
Date: Sat, 17 May 2014 03:14:10 -0400
Message-ID: <20140517071410.GE13003@sigill.intra.peff.net>
References: <20140517062418.18932.21200.chriscool@tuxfamily.org>
 <20140517064133.18932.74476.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat May 17 09:14:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlYoz-0008Db-Ck
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 09:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992444AbaEQHON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 03:14:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:53686 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756615AbaEQHOM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 03:14:12 -0400
Received: (qmail 11305 invoked by uid 102); 17 May 2014 07:14:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 May 2014 02:14:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 May 2014 03:14:10 -0400
Content-Disposition: inline
In-Reply-To: <20140517064133.18932.74476.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249455>

On Sat, May 17, 2014 at 08:41:30AM +0200, Christian Couder wrote:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t6050-replace.sh | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Yay, tests.

> +test_expect_success 'setup a fake editor' '
> +	cat >fakeeditor <<-\EOF &&
> +		#!/bin/sh
> +		sed -e "s/A U Thor/A fake Thor/" "$1" >"$1.new"
> +		mv "$1.new" "$1"
> +	EOF
> +	chmod +x fakeeditor
> +'

Please use write_script, like:

  test_expect_success 'setup a fake editor' '
	write_script fakeeditor <<-\EOF
		sed -e "s/A U Thor/A fake Thor/" "$1" >"$1.new"
		mv "$1.new" "$1"
	EOF
  '

which will use the $(SHELL_PATH) shebang. It doesn't matter for such a
simple script here (which even a broken #!/bin/sh could manage), but in
general, I think we're trying to set it consistently.

You could also &&-chain the commands in your fakeeditor script, though I
find it unlikely that sed will fail.

> +test_expect_success '--edit with and without already replaced object' '
> +	GIT_EDITOR=./fakeeditor test_must_fail git replace --edit "$PARA3" &&

Unfortunately it's not portable to do a one-shot environment variable on
a shell function like this; some shells leave the variable set after the
function returns. We've been using:

  test_must_fail env GIT_EDITOR=./fakeeditor git ...

The regular

  GIT_EDITOR=./fakeeditor git ...

ones are OK.

-Peff
