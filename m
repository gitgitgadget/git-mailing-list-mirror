From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 6/6 (v4)] support for path name caching in rev-cache
Date: Mon, 17 Aug 2009 23:24:09 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908172235360.6044@xanadu.home>
References: <op.uys3qwlmtdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 05:24:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdFJK-0003Gm-9w
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 05:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbZHRDYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 23:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbZHRDYU
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 23:24:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12613 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbZHRDYT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 23:24:19 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOJ00IAKY9L83F0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 17 Aug 2009 23:12:58 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <op.uys3qwlmtdk399@sirnot.private>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126342>

On Mon, 17 Aug 2009, Nick Edelen wrote:

> An update to caching mechanism, allowing path names to be cached for blob and 
> tree objects.  A list of names appearing in each cache slice is appended to the 
> end of the slice, which is referenced by variable-sized indexes per entry.  
> This allows pack-objects to more intelligently schedule unpacked/poorly packed 
> object, and enables proper duplication of rev-list's behaivor.
> 
> Signed-off-by: Nick Edelen <sirnot@gmail.com>

[...]

Well, OK.  Let's try it out for myself.

I'm applying the whole series on top of current "next" as of now.

Applying the first patch, git-am tells me: 

|warning: 70 lines add whitespace errors.

You might want to fix those.

Then build+install.  Things still work fine so far.  I'm using git's own 
git repository.  So let's get real:

|$ git rev-cache add --all
|fatal: Unable to create temporary file: Permission denied

Hmmm... why? Not good for a start.  Using strace:

|$ strace git rev-cache add --all
[...]
|stat(".git/rev-cache", {st_mode=S_IFDIR|0664, st_size=4096, ...}) = 0 
|open(".git/rev-cache/MGhgcp", O_RDWR|O_CREAT|O_EXCL, 0600) = -1 EACCES (Permission denied)
|write(2, "fatal: Unable to create temporary"..., 58) = 58 
|exit_group(128)                         = ?

OK, so attempting .git/rev-cache/MGhgcp fails with EACCES.  Let's see:

|$ ls -ld .git/rev-cache/
|drw-rw-r-- 2 nico nico 4096 2009-08-17 22:47 .git/rev-cache/

There is no directory execute permission at all.  Indeed, looking at 
rev-cache.c line 2314, the mode passed to mkdir() is 0x666.  This should 
rather be 0777.  Which brings the question: how could this ever work for 
you?  Are you testing your code as root?

|$ chmod +x .git/rev-cache
|$ git]$ git rev-cache add --all
|objects: 115733
|paths: 1535
|62e497619dbb2f8b783c89084054864965bb00d8
|endpoints:
|S 1cae2b588249e8b45239faebc658c7fa45948932
|S 4aec0d2391eb569776e332d9c15b354cd50a64c5
|S 1ff19ffed62bb581cd8eb635fe6e65ffca7ba1d0
|S fcd8ea7a91ad55d094a78c826083ebac149d81e5
|S 181301656f7a1086adcc41c3661551f190635003
|S 2898400a882bfb3c475fc2b53330912edc8a81f8
|S 7c7f2ebdb98f4844347f68b6e64c4968fa7f38e5
|S 1d9d1698ceb7b553f3cb1fdaa3150f0e85ab9cca
|S 348f73cc1db2d7b1412c40eba72319855e2959ff
|S fedc7d5458bd8e2e9589567041228a24a8d7eb4c
|S 0f57bf3ae8f0000de83907f0a674d70a879f7753
|S 7354ca323e31aa2d469498d06feebdcea137e93a
|S d47e28a143f40ad31b88e6d7b9b18bae60d21b01
|S 991ab5ed8769cd1a425b96b92772c89244bc957c
|S 07827905813bce9cadb9db2faac5848a61c7e69f
|S aff6ae5e2f10c4a8e399bf5aa446a58d74444aba
|S 6849908a55d0e7a95fa715310f739cfab4dd8def
|S ac34f56d4cf6a737f7d8cb56a9b57448f8d6e190
|S 740f1f8651561ee3f31d11cde492eedc77272ff1
|S 38b9118536279dd923e7d5c7444f5869b7f709b1
|S 13354f5377d82baee4d8c930df824c8dbeda396d
|S d82c2e2835dd1aca1a0b6b1fc9f6213ad0e0ae9c
|final return value: 0

Good, making progress.  By the way, is that output useful?  If so, is it 
documented somewhere?  Surely the "final return value" is probably not 
that useful...

Now I want to see how fast rev-list has become.

|$ git rev-list --all --objects > /dev/null
|Segmentation fault

BOOM!  :-(  And now half of the git commands are just as helpful with 
segmentation faults, including 'git log'.

Here's a backtrace from gdb:

|(gdb) bt
|#0  0x0000000000493c33 in to_disked_rc_object_entry (src=0x72d6e0,
|    dst=0x7ffff548c034) at rev-cache.c:121
|#1  0x00000000004957f0 in setup_traversal () at rev-cache.c:412
|#2  traverse_cache_slice_1 () at rev-cache.c:487
|#3  traverse_cache_slice (revs=0x7fffffffe010,
|    cache_sha1=0x7739b0 "b\227a\235/\213x<\211\b@T\206Ie",
|    commit=<value optimized out>, date_so_far=0x0, slop_so_far=0x0,
|    queue=0x7fffffffdef8, work=0x7fffffffe010) at rev-cache.c:884
|#4  0x000000000049a4e7 in get_revision_1 (revs=0x7fffffffe010)
|    at revision.c:1763
|#5  0x000000000049a55b in get_revision_internal (revs=0x7fffffffe010)
|    at revision.c:1886
|#6  0x000000000049a7c1 in get_revision (revs=0x7fffffffe010) at revision.c:1967
|#7  0x00000000004790a7 in traverse_commit_list (revs=0x7fffffffe010,
|    show_commit=0x4477d0 <show_commit>, show_object=0x447ba0 <show_object>,
|    data=0x7fffffffe3f0) at list-objects.c:164
|#8  0x000000000044808c in cmd_rev_list (argc=1, argv=0x7fffffffe680,
|    prefix=0x0) at builtin-rev-list.c:398
|#9  0x0000000000403d13 in run_builtin () at git.c:246
|#10 handle_internal_command (argc=3, argv=0x7fffffffe680) at git.c:391
|#11 0x0000000000403ebd in run_argv () at git.c:433
|#12 main (argc=3, argv=0x7fffffffe680) at git.c:504


Nicolas
