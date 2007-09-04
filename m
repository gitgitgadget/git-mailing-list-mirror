From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Git's database structure
Date: Tue, 4 Sep 2007 11:23:02 -0400
Message-ID: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 04 17:23:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISaFW-0002AX-E0
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 17:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183AbXIDPXG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 11:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753668AbXIDPXG
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 11:23:06 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:27224 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754654AbXIDPXE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 11:23:04 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1196853rvb
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 08:23:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=blezBjEMD5vhgtsbhU19gauUuoIsZHarsYNezZ7NiNi/PpjOn3s6HZ/yooRdytr662ugSu43sN8dg5TIp1bf0BS2WLM2YHVlvGrgQTXrowzoVBGn3TWXTEAUz+VE7fPBncyODKPTLuFfomfiMgHEs752Up+85BT/6t+tZdzjXkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZJIe9fTGZ10qAJTtQhI3POvMz+YihOlHSDnAMADzZZ2s+SRYhWD6Uik/DFaSVbxBumKW9OmLuVuRCnMKjZ5JEpYmpTd6Lrm5aCz6tkUTcfWiqJvqnl0HCek51pI/eMfXTdXwEJOpJr14UEosj2HhxYgs/WkRTdRqrt8gkn4uOM0=
Received: by 10.141.202.12 with SMTP id e12mr2339217rvq.1188919382914;
        Tue, 04 Sep 2007 08:23:02 -0700 (PDT)
Received: by 10.141.44.16 with HTTP; Tue, 4 Sep 2007 08:23:02 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57597>

Let's back up a little bit from "Caclulating tree node".  What are the
elements of git's data structures?

Right now we have an index structure (tree nodes) integrated in to a
base table. Integrating indexing into the data is not normally done in
a database. Doing a normalization analysis like this may expose flaws
in the way the data is structured. Of course we may also decide to
leave everything the way it is.

What about the special status of a rename? In the current model we
effectively have three tables.

commit - a set of all SHAs in the commit, previous commit, comment, author, etc
blob - a file, permissions, etc.
file names - name, SHA

The file name table is encoded as an index and it has been
intermingled with the commit table.

Looking at this from a set theory angle brings up the question, do we
really have three tables and file names are an independent variable
from the blobs, or should file names be an attribute of the blob?

How this gets structured in the db is an independent question about
how renames get detected on a commit. The current scheme for detecting
renames by comparing diffs is working fine. The question is, once we
detect a rename how should it be stored?

Ignoring the performance impacts and looking at the problem from the
set theory view point, should:
the pathnames be in their own table with a row for each alias
the pathnames be stored as an attribute of the blob

Both of these are the same information, we're just looking at how
things are normalized.

-- 
Jon Smirl
jonsmirl@gmail.com
