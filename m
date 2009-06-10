From: Elijah Newren <newren@gmail.com>
Subject: Re: EasyGit Integration
Date: Tue, 9 Jun 2009 22:20:45 -0600
Message-ID: <51419b2c0906092120o56db640cg2fcf77c11e7b7f42@mail.gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	 <alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>
	 <51419b2c0906091530t3dfa5267s2262f979f1e9982a@mail.gmail.com>
	 <alpine.LFD.2.01.0906091535410.6847@localhost.localdomain>
	 <20090610033211.GA7411@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 10 06:20:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEFJ1-0003cq-Rr
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 06:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbZFJEUp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 00:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbZFJEUo
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 00:20:44 -0400
Received: from mail-qy0-f180.google.com ([209.85.221.180]:44863 "EHLO
	mail-qy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbZFJEUn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2009 00:20:43 -0400
Received: by qyk10 with SMTP id 10so277635qyk.33
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 21:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kvbyEXGb/d6DDzoWd3e5QSrZbh6FijY7aVBbQmZ1j0c=;
        b=RKSBHDZ0U4nlBrGCXV3Znxxpy2Kn+D9hHqcA3Xs/IwwU/rYeFWKLTjIzX0HRvBzRTa
         Ct9NVuf/sms2OY31s/iKMYYSGn3Dehl0TNNsxtfpgQ7PXVO2+FyUJ304lDrTGUW2VRPv
         QjNCmRbuBvCyvsdvIFEmgnosbF4WWTlrTUK7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hdoFnMXjQO2cYIPL4DjNxz1hNB5kGUd51pDTahsUZoU9wsHD/fA6yrQdCnSB3UDYfm
         +jGypBvhNeehWvRL9rKAF1H5+Vgz98ZW/KL4rLKecmbwSSyhnBdehsAKtb//iEwxEY9R
         B/Bt01C2WkmgL9fMKEyghgxzoEOsz+ynp2mpM=
Received: by 10.229.89.146 with SMTP id e18mr219257qcm.23.1244607645822; Tue, 
	09 Jun 2009 21:20:45 -0700 (PDT)
In-Reply-To: <20090610033211.GA7411@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121249>

On Tue, Jun 9, 2009 at 9:32 PM, Theodore Tso<tytso@mit.edu> wrote:
> My personal opinion is this kind of overloading is actually more
> confusing than simply adding a new name, such as "git revert-file".
> Of course, you can do that already using a git alias.... =C2=A0So IMH=
O the
> best way of handling this issue is to have git tutorials use this as =
a
> teachable moment, so people can create their own git alias for "git
> checkout HEAD --".

So I have a few problems with such an alias:
* It fails to work during an initial commit ("git revert-files
new-file" -> "fatal: invalid reference: HEAD")
* When not working on the initial commit, it will silently do nothing
when given a newly added file rather than undoing the add
* As a side effect of the above, trying to undo all changes via "git
revert-files ." does not actually work; any newly added files will
still remain staged.
* It makes no sense during an incomplete merge (why is HEAD more
special than other refs in $git_dir/MERGE_HEAD?  Shouldn't the user
need to specify which ref to revert relative to in such a case?)
* It can't be used to revert a file back to a revision prior to HEAD
(and 'git checkout OLDER_COMMIT -- FILE' in such a case isn't always
the right match either as it can leave the file in the working copy
when it should be removed).
* It provides no option to make the changes to just the index or just
the working copy; it always affects both (which is the right default,
but sometimes I like making changes to just one of those two places).

"git checkout <commit> -- <paths>..."  really is a different command
than the "revert" of svn, bzr, darcs, or mercurial.  There's clearly a
lot of overlap, but they're not the same.  I fear that claiming they
are equivalent will at some point just cause extra confusion for new
git users.


Elijah
