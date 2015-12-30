From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v8] ls-files: Add eol diagnostics
Date: Wed, 30 Dec 2015 14:22:44 +0000
Message-ID: <5683E8B4.7040005@ramsayjones.plus.com>
References: <5683D49D.2010509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 30 15:24:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEHfh-0002z3-Ek
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 15:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbbL3OYJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Dec 2015 09:24:09 -0500
Received: from avasout07.plus.net ([84.93.230.235]:44398 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbbL3OYI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 09:24:08 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout07 with smtp
	id zqNr1r00F4mu3xa01qNsBh; Wed, 30 Dec 2015 14:22:52 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=MZKRwMLf c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=BCjA09oAAAAA:8 a=DoEN08qvR1caZIqocaMA:9
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <5683D49D.2010509@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283183>



On 30/12/15 12:57, Torsten B=C3=B6gershausen wrote:
> When working in a cross-platform environment, a user wants to
> check if text files are stored normalized in the repository and if
> .gitattributes are set appropriately.
>=20
> Make it possible to let Git show the line endings in the index and
> in the working tree and the effective text/eol attributes.
>=20
> The end of line ("eolinfo") are shown like this:
> "binary"       binary file
> "text-no-eol"  text file without any EOL
> "text-lf"      text file with LF
> "text-crlf"    text file with CRLF
> "text-crlf-lf" text file with mixed line endings.
>=20
> The effective text/eol attribute is one of these:
> "", "-text", "text", "text=3Dauto", "eol=3Dlf", "eol=3Dcrlf"
>=20
> git ls-files --eol gives an output like this:
>=20
> i/text-no-eol   w/text-no-eol   attr/text=3Dauto t/t5100/empty
> i/binary        w/binary        attr/-text     t/test-binary-2.png
> i/text-lf       w/text-lf       attr/eol=3Dlf    t/t5100/rfc2047-info=
-0007
> i/text-lf       w/text-crlf     attr/eol=3Dcrlf  doit.bat
> i/text-crlf-lf  w/text-crlf-lf  attr/          locale/XX.po
>=20
> Add test cases in t0027, thanks to Junio C Hamano for the optimized
> grep-less sed expression.
>=20
> Helped-By: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> Changes since v7:
> - Remove the "may change" from commit message.
> - Run make doc, improved git-ls-files.txt
>  Documentation/git-ls-files.txt |  23 +++++++++
>  builtin/ls-files.c             |  19 +++++++
>  convert.c                      |  85 +++++++++++++++++++++++++++++++
>  convert.h                      |   3 ++
>  t/t0027-auto-crlf.sh           | 112 +++++++++++++++++++++++++++++++=
+++++-----
>  5 files changed, 230 insertions(+), 12 deletions(-)
>=20
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-fi=
les.txt
> index e26f01f..13b0e1d 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -12,6 +12,7 @@ SYNOPSIS
>  'git ls-files' [-z] [-t] [-v]
>  		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])=
*
>  		(-[c|d|o|i|s|u|k|m])*
> +		[--eol]
>  		[-x <pattern>|--exclude=3D<pattern>]
>  		[-X <file>|--exclude-from=3D<file>]
>  		[--exclude-per-directory=3D<file>]
> @@ -147,6 +148,19 @@ a space) at the start of each line:
>  	possible for manual inspection; the exact format may change at
>  	any time.
>  +--eol::
> +	Show line endings ("eolinfo") and the text/eol attributes ("texteol=
attr") of
> files.
> +	"eolinfo" is the file content identification used by Git when
> +	the "text" attribute is "auto", or core.autocrlf !=3D false.
> ++
> +"eolinfo" is either "" (when the the info is not available"), or one=
 of "binary",
> +"text-no-eol", "text-lf", "text-crlf" or "text-crlf-lf".

<bikeshedding>

Again, I think this list reads better as: binary, none, lf, crlf and mi=
xed.

If you prefer to have 'text' in there somewhere, how about:

   binary, text-none, text-lf, text-crlf, text-mixed.

:-D

(I promise not the mention it again!)

</bikeshedding>

ATB,
Ramsay Jones
