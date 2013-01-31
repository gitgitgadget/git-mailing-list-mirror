From: Jeff King <peff@peff.net>
Subject: Re: Re: Segmentation fault with latest git (070c57df)
Date: Thu, 31 Jan 2013 02:55:11 -0500
Message-ID: <20130131075511.GB5342@sigill.intra.peff.net>
References: <15825158.309231359617223702.JavaMail.weblogic@epml26>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>, Antoine Pelisse <apelisse@gmail.com>
To: Jongman Heo <jongman.heo@samsung.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 08:55:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0ozi-00033v-FP
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 08:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078Ab3AaHzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 02:55:16 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54481 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754928Ab3AaHzO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 02:55:14 -0500
Received: (qmail 4379 invoked by uid 107); 31 Jan 2013 07:56:37 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Jan 2013 02:56:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jan 2013 02:55:11 -0500
Content-Disposition: inline
In-Reply-To: <15825158.309231359617223702.JavaMail.weblogic@epml26>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215106>

On Thu, Jan 31, 2013 at 07:27:04AM +0000, Jongman Heo wrote:

> FYI, gdb backtrace and valgrind output attached below, Thanks.

Thanks, that's helpful.

> #4  0x0812bda0 in string_list_insert (list=0xbfffe7c0, string=0x821ec3c "refs/remotes/origin/HEAD") at string-list.c:57
> #5  0x08071838 in add_existing (refname=0x821ec3c "refs/remotes/origin/HEAD", 
>     sha1=0x821ec14 "\a\fW\337B\352N\255\314C\320Em\021E`\022C&", <incomplete sequence \303>, flag=1, cbdata=0xbfffe7c0)
>     at builtin/fetch.c:570

So we are inserting the string from add_existing, which gets the list
from a callback parameter. Which comes from...

> #13 0x0807390a in do_fetch (remote=<value optimized out>, argc=0, argv=0xbfffe9f8) at builtin/fetch.c:699

...here, which does this:

  struct string_list existing_refs = STRING_LIST_INIT_NODUP;
  [...]
  for_each_ref(add_existing, &existing_refs);

And yet we get:

> ==2195== Conditional jump or move depends on uninitialised value(s)
> ==2195==    at 0x812B41F: get_entry_index (string-list.c:10)
> ==2195==    by 0x812BD5F: string_list_insert_at_index (string-list.c:33)
> ==2195==    by 0x812BD9F: string_list_insert (string-list.c:57)
> ==2195==    by 0x8071837: add_existing (fetch.c:570)
> ==2195==    by 0x810AF96: do_one_ref (refs.c:525)
> ==2195==    by 0x810BB20: do_for_each_ref_in_dir (refs.c:551)
> ==2195==    by 0x810BD34: do_for_each_ref_in_dirs (refs.c:623)
> ==2195==    by 0x810BC8D: do_for_each_ref_in_dirs (refs.c:597)
> ==2195==    by 0x810C303: do_for_each_ref (refs.c:1295)
> ==2195==    by 0x810C63A: for_each_ref (refs.c:1343)
> ==2195==    by 0x8073909: fetch_one (fetch.c:699)
> ==2195==    by 0x8074250: cmd_fetch (fetch.c:992)

which seems odd. cmp should be initialized to NULL, and then we never
touch it (and even if we did, it wouldn't be unitialized, but rather
have the value we put in it).

It's almost like the compiler is getting the initializer wrong. It's a
long shot, but I wonder if the presence of the bitfield could be
triggering a compiler bug (or there is a subtle C rule about bitfield
initializations that I do not know). Just for the sake of my sanity,
what does the following program output for you?

-- >8 --
#include <stdio.h>
#include <stdlib.h>

typedef int (*compare_fn)(const char *, const char *);

struct foo {
  char **items;
  unsigned int nr, alloc;
  unsigned int bitfield:1;
  compare_fn cmp;
};

int main(void)
{
  struct foo f = { NULL, 0, 0, 0 };
  printf("cmp is %lu\n", (unsigned long)f.cmp);
  return 0;
}
