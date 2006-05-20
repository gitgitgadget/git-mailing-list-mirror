From: Yann Dirson <ydirson@altern.org>
Subject: [BUG] "stg pull" on qgit tree shows problems, including git-http-fetch segfault
Date: Sat, 20 May 2006 14:58:04 +0200
Message-ID: <20060520125804.GG6535@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat May 20 14:46:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhQqX-0000Kr-BW
	for gcvg-git@gmane.org; Sat, 20 May 2006 14:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWETMqP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 08:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWETMqO
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 08:46:14 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:19868 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S964826AbWETMqO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 08:46:14 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id BF18B4F1E1
	for <git@vger.kernel.org>; Sat, 20 May 2006 14:46:12 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FhR1w-000546-NT
	for git@vger.kernel.org; Sat, 20 May 2006 14:58:04 +0200
To: GIT list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20377>

With "master" branch pointing to tags/qgit-1.2~17 and "origin" to
0a327c900530d9dd293cd252894a24913d4172c3, with no patch applied on
"master" stack, using stgit 0.9 and git 1.3.2:

$ stg pull
Pulling from "origin"...
Fetching refs/heads/master from http://digilander.libero.it/mcostalba/scm/qgit.git using http
got 5d0d2f1703976e04c6db1e55ea6a044981b9ed20
walk 5d0d2f1703976e04c6db1e55ea6a044981b9ed20
[...]
got 1f151284442358eee6da80394585491295c94380
error: File 24bd6f23c6d0161f7e775a0e6ab767725b6344ab (http://digilander.libero.it/mcostalba/scm/qgit.git/objects/f7/dc43059ca42dec2ea7214a33d1ff3c35e0aca5) corrupt
Getting pack list for http://digilander.libero.it/mcostalba/scm/qgit.git/
got 63dc5a19ec0ac37fec09e4023cd51a62eb3efa15
[...]
got 53563b4b6b32ba7ea184a4eeb555db76e276c8a6
error: XML error: syntax error
got 73c20d6d667ff3860718d5e1382e686531360082
[...]
got 0219d8723f9a4fa562d99eb0840741112a13466d
error: The requested URL returned error: 405
Getting alternates list for http://digilander.libero.it/mcostalba/scm/qgit.git/
got 33e3b252eb5dbe84116a858136b9b35fe43bf768
Also look at <meta http-equiv="Refresh" content="5;URL=http://digiland.libe
Also look at <BASE HREF="http://digiland.liber
/usr/bin/git-fetch: line 268:  3725 Segmentation fault      git-http-fetch -v -a "$head" "$remote/"
stg pull: Failed "git-pull origin"


Running "stg pull" again gives only another "XML error", and finishes
the pull.

After unpacking all packs (mv .git/objects/pack and git-unpack-object
the contents) to be sure pruning does force everything to be
re-fetched, the following commands allow to reproduce the problem:

 git-rev-parse tags/qgit-1.2~17 > .git/refs/heads/master 
 git-rev-parse tags/qgit-1.2~17 > .git/refs/bases/master 
 echo 0a327c900530d9dd293cd252894a24913d4172c3 >.git/refs/heads/origin 
 git-prune
 cg-reset
 stg pull

Output then reproducibly goes like the above, if one reruns the same
6 commands repeatedly, though the fetch order is not deterministic,
which may explain slight differences in the output.

Using current HEAD git instead of 1.3.2 does not improve things.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
