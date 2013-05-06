From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: trouble on windows network share
Date: Mon, 6 May 2013 12:08:18 +0200
Message-ID: <878v3sh14d.fsf@linux-k42r.v.cablecom.net>
References: <871B6C10EBEFE342A772D1159D1320853F63D205@umechphj.easf.csd.disa.mil>
	<1367529968647-7584800.post@n2.nabble.com>
	<87ppx8o1lj.fsf@linux-k42r.v.cablecom.net>
	<8B6563E531152E4190313499F193F94214A9C966@mbx500-u1-lo-3.exch500.msoutlookonline.net>
	<87ip2wla12.fsf@linux-k42r.v.cablecom.net>
	<8B6563E531152E4190313499F193F94214AAAB42@mbx500-u1-lo-3.exch500.msoutlookonline.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Goldfarb <deg@degel.com>
X-From: git-owner@vger.kernel.org Mon May 06 12:08:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZILK-0008Na-At
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 12:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456Ab3EFKIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 06:08:22 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:50443 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753330Ab3EFKIV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 06:08:21 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 6 May
 2013 12:08:18 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 6 May 2013 12:08:19 +0200
In-Reply-To: <8B6563E531152E4190313499F193F94214AAAB42@mbx500-u1-lo-3.exch500.msoutlookonline.net>
	(David Goldfarb's message of "Mon, 6 May 2013 09:53:51 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223436>

David Goldfarb <deg@degel.com> writes:

> Looks like it works.
>
> From the windows machine:
>     U:\foo>git cat-file -p 0b89efdeef245ed6a0a7eacc5c578629a141f856
>     100644 blob b02e7c87fe376a353ea4f014bdb3f5200a946b37    foo1
>     100644 blob 2cbf64f759a62392ad9dfe1fb9c2cdb175876014    foo2
>
>     U:\foo>
>
>
> Double-checking that nothing was fixed or changed when I earlier committed the file from Linux, here's a second test:
>
>
>     U:\foo>git cat-file -p 0b89efdeef245ed6a0a7eacc5c578629a141f856
>     100644 blob b02e7c87fe376a353ea4f014bdb3f5200a946b37    foo1
>     100644 blob 2cbf64f759a62392ad9dfe1fb9c2cdb175876014    foo2
>     
>     U:\foo>git status
>     # On branch master
>     # Untracked files:
>     #   (use "git add <file>..." to include in what will be committed)
>     #
>     #       trace1
>     #       trace2
>     nothing added to commit but untracked files present (use "git add" to track)
>     
>     U:\foo>git add trace1
>     
>     U:\foo>git commit trace1 -m "testing"

Note that specifying 'trace1' here is redundant, since you already added
it and had no other staged changes.  Perhaps you can re-run a test like
this without the extra argument for comparison.  That would tell us if
it matters that the write and read happen in the same process.

>     error: unable to find cecae5b4c87ea21aef513fcfcd5c27fe87e0536f
>     fatal: cecae5b4c87ea21aef513fcfcd5c27fe87e0536f is not a valid object
>     
>     U:\foo>git cat-file -p cecae5b4c87ea21aef513fcfcd5c27fe87e0536f
>     100644 blob b02e7c87fe376a353ea4f014bdb3f5200a946b37    foo1
>     100644 blob 2cbf64f759a62392ad9dfe1fb9c2cdb175876014    foo2
>     100644 blob 19102815663d23f8b75a47e7a01965dcdc96468c    test.txt
>     100644 blob c9009b02950964cf1d5281125e6e2f647dd9dc16    trace1

I'm inclined to just say that your FS is crazy.

What's unsatisfactory is that we already have a bunch of crazy FS
workarounds in move_temp_to_file(), which is one obvious candidate for
what is going on here.  So this wouldn't be something new; just another
craziness to work around.

For example, you could test the theory that rename() has something to do
with it by patching this into move_temp_to_file():

diff --git i/sha1_file.c w/sha1_file.c
index 67e815b..22af015 100644
--- i/sha1_file.c
+++ w/sha1_file.c
@@ -2635,6 +2635,10 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 		/* FIXME!!! Collision check here ? */
 	}
 
+	if (access(filename, R_OK) < 0)
+		return error("access(%s, R_OK) failed immediately after rename(): %s",
+			     filename, strerror(errno));
+
 out:
 	if (adjust_shared_perm(filename))
 		return error("unable to set permission to '%s'", filename);


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
