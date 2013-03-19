From: Jeff King <peff@peff.net>
Subject: Re: Memory corruption when rebasing with git version 1.8.1.5 on arch
Date: Tue, 19 Mar 2013 09:44:52 -0400
Message-ID: <20130319134452.GA6752@sigill.intra.peff.net>
References: <5139D76D.80703@bernhard-posselt.com>
 <20130308212831.GA9217@sigill.intra.peff.net>
 <513A7D80.5000501@bernhard-posselt.com>
 <20130309044850.GB12167@sigill.intra.peff.net>
 <513B14EC.4040504@bernhard-posselt.com>
 <20130310070505.GA15324@sigill.intra.peff.net>
 <513C7267.2090608@bernhard-posselt.com>
 <20130311051840.GB13510@sigill.intra.peff.net>
 <51484125.9000307@bernhard-posselt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bernhard Posselt <mail@bernhard-posselt.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 14:45:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHwrC-0001WX-NQ
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 14:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469Ab3CSNpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 09:45:05 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58358 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754122Ab3CSNo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 09:44:59 -0400
Received: (qmail 29369 invoked by uid 107); 19 Mar 2013 13:46:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Mar 2013 09:46:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Mar 2013 09:44:52 -0400
Content-Disposition: inline
In-Reply-To: <51484125.9000307@bernhard-posselt.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218513>

On Tue, Mar 19, 2013 at 11:42:45AM +0100, Bernhard Posselt wrote:

> it seems that the memory corruption does not happen anymore when i change
> 
> [apply]
>         whitespace = fix
> 
> to
> 
> [apply]
>         #whitespace = fix
> 
> so fixing whitespaces may be the culprit

Thanks, I'm able to reproduce with the config you showed. The other key
element seems to be using tab-in-indent.  I am not too familiar with
this code, but I was able to get a much smaller reproduction recipe:

-- >8 --
# make tabs more obvious by using "Q" instead
q_to_tab() {
  perl -lpe 's/Q/\t/g'
}

q_to_tab >preimage <<\EOF
QQa
QQb
QQc
                d
QQe
QQf
QQg
EOF

q_to_tab >patch <<\EOF
diff --git a/preimage b/preimage
--- a/preimage
+++ b/preimage
@@ -1,7 +1,6 @@ public static function store($filename) {
 QQa
 QQb
 QQc
-QQd
 QQe
 QQf
 QQg
EOF

valgrind \
git -c core.whitespace=tab-in-indent apply --whitespace=fix patch
-- 8< --

which yields:

==7112== Invalid write of size 2
==7112==    at 0x4C2C023: memcpy (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==7112==    by 0x40C365: update_pre_post_images (apply.c:2165)
==7112==    by 0x40CC52: match_fragment (apply.c:2402)
[...]
==7112==  Address 0x6e57a5e is 0 bytes after a block of size 94 alloc'd
==7112==    at 0x4C2A26B: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==7112==    by 0x4C2A51F: realloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==7112==    by 0x535193: xrealloc (wrapper.c:100)
==7112==    by 0x51C322: strbuf_grow (strbuf.c:74)
==7112==    by 0x51C10C: strbuf_init (strbuf.c:34)
==7112==    by 0x40D329: apply_one_fragment (apply.c:2602)
[...]

and so on. I haven't quite figured out what is going on. It looks like
we call update_pre_post_images with postlen==0, which causes it to just
write the fixed postimage into the existing buffer. But of course the
fixed version is bigger, because we are expanding the tabs into 8
spaces (but it _doesn't_ break if each line starts with only one tab,
which confuses me).

I'm not too familiar with this code. Maybe Junio can say more.

-Peff
