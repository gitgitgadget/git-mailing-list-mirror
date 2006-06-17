From: Pavel Roskin <proski@gnu.org>
Subject: Re: parsecvs and unnamed branches
Date: Sat, 17 Jun 2006 00:08:56 -0400
Message-ID: <1150517336.9144.8.camel@dv>
References: <9e4733910606161444i2f996096sbd1f9b3f3ff3a32d@mail.gmail.com>
	 <1150496362.6983.34.camel@neko.keithp.com>
	 <9e4733910606162002x508ec6ccjbc36e4220ca44fd6@mail.gmail.com>
	 <1150513943.29738.15.camel@dv>
	 <9e4733910606162031o69df27fdje50c88949ed990b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Keith Packard <keithp@keithp.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 17 06:09:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrS7O-0003bU-Ou
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 06:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWFQEJB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 00:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbWFQEJB
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 00:09:01 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:16355 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751226AbWFQEJA
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 00:09:00 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FrS7H-0004Br-TU
	for git@vger.kernel.org; Sat, 17 Jun 2006 00:08:59 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FrS7E-0002w3-RA; Sat, 17 Jun 2006 00:08:56 -0400
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606162031o69df27fdje50c88949ed990b5@mail.gmail.com>
X-Mailer: Evolution 2.7.2.1 (2.7.2.1-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21997>

On Fri, 2006-06-16 at 23:31 -0400, Jon Smirl wrote:

> Parsecvs was compiled '-O2 -g' why didn't it decode the addresses to symbols?

Sorry, I was too quick to put blame on you.  Maybe glibc can only list
its own symbols.

I could reproduce the problem trivially with a single file, and here's
what Valgrind says:

==11154== Invalid free() / delete / delete[]
==11154==    at 0x4905423: free (vg_replace_malloc.c:233)
==11154==    by 0x40C136: git_pack_directory (git.c:620)
==11154==    by 0x40C1B4: git_rev_list_pack (git.c:639)
==11154==    by 0x4067DA: main (parsecvs.c:785)


git_pack_directory() tries to free() the result of
git_system_to_string(), which is in turn a result of atom().  My
understanding is that atoms should not be freed.  They are not freed in
other cases.

Patch:

diff --git a/README b/README
diff --git a/git.c b/git.c
index 33b29c7..7312568 100644
--- a/git.c
+++ b/git.c
@@ -617,7 +617,6 @@ git_pack_directory (void)
 	}
 	free (objects_dir);
 	pack_dir = git_format_command ("%s/objects/pack", git_dir);
-        free (git_dir);
 	if (!pack_dir)
 	    return NULL;
 	if (access (pack_dir, F_OK) == -1 &&

-- 
Regards,
Pavel Roskin
