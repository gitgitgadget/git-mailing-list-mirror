From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: Make branch use correct svn-remote
Date: Tue, 02 Dec 2008 19:55:06 -0800
Message-ID: <7vbpvtj4kl.fsf@gitster.siamese.dyndns.org>
References: <1228185780-22938-1-git-send-email-deskinm@umich.edu>
 <20081202215157.GB9650@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Deskin Miller <deskinm@umich.edu>, git@vger.kernel.org,
	gitster@pobox.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 04:56:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7iqn-0004Eo-VJ
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 04:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbYLCDzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 22:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbYLCDzR
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 22:55:17 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbYLCDzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 22:55:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C230683258;
	Tue,  2 Dec 2008 22:55:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 884FB83257; Tue,
  2 Dec 2008 22:55:08 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3067A5B6-C0EE-11DD-A3E6-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102208>

Eric Wong <normalperson@yhbt.net> writes:

> Deskin Miller <deskinm@umich.edu> wrote:
>> The 'branch' subcommand incorrectly had the svn-remote to use hardcoded
>> as 'svn', the default remote name.  This meant that branches derived
>> from other svn-remotes would try to use the branch and tag configuration
>> for the 'svn' remote, potentially copying would-be branches to the wrong
>> place in SVN, into the branch namespace for another project.
>> 
>> Fix this by using the remote name extracted from the svn info for the
>> specified git ref.  Add a testcase for this behaviour.
>> 
>> Signed-off-by: Deskin Miller <deskinm@umich.edu>
>
> Looks alright to me, thanks Deskin.
>
> Acked-by: Eric Wong <normalperson@yhbt.net>

Does not work for me X-<.

* expecting success:
        (svn co "$svnrepo" svn &&
        cd svn &&
        mkdir mirror &&
        svn add mirror &&
        svn copy trunk tags branches mirror/ &&
        svn ci -m "made mirror" ) &&
        rm -rf svn &&
        git svn init -s -R mirror --prefix=mirror/ "$svnrepo"/mirror &&
        git svn fetch -R mirror &&
        git checkout mirror/trunk &&
        base=$(git rev-parse HEAD:) &&
        git svn branch -m "branch in mirror" d &&
        test $base = $(git rev-parse remotes/mirror/d:) &&
        test_must_fail git rev-parse remotes/d

A    svn/trunk
A    svn/trunk/foo
A    svn/branches
A    svn/branches/a
A    svn/branches/a/foo
A    svn/branches/b
A    svn/branches/b/foo
A    svn/tags
A    svn/tags/tag4
A    svn/tags/tag4/foo
A    svn/tags/tag1
A    svn/tags/tag1/foo
A    svn/tags/tag2
A    svn/tags/tag2/foo
A    svn/tags/tag3
A    svn/tags/tag3/foo
Checked out revision 8.
A         mirror
svn: Client error in parsing arguments
* FAIL 4: branch uses correct svn-remote

                (svn co "$svnrepo" svn &&
                cd svn &&
                mkdir mirror &&
                svn add mirror &&
                svn copy trunk tags branches mirror/ &&
                svn ci -m "made mirror" ) &&
                rm -rf svn &&
                git svn init -s -R mirror --prefix=mirror/ "$svnrepo"/mirror &&
                git svn fetch -R mirror &&
                git checkout mirror/trunk &&
                base=$(git rev-parse HEAD:) &&
                git svn branch -m "branch in mirror" d &&
                test $base = $(git rev-parse remotes/mirror/d:) &&
                test_must_fail git rev-parse remotes/d
