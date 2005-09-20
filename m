From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Make the git-fsck-objects diagnostics more useful
Date: Tue, 20 Sep 2005 15:55:32 -0400
Message-ID: <200509201955.j8KJtWAr003157@laptop11.inf.utfsm.cl>
References: <pasky@ucw.cz>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 21:57:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHoDW-0005Ih-Sh
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 21:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbVITTzo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 15:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbVITTzn
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 15:55:43 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:35035 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S965103AbVITTzn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 15:55:43 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j8KJtWmB019055
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 Sep 2005 15:55:32 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id j8KJtWAr003157;
	Tue, 20 Sep 2005 15:55:32 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: Message from Petr Baudis <pasky@ucw.cz> 
   of "Tue, 20 Sep 2005 20:56:05 +0200." <20050920185605.GA28621@pasky.or.cz> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 20 Sep 2005 15:55:32 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9020>

Petr Baudis <pasky@ucw.cz> wrote:
> Actually report what exactly is wrong with the object, instead of an
> ambiguous 'bad sha1 file' or such. In places where we already do, unify
> the format and clean the messages up.
> 
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> 
> ---
> commit ff0b3368b45a07ac080574eb721a607892413b99
> tree c5e730edddb7679bee63a7d76fb088a7378a9d8b
> parent 12913234050c07785b7fc5929e4c8b5f80606609
> author Petr Baudis <pasky@suse.cz> Tue, 20 Sep 2005 20:54:33 +0200
> committer Petr Baudis <xpasky@machine.(none)> Tue, 20 Sep 2005 20:54:33 +0200
> 
>  fsck-objects.c |   82 +++++++++++++++++++++++++++++++++-----------------------
>  1 files changed, 48 insertions(+), 34 deletions(-)
> 
> diff --git a/fsck-objects.c b/fsck-objects.c
> --- a/fsck-objects.c
> +++ b/fsck-objects.c
> @@ -20,6 +20,35 @@ static int check_strict = 0;
>  static int keep_cache_objects = 0; 
>  static unsigned char head_sha1[20];
>  
> +
> +static void objreport(struct object *obj, const char *severity,
> +                      const char *err, va_list params)
> +{
> +	fprintf(stderr, "%s in %s %s: ",
> +	        severity, obj->type, sha1_to_hex(obj->sha1));
> +	vfprintf(stderr, err, params);
> +	fputs("\n", stderr);
> +}

Is this legal? I am under the impression you have to call
va_start()/va_end() always, even if you just pass the va_list down.

The comp.lang.c FAQ <http://www.eskimo.com/~scs/C-faq/q15.5.html> agrees
with me here... it should be:

static void objreport(struct object *obj, const char *severity,
                      const char *err, ...)
{
	va_list params;
	
	fprintf(stderr, "%s in %s %s: ",
	        severity, obj->type, sha1_to_hex(obj->sha1));
	va_start(params, err);
        vfprintf(stderr, err, params);	
	va_end(params);
	fputs("\n", stderr);
}

[Yes, I know. "We all are using gcc and glibc on Linux". But anyway.]
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
