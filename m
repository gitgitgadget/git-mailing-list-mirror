From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Mon, 17 Aug 2009 08:41:35 -0700
Message-ID: <7vtz06xxao.fsf@alter.siamese.dyndns.org>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
 <200908142223.07994.jnareb@gmail.com>
 <7veird4yyi.fsf@alter.siamese.dyndns.org>
 <200908160137.30384.jnareb@gmail.com>
 <alpine.DEB.1.00.0908161002460.8306@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0908171101090.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 17:42:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md4LM-0000CW-S4
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 17:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756002AbZHQPlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 11:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755890AbZHQPlq
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 11:41:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755582AbZHQPlo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 11:41:44 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 79D572CD0E;
	Mon, 17 Aug 2009 11:41:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 975032CD0C; Mon, 17 Aug 2009
 11:41:37 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0908171101090.4991@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Mon\, 17 Aug 2009 11\:08\:27 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 77F9825C-8B44-11DE-8C93-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126195>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The scenario is this: the repository contains a file that users are 
> supposed to change, but not commit to (only the super-intelligent inventor 
> of this scenario is allowed to).  As this repository is originally a 
> subversion one, there is no problem: people just do not switch branches.
>
> But this guy uses git-svn, so he does switch branches, and to avoid 
> committing the file by mistake, he marked it assume-unchanged.  Only that 
> a branch switch overwrites the local changes.

If it is a problem that a branch switch overwrites the local changes in
assume-unchanged file, perhaps that is what this person needs to change?

Let's step back a bit and think.

Local changes in git do not belong to any particular branch.  They belong
to the work tree and the index.  Hence you (1) can switch from branch A to
branch B iff the branches do not have difference in the path with local
changes, and (2) have to stash save, switch branches and then stash pop if
you have local changes to paths that are different between branches you
are switching between.

How should assume-unchanged play with this philosophy?

I'd say that assume-unchanged is a promise you make git that you won't
change these paths, and in return to the promise git will give you faster
response by not running lstat on them.  Having changes in such paths is
your problem and you deserve these chanegs to be lost.  At least, that is
the interpretation according to the original assume-unchanged semantics.

If some paths should not be committed, I'd say it should be handled by a
pre commit hook, and not assume-unchanged.

Is checking with "diff --cached" on the paths and either erroring out (or
better yet resetting the problematic paths in the index) an option?
