From: Antti-Juhani Kaijanaho <antti-juhani@kaijanaho.info>
Subject: Re: [PATCH] Spell __attribute__ correctly in cache.h.
Date: Sun, 28 Aug 2005 22:08:53 +0300
Message-ID: <43120BC5.8060608@kaijanaho.info>
References: <19723.1125249085@lotus.CS.Berkeley.EDU> <Pine.LNX.4.58.0508281045060.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jason Riedy <ejr@EECS.Berkeley.EDU>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 21:10:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9SX2-0002LQ-N9
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 21:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVH1TJG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 15:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVH1TJG
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 15:09:06 -0400
Received: from flowerpot.kaijanaho.info ([80.68.88.155]:29457 "EHLO
	flowerpot.kaijanaho.info") by vger.kernel.org with ESMTP
	id S1750753AbVH1TJF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 15:09:05 -0400
Received: from [192.168.0.100] (kukkaruukku.keltti.jyu.fi [::ffff:130.234.192.228])
  (AUTH: PLAIN gaia, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by flowerpot.kaijanaho.info with esmtp; Sun, 28 Aug 2005 22:13:48 +0300
  id 00050593.43120CEC.0000335D
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508281045060.3317@g5.osdl.org>
X-Enigmail-Version: 0.92.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7882>

Linus Torvalds wrote:
> But using "array[]" means that "sizeof()" no longer works, and then you 
> have to use "offsetof()", which is a big pain.

This is not true under C99.  If an array[] is the last member of a
struct (which is what we are, AFAIK, talking about), then sizeof that
struct is defined and gives the size of that struct as if the array's
size were zero (but the struct cannot be used in an automatic context).
 Hence the idiom

  struct foo {
    ...
    int bar[];
  };
  ...
  struct foo *baz = malloc(sizeof *baz + 15 * sizeof (int));
  ...

which allocates baz in such a way that bar is a 15-element array of ints.

Of course, I cannot speak of how other non-C99 compilers implement this,
but GCC gets it right:

ajk@kukkamaljakko:~$ cat foo.c
#include <stdio.h>

struct foo {
        int a;
        int b[];
};

struct bar {
        int a;
        int b[1];
};

int main(void)
{
        printf("sizeof(struct foo) = %zu\n"
               "sizeof(struct bar) = %zu\n"
               "sizeof(int) = %zu\n",
               sizeof(struct foo),
               sizeof(struct bar),
               sizeof(int));
        return 0;
}
ajk@kukkamaljakko:~$ gcc --std=c89 -pedantic -Wall -W -ofoo foo.c
foo.c:5: warning: ISO C90 does not support flexible array members
foo.c: In function 'main':
foo.c:20: warning: ISO C90 does not support the 'z' printf length modifier
foo.c:20: warning: ISO C90 does not support the 'z' printf length modifier
foo.c:20: warning: ISO C90 does not support the 'z' printf length modifier
ajk@kukkamaljakko:~$ gcc --std=c99 -pedantic -Wall -W -ofoo foo.c
ajk@kukkamaljakko:~$ ./foo
sizeof(struct foo) = 4
sizeof(struct bar) = 8
sizeof(int) = 4
ajk@kukkamaljakko:~$

(Tested with both 3.3 and 4.0 in Debian unstable.)
-- 
Antti-Juhani
