From: Michael Hirshleifer <111mth@caltech.edu>
Subject: Possible vulnerability to SHA-1 collisions
Date: Sat, 24 Nov 2012 11:12:28 +0000
Message-ID: <50B0AB9C.2040802@caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 12:21:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcDni-0004j3-5d
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 12:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197Ab2KXLVU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Nov 2012 06:21:20 -0500
Received: from outgoing-mail.its.caltech.edu ([131.215.239.19]:20375 "EHLO
	outgoing-mail.its.caltech.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751158Ab2KXLVT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Nov 2012 06:21:19 -0500
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Nov 2012 06:21:19 EST
Received: from fire-doxen.imss.caltech.edu (localhost [127.0.0.1])
	by fire-doxen-postvirus (Postfix) with ESMTP id 6BE1F2E50E43
	for <git@vger.kernel.org>; Sat, 24 Nov 2012 03:12:36 -0800 (PST)
X-Spam-Scanned: at Caltech-IMSS on fire-doxen by amavisd-new
Received: from [192.168.2.193] (ip68-231-215-250.oc.oc.cox.net [68.231.215.250])
	(Authenticated sender: 111mth)
	by fire-doxen-ssl (Postfix) with ESMTP id 9FDB12E50DDB
	for <git@vger.kernel.org>; Sat, 24 Nov 2012 03:12:31 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210320>

Evil Guy creates 2 files, 1 evil and 1 innocuous, with the same SHA-1=20
checksum (including Git header). Mr. Evil creates a local branch with a=
n=20
innocuous name like =E2=80=9Ctest-bugfix=E2=80=9D, and adds a commit co=
ntaining a=20
reference to the evil file. Separately, using a sockpuppet, Evil Guy=20
creates an innocuous bugfix (very likely to be accepted) containing the=
=20
innocuous file, and submits it to Good Guy. Before Good Guy can commit=20
the bugfix, Evil Guy pushes the evil branch to Github, and then=20
immediately deletes it; or equivalently --force pushes any innocuous=20
commit on top of it. (This is unlikely to arouse suspicion, and he can=20
always say he deleted it because it didn=E2=80=99t work.)

Git keeps unreferenced objects around for a few weeks, so when Good Guy=
=20
commits the patch and pushes to Github, an object with an sha1sum that=20
matches the good file will already exist in the main repository. Since=20
Git keeps the local copy of files when sha1sums match, the main Github=20
repository will then contain the evil file associated with Good Guy=E2=80=
=99s=20
commit. Any users cloning from Github will get the evil version. This i=
s=20
an exploit.

And Good Guy=E2=80=99s local repository will contain the good file; he =
will not=20
notice anything amiss unless he nukes his local repository and clones=20
from Github again. Even when the compromise is discovered, there will b=
e=20
no reason to suspect Evil Guy; the evil file seems to have been=20
committed by Good Guy.

Previous discussion about hash collisions in Git seems to conclude that=
=20
they aren=E2=80=99t a security threat. See=20
http://stackoverflow.com/questions/9392365/how-would-git-handle-a-sha-1=
-collision-on-a-blob/9392525#9392525,=20
Linus Torvalds arguing that Git=E2=80=99s security doesn=E2=80=99t depe=
nd on SHA-1=20
collision resistance.

This proposed exploit does not involve social engineering, or any good=20
guys failing to spot or accepting patches containing evil data (what=20
Good Guy accepts is a genuine bugfix). It contaminates the main public=20
repository in a way that Good Guy won=E2=80=99t immediately notice. It =
does not=20
require a second-preimage attack; Bad Guy creates both versions of the=20
file. While this does require the bad guy to have commit access, the ba=
d=20
guy can avoid suspicion after the attack.
