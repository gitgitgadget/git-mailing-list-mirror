From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] repack: call prune_packed_objects() and update_server_info()
 directly
Date: Sat, 13 Sep 2014 10:59:03 +0200
Message-ID: <54140757.4010300@gmail.com>
References: <5413F201.8030005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 13 10:59:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSjAn-0004kN-Tn
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 10:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbaIMI7I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Sep 2014 04:59:08 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:34860 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbaIMI7G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 04:59:06 -0400
Received: by mail-we0-f177.google.com with SMTP id u57so1790108wes.36
        for <git@vger.kernel.org>; Sat, 13 Sep 2014 01:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=K3olOE/4Qx++fJN+e2kpjlDA4SmsMTL+vFD/vGXkpK8=;
        b=TDcKFBJXYUsX4SHMrQ7NBklngvR51wj9JdDPscYF6cN41bgNqv+K8I5OYbh/D4AjSN
         /dmJ1X96lXryjjCa6lzEIeeznDsGtpOpm6hbdYBkZf8Z8zpfMptN7D9U3zlkjRYj6qIW
         2LIhdkcEy4tFPTbpnzHhn4sp+zsa8OD7u03n1dHv0yPxy528RvyMiQpuMs3HdYKFHn8Q
         kLFqxDmPPeN0+C0TbW/tlF5CJJHB43QQ5JhTD5By1VJE80x2XEtwruBTofP3UEr3rUuw
         x4gzks8wQKC05bASqJS8T3/r7UebPizi5wvYE0gkQ9zk0GKdxkGbFRs2BCBBWYBRPVTL
         5Erg==
X-Received: by 10.194.122.6 with SMTP id lo6mr17955189wjb.17.1410598744014;
        Sat, 13 Sep 2014 01:59:04 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id gl10sm4533321wib.1.2014.09.13.01.59.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Sep 2014 01:59:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <5413F201.8030005@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256957>

On 13.09.2014 09:28, Ren=C3=A9 Scharfe wrote:
> Call the functions behind git prune-packed and git update-server-info
> directly instead of using run_command().  This is shorter, easier and
> quicker.
>=20
> Signed-off-by: Rene Scharfe <l.s.r@web.de>

Thanks for cleaning up the literal rewrite of the shell script
and making it look more like a C program.

Reviewed-by: Stefan Beller <stefanbeller@gmail.com>

> ---
>  builtin/repack.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
>=20
> diff --git a/builtin/repack.c b/builtin/repack.c
> index fc088db..2aae05d 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -377,6 +377,7 @@ int cmd_repack(int argc, const char **argv, const=
 char *prefix)
>  	/* End of pack replacement. */
> =20
>  	if (delete_redundant) {
> +		int opts =3D 0;
>  		sort_string_list(&names);
>  		for_each_string_list_item(item, &existing_packs) {
>  			char *sha1;
> @@ -387,25 +388,13 @@ int cmd_repack(int argc, const char **argv, con=
st char *prefix)
>  			if (!string_list_has_string(&names, sha1))
>  				remove_redundant_pack(packdir, item->string);
>  		}
> -		argv_array_push(&cmd_args, "prune-packed");
> -		if (quiet)
> -			argv_array_push(&cmd_args, "--quiet");
> -
> -		memset(&cmd, 0, sizeof(cmd));
> -		cmd.argv =3D cmd_args.argv;
> -		cmd.git_cmd =3D 1;
> -		run_command(&cmd);
> -		argv_array_clear(&cmd_args);
> +		if (!quiet && isatty(2))
> +			opts |=3D PRUNE_PACKED_VERBOSE;
> +		prune_packed_objects(opts);
>  	}
> =20
> -	if (!no_update_server_info) {
> -		argv_array_push(&cmd_args, "update-server-info");
> -		memset(&cmd, 0, sizeof(cmd));
> -		cmd.argv =3D cmd_args.argv;
> -		cmd.git_cmd =3D 1;
> -		run_command(&cmd);
> -		argv_array_clear(&cmd_args);
> -	}
> +	if (!no_update_server_info)
> +		update_server_info(0);
>  	remove_temporary_files();
>  	string_list_clear(&names, 0);
>  	string_list_clear(&rollback, 0);
>=20
