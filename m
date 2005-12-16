From: Pavel Roskin <proski@gnu.org>
Subject: Re: qgit reports errors in the git repository
Date: Thu, 15 Dec 2005 19:35:49 -0500
Message-ID: <1134693349.22652.22.camel@dv>
References: <1134433440.3798.27.camel@dv>
	 <Pine.LNX.4.64.0512121700010.15597@g5.osdl.org>
	 <1134624477.5360.6.camel@dv>
	 <e5bfff550512150501v48bb65abwf44b3fc21f33bdf6@mail.gmail.com>
	 <1134665095.27212.22.camel@dv>
	 <e5bfff550512151100k33a66db5tdb2eb1ff2da10a59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-9rcZHwSS5lpWsL+Q8hFB"
Cc: Linus Torvalds <torvalds@osdl.org>, git <git@vger.kernel.org>,
	Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Fri Dec 16 01:37:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1En3Zr-00035i-E4
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 01:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVLPAf7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 19:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVLPAf7
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 19:35:59 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:35728 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751226AbVLPAf7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 19:35:59 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1En3YL-00026B-NZ
	for git@vger.kernel.org; Thu, 15 Dec 2005 19:34:30 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1En3Ze-0003KT-6W; Thu, 15 Dec 2005 19:35:50 -0500
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550512151100k33a66db5tdb2eb1ff2da10a59@mail.gmail.com>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13723>


--=-9rcZHwSS5lpWsL+Q8hFB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-12-15 at 20:00 +0100, Marco Costalba wrote:

>  Yes! this is a bug.
> Thanks  for the patch, applied.

Actually, the qgit git repository appear to be broken right now.  First
of all, requests to missing files return code 200 rather that 404.
git-http-fetch crashes trying to parse the returned page as alternates.
I've fixed it.

It's a hack, not a signed patch, please be cautious:

diff --git a/http-fetch.c b/http-fetch.c
index ad59f1c..2767676 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -520,6 +520,8 @@ static void process_alternates_response(
 				}
 			}
 			// skip 'objects' at end
+			okay &= (posn - i > 8);
+			okay &= (strncmp(data + posn - 8, "/objects", 8) == 0);
 			if (okay) {
 				target = xmalloc(serverlen + posn - i - 6);
 				strncpy(target, base, serverlen);
@@ -601,7 +603,7 @@ static void fetch_alternates(char *base)
 	else
 		got_alternates = -1;
 
-	free(data);
+//	free(data);
 	free(url);
 }
 

The free() was commented out because glibc detects double free and
prints backtrace.  It's Fedora Core 4 on x86_64, all up-to-date.  I
don't see where "data" is freed, maybe it's a bug in glibc.

Even clean fetch of qgit doesn't work:

$ cg-clone http://digilander.libero.it/mcostalba/qgit.git
defaulting to local storage area
Fetching head...
Fetching objects...
progress: 8 objects, 12858 bytes
error: File 8fef66ee82bcbbc26426d21e537478867f648e12 (http://digilander.libero.it/mcostalba/qgit.git/objects/fc/0712e55de18eda32aee44bd7863fee37fc83aa) corrupt

Getting pack list for http://digilander.libero.it/mcostalba/qgit.git/
progress: 11 objects, 76091 bytes
Getting alternates list for http://digilander.libero.it/mcostalba/qgit.git/
error: Unable to find fc0712e55de18eda32aee44bd7863fee37fc83aa under http://digilander.libero.it/mcostalba/qgit.git/

Cannot obtain needed commit fc0712e55de18eda32aee44bd7863fee37fc83aa
while processing commit 5013d718eea0b19a28faebf93eade68127f4b2b4.
Waiting for http://digilander.libero.it/mcostalba/qgit.git/objects/20/35781249a0d6c788e4aef07432c335d9694b9b
progress: 12 objects, 80655 bytes
cg-fetch: objects fetch failed
cg-clone: fetch failed

Anyway, I'm using the latest revision I could get,
9e5ccecbef2a9cb4b75887791b410c0e07d630cc.

> Unfortunatly, regarding the main question on git-cat-file I cannot
> reproduce the bug.

I've made a clean checkout of git using git-fetch:
git-clone git://www.kernel.org/pub/scm/git/git.git

Now qgit complains about 1ed91937e5cd59fdbdfa5f15f6fac132d2b21ce0.

> The problem is that on my box the object
> 23ea3e201cea0deea909569e08e950a9ec2345f7 is
> _never_ fed to git-cat-file because is filtered out ending with "^{}"
> git-ls-remote ./.git |grep 23ea3e201cea0deea909569e08e950a9ec2345f7
> 23ea3e201cea0deea909569e08e950a9ec2345f7        refs/tags/v0.99.9g^{}

Same for me.

> The corresponding tag feeded to git-cat-file is 
> bd67d7d845eb5ae929306dadd3dff41cf04ce004
> 
> I have just made a
> git pull
> git fetch --tags
> 
> from git repository.

OK, "git fetch --tags" made the difference for the old repository!  Now
it also complains about 1ed91937e5cd59fdbdfa5f15f6fac132d2b21ce0.

I was using cogito only on the old repository.  I think cogito doesn't
run "git fetch --tags" or anything equivalent.

> So, please, test with this:
> 
> --- a/src/git_startup.cpp
> +++ b/src/git_startup.cpp
> @@ -111,6 +111,7 @@ bool Git::getRefs() {
>  
>          if (itNext != rLst.constEnd() && (*itNext).right(3) == "^{}")
> {
>              signedTag = true;
> +            dbg(refSha);
>              if (run("git-cat-file tag " + refSha, &runOutput)) {
>                  QString msg(runOutput.section("\n\n", 1));
>                  if (!msg.isEmpty())
> 
> and send me the output. Mine is
[skip]

Both are attached.

-- 
Regards,
Pavel Roskin

--=-9rcZHwSS5lpWsL+Q8hFB
Content-Disposition: attachment; filename=log.new
Content-Type: text/plain; name=log.new; charset=us-ascii
Content-Transfer-Encoding: base64

cmVmU2hhIGlzIDxhMGU3ZDM2MTkzYjk2ZjU1MjA3MzU1OGFjZjVmY2MxZjEwNTI4OTE3Pg0KcmVm
U2hhIGlzIDxmMjVhMjY1YTM0MmFlZDYwNDFhYjBjYzQ4NDIyNGQ5Y2E1NGI2ZjQxPg0KcmVmU2hh
IGlzIDxjNWRiNTQ1NmFlM2IwODczZmM2NTljMTlmYWZkZGUyMjMxM2NjNDQxPg0KcmVmU2hhIGlz
IDw3Y2VjYTI3NWQwNDdjOTBjMGM3ZDVhZmIxM2FiOTdlZmRmNTFiZDZlPg0KcmVmU2hhIGlzIDxi
M2U5NzA0ZWNkZjQ4ODY5ZjYzNWYwYWE5OWRkZmI1MTNmODg1YWZmPg0KcmVmU2hhIGlzIDwwN2Uz
OGRiNmE1YTAzNjkwMDM0ZDI3MTA0NDAxZjZjOGVhNDBmMWZjPg0KcmVmU2hhIGlzIDxmMTJlMjJk
NGMxMmMzZDAyNjNmYTY4MWYyNWMwNjU2OWY2NDNkYTBmPg0KcmVmU2hhIGlzIDxmODY5NmZjZDJh
YmM0NDZhNWNjZGEzZTQxNGI3MzFlZmYyYTdlOTgxPg0KcmVmU2hhIGlzIDwxMDk0Y2Y0MGY3MDI5
ZjgwMzQyMWMxZGNjOTcxMjM4NTA3YzgzMGM1Pg0KcmVmU2hhIGlzIDxkYTMwYzZjMzljZDNiMDQ4
OTUyYTE1OTI5YzU0NDBhY2ZkNzFiOTEyPg0KcmVmU2hhIGlzIDw5MTY1ZWMxN2ZkZTI1NWExNzcw
ODg2MTg5MzU5ODk3ZGJiNTQxMDEyPg0KcmVmU2hhIGlzIDwwMmIyYWNmZjhiYWZiNmQ3M2M2NTEz
NDY5Y2RkYTBjNmMxOGM0MTM4Pg0KcmVmU2hhIGlzIDxiMDQxODk1YWYzMjNiZGVmMTBjYzlhNzE4
YmRhNDY4YmEzNjIyYmMwPg0KcmVmU2hhIGlzIDxjZmMyZWE2MTE2NDEwYTU0NTU3M2Q1ZmE1MzEx
ZDNjM2IyZGY2OWQxPg0KcmVmU2hhIGlzIDwwYjEyMjIwMWFmMGFmYjZhNmE4MDU5ZmY0NDZhMWUy
NmIxZDBjODIzPg0KcmVmU2hhIGlzIDxkMTg2ZjNkMjExNDhmMzczYTVlYTVlNDM4MDRmNWY2NzA3
NjcwYTg3Pg0KcmVmU2hhIGlzIDw0ODA1NWJiMzhkNjUwYWIzOTk1N2VkMDdkNjQwNDY5MTc2YzEy
NDE5Pg0KcmVmU2hhIGlzIDxiNzlhNWE0OWM5ZTQxMmUyN2EzMzZlNzA1ZmI3YjQ2MjM2N2Y0YzE2
Pg0KcmVmU2hhIGlzIDxlYmQ1ZDAwMmRhM2Y2Y2ZiZDBhYTNmZjViNWM0YTlkOWVlZWU2MzBkPg0K
cmVmU2hhIGlzIDwwOGY5ZjMyMDc2NDU1ZmY3NWI1OWI0MWQ3MDAzOTI3ODY5MDgyYTNmPg0KcmVm
U2hhIGlzIDw2N2I0Yjc4ODU4ZDlkOWRkMDQ0Zjc1OGE5MGE0MjcwZTQ4NTQzY2YxPg0KcmVmU2hh
IGlzIDxjNTEyYjAzNDQxOTY5MzFhZDNhOWEwNDllYjNmNWQzZjA1YjA5MzI4Pg0KcmVmU2hhIGlz
IDwzZDY1YTgzOGM3N2Y4MTY1MjdhY2Y4NGM4OTk0MTllYjY4MjVkY2VlPg0KcmVmU2hhIGlzIDwz
NTIxMDE3NTU2YzVkZTQxNTlkYTQ2MTVhMzlmYTRkNWQyYzI3OWI1Pg0KcmVmU2hhIGlzIDwxMDdl
M2QyYjRkNWI5ZWNkOWExNWEyM2FkMWM2NDY1MmI4YjY3YmE5Pg0KcmVmU2hhIGlzIDwxMGU1YWU2
OWViNmNkY2RkMTQ5YmIyM2UxZTczMTMxYWRmNGFiM2I3Pg0KcmVmU2hhIGlzIDxiNjg1YjE0Y2Q5
Mzg1ZThiMGY1NzQyZWJjZDM1ZWY4YzhjMTJlYzRkPg0KcmVmU2hhIGlzIDxiZDY3ZDdkODQ1ZWI1
YWU5MjkzMDZkYWRkM2RmZjQxY2YwNGNlMDA0Pg0KcmVmU2hhIGlzIDw1Yzg1NzYzOGQ1NWJkZDU3
NWQzZjM4YmYzYjk5ZjFhMmY5OWQzZTQ2Pg0KcmVmU2hhIGlzIDw0YTZhMzk0YzYyZjMzYTNiZjk0
YmFkZDZiMTRiYzFmNDg2NDc5MDVmPg0KcmVmU2hhIGlzIDxjMGY3ZDQ0ZWNiYTc1ZDU0YTczYmE1
NDJhZGRlMGZmODBkMmRhMDNhPg0KcmVmU2hhIGlzIDwwYzY3NWU5ZDBiNWY1ZDFmYmI3YjAxNjlk
NzE3Njk5OTNiMjI1NzAxPg0KcmVmU2hhIGlzIDxjYTZjZWM5YzU4NDNkODVkMjNiMTE4NGQ1ODRh
MTE2OTlkOTJlOTI3Pg0KcmVmU2hhIGlzIDw5M2VhNGE5NTk5NTY0MTAxYmUyMDUwN2EzYTc1NmQz
ODQyN2E3MGFjPg0KcmVmU2hhIGlzIDw3MWMxYTcwMGRhNjBkYThjZjk5ZDU4NmNjNjE4YzQ2ZmVm
MjAxZWQxPg0KcmVmU2hhIGlzIDwxZWQ5MTkzN2U1Y2Q1OWZkYmRmYTVmMTVmNmZhYzEzMmQyYjIx
Y2UwPg0KcmVmU2hhIGlzIDw1ZjRjZDRjYTAxNWRjNzk1YjlmN2Y0ZmVkMTFiM2Y4MGE2MGFjMTc1
Pg0KcmVmU2hhIGlzIDwxMTJjNGZkNmIzZmU0MDBhMDc1ZDU3NWMwZmUxYTU4M2FhZmU4ZjJjPg0K
cmVmU2hhIGlzIDxkY2QxMThmNmI5MzNkN2E4MTczOWMzYzQyNjllMmJmNDY1NGU0YTk5Pg0KcmVm
U2hhIGlzIDwwNTVlNGFlM2FlNmViMzQ0Y2JhYmYyYTUyNTZhNDllYTY2MDQwMTMxPg0KcmVmU2hh
IGlzIDwyZDI4NDZjZDA2ZmNlNzE5YzM1YjU4YThiODFmN2FlNDJmMTk4NmNhPg0KcmVmU2hhIGlz
IDw3ODFhYWIxN2ZlNTQ0Y2JmY2FiYTBmMGVhNWNhY2Y3NjcyNzE3MjM2Pg0K


--=-9rcZHwSS5lpWsL+Q8hFB
Content-Disposition: attachment; filename=log.old
Content-Type: application/x-trash; name=log.old
Content-Transfer-Encoding: base64

cmVmU2hhIGlzIDwwOTE4Mzg1ZGJkOTY1NmNhYjBkMWQ4MWJhNzQ1M2Q0OWJiYzE2MjUwPgpyZWZT
aGEgaXMgPGYyNWEyNjVhMzQyYWVkNjA0MWFiMGNjNDg0MjI0ZDljYTU0YjZmNDE+CnJlZlNoYSBp
cyA8YzVkYjU0NTZhZTNiMDg3M2ZjNjU5YzE5ZmFmZGRlMjIzMTNjYzQ0MT4KcmVmU2hhIGlzIDw3
Y2VjYTI3NWQwNDdjOTBjMGM3ZDVhZmIxM2FiOTdlZmRmNTFiZDZlPgpyZWZTaGEgaXMgPGIzZTk3
MDRlY2RmNDg4NjlmNjM1ZjBhYTk5ZGRmYjUxM2Y4ODVhZmY+CnJlZlNoYSBpcyA8MDdlMzhkYjZh
NWEwMzY5MDAzNGQyNzEwNDQwMWY2YzhlYTQwZjFmYz4KcmVmU2hhIGlzIDxmMTJlMjJkNGMxMmMz
ZDAyNjNmYTY4MWYyNWMwNjU2OWY2NDNkYTBmPgpyZWZTaGEgaXMgPGY4Njk2ZmNkMmFiYzQ0NmE1
Y2NkYTNlNDE0YjczMWVmZjJhN2U5ODE+CnJlZlNoYSBpcyA8MTA5NGNmNDBmNzAyOWY4MDM0MjFj
MWRjYzk3MTIzODUwN2M4MzBjNT4KcmVmU2hhIGlzIDxkYTMwYzZjMzljZDNiMDQ4OTUyYTE1OTI5
YzU0NDBhY2ZkNzFiOTEyPgpyZWZTaGEgaXMgPDkxNjVlYzE3ZmRlMjU1YTE3NzA4ODYxODkzNTk4
OTdkYmI1NDEwMTI+CnJlZlNoYSBpcyA8MDJiMmFjZmY4YmFmYjZkNzNjNjUxMzQ2OWNkZGEwYzZj
MThjNDEzOD4KcmVmU2hhIGlzIDxiMDQxODk1YWYzMjNiZGVmMTBjYzlhNzE4YmRhNDY4YmEzNjIy
YmMwPgpyZWZTaGEgaXMgPGNmYzJlYTYxMTY0MTBhNTQ1NTczZDVmYTUzMTFkM2MzYjJkZjY5ZDE+
CnJlZlNoYSBpcyA8MGIxMjIyMDFhZjBhZmI2YTZhODA1OWZmNDQ2YTFlMjZiMWQwYzgyMz4KcmVm
U2hhIGlzIDxkMTg2ZjNkMjExNDhmMzczYTVlYTVlNDM4MDRmNWY2NzA3NjcwYTg3PgpyZWZTaGEg
aXMgPDQ4MDU1YmIzOGQ2NTBhYjM5OTU3ZWQwN2Q2NDA0NjkxNzZjMTI0MTk+CnJlZlNoYSBpcyA8
Yjc5YTVhNDljOWU0MTJlMjdhMzM2ZTcwNWZiN2I0NjIzNjdmNGMxNj4KcmVmU2hhIGlzIDxlYmQ1
ZDAwMmRhM2Y2Y2ZiZDBhYTNmZjViNWM0YTlkOWVlZWU2MzBkPgpyZWZTaGEgaXMgPDA4ZjlmMzIw
NzY0NTVmZjc1YjU5YjQxZDcwMDM5Mjc4NjkwODJhM2Y+CnJlZlNoYSBpcyA8NjdiNGI3ODg1OGQ5
ZDlkZDA0NGY3NThhOTBhNDI3MGU0ODU0M2NmMT4KcmVmU2hhIGlzIDxjNTEyYjAzNDQxOTY5MzFh
ZDNhOWEwNDllYjNmNWQzZjA1YjA5MzI4PgpyZWZTaGEgaXMgPDNkNjVhODM4Yzc3ZjgxNjUyN2Fj
Zjg0Yzg5OTQxOWViNjgyNWRjZWU+CnJlZlNoYSBpcyA8MzUyMTAxNzU1NmM1ZGU0MTU5ZGE0NjE1
YTM5ZmE0ZDVkMmMyNzliNT4KcmVmU2hhIGlzIDwxMDdlM2QyYjRkNWI5ZWNkOWExNWEyM2FkMWM2
NDY1MmI4YjY3YmE5PgpyZWZTaGEgaXMgPDEwZTVhZTY5ZWI2Y2RjZGQxNDliYjIzZTFlNzMxMzFh
ZGY0YWIzYjc+CnJlZlNoYSBpcyA8YjY4NWIxNGNkOTM4NWU4YjBmNTc0MmViY2QzNWVmOGM4YzEy
ZWM0ZD4KcmVmU2hhIGlzIDxiZDY3ZDdkODQ1ZWI1YWU5MjkzMDZkYWRkM2RmZjQxY2YwNGNlMDA0
PgpyZWZTaGEgaXMgPDIzZWEzZTIwMWNlYTBkZWVhOTA5NTY5ZTA4ZTk1MGE5ZWMyMzQ1Zjc+CnJl
ZlNoYSBpcyA8ZDY2MDJlYzUxOTRjODdiMGZjODcxMDNjYTRkNjcyNTFjNzZmMjMzYT4K


--=-9rcZHwSS5lpWsL+Q8hFB--
