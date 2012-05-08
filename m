From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] checkout: do not corrupt HEAD on empty repo
Date: Tue, 8 May 2012 18:25:29 +0200
Message-ID: <CABPQNSau5snkNLqsnBnsLVBVNKHXnvb8rsE8DbNfpo9__5uijA@mail.gmail.com>
References: <1336493114-4984-1-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, j.sixt@viscovery.net, schwab@linux-m68k.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 18:26:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRnEu-0002p2-2a
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 18:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445Ab2EHQ0K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 12:26:10 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52915 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843Ab2EHQ0J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 12:26:09 -0400
Received: by dady13 with SMTP id y13so2848267dad.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 09:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=5OFCItzpFcYVHrlAXcYxOlUpGRbEPD9VwxoMvXxW1do=;
        b=KD1CI744A2alDzHv0GU+U+VUjz5ULEqqxcZ86e74IdjMkd3MY4zsrP5XNI9Dn8Acz/
         08ConPGwFxWOOVKUW7oIWyYuxZvJEJ66H5PprT5/UqF7xl7egLeDhWBUMyJnzgJv8bKK
         ZWrozgpEN4o7hybeY1L7aw93obLUa44wdiCSF2eLmhqYb4DyK26reZ6cJxT0f/gx82XR
         wdO2EpV6pR1Ma0x7Ekn/hIzANgKmpGyTeZ3bChM5+XeG8xk0LnL55zveuYwcTlhShyej
         ddpMeTpyu83rzR8rNKokDpBtUllZdrnw+oShqY8KrUbLH8Q8hQBgAG7o3laMbA7bqn83
         TgAQ==
Received: by 10.68.225.104 with SMTP id rj8mr44508365pbc.135.1336494369294;
 Tue, 08 May 2012 09:26:09 -0700 (PDT)
Received: by 10.68.73.65 with HTTP; Tue, 8 May 2012 09:25:29 -0700 (PDT)
In-Reply-To: <1336493114-4984-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197384>

On Tue, May 8, 2012 at 6:05 PM, Erik Faye-Lund <kusmabite@gmail.com> wr=
ote:
> In abe1998 ("git checkout -b: allow switching out of an unborn
> branch"), a code-path overly-optimisticly assumed that a
> branch-name was specified. This is not always the case, and as
> a result a NULL-pointer was attempted printed to .git/HEAD.
>
> This could lead to at least two different failure modes:
> =A01) The CRT formated the NULL-string as something useful (e.g
> =A0 =A0"(null)")
> =A02) The CRT crasheed.
>
> Neither were very convenient for formatting a new HEAD-reference.
>
> To fix this, reintroduce some strictness so we only take this
> new codepath if a banch-name was specified.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
> =A0builtin/checkout.c =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0t/t2015-checkout-unborn.sh | =A0 11 +++++++++++
> =A02 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 23fc56d..35924d4 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1091,7 +1091,7 @@ int cmd_checkout(int argc, const char **argv, c=
onst char *prefix)
> =A0 =A0 =A0 =A0if (opts.writeout_stage)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die(_("--ours/--theirs is incompatible=
 with switching branches."));
>
> - =A0 =A0 =A0 if (!new.commit) {
> + =A0 =A0 =A0 if (!new.commit && opts.new_branch) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned char rev[20];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int flag;
>
> diff --git a/t/t2015-checkout-unborn.sh b/t/t2015-checkout-unborn.sh
> index 6352b74..2fa9458 100755
> --- a/t/t2015-checkout-unborn.sh
> +++ b/t/t2015-checkout-unborn.sh
> @@ -46,4 +46,15 @@ test_expect_success 'checking out another branch f=
rom unborn state' '
> =A0 =A0 =A0 =A0test_cmp expect actual
> =A0'
>
> +test_expect_success 'checking out in a newly created repo' '
> + =A0 =A0 =A0 test_create_repo empty &&
> + =A0 =A0 =A0 (
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cd empty &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cat .git/HEAD >expect &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 test_must_fail git checkout &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cat .git/HEAD >actual &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 test_cmp expect actual
> + =A0 =A0 =A0 )
> +'
> +
> =A0test_done

Hmh, this is needlessly cluttery. The following should cover it:

---
diff --git a/t/t2015-checkout-unborn.sh b/t/t2015-checkout-unborn.sh
index 2fa9458..b49fedf 100755
--- a/t/t2015-checkout-unborn.sh
+++ b/t/t2015-checkout-unborn.sh
@@ -50,10 +50,7 @@ test_expect_success 'checking out in a newly created=
 repo' '
 	test_create_repo empty &&
 	(
 		cd empty &&
-		cat .git/HEAD >expect &&
-		test_must_fail git checkout &&
-		cat .git/HEAD >actual &&
-		test_cmp expect actual
+		test_must_fail git checkout
 	)
 '
