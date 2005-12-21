From: Junio C Hamano <junkio@cox.net>
Subject: Re: Am I doing something wrong?
Date: Wed, 21 Dec 2005 11:58:30 -0800
Message-ID: <7vvexi8bo9.fsf@assigned-by-dhcp.cox.net>
References: <86k6dyxuke.fsf@blue.stonehenge.com>
	<7v3bkmcp83.fsf@assigned-by-dhcp.cox.net>
	<864q52xrm6.fsf@blue.stonehenge.com>
	<7vmziub9yw.fsf@assigned-by-dhcp.cox.net>
	<86zmmuwbzh.fsf@blue.stonehenge.com>
	<7vhd92b90w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Peter Baumann <peter.baumann@gmail.com>,
	merlyn@stonehenge.com (Randal L. Schwartz),
	Luben Tuikov <ltuikov@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Dec 21 20:59:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpA6d-0008Ow-Ko
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 20:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbVLUT6c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 14:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbVLUT6c
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 14:58:32 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:46756 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964799AbVLUT6c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 14:58:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221195701.TKFA17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 14:57:01 -0500
To: git@vger.kernel.org
In-Reply-To: <7vhd92b90w.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 21 Dec 2005 10:27:27 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13894>

It turns out to be a stupid off-by-one error in http-fetch.c.
The objects/info/packs file has the following:

        $ cat objects/info/packs
        P pack-46ff81b11ed16ed38caa4aada913cb08c00185b2.pack
        P pack-05f611b3b8198b262acdf678584d365f8e879aec.pack
        P pack-740c99c0be6734adbd130737dec2608dc4682761.pack
        $

The code that parses this in http-fetch had an off-by-one, and
incorrectly thought that the last entry was incomplete.  This
problem did not surface earlier, because objects/info/packs file
used to have other information after all the P lines, but
http-fetch was not interested in was skipping them.  The latest
update-server-info stopped producing those extra lines.

As a band-aid, I just ran this command at the server that public
ones mirror from:

	$ echo >>objects/info/packs

The change seems to have mirrored out already, and my "broken"
client before the attached patch successfully fetches from
there, so hopefully things would work OK for you as well.

I also have to add some code to server-info.c, to append an
empty after objects/info/packs file to work around this bug in
the deployed http clients.

Thanks for your help in diagnosing and fixing this problem.

-- >8 --
[PATCH] http-fetch.c: fix objects/info/pack parsing.

It failed to register the last pack mentioned in the
objects/info/packs file.  Also it had an independent overrun
error.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
git diff
diff --git a/http-fetch.c b/http-fetch.c
index ad59f1c..3cd6ef9 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -658,7 +658,7 @@ static int fetch_indices(struct alt_base
 		switch (data[i]) {
 		case 'P':
 			i++;
-			if (i + 52 < buffer.posn &&
+			if (i + 52 <= buffer.posn &&
 			    !strncmp(data + i, " pack-", 6) &&
 			    !strncmp(data + i + 46, ".pack\n", 6)) {
 				get_sha1_hex(data + i + 6, sha1);
@@ -667,7 +667,7 @@ static int fetch_indices(struct alt_base
 				break;
 			}
 		default:
-			while (data[i] != '\n')
+			while (i < buffer.posn && data[i] != '\n')
 				i++;
 		}
 		i++;

Compilation finished at Wed Dec 21 11:40:06
