From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH RFC] parse_object: pass on the original sha1, not the replaced one
Date: Thu, 5 Aug 2010 13:41:08 +0200
Message-ID: <201008051341.08632.chriscool@tuxfamily.org>
References: <1280579802-8606-1-git-send-email-pclouds@gmail.com> <201008041457.31975.chriscool@tuxfamily.org> <AANLkTimVnAO6kCAo8N6DM9GX3z+DjKJgKizdTnktyb8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 13:43:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgyrK-0004hh-0T
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 13:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759080Ab0HELnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 07:43:33 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:45861 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755620Ab0HELnc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 07:43:32 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id BC809818068;
	Thu,  5 Aug 2010 13:43:25 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-23-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <AANLkTimVnAO6kCAo8N6DM9GX3z+DjKJgKizdTnktyb8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152647>

On Thursday 05 August 2010 00:07:45 Nguyen Thai Ngoc Duy wrote:
> On Wed, Aug 4, 2010 at 10:57 PM, Christian Couder
> 
> <chriscool@tuxfamily.org> wrote:
> > On Wednesday 04 August 2010 14:42:50 Nguyen Thai Ngoc Duy wrote:
> >> On Wed, Aug 4, 2010 at 9:58 PM, Christian Couder
> >> 
> >> <chriscool@tuxfamily.org> wrote:
> >> >> > I will
> >> >> > try to have a deeper look at that, but it would help if you could
> >> >> > give an example of a command that triggers this behavior.
> >> >> 
> >> >> The following patch add "sha1" command. These commands give different
> >> >> sha1:
> >> >> 
> >> >> git sha1 `git rev-parse HEAD` `git rev-parse HEAD^` A
> >> >> git sha1 `git rev-parse HEAD` `git rev-parse HEAD^` B
> >> > 
> >> > Yes, but that does not mean that the content of the object returned by
> >> > lookup_commit(A) is not the content of A.
> >> > 
> >> > Or do you have an example where the content of the object returned by
> >> > lookup_commit(A) is not the content of A?
> >> 
> >> Both return the content of B. I modified my patch a bit to also show
> >> the content, ((struct commit*)obj)->buffer.
> > 
> > I also modified your patch but I don't get any content shown when using
> > lookup_commit()
> > 
> > I use:
> > 
> > diff --git a/builtin/sha1.c b/builtin/sha1.c
> > new file mode 100644
> > index 0000000..8e081b2
> > --- /dev/null
> > +++ b/builtin/sha1.c
> > @@ -0,0 +1,27 @@
> > +#include "cache.h"
> > +#include "commit.h"
> > +
> > +int cmd_sha1(int argc, char **argv)
> > +{
> > +       unsigned char old[20];
> > +       unsigned char new[20];
> > +       struct object *obj;
> > +
> > +       get_sha1_hex(argv[1], old);
> > +       get_sha1_hex(argv[2], new);
> > +       printf("old  = %s\nnew  = %s\n", argv[1], argv[2]);
> > +       replace_pair(old, new);
> > +       if (argv[3][0] == 'A')
> > +              obj = parse_object(old);
> > +       else {
> > +              struct commit *com = lookup_commit(old);
> > +              if (com->buffer)
> > +                      printf("commit buffer:\n%s", com->buffer);
> > +              else
> > +                      printf("no commit buffer\n");
> > +              obj = (struct object *)com;
> > +       }
> > +
> > +       printf("sha1 = %s\n", sha1_to_hex(obj->sha1));
> > +       return 0;
> > +}
> > 
> > and I get:
> > 
> > $ git sha1 `git rev-parse HEAD` `git rev-parse HEAD^` B
> > old  = 5b4585a035e2ba61573273dacc6d17d7e8fcbc7d
> > new  = c9b402bd93105f80f3c5d67ecfccc8ba36810613
> > no commit buffer
> > sha1 = 5b4585a035e2ba61573273dacc6d17d7e8fcbc7d
> > 
> > Could you show what code you use?
> 
> You need parse_commit() (unless somebody already did that before
> lookup_commit()).

It looks like parse_commit() is buggy regarding replaced objects. But I am not 
sure how it should be fixed.

Anyway if you use parse_object(), then you don't need parse_commit(). So if 
possible you should use parse_object() instead of both lookup_commit() and 
parse_commit().

Best regards,
Christian.
