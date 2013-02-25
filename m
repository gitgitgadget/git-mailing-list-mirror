From: Jeff King <peff@peff.net>
Subject: Re: [PATCH ] t4210-log-i18n: spell encoding name "UTF-8" correctly
Date: Mon, 25 Feb 2013 10:19:17 -0500
Message-ID: <20130225151916.GA7725@sigill.intra.peff.net>
References: <201302090052.22053.thom311@gmail.com>
 <7vsj56xsg5.fsf@alter.siamese.dyndns.org>
 <7vobfuxrns.fsf@alter.siamese.dyndns.org>
 <20130209002710.GA5570@sigill.intra.peff.net>
 <7vfw16xqvj.fsf@alter.siamese.dyndns.org>
 <7va9rexqii.fsf@alter.siamese.dyndns.org>
 <20130211191607.GA21269@sigill.intra.peff.net>
 <7v621ymxfv.fsf@alter.siamese.dyndns.org>
 <20130211205958.GA32740@sigill.intra.peff.net>
 <512B22DE.9070603@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Haller <thom311@gmail.com>,
	Git List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 16:19:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9zqF-0002ft-1Z
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 16:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758662Ab3BYPTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 10:19:22 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59945 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757549Ab3BYPTV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 10:19:21 -0500
Received: (qmail 16243 invoked by uid 107); 25 Feb 2013 15:20:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Feb 2013 10:20:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Feb 2013 10:19:17 -0500
Content-Disposition: inline
In-Reply-To: <512B22DE.9070603@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217059>

On Mon, Feb 25, 2013 at 09:37:50AM +0100, Johannes Sixt wrote:

> From: Johannes Sixt <j6t@kdbg.org>
> 
> iconv on Windows does not know the encoding name "utf8", and does not
> re-encode log messages when this name is given. Request "UTF-8" encoding.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  I'm not sure whether I'm right to say that "UTF-8" is the correct
>  spelling. Anyway, 'iconv -l' on my old Linux box lists "UTF8", but on
>  Windows it does not.

UTF-8 is correct according to:

  https://en.wikipedia.org/wiki/Utf8#Official_name_and_variants

>  A more correct fix would probably be to use is_encoding_utf8() in more
>  places, but it's outside my time budget look after it.

Yeah, I wonder if this is a symptom of a deeper issue, which is that
utf-8 has many synonyms, and we would prefer to canonicalize the
encoding name before generating an object to avoid inconsistencies (of
course we cannot do so for every imaginable encoding, but utf-8 is a
pretty obvious one we handle already). We _should_ be generating commits
with no encoding header at all for utf-8, though.

And indeed, it looks like that is the case. commit_tree_extended has:

    /* Not having i18n.commitencoding is the same as having utf-8 */
    encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);

    [...]

    if (!encoding_is_utf8)
            strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);


which makes me think that this first hunk...

> diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
> index 52a7472..b1956e2 100755
> --- a/t/t4210-log-i18n.sh
> +++ b/t/t4210-log-i18n.sh
> @@ -15,7 +15,7 @@ test_expect_success 'create commits in different encodings' '
>  	t${utf8_e}st
>  	EOF
>  	git add msg &&
> -	git -c i18n.commitencoding=utf8 commit -F msg &&
> +	git -c i18n.commitencoding=UTF-8 commit -F msg &&
>  	cat >msg <<-EOF &&
>  	latin1

...should be a no-op; the utf8 there should never be seen by anybody but
git. Can you confirm that is the case?

> @@ -30,7 +30,7 @@ test_expect_success 'log --grep searches in log output encoding (utf8)' '
>  	latin1
>  	utf8
>  	EOF
> -	git log --encoding=utf8 --format=%s --grep=$utf8_e >actual &&
> +	git log --encoding=UTF-8 --format=%s --grep=$utf8_e >actual &&
>  	test_cmp expect actual
>  '

This one will feed it to iconv, though, because the latin1 commit will
need to be re-encoded. I think the simplest thing would just be:

diff --git a/utf8.c b/utf8.c
index 1087870..8d42b50 100644
--- a/utf8.c
+++ b/utf8.c
@@ -507,6 +507,17 @@ char *reencode_string(const char *in, const char *out_encoding, const char *in_e
 
 	if (!in_encoding)
 		return NULL;
+
+	/*
+	 * Some platforms do not have the variously spelled variants of
+	 * UTF-8, so let us feed iconv the most official spelling, which
+	 * should hopefully be accepted everywhere.
+	 */
+	if (is_encoding_utf8(in_encoding))
+		in_encoding = "UTF-8";
+	if (is_encoding_utf8(out_encoding))
+		out_encoding = "UTF-8";
+
 	conv = iconv_open(out_encoding, in_encoding);
 	if (conv == (iconv_t) -1)
 		return NULL;

Does that fix the tests for you? It's a larger change, but I think it
makes git friendlier all around for people on Windows.

-Peff
