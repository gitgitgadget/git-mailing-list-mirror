From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Add git-annotate, a tool for assigning blame.
Date: Thu, 23 Feb 2006 17:10:49 -0500
Message-ID: <20060223221048.GA6423@mythryan2.michonline.com>
References: <11404323692193-git-send-email-ryan@michonline.com> <20060220234054.GA7903@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 23:12:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCOh4-0001b5-4i
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 23:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbWBWWMJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 17:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWBWWMJ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 17:12:09 -0500
Received: from mail.autoweb.net ([198.172.237.26]:55507 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751789AbWBWWMI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 17:12:08 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FCOgu-0003Kw-HX; Thu, 23 Feb 2006 17:12:05 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FCOgn-0005dr-1o; Thu, 23 Feb 2006 17:11:57 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1FCOgE-00044e-OM; Thu, 23 Feb 2006 17:11:22 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
Content-Disposition: inline
In-Reply-To: <20060220234054.GA7903@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.9i
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16670>

(Biased critique since I have the other tool in the tree, but still...)

On Tue, Feb 21, 2006 at 12:40:54AM +0100, Fredrik Kuivinen wrote:
> diff --git a/blame.c b/blame.c
> new file mode 100644
> index 0000000..d4a2fad
> --- /dev/null
> +++ b/blame.c
> @@ -0,0 +1,444 @@
> +#include <assert.h>
> +
> +#include "cache.h"
> +#include "refs.h"
> +#include "tag.h"
> +#include "commit.h"
> +#include "tree.h"
> +#include "blob.h"
> +#include "epoch.h"
> +#include "diff.h"
> +
> +#define DEBUG 0
> +
> +struct commit** blame_lines;
> +int num_blame_lines;
> +
> +struct util_info
> +{
> +    int* line_map;
> +    int num_lines;
> +    unsigned char sha1[20]; /* blob sha, not commit! */
> +    char* buf;
> +    unsigned long size;
> +//    const char* path;
> +};
> +
> +struct chunk
> +{
> +    int off1, len1; // ---
> +    int off2, len2; // +++
> +};
> +
> +struct patch
> +{
> +    struct chunk* chunks;
> +    int num;
> +};
> +
> +static void get_blob(struct commit* commit);
> +
> +int num_get_patch = 0;
> +int num_commits = 0;
> +
> +struct patch* get_patch(struct commit* commit, struct commit* other)
> +{
> +    struct patch* ret = xmalloc(sizeof(struct patch));
> +    ret->chunks = NULL;
> +    ret->num = 0;
> +
> +    struct util_info* info_c = (struct util_info*) commit->object.util;
> +    struct util_info* info_o = (struct util_info*) other->object.util;
> +
> +    if(!memcmp(info_c->sha1, info_o->sha1, 20))
> +        return ret;
> +
> +    get_blob(commit);
> +    get_blob(other);
> +
> +    FILE* fout = fopen("/tmp/git-blame-tmp1", "w");

Probably should be using something like mkstemp (mkstmp?) here, so if
someone is runnign things as root or with a malicous user around, things
don't collide.

Hell, so on a multi-user machine this doesn't blow up on you.

But, read down for a related comment.

> +    if(!fout)
> +        die("fopen tmp1 failed: %s", strerror(errno));
> +
> +    if(fwrite(info_c->buf, info_c->size, 1, fout) != 1)
> +        die("fwrite 1 failed: %s", strerror(errno));
> +    fclose(fout);
> +
> +    fout = fopen("/tmp/git-blame-tmp2", "w");
> +    if(!fout)
> +        die("fopen tmp2 failed: %s", strerror(errno));
> +
> +    if(fwrite(info_o->buf, info_o->size, 1, fout) != 1)
> +        die("fwrite 2 failed: %s", strerror(errno));
> +    fclose(fout);
> +
> +    FILE* fin = popen("diff -u0 /tmp/git-blame-tmp1 /tmp/git-blame-tmp2", "r");
> +    if(!fin)
> +        die("popen failed: %s", strerror(errno));

Can't git-diff-tree do this sufficiently, anyway?  See my Perl script
for an example, you just need both commit IDs and both filenames and the
appropriate -M and you get the right results.

(It's possible that's part of where the performance differences are,
though, not really sure at the moment.)

I'm going to stop there for the moment, I'm not really confident in my
understanding of git-internals to say much more just yet.

This could probably benefit a *LOT* from the libification project, I
think, though.


-- 

Ryan Anderson
  sometimes Pug Majere
