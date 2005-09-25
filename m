From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Implementing diff, was Re: git 0.99.7b doesn't build on Cygwin
Date: Sun, 25 Sep 2005 12:16:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0509251205230.23415@localhost.localdomain>
References: <ud5mznc1x.fsf@peter-b.co.uk>
 <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231647300.3308@g5.osdl.org> <Pine.LNX.4.58.0509231737140.3308@g5.osdl.org>
 <7vzmq1twh5.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0509251745160.17672@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0509250854570.22725@localhost.localdomain>
 <Pine.LNX.4.58.0509250959540.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 21:14:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJbwz-0002p7-P5
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 21:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVIYTNc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 15:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbVIYTNc
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 15:13:32 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:7309 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S932272AbVIYTNb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 15:13:31 -0400
X-AuthUser: davidel@xmailserver.org
Received: from debstar.dev.mdolabs.com
	by xmailserver.org with [XMail 1.22 ESMTP Server]
	id <S1A118C> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Sun, 25 Sep 2005 12:14:44 -0700
X-X-Sender: davide@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509250959540.3308@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9277>

On Sun, 25 Sep 2005, Linus Torvalds wrote:

> On Sun, 25 Sep 2005, Davide Libenzi wrote:
>>
>> What you'd have to do, if you chose to use diffutils stuff, is to
>> transform the main() of diff in diff_main(), use setjmp/longjmp to capture
>> its exit()s, and make it use a proper allocator (if you want to avoid
>> leaks upon aborts).
>
> I'd love to use libxdiff instead since you say it can do it, but quite
> frankly, the man-page didn't much help me. Do you have an example of how
> to generate a uni-diff with it? Something that mortal men can read and say
> "oh"?

Ahh, you looked at the docs. Don't do that ;) Take a look at the 
test/xdiff_test.c for an example on how to use its most important APIs. 
There is also a regression test (xregression) that create random files, 
renadomly changes them, and then try that (A-B)+B=A and (B-A)+A=B (for 
both text and binary). I'm dropping inline an example on how to text-diff ...



- Davide



#include "xmacros.h"
#include "xdiff.h"

#define XDLT_STD_BLKSIZE (1024 * 8)

static int xdlt_load_mmfile(char const *fname, mmfile_t *mf, int binmode) {
         char cc;
         int fd;
         long size, bsize;
         char *blk;

         if (xdl_init_mmfile(mf, XDLT_STD_BLKSIZE, XDL_MMF_ATOMIC) < 0) {

                 return -1;
         }
         if ((fd = open(fname, O_RDONLY)) == -1) {
                 perror(fname);
                 xdl_free_mmfile(mf);
                 return -1;
         }
         if ((size = bsize = lseek(fd, 0, SEEK_END)) > 0 && !binmode) {
                 if (lseek(fd, -1, SEEK_END) != (off_t) -1 &&
                     read(fd, &cc, 1) && cc != '\n')
                         bsize++;
         }
         lseek(fd, 0, SEEK_SET);
         if (!(blk = (char *) xdl_mmfile_writeallocate(mf, bsize))) {
                 xdl_free_mmfile(mf);
                 close(fd);
                 return -1;
         }
         if (read(fd, blk, (size_t) size) != (size_t) size) {
                 perror(fname);
                 xdl_free_mmfile(mf);
                 close(fd);
                 return -1;
         }
         close(fd);
         if (bsize > size)
                 blk[size] = '\n';
         return 0;
}

static int xdlt_outf(void *priv, mmbuffer_t *mb, int nbuf) {
         int i;

         for (i = 0; i < nbuf; i++)
                 if (!fwrite(mb[i].ptr, mb[i].size, 1, (FILE *) priv))
                         return -1;
         return 0;
}

static void *wrap_malloc(void *priv, unsigned int size) {

         return malloc(size);
}

static void wrap_free(void *priv, void *ptr) {

         free(ptr);
}

static void *wrap_realloc(void *priv, void *ptr, unsigned int size) {

         return realloc(ptr, size);
}

int sample_textdiff(char const *pre, char const *post, FILE *outf) {
         int error;
         memallocator_t malt;
         mmfile_t mf1, mf2;
         xpparam_t xpp;
         xdemitconf_t xecfg;
         xdemitcb_t ecb;

         malt.priv = NULL;
         malt.malloc = wrap_malloc;
         malt.free = wrap_free;
         malt.realloc = wrap_realloc;
         xdl_set_allocator(&malt);
         if (xdlt_load_mmfile(pre, &mf1, 0) < 0)
                 return -1;
         if (xdlt_load_mmfile(post, &mf2, 0) < 0) {
                 xdl_free_mmfile(&mf1);
                 return -1;
         }
         xpp.flags = 0;
         xecfg.ctxlen = 3;
         ecb.priv = outf;
         ecb.outf = xdlt_outf;
         error = xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
         xdl_free_mmfile(&mf2);
         xdl_free_mmfile(&mf1);

         return error;
}
