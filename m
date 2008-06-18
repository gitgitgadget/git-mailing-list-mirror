From: marc.zonzon+git@gmail.com
Subject: sharing object packs
Date: Wed, 18 Jun 2008 21:57:26 +0200
Message-ID: <20080618195726.GA20440@kernoel.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 21:58:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K93nY-0006Em-Gc
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 21:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbYFRT5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 15:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753877AbYFRT5b
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 15:57:31 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:33228 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753660AbYFRT5a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 15:57:30 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 4196A17B656;
	Wed, 18 Jun 2008 21:57:27 +0200 (CEST)
Received: from kernoel.kernoel.fr (lns-bzn-47f-81-56-187-30.adsl.proxad.net [81.56.187.30])
	by smtp3-g19.free.fr (Postfix) with ESMTP id F2DE317B636;
	Wed, 18 Jun 2008 21:57:26 +0200 (CEST)
Received: by kernoel.kernoel.fr (Postfix, from userid 206)
	id 6F5F5300D8; Wed, 18 Jun 2008 21:57:25 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85407>

Hello

I have a big bare repository 'main.git' and many small git repositories sub1, sub2, ... subn.
All repositories lie in the same file file system, and each subx repository track and fetch main.git in a remote branch.

I would like to avoid duplicating main.git objects, I have made some tries:

- Putting a hard link to the pack in the object repository of main.git into subx object repository before fetching the main.git remote. 
It works well... until the first repack on either side. 
Note that the problem is the same for any clone of a local repository, the hard link of packs vanish on the first repack. 
You end up with a pack with the same objects, and so the same name, but organized in a different way so with an associated idx file and often a different file size.

- Using an objects/info/alternates with the path of main.git object repository.
It work well too, but I import objects from main.git inside subx, and they don't have the same life time than those in main.git. So they can, disapear during a git-prune-packed or gc. (The same problem we have with: git clone --share)

- I tried also to use git-relink to synchronize diverging repositories. But git-relink see different packs with the same name, (because repacked in a different way) and refuse to hard-link the packs but hard-links the .idx which has also an identical name and had the same size in my experiments.
So the .idx does no longer agree with the .pack and git fsck fail. Of course we can recover the repository by generating a new idx, but git-relink is a dangerous tool to use here.

If we unpack all objects we have not all these problems, but the main.git is in this case quite big. Of course it may be better to have a big repository than 20 copies of the packed repository. 
But I suppose that that there is some way to share an object repository in a safe way, even if it includes some packs.

I am quite new to git core and internals, so I may have missed the point.

Marc
