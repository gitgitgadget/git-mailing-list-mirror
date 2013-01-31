From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Segmentation fault with latest git (070c57df)
Date: Thu, 31 Jan 2013 09:42:07 +0100
Message-ID: <87wqutvj4w.fsf@pctrast.inf.ethz.ch>
References: <15825158.309231359617223702.JavaMail.weblogic@epml26>
	<20130131075511.GB5342@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jongman Heo <jongman.heo@samsung.com>, git <git@vger.kernel.org>,
	"Antoine Pelisse" <apelisse@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 09:42:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0pj8-0004pP-Cy
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 09:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342Ab3AaImN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 03:42:13 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:41639 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214Ab3AaImL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 03:42:11 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 31 Jan
 2013 09:42:01 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.208.71) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 31 Jan
 2013 09:42:08 +0100
In-Reply-To: <20130131075511.GB5342@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 31 Jan 2013 02:55:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.208.71]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215109>

Jeff King <peff@peff.net> writes:

> On Thu, Jan 31, 2013 at 07:27:04AM +0000, Jongman Heo wrote:
>
>> FYI, gdb backtrace and valgrind output attached below, Thanks.
>
> Thanks, that's helpful.
>
>> #4 0x0812bda0 in string_list_insert (list=0xbfffe7c0,
>> string=0x821ec3c "refs/remotes/origin/HEAD") at string-list.c:57
>> #5  0x08071838 in add_existing (refname=0x821ec3c "refs/remotes/origin/HEAD", 
>>     sha1=0x821ec14 "\a\fW\337B\352N\255\314C\320Em\021E`\022C&",
>> <incomplete sequence \303>, flag=1, cbdata=0xbfffe7c0)
>>     at builtin/fetch.c:570
>
> So we are inserting the string from add_existing, which gets the list
> from a callback parameter. Which comes from...
>
>> #13 0x0807390a in do_fetch (remote=<value optimized out>, argc=0,
>> argv=0xbfffe9f8) at builtin/fetch.c:699
>
> ...here, which does this:
>
>   struct string_list existing_refs = STRING_LIST_INIT_NODUP;
>   [...]
>   for_each_ref(add_existing, &existing_refs);
>
> And yet we get:
>
>> ==2195== Conditional jump or move depends on uninitialised value(s)
>> ==2195==    at 0x812B41F: get_entry_index (string-list.c:10)
>> ==2195==    by 0x812BD5F: string_list_insert_at_index (string-list.c:33)
>> ==2195==    by 0x812BD9F: string_list_insert (string-list.c:57)
>> ==2195==    by 0x8071837: add_existing (fetch.c:570)
>> ==2195==    by 0x810AF96: do_one_ref (refs.c:525)
>> ==2195==    by 0x810BB20: do_for_each_ref_in_dir (refs.c:551)
>> ==2195==    by 0x810BD34: do_for_each_ref_in_dirs (refs.c:623)
>> ==2195==    by 0x810BC8D: do_for_each_ref_in_dirs (refs.c:597)
>> ==2195==    by 0x810C303: do_for_each_ref (refs.c:1295)
>> ==2195==    by 0x810C63A: for_each_ref (refs.c:1343)
>> ==2195==    by 0x8073909: fetch_one (fetch.c:699)
>> ==2195==    by 0x8074250: cmd_fetch (fetch.c:992)
>
> which seems odd. cmp should be initialized to NULL, and then we never
> touch it (and even if we did, it wouldn't be unitialized, but rather
> have the value we put in it).
>
> It's almost like the compiler is getting the initializer wrong. It's a
> long shot, but I wonder if the presence of the bitfield could be
> triggering a compiler bug (or there is a subtle C rule about bitfield
> initializations that I do not know). Just for the sake of my sanity,
> what does the following program output for you?
>
> -- >8 --
> #include <stdio.h>
> #include <stdlib.h>
>
> typedef int (*compare_fn)(const char *, const char *);
>
> struct foo {
>   char **items;
>   unsigned int nr, alloc;
>   unsigned int bitfield:1;
>   compare_fn cmp;
> };
>
> int main(void)
> {
>   struct foo f = { NULL, 0, 0, 0 };
>   printf("cmp is %lu\n", (unsigned long)f.cmp);
>   return 0;
> }

I doubt that would help because that stack region would be 0 anyway due
to kernel initialization of new pages.  You'd have to somehow trample
over it first, like below.

Or perhaps something in the build process went wrong, and fetch.c didn't
get the memo about the new field in the struct.  Depending on stack
layout, the next variable might be the 'int i' right before the
'string_list list' in the code, which could explain the value of 1.

---- 8< ----
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef int (*compare_fn)(const char *, const char *);

struct foo {
  char **items;
  unsigned int nr, alloc;
  unsigned int bitfield:1;
  compare_fn cmp;
};

void scramble()
{
  char foo[256];
  memset(foo, 0x42, 256);
}

void init()
{
  struct foo f = { NULL, 0, 0, 0 };
  printf("cmp is %lu\n", (unsigned long)f.cmp);
}

int main(void)
{
  scramble();
  init();
  return 0;
}
