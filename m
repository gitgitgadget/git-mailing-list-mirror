From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Introduce rename factorization in diffcore.
Date: Fri, 07 Nov 2008 12:19:14 -0800
Message-ID: <7v3ai3gugt.fsf@gitster.siamese.dyndns.org>
References: <20081101215739.1116.59319.stgit@gandelf.nowhere.earth>
 <20081101220319.1116.50509.stgit@gandelf.nowhere.earth>
 <7vy6zwgx3i.fsf@gitster.siamese.dyndns.org>
 <20081107193957.GI5158@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri Nov 07 21:21:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyXpG-0004N4-Cq
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 21:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbYKGUTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 15:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbYKGUTr
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 15:19:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37197 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbYKGUTr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 15:19:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 333DF7A539;
	Fri,  7 Nov 2008 15:19:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B4E6F7A52D; Fri,
  7 Nov 2008 15:19:22 -0500 (EST)
In-Reply-To: <20081107193957.GI5158@nan92-1-81-57-214-146.fbx.proxad.net>
 (Yann Dirson's message of "Fri, 7 Nov 2008 20:39:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6AF8AC32-AD09-11DD-AD8B-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100328>

Yann Dirson <ydirson@altern.org> writes:

> The direct transposition of the raw output of a dir rename with a
> change would yield something like:
>
> |diff --git a/ppc/ b/foo
> |similarity index 100%
> |rename from ppc/
> |rename to foo/
> |diff --git a/ppc/sha1.h b/foo/sha1.h
> |--- ppc/sha1.h
> |+++ foo/sha1.h
> |...
>
> This would have the usefulness I'm looking for, in that the content
> modifications would not be "hidden" among a whole lot af individual
> file rename hunks.

I am afraid that this is totally unacceptable, as you yourself mentioned,
the end result is unapplicable with any existing tool and would confuse
viewers like gitk and gitweb.

I think it would be a much better approach to emit a hint that talks about
directory rename in a format that does not fool usual "patch" application
tools.  E.g.

|directory moved with similarity index 82%
|rename from ppc
|rename from foo
|diff --git a/ppc/sha1.h b/foo/sha1.h
|similarity index 85%
|rename from ppc/sha1.h
|rename to foo/sha1.h
|index  9b34f76..8fce4b7 100644
|--- ppc/sha1.h
|+++ foo/sha1.h
|@@ ...

IOW, do not add anything that begins with "diff --git" if it is not a
patch.
