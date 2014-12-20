From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2] git-config support for diff.relative setting
Date: Sat, 20 Dec 2014 14:32:46 -0000
Organization: OPDS
Message-ID: <CFEBFB254713492C988FED7E11475227@PhilipOakley>
References: <54954054.7080201@shysecurity.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: "Duy Nguyen" <pclouds@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: <kelson@shysecurity.com>, "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 20 15:32:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2L5U-0007Dy-0P
	for gcvg-git-2@plane.gmane.org; Sat, 20 Dec 2014 15:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbaLTOcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2014 09:32:36 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:27022 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752463AbaLTOcg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Dec 2014 09:32:36 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArQKAPqHlVROl3GlPGdsb2JhbABbgwZSWIMEgypsvxCFbgQCgRIXAQEBAQEBBQEBAQE4O4QHBQEBAQECAQgBARkVHgEBIQUGAgMFAgEDFQUCBSECAhQBBBoGBwMUBgESCAIBAgMBiBMMukeGU487gSGOUYJvLoETBY4PTIJyln6EED4xgkMBAQE
X-IPAS-Result: ArQKAPqHlVROl3GlPGdsb2JhbABbgwZSWIMEgypsvxCFbgQCgRIXAQEBAQEBBQEBAQE4O4QHBQEBAQECAQgBARkVHgEBIQUGAgMFAgEDFQUCBSECAhQBBBoGBwMUBgESCAIBAgMBiBMMukeGU487gSGOUYJvLoETBY4PTIJyln6EED4xgkMBAQE
X-IronPort-AV: E=Sophos;i="5.07,613,1413241200"; 
   d="scan'208";a="480342431"
Received: from host-78-151-113-165.as13285.net (HELO PhilipOakley) ([78.151.113.165])
  by out1.ip04ir2.opaltelecom.net with SMTP; 20 Dec 2014 14:32:32 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261603>

From: <kelson@shysecurity.com>
> By default, git-diff shows changes and pathnames relative to the 
> repository root. Setting the diff.relative config option to "true" 
> shows pathnames relative to the current directory and excludes changes 
> outside this directory (identical to "git diff --relative").
Shouldn't this `(identical to "git diff --relative")` also be included 
in the documentation change? It would truly clarify the intenbt for the 
reader.

>
> Signed-off-by: Brandon Phillips <kelson@shysecurity.com>
> ---
>  Documentation/diff-config.txt |  6 ++++++
>  diff.c                        |  8 ++++++++
>  t/t4045-diff-relative.sh      | 21 +++++++++++++++++++++
>  3 files changed, 35 insertions(+)
>
> diff --git a/Documentation/diff-config.txt 
> b/Documentation/diff-config.txt
> index b001779..10f183f 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -182,3 +182,9 @@ diff.algorithm::
>  low-occurrence common elements".
>  --
>  +
> +
> +diff.relative::
> + By default, linkgit:git-diff[1] shows changes and pathnames
> + relative to the repository root. Setting this variable to
> + `true` shows pathnames relative to the current directory and
> + excludes changes outside this directory.
    Insert `(identical to "git diff --relative")` here?

> diff --git a/diff.c b/diff.c
> index d1bd534..03697a9 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -223,6 +223,14 @@ int git_diff_ui_config(const char *var, const 
> char
> *value, void *cb)
>  return 0;
>  }
>
> + if (!strcmp(var, "diff.relative")) {
> + if (git_config_bool(var, value))
> + DIFF_OPT_SET(&default_diff_options, RELATIVE_NAME);
> + else
> + DIFF_OPT_CLR(&default_diff_options, RELATIVE_NAME);
> + return 0;
> + }
> +
>  if (git_color_config(var, value, cb) < 0)
>  return -1;
>
> diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
> index 3950f50..8c8fe0b 100755
> --- a/t/t4045-diff-relative.sh
> +++ b/t/t4045-diff-relative.sh
> @@ -29,6 +29,23 @@ test_expect_success "-p $*" "
>  "
>  }
>
> +check_config() {
> +expect=$1; shift
> +cat >expected <<EOF
> +diff --git a/$expect b/$expect
> +new file mode 100644
> +index 0000000..25c05ef
> +--- /dev/null
> ++++ b/$expect
> +@@ -0,0 +1 @@
> ++other content
> +EOF
> +test_expect_success "git-config diff.relative=true in $1" "
> + (cd $1; git -c diff.relative=true diff -p HEAD^ >../actual) &&
> + test_cmp expected actual
> +"
> +}
> +
>  check_numstat() {
>  expect=$1; shift
>  cat >expected <<EOF
> @@ -69,5 +86,9 @@ for type in diff numstat stat raw; do
>  check_$type file2 --relative=subdir
>  check_$type dir/file2 --relative=sub
>  done
> +for type in config; do
> + check_$type file2 subdir/
> + check_$type file2 subdir
> +done
>
>  test_done
> -- 
Philip 
