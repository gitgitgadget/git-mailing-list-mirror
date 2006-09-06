From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/2] Add git-archive
Date: Wed, 06 Sep 2006 22:17:53 +0200
Message-ID: <44FF2CF1.9020201@lsrfire.ath.cx>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 22:18:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL3qT-0005EZ-EV
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 22:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbWIFUR6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 16:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbWIFUR6
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 16:17:58 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:41965
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751569AbWIFUR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 16:17:57 -0400
Received: from [10.0.1.3] (p508E760A.dip.t-dialin.net [80.142.118.10])
	by neapel230.server4you.de (Postfix) with ESMTP id 6BCB01400D;
	Wed,  6 Sep 2006 22:17:56 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26557>

Franck Bui-Huu schrieb:
> diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
> index 61a4135..e0da01e 100644
> --- a/builtin-tar-tree.c
> +++ b/builtin-tar-tree.c
> @@ -9,6 +9,7 @@ #include "strbuf.h"
> #include "tar.h"
> #include "builtin.h"
> #include "pkt-line.h"
> +#include "archive.h"
> 
> #define RECORDSIZE    (512)
> #define BLOCKSIZE    (RECORDSIZE * 20)
> @@ -338,6 +339,71 @@ static int generate_tar(int argc, const
>     return 0;
> }
> 
> +static int write_tar_entry(const unsigned char *sha1,
> +                           const char *base, int baselen,
> +                           const char *filename, unsigned mode, int stage)
> +{
> +    static struct strbuf path;
> +    int filenamelen = strlen(filename);
> +    void *buffer;
> +    char type[20];
> +    unsigned long size;
> +
> +    if (!path.alloc) {
> +        path.buf = xmalloc(PATH_MAX);
> +        path.alloc = PATH_MAX;
> +        path.len = path.eof = 0;
> +    }
> +    if (path.alloc < baselen + filenamelen) {
> +        free(path.buf);
> +        path.buf = xmalloc(baselen + filenamelen);
> +        path.alloc = baselen + filenamelen;
> +    }
> +    memcpy(path.buf, base, baselen);
> +    memcpy(path.buf + baselen, filename, filenamelen);
> +    path.len = baselen + filenamelen;
> +    if (S_ISDIR(mode)) {
> +        strbuf_append_string(&path, "/");
> +        buffer = NULL;
> +        size = 0;
> +    } else {
> +        buffer = read_sha1_file(sha1, type, &size);
> +        if (!buffer)
> +            die("cannot read %s", sha1_to_hex(sha1));
> +    }
> +
> +    write_entry(sha1, &path, mode, buffer, size);

Here occurs the memory leak that I've been talking about.  buffer needs
to be free'd.

> +
> +    return READ_TREE_RECURSIVE;
> +}
