From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Deleted folder keeps showing up?
Date: Fri, 04 Sep 2009 01:36:13 -0700
Message-ID: <7vfxb3yuma.fsf@alter.siamese.dyndns.org>
References: <34230C98-81B8-4DC8-846F-8B6FA2A022DA@gmx.de>
 <4AA0C4A2.5040405@drmicha.warpmail.net>
 <8E56979B-5D85-4844-A492-8149EE9E9B2F@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Benjamin Buch <benni.buch@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 04 10:36:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjUHb-0008LH-Ut
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 10:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122AbZIDIg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 04:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754200AbZIDIg0
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 04:36:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43074 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051AbZIDIgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 04:36:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C0A2435F3;
	Fri,  4 Sep 2009 04:36:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=XKw7s5IP31h0eLqpGDLESIpaqNY=; b=t2mopp2dfvDkEaJlJi70z6b
	g5CVvC7U1xGkZFlaaGc455wXOc1Syhi48tfxT58EmJjoSdkvtkQeg/T7rCv0y564
	WGBqlozaBjRroHqJKPJcv9/iML/Z8K/s8jb7pbsgyPSjpSAHaO3bkoEISEXPh9y+
	fIfPaNkwPXOa705HuIgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=QlYqCkLXhobzKCkLXpMwKzrzW1p71ILpu4jIRJ/VDm4PJ4TpT
	Eki3UEe+eQUMXWYRcHy3EGTiER6CWWYgK76zyBsqvkEDwek+8AcP+KJsYxHntUsK
	ys8u1VrruuROguySMJIonZ/b+ID9IWiK9d1uc5D9SSxh/+sNA5Nr2H3QX0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 034A1435F2;
	Fri,  4 Sep 2009 04:36:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 78D23435F1; Fri,  4 Sep 2009
 04:36:15 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0509F464-992E-11DE-89EC-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127696>

Benjamin Buch <benni.buch@gmx.de> writes:

> Strangely, I can't reproduce the error  today.

If a branch has dir/file tracked, and another branch does not have
anything tracked in dir/ directory at all, then switching from the former
branch to the latter can remove dir/ only when you do not have any
untracked files in there when you switch.  Otherwise dir/ must stay
behind to keep the untracked files.

You can see it by a simple experiment.

    $ rm -fr trial
    $ mkdir trial
    $ cd trial
    $ git init
    $ >elif
    $ git commit -m initial
    $ git branch lacksdir
    $ mkdir dir
    $ >dir/file
    $ git add dir/file
    $ git commit -m add-dir-file

Now, after this set-up, your 'master' has dir/file and 'lacksdir' does
not have anything tracked in dir/ directory.

Observe:

    $ git checkout lacksdir
    $ find ??*
    elif
    $ git checkout master
    $ find ??*
    dir
    dir/file
    elif
    $ >dir/garbage
    $ git checkout lacksdir
    $ find ??*
    dir
    dir/garbage
    elif

If switching to 'lacksdir' removed the dir/ directory, whatever was in the
untracked file dir/garbage will be lost.  In the above exercise, I named
it garbage, so a casual reader might get a false impression that it should
be thrown away, but in real life workflow, it often happens that

 (1) you start doing some interesting experimental changes, while on
     'master';

 (2) you realize that this change does not belong to 'master', but belongs
     to some other branch, perhaps 'lacksdir';

 (3) you switch to the branch, to keep working.

Remember that, in git, your uncommitted changes to the index and the work
tree do not belong to the branch.  They try to follow you across branch
switching.  Since untracked new files are something potentially you might
want to add after branch switching, we do not remove them.  And because we
choose not to remove dir/file, even though the commit at the tip of the
lacksdir branch does not have anything tracked in dir/ directory, we
cannot remove it from the work tree.
