From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] symref rename/delete fixes
Date: Sun, 26 Oct 2008 22:31:09 -0700
Message-ID: <7vhc6yioyq.fsf@gitster.siamese.dyndns.org>
References: <7v8wsca5ne.fsf@gitster.siamese.dyndns.org>
 <cover.1224987944.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Oct 27 06:32:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuKiW-0001Um-LQ
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 06:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbYJ0FbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 01:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbYJ0FbY
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 01:31:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbYJ0FbY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 01:31:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B343749AA;
	Mon, 27 Oct 2008 01:31:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F150E749A8; Mon, 27 Oct 2008 01:31:16 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7E7522B0-A3E8-11DD-8D24-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99206>

Miklos Vajna <vmiklos@frugalware.org> writes:

> A symref-aware rename_ref() is needed by git remove rename, since it
> typically does origin/HEAD -> upstream/HEAD symref renames there.
>
> Of course you can say that this should be handled by git-remote itself,
> without using rename_ref() but that not seem to be a good solution to
> me. (Workaround in the wrong layer, instead of a solution in a good
> one.)

I do not think it is a workaround at all.

I would even say that the renaming of symref that "git remote rename"
needs to do is fundamentally different from what rename_ref() is about,
and trying to cram it into rename_ref() is a grave mistake.

If you "git remote rename origin upstream" when origin/HEAD points at
refs/remotes/origin/master, you need to make the renamed one point at
refs/remotes/upstream/master, as you will be renaming origin/master to
upstream/master.

Normal "rename_ref()" would just rename the ref without touching its
contents, and if you used it to implement "git remote rename", your
upstream/HEAD would point at the old name "origin/master" that will
disappear when rename is finished, wouldn't it?  I do not think it is
useful.

There may be cases where you would really want to rename the symbolic ref
without changing its value (e.g. which other ref it points at), but as you
mentioned, even "git branch -m" is not such a usecase.

I think it is better to simply forbid renaming of a symref _until_ we know
what we want it to mean.  It is a lot easier to start strict and then add
features, than start loosely and implement an unclean semantics, and then
having to fix that semantics after people start to rely on the initial
(potentially crazy) semantics.
