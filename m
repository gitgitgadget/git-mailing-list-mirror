From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH try 2] t1301-shared-repo.sh: don't let a default ACL
	interfere with the test
Date: Wed, 15 Oct 2008 10:34:02 -0400
Message-ID: <1224081242.2935.13.camel@mattlaptop2.local>
References: <1224022020.2699.4.camel@mattlaptop2.local>
	 <1224022216.2699.5.camel@mattlaptop2.local>
	 <7vzll66c5u.fsf@gitster.siamese.dyndns.org>
	 <48F589EC.6050307@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 15 16:36:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq7Tu-0004Tq-Gj
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 16:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbYJOOey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 10:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753259AbYJOOey
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 10:34:54 -0400
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:43080 "EHLO
	jankymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753121AbYJOOex (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2008 10:34:53 -0400
Received: from [129.2.207.232] (ml2.student.umd.edu [129.2.207.232])
	by jankymail-a5.g.dreamhost.com (Postfix) with ESMTP id D213513F42;
	Wed, 15 Oct 2008 07:34:51 -0700 (PDT)
In-Reply-To: <48F589EC.6050307@viscovery.net>
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98274>

On Wed, 2008-10-15 at 08:13 +0200, Johannes Sixt wrote:
> Junio C Hamano schrieb:
> > Makes me wonder why this is _not_ inside test-lib.sh where it creates the
> > test (trash) directory.  That way, you would cover future tests that wants
> > to see a saner/simpler POSIX permission behaviour, wouldn't you?
> 
> But that would also paper over unanticipated bad interactions with strange
> ACLs that people might set, wouldn't it? By not placing this into
> test-lib.sh there is a higher chance that such an interaction is revealed,
> and we can react on it (educate users or fix the code).

A default ACL on the working tree does not interfere with git's
operation.  If the repository is shared, git will explicitly set the
permissions of every file as configured; otherwise, new files will
simply take their permissions from the default ACL instead of the
creating process's umask.  This is exactly the behavior that a user who
sets a default ACL would expect.  There is no need to modify
adjust_shared_perm or to warn users not to use default ACLs.

The only problem here is that a default ACL prevents
t1301-shared-repo.sh from testing the interaction between the umask and
the sharedRepository setting, since the test case expects new files to
be created according to the umask it set but the default ACL is
overriding the umask.  Removing the trash directory's default ACL is a
perfectly legitimate way for t1301-shared-repo.sh to test what it wants
to test.  Another option would be to modify the trash directory's
default ACL instead of modifying the umask.

Other tests will not care whether test-lib.sh clears a default ACL for
them because they are not specifically testing file permissions.
Therefore, I thought it best to leave the default ACL alone so that the
trash directories get the permissions the user has specified in the
default ACL in case he/she cares about sharing the trash directories
with others.

Matt
