From: Marcus Comstedt <marcus@mc.pp.se>
Subject: Fix for normalization of foreign idents
Date: Mon, 23 Aug 2010 23:30:31 +0200
Message-ID: <1282599032-11369-1-git-send-email-marcus@mc.pp.se>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 23 23:30:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnebR-0003lD-EF
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 23:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749Ab0HWVam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 17:30:42 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:39688 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511Ab0HWVal (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 17:30:41 -0400
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id E60F3F82A;
	Mon, 23 Aug 2010 23:30:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1282599038; bh=wK8rBoTQldqg+eF4QhYdyl/sguBlPG7/EGz9MQcTM5I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=K/j94+2qxHzlZydUf1ozhzekt6S
	viJKYcFtBR9jkbNtHxzIwpwNIAx4oaGdedG77qAmCPj+gbzWvtKEuRV23ApNsWTFG6e
	DS5+a4RFbeDtH3Yk2/Ox292Mvb0QQjyWyPj1jZ+v1Mojp8g3SvCy0BJL5K2Stg9pV9Q
	kVUwgKNSp4=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <marcus@chiyo>)
	id 1OnebG-0002y3-EP; Mon, 23 Aug 2010 23:30:38 +0200
X-Mailer: git-send-email 1.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154259>

Hi.

The new behaviour that $Id$ tags containing expanded idents from
other version control systems, nice though it is, has a rather
serious problem.  This is because convert_to_git is no longer
the inverse operation of convert_to_working_tree.  For native
git idents, the transformations are

  $Id$ --(c_t_w_t)--> $Id: 123...$ --(c_t_g)--> $Id$

but for foreign idents, it becomes

  $Id: blah$ --(c_t_w_t)--> $Id: blah$ --(c_t_g)--> $Id$

The result of this is that git may consider even newly checked out
files as modified, even though neither the file contents nor its
attributes have been modified after the checkout.  I say _may_, because
it can also happen that it decides based on the time stamps that it
doesn't need to compare the actual contents, in which case the file
does not show as modified.

The following patch fixes this by preserving the foreign ident
also in convert_to_git, meaning that convert_to_git is again the
inverse operation of convert_to_working_tree, with the following
transformation series:

  $Id: blah$ --(c_t_w_t)--> $Id: blah$ --(c_t_g)--> $Id: blah$

This restores correct and deterministic operation of status and
diff, meaning that if the file hasn't actually been modified, no
modifications are shown.

As you might suggest, always keeping the foreign ident would mean it
is never updated when you commit new versions of the file, which isn't
really what we want.  Keeping the foreign ident as long as the last
modification to the file was made in the previous version control
system makes perfect sense, but once we make a commit to the file
within git, it should be replaced with a git ident.  The patch is
therefore slightly more complex, adding an extra parameter to control
whether foreign idents are collapsed or not.  This parameter is set
to true only in the case when index_mem is called with write_object
set to true, which is to say when we create a new blob from the
working tree (i.e. we are committing the file).

I hope we can agree that this is a sound and unintrusive way of
handling the problem.  :-)

Incidentally, should one want to create a commit to replace a foreign
ident with a native git one without making any other changes to the
file, this is still simple to do.  All that is needed is to change any
character inside the expanded ident in the working tree, and the file
will show as modified, and will have the foreign ident removed on
commit.


  // Marcus
