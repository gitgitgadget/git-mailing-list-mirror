From: Mark Levedahl <mdl123@verizon.net>
Subject: Scripts to use "bundles" for moving data between repositories
Date: Wed, 14 Feb 2007 09:10:25 -0500
Message-ID: <11714622292110-git-send-email-mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 15:10:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHKqM-0002j3-GD
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 15:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbXBNOKe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 09:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbXBNOKd
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 09:10:33 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:64860 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932311AbXBNOKd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 09:10:33 -0500
Received: from fal-l07294-lp.us.ray.com ([71.246.235.75])
 by vms044.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JDG00AF3I1BOWF0@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 14 Feb 2007 08:10:24 -0600 (CST)
X-Mailer: git-send-email 1.5.0.rc3.24.g0c5e
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39648>

I am working a project using git where we have many repositories on machines
that can never be directly connected, but which need to have the same objects
and development history.  Existing git protocols offer limited support: we can
either a) publish and apply patch files branch by branch, or b) copy an entire
repository from one machine to another and then do local push or fetch.  While
both are workable, neither is a completely satisfactory solution, so I wrote the
attached scripts that support a "bundle" transfer mechanism.  A bundle is a zip
archive having two files: a list of references as given by git-show-ref and a
pack file of objects from git-pack-objects.  git-bundle creates the bundle,
git-unbundle unpacks and applies at the receiving end.  The means of
transporting the bundle file between the machines is arbitrary (sneaker net,
email, etc all can work).

This transfer protocol leaves it to the user to assure that the objects in the 
bundle are sufficient to update the target machine.  This is a direct 
consequence of the prohibition on direct communication between the machines.  
The approach supported here is to use normal git-rev-list format to specify what 
to include, e.g.  master~10..master, or ^master pu next, etc.  Having too many 
objects in the pack file is fine: git-unpack-objects at the receiving end 
happily ignores things not needed. git-unbundle normally checks that the updated 
references are fast-forward (--force to override), and that all required objects 
exist (--shallow to override). This latter option supports a disconnected 
shallow clone.

I offer this for inclusion in the main distribution, comments and suggestions
for improvement are welcome regardless. The scripts are working for me today
and I find them very useful.

Mark Levedahl
