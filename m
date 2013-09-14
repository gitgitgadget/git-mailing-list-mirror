From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 2/3] relative_path should honor dos_drive_prefix
Date: Sat, 14 Sep 2013 08:11:31 +0200
Message-ID: <5233FE13.4070006@web.de>
References: <cover.1379048276.git.worldhello.net@gmail.com> <79cfcc0c66eb19e3621fff2dafefdddbcbc824cf.1379048276.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Tvangeste <i.4m.l33t@yandex.ru>, Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 14 08:11:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKj57-00068V-I4
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 08:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776Ab3INGLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Sep 2013 02:11:39 -0400
Received: from mout.web.de ([212.227.17.11]:63293 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978Ab3INGLi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Sep 2013 02:11:38 -0400
Received: from [192.168.209.26] ([217.208.218.204]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0M5OaF-1W9MSF3EmV-00zavG for <git@vger.kernel.org>;
 Sat, 14 Sep 2013 08:11:37 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <79cfcc0c66eb19e3621fff2dafefdddbcbc824cf.1379048276.git.worldhello.net@gmail.com>
X-Provags-ID: V03:K0:m4zuISwPqz33qDhW+l1uFeC1PQAvVcJ63FLQGWA+oFxuyV882Up
 T98aQX9iFX0kY1YYWZwqk0Ie0YhUgztJM2u1kVJl7HHHSMNnp65qjFwA31EaUIBtRd8taQo
 fGL2iIf5QikDoxrZaxLKvSSfdzZ4uUeBmbOs0i2H25WL4/ypi2VN4+CwdcpyCjd+opVBwvV
 LFyfg90UzFdAxZbcM02Zg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234791>

On 13.09.13 07:08, Jiang Xin wrote:
> Tvangeste found that the "relative_path" function could not work
> properly on Windows if "in" and "prefix" have dos driver prefix.
> ($gmane/234434)
>
> e.g., When execute: test-path-utils relative_path "C:/a/b" "D:/x/y",
> should return "C:/a/b", but returns "../../C:/a/b", which is wrong.
>
> So make relative_path honor dos_drive_prefix, and add test cases
> for it in t0060.
>
> Reported-by: Tvangeste <i.4m.l33t@yandex.ru>
> Helped-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  path.c                | 20 ++++++++++++++++++++
>  t/t0060-path-utils.sh |  4 ++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/path.c b/path.c
> index 9fd28bcd..65d376d 100644
> --- a/path.c
> +++ b/path.c
> @@ -434,6 +434,16 @@ int adjust_shared_perm(const char *path)
>  	return 0;
>  }
>  
> +static int have_same_root(const char *path1, const char *path2)
> +{
> +	int is_abs1, is_abs2;
> +
> +	is_abs1 = is_absolute_path(path1);
> +	is_abs2 = is_absolute_path(path2);
> +	return (is_abs1 && is_abs2 && tolower(path1[0]) == tolower(path2[0])) ||
> +	       (!is_abs1 && !is_abs2);
> +}
> +
I think the name of the fuction is somewhat misleading, as we are not sure if
they really have the same root.
And that is investigated further down.

may_have_same_root() could be a better name.

[snip]

>  	while (i < prefix_len && j < in_len && prefix[i] == in[j]) {
>  		if (is_dir_sep(prefix[i])) {
>  			while (is_dir_sep(prefix[i]))
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 82a6f21..0187d11 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -210,6 +210,10 @@ relative_path foo/a/b/		foo/a/b		./
>  relative_path foo/a		foo/a/b		../
>  relative_path foo/x/y		foo/a/b		../../x/y
>  relative_path foo/a/c		foo/a/b		../c
> +relative_path foo/a/b		/foo/x/y	foo/a/b
> +relative_path /foo/a/b		foo/x/y		/foo/a/b
> +relative_path d:/a/b		D:/a/c		../b		MINGW
> +relative_path C:/a/b		D:/a/c		C:/a/b		MINGW
Side question:
What happens if we feed in a relative path with a dos drive?
like "c:foo" which is different from c:/foo.
