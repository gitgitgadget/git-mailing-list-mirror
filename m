From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Creates unreadable pack files on platforms with sizeof(unsigned long)
 != sizeof(uintmax_t)
Date: Sun, 20 Mar 2016 22:20:02 +0100
Message-ID: <56EF1402.4050708@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git-for-windows@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 20 22:41:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahl6R-0000iM-Oo
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 22:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbcCTVju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 17:39:50 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:39465 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750760AbcCTVjt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Mar 2016 17:39:49 -0400
X-Greylist: delayed 1183 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Mar 2016 17:39:48 EDT
Received: from p3e9bcb68.dip0.t-ipconnect.de ([62.155.203.104] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1ahklX-0005Kf-Ir; Sun, 20 Mar 2016 22:20:03 +0100
X-Priority: Normal
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1458509989;896bdcd3;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289386>

Hi,

while playing around with some git settings I encountered some problems on Windows x64
using the 64bit build of git.
And it is not restricted to that platform.

Recipe to break:
mkdir test &&
cd test &&
truncate -s 5g largefile.bin &&
git init &&
git add . &&
git commit -m "changes" &&
git fsck

Result:
Initialized empty Git repository in E:/ttest/.git/
[master (root-commit) d19adaf] changes
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 largefile.bin
Checking object directories: 100% (256/256), done.
error: bad object header
error: unknown object type -1 at offset 12 in
.git/objects/pack/pack-25250ce5c176078ba51a42fee177c2f03f8845ca.pack
error: cannot unpack 0be2be10a4c8764f32c4bf372a98edc731a4b204 from
.git/objects/pack/pack-25250ce5c176078ba51a42fee177c2f03f8845ca.pack at offset
12
Checking objects: 100% (1/1), done.

So I've created a repository which I can now not use.

The die() call is from unpack_object_header_buffer() in sha1_file.c. On windows x64
bitsizeof(long) returns 32 and equals shift at some point.
unpack_object_header_buffer() returns the size in an unsigned long (32bit). [1, 2, 3]

The questions why this has not been detected on creating the pack leads to
encode_in_pack_object_header()
which uses uintmax_t (64 bit wide) for storing the size.

unsigned long is used in more places for file sizes e.g. in struct object_entry
in pack-objects.h.

The proper solution now would be, I guess, to convert file sizes from unsigned long to something
which is wider on windows x64 and in the best case the same size on linux. My git code base foo is rather
low and it looks much more involved than a simple s//.

A first intermediate solution could be to die on pack creation e.g. in 

diff --git a/pack-write.c b/pack-write.c
index 33293ce..ebb8b0a 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -313,6 +313,9 @@ int encode_in_pack_object_header(enum object_type type, uintmax_t size, unsigned
        if (type < OBJ_COMMIT || type > OBJ_REF_DELTA)
                die("bad type %d", type);

+       if (bitsizeof(unsigned long) != bitsizeof(uintmax_t) && size > (unsigned long) size)
+               die("Cannot handle files this big");
+
        c = (type << 4) | (size & 15);
        size >>= 4;
        while (size) {

With that patch I get

$ ../git add .
fatal: Cannot handle files this big

I know that usually people don't add big binary files to git. But I do, so I care ;)
If this direction sounds reasonable I can provide a proper patch.

Thanks,
Thomas

[1]: https://msdn.microsoft.com/en-us/library/323b6b3k.aspx
[2]: https://msdn.microsoft.com/en-us/library/s3f49ktz.aspx
[3]: http://stackoverflow.com/questions/7607502/sizeoflong-in-64-bit-c
