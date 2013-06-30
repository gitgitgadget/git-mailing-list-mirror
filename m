From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] commit: reject invalid UTF-8 codepoints
Date: Sat, 29 Jun 2013 19:13:40 -0700
Message-ID: <7v7ghcl50r.fsf@alter.siamese.dyndns.org>
References: <20130629174023.GB226907@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Jun 30 04:14:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ut79Q-0005fi-Ef
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 04:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058Ab3F3CNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jun 2013 22:13:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55382 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751Ab3F3CNq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jun 2013 22:13:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01D941B731;
	Sun, 30 Jun 2013 02:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+nRMvI0eLwF7UuS/hDvcyynSQd4=; b=TQdKw9
	yGyZPmWyfdzW8pGCV/+DplBYiOMuzzlUG5bn+VWOHuLgQ0MvZy0VmxPdXAlho41K
	cwjP6ihwkkIfMELKim7WY44VCALBjL/OOe6emSdL6hWK6eMO9MaMZN2wpQbmHNTi
	8wdnlI9kbnfnvXcFsii5uxgwg7cEim4WpzRvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vBfpcOVK8O/1HVKQZ7mp+km2vq/KBS7u
	1FxDcXoPXDa2TnLnSzDjewKqngN6vrzuHvqpCbsQQljrl/29Id74L5boli5Fy2ex
	KIN2jVUo8RP9olWu9Yu7h6k8vEKqkeCgDGOOsdgXWoQ57bonUbkkRhcRiZTrD5po
	LdIyjFiMffo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA3BD1B730;
	Sun, 30 Jun 2013 02:13:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E00E1B72F;
	Sun, 30 Jun 2013 02:13:45 +0000 (UTC)
In-Reply-To: <20130629174023.GB226907@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Sat, 29 Jun 2013 17:40:23 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B12DD5C4-E12A-11E2-A0A8-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229261>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The commit code already contains code for validating UTF-8, but it
> does not check for invalid values, such as guaranteed
> non-characters and surrogates.  Fix this by explicitly checking
> for and rejecting such characters.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---

Does this correspond to the following comment in the same file, and
if so, shouldn't this part of your patch?

diff --git a/commit.c b/commit.c
index 888e02a..8ce20d5 100644
--- a/commit.c
+++ b/commit.c
@@ -1292,8 +1292,8 @@ static int find_invalid_utf8(const char *buf, int len)
  * If it isn't, it assumes any non-utf8 characters are Latin1,
  * and does the conversion.
  *
- * Fixme: we should probably also disallow overlong forms and
- * invalid characters. But we don't do that currently.
+ * Fixme: we should probably also disallow overlong forms.
+ * But we don't do that fully, yet.
  */
 static int verify_utf8(struct strbuf *buf)
 {

> @@ -1264,24 +1265,35 @@ static int find_invalid_utf8(const char *buf, int len)
>  			bytes++;
>  		}
>  
> -		/* Must be between 1 and 5 more bytes */
> -		if (bytes < 1 || bytes > 5)
> +		/* Must be between 1 and 3 more bytes */
> +		if (bytes < 1 || bytes > 3)
>  			return bad_offset;

We used to allow te original up-to-6 form and this update is about
rejecting anything above U+10FFFF (in line with e.g. RFC 3629)?

>  		/* Do we *have* that many bytes? */
>  		if (len < bytes)
>  			return bad_offset;
>  
> +		/* Place the encoded bits at the bottom of the value. */
> +		codepoint = (c & 0x7f) >> bytes;
> +
>  		offset += bytes;
>  		len -= bytes;
>  
>  		/* And verify that they are good continuation bytes */
>  		do {
> +			codepoint <<= 6;
> +			codepoint |= *buf & 0x3f;
>  			if ((*buf++ & 0xc0) != 0x80)
>  				return bad_offset;
>  		} while (--bytes);
>  
> -		/* We could/should check the value and length here too */
> +		/* Check the value here */
> +		if (codepoint >= 0xd800 && codepoint <= 0xdfff)
> +			return bad_offset;

As you use separate if statements for this check, perhaps you can
give each of them a better comment to say what each is rejecting?
E.g.

	/* do not allow range for surrogate pair */
		if (codepoint >= 0xd800 && codepoint <= 0xdfff)
			return bad_offset;

> +		if (codepoint > 0x10ffff)
> +			return bad_offset;
> +		if ((codepoint & 0x1ffffe) == 0xfffe)
> +			return bad_offset;

As that comment I quoted at the beginning says, we did not check for
invalid encoded values and the primary reason for it is beccause
this function did not want to look into the actual values here.  But
now you are looking into "codepoint", you can now also check for
"overlong" form (e.g. sequence "C0 80" turning into U+0000)?

>  	}
>  	return -1;
>  }
> diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
> index 37ddabb..16ed707 100755
> --- a/t/t3900-i18n-commit.sh
> +++ b/t/t3900-i18n-commit.sh
> @@ -39,6 +39,15 @@ test_expect_failure 'UTF-16 refused because of NULs' '
>  	git commit -a -F "$TEST_DIRECTORY"/t3900/UTF-16.txt
>  '
>  
> +test_expect_success 'UTF-8 invalid characters refused' '
> +	rm -f "$HOME/stderr" &&
> +	echo "UTF-8 characters" >F &&
> +	git commit -a -F "$TEST_DIRECTORY"/t3900/UTF-8-invalid.txt \
> +		2>"$HOME"/stderr &&
> +	grep "did not conform" "$HOME"/stderr
> +'
> +
> +rm -f "$HOME/stderr"

Perhaps

        test_expect_success 'test name' '
                test_when_finished "rm -f $HOME/stderr" &&
                "rm -f $HOME/stderr" &&
                echo ...
                grep "did not conform" ...
        '

> diff --git a/t/t3900/UTF-8-invalid.txt b/t/t3900/UTF-8-invalid.txt
> new file mode 100644
> index 0000000..343684d
> --- /dev/null
> +++ b/t/t3900/UTF-8-invalid.txt
> @@ -0,0 +1,3 @@
> +Commit message
> +
> +Invalid surrogate:???

I suspect that I did not receive what you intended to send.  Do you
want to send this part as a binary patch perhaps?
