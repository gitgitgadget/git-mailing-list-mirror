From: Ben Walton <bdwalton@gmail.com>
Subject: Re: [PATCH] Avoid difference in tr semantics between System V and BSD
Date: Mon, 28 Oct 2013 21:43:57 +0000
Message-ID: <CAP30j164JyuZ7TZ=LhaGWMX4VLyX_T7nS6Mn9ztrjKfJRM2mnw@mail.gmail.com>
References: <xmqqiowhdqx8.fsf@gitster.dls.corp.google.com>
	<1382996441-18926-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Ben Walton <bdwalton@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Oct 28 22:44:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaubU-000200-IR
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 22:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757519Ab3J1Vn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 17:43:59 -0400
Received: from mail-qa0-f43.google.com ([209.85.216.43]:49596 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001Ab3J1Vn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 17:43:58 -0400
Received: by mail-qa0-f43.google.com with SMTP id i13so2463359qae.9
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 14:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oLChXGXMpcfOAn+a+YK+wbGKjaP9eiaAXy0oBbKYzPQ=;
        b=X9gmuEAcW7YW6i8+hOeROAnZZ3vC/IXO3DUzRiG8kTO7aVWJNmz+PstVeARn2vIC0A
         rMNxWPHP/+EIXfyeH/q58khkU/E6ngHJcyxTW5RL3d2zFARidYXl4xgJ56hxMr/NrHX6
         Oc9VsC9qReOT2yeJh3WxzsHPy2DqBWeliYajjjUKK9gTyzxN/Dg29lTr+M1IB+ytO/2m
         BNEaWerqf4pb2HtlZR+wORiqJEExL9M4Jom7R+glZlyw3B5FL0wT72lSl3jNIiNYau18
         S5preeWiY5vrqknjnfdCkUrB6h9hj1m9mtJZLkn0qsbccPtbvxjKt+O/kkhZEhyhJ61U
         sn7g==
X-Received: by 10.49.3.3 with SMTP id 3mr31926095qey.56.1382996637315; Mon, 28
 Oct 2013 14:43:57 -0700 (PDT)
Received: by 10.224.189.12 with HTTP; Mon, 28 Oct 2013 14:43:57 -0700 (PDT)
In-Reply-To: <1382996441-18926-1-git-send-email-bdwalton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236868>

Ignore this version. The immediate followup quotes PERL_PATH.

On Mon, Oct 28, 2013 at 9:40 PM, Ben Walton <bdwalton@gmail.com> wrote:
> Solaris' tr (both /usr/bin/ and /usr/xpg4/bin) uses the System V
> semantics for tr whereby string1's length is truncated to the length
> of string2 if string2 is shorter. The BSD semantics, as used by GNU tr
> see string2 padded to the length of string1 using the final character
> in string2. POSIX explicitly doesn't specify the correct behavior
> here, making both equally valid.
>
> This difference means that Solaris' native tr implementations produce
> different results for tr ":\t\n" "\0" than GNU tr. This breaks a few
> tests in t0008-ignores.sh.
>
> Possible fixes for this are to make string2 be "\0\0\0" or "[\0*]".
>
> Instead, use perl to perform these transliterations which means we
> don't need to worry about the difference at all. Since we're replacing
> tr with perl, we also use perl to replace the sed invocations used to
> transform the files.
>
> Replace four identical transforms with a function named
> broken_c_unquote. Replace the other two identical transforms with a
> fuction named broken_c_unquote_verbose.
>
> Signed-off-by: Ben Walton <bdwalton@gmail.com>
> ---
>  t/t0008-ignores.sh | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index 181513a..45f9396 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -37,6 +37,14 @@ test_stderr () {
>         test_cmp "$HOME/expected-stderr" "$HOME/stderr"
>  }
>
> +broken_c_unquote () {
> +       $PERL_PATH -pe 's/^"//; s/\\//; s/"$//; tr/\n/\0/' "$@"
> +}
> +
> +broken_c_unquote_verbose () {
> +       $PERL_PATH -pe 's/      "/      /; s/\\//; s/"$//; tr/:\t\n/\0/' "$@"
> +}
> +
>  stderr_contains () {
>         regexp="$1"
>         if grep "$regexp" "$HOME/stderr"
> @@ -606,12 +614,11 @@ cat <<-EOF >expected-verbose
>         $global_excludes:2:!globaltwo   b/globaltwo
>  EOF
>
> -sed -e 's/^"//' -e 's/\\//' -e 's/"$//' stdin | \
> -       tr "\n" "\0" >stdin0
> -sed -e 's/^"//' -e 's/\\//' -e 's/"$//' expected-default | \
> -       tr "\n" "\0" >expected-default0
> -sed -e 's/     "/      /' -e 's/\\//' -e 's/"$//' expected-verbose | \
> -       tr ":\t\n" "\0" >expected-verbose0
> +broken_c_unquote stdin >stdin0
> +
> +broken_c_unquote expected-default >expected-default0
> +
> +broken_c_unquote_verbose expected-verbose >expected-verbose0
>
>  test_expect_success '--stdin' '
>         expect_from_stdin <expected-default &&
> @@ -692,12 +699,11 @@ EOF
>  grep -v '^::   ' expected-all >expected-verbose
>  sed -e 's/.*   //' expected-verbose >expected-default
>
> -sed -e 's/^"//' -e 's/\\//' -e 's/"$//' stdin | \
> -       tr "\n" "\0" >stdin0
> -sed -e 's/^"//' -e 's/\\//' -e 's/"$//' expected-default | \
> -       tr "\n" "\0" >expected-default0
> -sed -e 's/     "/      /' -e 's/\\//' -e 's/"$//' expected-verbose | \
> -       tr ":\t\n" "\0" >expected-verbose0
> +broken_c_unquote stdin >stdin0
> +
> +broken_c_unquote expected-default >expected-default0
> +
> +broken_c_unquote_verbose expected-verbose >expected-verbose0
>
>  test_expect_success '--stdin from subdirectory' '
>         expect_from_stdin <expected-default &&
> --
> 1.8.1.2
>



-- 
---------------------------------------------------------------------------------------------------------------------------
Take the risk of thinking for yourself.  Much more happiness,
truth, beauty and wisdom will come to you that way.

-Christopher Hitchens
---------------------------------------------------------------------------------------------------------------------------
