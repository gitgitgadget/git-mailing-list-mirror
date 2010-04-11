From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Sat, 10 Apr 2010 20:50:42 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004101617460.7232@xanadu.home>
References: <loom.20100406T161552-321@post.gmane.org>
 <alpine.LFD.2.00.1004061709360.7232@xanadu.home> <4BBC1ED3.6020008@gmail.com>
 <alpine.LFD.2.00.1004070842580.7232@xanadu.home> <hppu9a$ugq$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Vitaly Berov <vitaly.berov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 03:07:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0ldb-0005th-LG
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 03:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab0DKBGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 21:06:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61402 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321Ab0DKBGy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 21:06:54 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L0O009BVT0I8X50@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 10 Apr 2010 20:50:42 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <hppu9a$ugq$1@dough.gmane.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144620>

On Sat, 10 Apr 2010, Vitaly Berov wrote:

> Hi,
> 
> On 04/07/2010 04:55 PM, Nicolas Pitre wrote:
> > On Wed, 7 Apr 2010, Vitaly wrote:
> > 
> > 
> > OK then.  What happens if you do the following on the server machine
> > where the repository is stored:
> > 
> > 	git repack -a -f -d
> > 
> > How long does this take?
> > 
> > If the "Resolving deltas" takes more than 10 minutes, could you capture
> > a strace dump from that process during a minute or so and post it here?
> 
> Nicolas, I took strace and sent it to you personally.
> 
> Here is the extract (99% of strace is the same):
> --------------
> access("/home/vitaly/Projects/test/a1/.git/objects/0f/9a3d28766f8b767fb64166139dd65c079512de", F_OK) = -1 ENOENT (No such file or directory)
> pread(5, "x\234\324\275y\\Ni\374\377\177\256\323]\335Q\271S\332\220\"\n\241\10Q\10!$!d/\262"..., 214850, 8944159649) = 214850
> access("/home/vitaly/Projects/test/a1/.git/objects/a5/5430cbc6674b56d7c2d2d81ef5b7d5c8ebdec8", F_OK) = -1 ENOENT (No such file or directory)
> pread(5, "x\234\354\275\vT\224U\0270<\347\231\v\363\250\244#\f0\"\"\"\312ETD\300af"..., 159502, 8944374506) = 159502
> access("/home/vitaly/Projects/test/a1/.git/objects/e5/02b7d050d1b81ebc256234e303eac17116c9fb", F_OK) = -1 ENOENT (No such file or directory)
> pread(5, "x\234\324\274yX\24G\3607>\3353\263,\310\342\"7\2.\202\342\1\10\212\210\212\10\236x\341"..., 61131, 8944534014) = 61131
> access("/home/vitaly/Projects/test/a1/.git/objects/5b/6bdba61771e5ba63ba8b43659db1612345c2eb", F_OK) = -1 ENOENT (No such file or directory)
> pread(5, "x\234\324\275\tX\216Y\3747~\237\323\366DOJiyR\236\210B*$!\311\276\223=[\n"..., 236685, 8944595152) = 236685
> -----------------
> As for me, it looks very suspicious.

It isn't.  The pread() is performed for each delta object within the 
received pack to be resolved, and then the access() is performed to make 
sure the resolved delta doesn't match an object in loose form with the 
same hash.  Of course deltas are recursive, meaning that a delta might 
refer to a base object which is itself a delta, and so on.  And yet a 
base object might have many delta objects referring to it.  So without a 
smart delta resolution ordering and caching, we'd end up with an 
exponential number of pread calls.  However the cache size is limited to 
avoid memory exhaustion with deep and wide delta trees (that's the 
core.deltaBaseCacheLimit config variable).

So from that strace capture you sent me, we can get:

$ grep access strace.txt  | wc -l
3925

$ grep pread strace.txt  | wc -l
4095

$ grep pread strace.txt | sort | uniq -d | wc -l
75

So, given 3925 deltas to process, only 4095 objects were read, which is 
not too bad.  Still, 75 of them were read more than once, which means 
they were evicted from the cache while they were still needed.  The 
core.deltaBaseCacheLimit could be increased to avoid those 75 
duplicates.  Let's have a look at a few of them:

$ grep pread strace.txt | sort | uniq -cd | sort -nr
     20 pread(5, "x\234\354\275w\234\34\305\3210<;\263;\233\357nf\357v/I{\312\243\333=\235t\247p'"..., 1265653, 504922895) = 1265653
     20 pread(5, "x\234\254}\7|\24E\373\377\315\354f\357r\227v\227\344.\275A`\271\\\200\20:\204^\245\203"..., 264956, 506188555) = 264956
      6 pread(5, "x\234\274}\7xT\305\366\370\336\231\335\273\273\251\354f\263\233\36:\227d\3\201@ \224PB\257"..., 253102, 49016172335) = 253102
      6 pread(5, "x\234\274\275\7\224\34\305\3618<;\263;\263\341\322\356\336\355^\222N\361\30\335\355)\235\20w\2"..., 506683, 48982212429) = 506683
      6 pread(5, "x\234\254}\7x\34\305\25\360\336\336\335^Q\275;\351N\262d\313M\362\372tr\2231\226\1\27"..., 402609, 49245906707) = 402609
      6 pread(5, "x\234\254\275\t|\24\305\3628\2763\323;\273I6\t\331lvs\21B\270\206\315&\1\2H@"..., 176754, 49246749832) = 176754
      6 pread(5, "x\234\234}\7|T\305\366\377\336\331\315\246P\23H\205$t\226$t)\t\322\244\367\5\5\5\244"..., 236257, 49246513568) = 236257
      6 pread(5, "x\234\224}\7|TE\360\377\355\356\225t\270\224K\207$@r\244\2\241\205\320{\21\10 \35\351"..., 204238, 49246309323) = 204238
      5 pread(5, "x\234\264\275\7xT\305\0277\274\367\316\335\273%u7\311n*!\204rI6\t$\20\10\275\211"..., 233622, 49247108828) = 233622
      5 pread(5, "x\234\254\275\7|T\305\363\0~\357\275\275w\227\334%\341\222\334]zB \341\270\\\n\204\26:"..., 182228, 49246926593) = 182228
      5 pread(5, "x\234\234\274\5x\24\327\32\377\177\316\314fvf\26\22\226@\2\4\222l\4\"\33 \4\v\20\10"..., 70234, 49247342456) = 70234
      4 pread(5, "x\234m{\t\\TU\373\377\3343\\\34\206a\270s/\273\10\303* \340 \240\250\250\203\"\232"..., 9345, 49425395631) = 9345
      4 pread(5, "x\234-\326\177P\323e\34\300\3619`\342T\4\324)\23\1'\242\241\233c\300D:)~\232\250"..., 1211, 49248626398) = 1211
      4 pread(5, "x\234\314\275w\234\24E\363\7\274\323\263;\273\227o\367\356v\357\270\304\35\341\3662p\204;r\16"..., 149400, 49425246225) = 149400
      4 pread(5, "x\234\274\275\7|\34\305\3658\276\345n\257J\362\355Iw\262e[r_K'7al\31\343\2"..., 549072, 38602368468) = 549072

So... the first two objects are clearly a problem as they are re-loaded 
over and over. Given that their offset is far away from the others i.e. 
relatively at the beginning of the pack, they probably are quite high in 
their delta hierarchy.  And what's really bad is to see those at the 
beginning of 10 pread() calls in a row meaning that an entire delta 
string has to be replayed in order to get back all those base objects 
that were evicted from the cache.  That's clearly wasted CPU cycles and 
that shouldn't happen with a large enough value for 
core.deltaBaseCacheLimit.  Given that your files are "relatively" small 
i.e. in the 4MB range max, then the cache should be able to hold quite 
many of them.  At the moment with its 16MB limit, only a few of those 
objects would evict many objects from the cache quickly.

If this is still not good enough, then you could add a negative delta 
attribute to those large binary files (see 
http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html)
and repack the repository on the server.  Of course that will make the 
repository larger and the data transfer longer when cloning, but the 
"resolving deltas" will be much faster.  This is therefore a tradeoff.

Another solution which might be way more practical for users of such a 
huge repository is simply to use a shallow clone.  Surely those people 
cloning this repository might not need the full history of the 
repository.  So you could simply use:

	git clone --depth=10 ...

and have only the last 10 revisions transferred.  Later on the 
repository can be deepened by passing the --depth argument with a larger 
value to the fetch command if need be.


Nicolas
