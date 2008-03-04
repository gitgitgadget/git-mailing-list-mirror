From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Add test for cloning with "--reference" repo being a
 subset of source repo
Date: Tue, 04 Mar 2008 04:02:57 +0100
Message-ID: <200803040402.57993.johan@herland.net>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org>
 <200803031004.16568.johan@herland.net>
 <alpine.LNX.1.00.0803031318000.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristian =?iso-8859-1?q?H=F8gsberg?= <krh@redhat.com>,
	Santi =?iso-8859-1?q?B=E9jar?= <sbejar@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 04:04:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWNRj-0004T7-GJ
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 04:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbYCDDDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 22:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbYCDDDX
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 22:03:23 -0500
Received: from smtp.getmail.no ([84.208.20.33]:40473 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372AbYCDDDX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 22:03:23 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JX600L0DR5B8C00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 04 Mar 2008 04:03:11 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JX6008ARR4YLQ40@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 04 Mar 2008 04:02:58 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JX600FW6R4YMR90@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 04 Mar 2008 04:02:58 +0100 (CET)
In-reply-to: <alpine.LNX.1.00.0803031318000.19665@iabervon.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76019>

On Monday 03 March 2008, Daniel Barkalow wrote:
> On Mon, 3 Mar 2008, Johan Herland wrote:
> 
> > Not sure what's going on here, yet, but I thought I'd give you a heads up.
> 
> I figured it out, and pushed out a fix; it was doing everything correctly, 
> but it wrote to the alternates files after the library had read that file, 
> so it then didn't notice that it actually had the objects that are in the 
> second alternate repository.

Thanks. After looking a bit more at the original test repo where I found
this issue, I discovered another, similar bug. This one seems ugly; brace
yourself:

In some cases (I'm not exactly sure of all the preconditions) when
cloning with "--reference", it seems git tries to access a loose object
in the "--reference" repo instead of in the cloned repo, even if that
object is already present in the cloned repo and _missing_ in the
"--reference" repo. The symptom is this error message:
    error: Trying to write ref $ref with nonexistant object $sha1

After playing around with this in gdb, it seems the problem is all the
way down in sha1_file_name() (sha1_file.c). This function is responsible
for generating the loose object filename for a given $sha1. It keeps a
static char *base which is initially set to the object directory name,
and then calls fill_sha1_path() to copy the rest of the object filename
into the following bytes. On subsequent calls, only the fill_sha1_path()
part is done, thereby reusing the base from the previous invocation.

What I observe is that this base is not reset after accessing loose
objects in the "--reference" repo. Thus, later when accessing objects in
the cloned repo, sha1_file_name() generates incorrect filenames (pointing
to the "--reference" repo instead of the cloned repo).

Of course, this often goes undetected since the "--reference" repo often
have the same loose objects as the clone.

Unfortunately (from a builtin git-clone's POV) this seems to be
symptomatic of a deeper problem in this part of the code: Using
function-static variables as caches only works as far as the cache
is in sync with reality. Especially when switching between multiple
repositories within the same process, it seems that several of these
variables are left with invalid data in them. This needs to be fixed,
if not only for now, then at least as part of the libification effort.

I'm not sure what is the best way of fixing this issue; my initial guess
is to move these function-static variables out to file-level, and make
sure they're properly reset whenever the appropriate context is changed
(typically when set_git_dir() is called, I guess).

Here are the function-static variables I immediately found in sha1_file.c
(there may be more, both in sha1_file.c and in other files):
- sha1_file_name(): static char *base
- sha1_pack_name(): static char *base
- sha1_pack_index_name(): static char *base
- find_pack_entry(): static struct packed_git *last_found
  (not sure about this one)

I will follow up this email with two patches, one adding the failing test,
and one providing a simple fix for that specific test (although very much
insufficient as a fix for the actual issue described above).


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
