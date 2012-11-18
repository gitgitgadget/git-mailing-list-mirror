From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/7] completion: make the 'basic' test more tester-friendly
Date: Sun, 18 Nov 2012 10:39:02 +0100
Message-ID: <CAMP44s1zibHCFCm_=E+WXmTpX+xvpLWGbcpf32QuWsWAa+Y5uA@mail.gmail.com>
References: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
	<1353150353-29874-2-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Nov 18 10:39:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta1LS-00029j-Uo
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 10:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798Ab2KRJjF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Nov 2012 04:39:05 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:49312 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab2KRJjD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Nov 2012 04:39:03 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so4024645oag.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 01:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=H+aM2PjcfTPo4yz6tBoE6l9ZpyQLTCyv7bO/xAbG7E8=;
        b=vF6wzioSorJa6HzbpaD/0djGS6tOWdEcGNUEPkQ0UoMWJcWeAsy30fXmCJXjDJ1eok
         QbVm6S1p6mOlZ3OajcFLblhaePX+WzB0kuLrT6oCVIZ/DrwxlYvNmiNa50v99+ycQNEr
         r330Tn0RN2ANiRy+NVOge9gHePSy4kvotl+KQ1rRtQDry7PjLPgrN2RlydzVrymgCYY7
         YMIyt23NaRtivoxWOnABdqurLPrhj4l3dJBM2pt/NPUMNN1hRT8Ld8+lqagZYKhD9jRu
         DzrhZkk4rWWasx+HKF7P7sFJZ5RMputbiRkIeLadvYBrp4Rf6+0Etyrg9yS7biuzGtXm
         fGTg==
Received: by 10.60.20.1 with SMTP id j1mr7941595oee.46.1353231542596; Sun, 18
 Nov 2012 01:39:02 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 18 Nov 2012 01:39:02 -0800 (PST)
In-Reply-To: <1353150353-29874-2-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210003>

On Sat, Nov 17, 2012 at 12:05 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:
> The 'basic' test uses 'grep -q' to filter the resulting possible
> completion words while looking for the presence or absence of certain
> git commands, and relies on grep's exit status to indicate a failure.
>
> This works fine as long as there are no errors.  However, in case of =
a
> failure it doesn't give any indication whatsoever about the reason of
> the failure, i.e. which condition failed.
>
> To make testers' life easier provide some output about the failed
> condition: store the results of the filtering in a file and compare
> its contents to the expected results by the good old test_cmp helper.
> However, to actually get output from test_cmp in case of an error we
> must make sure that test_cmp is always executed.  Since in case of an
> error grep's exit code aborts the test immediately, before running th=
e
> subsequent test_cmp, do the filtering using sed instead of grep.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>  t/t9902-completion.sh | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 8fa025f9..b56759f7 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -158,14 +158,22 @@ test_expect_success '__gitcomp - suffix' '
>  test_expect_success 'basic' '
>         run_completion "git \"\"" &&
>         # built-in
> -       grep -q "^add \$" out &&
> +       echo "add " >expected &&
> +       sed -n "/^add \$/p" out >out2 &&
> +       test_cmp expected out2 &&
>         # script
> -       grep -q "^filter-branch \$" out &&
> +       echo "filter-branch " >expected &&
> +       sed -n "/^filter-branch \$/p" out >out2 &&
> +       test_cmp expected out2 &&
>         # plumbing
> -       ! grep -q "^ls-files \$" out &&
> +       >expected &&
> +       sed -n "/^ls-files \$/p" out >out2 &&
> +       test_cmp expected out2 &&
>
>         run_completion "git f" &&
> -       ! grep -q -v "^f" out
> +       >expected &&
> +       sed -n "/^[^f]/p" out >out2 &&
> +       test_cmp expected out2
>  '
>
>  test_expect_success 'double dash "git" itself' '

It's not very useful to see a single failure without context. Maybe thi=
s:

--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -191,18 +191,20 @@ test_expect_success '__gitcomp_nl - doesnt fail
because of invalid variable name

 test_expect_success 'basic' '
        run_completion "git " &&
+       (
        # built-in
-       echo "add " >expected &&
-       sed -n "/^add \$/p" out >out2 &&
-       test_cmp expected out2 &&
+       sed -n "/^add $/p" out &&
        # script
-       echo "filter-branch " >expected &&
-       sed -n "/^filter-branch \$/p" out >out2 &&
-       test_cmp expected out2 &&
+       sed -n "/^filter-branch $/p" out &&
        # plumbing
-       >expected &&
-       sed -n "/^ls-files \$/p" out >out2 &&
-       test_cmp expected out2 &&
+       sed -n "/^ls-files $/p" out
+       ) > actual &&
+
+       sed -e 's/Z$//' > expected <<-EOF &&
+       add Z
+       filter-branch Z
+       EOF
+       test_cmp expected actual &&

        run_completion "git f" &&
        >expected &&

--=20
=46elipe Contreras
