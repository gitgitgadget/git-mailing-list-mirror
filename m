From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git index: how does it work?
Date: Wed, 12 Aug 2009 13:31:24 -0700
Message-ID: <7vab24ydsz.fsf@alter.siamese.dyndns.org>
References: <loom.20090805T160528-69@post.gmane.org>
 <7v7hxi9m4k.fsf@alter.siamese.dyndns.org>
 <436D5ED1-2F0E-4227-AC4A-3A5FD16B2DCF@cuttshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shaun Cutts <shaun@cuttshome.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 22:31:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbKTz-0000GP-Ej
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 22:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424AbZHLUb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 16:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754057AbZHLUb2
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 16:31:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38918 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058AbZHLUb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 16:31:27 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 17CCF270C9;
	Wed, 12 Aug 2009 16:31:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 08522270C6; Wed, 12 Aug 2009
 16:31:25 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1D58B5CA-877F-11DE-A1B2-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125742>

Shaun Cutts <shaun@cuttshome.net> writes:

> Are renames being tracked by the index, and is there a more basic
> interface than "status" to query about them?

No.  Index, nor git in general, never records renames.  git records
contents, not content changes.  The index records a state, so does the
tree object pointed at by the HEAD commit.

When you ask for "status", git will notice that you have lost a file, and
added a new one, between these two states, by comparing them.  The
contents of these lost files and added files are then compared, and ones
with similar contents are paired up.

That way, you do not have to use "git mv A B" to "rename" A to B.  You can
just as well "mv A B; git rm A; git add B", and get the same outcome,
exactly because git does not record renames.

Instead, we track them by deducing that you renamed from the result.

The tree-vs-index comparison "git status" does to figure all this out is
"git diff-index -M --cached HEAD".

As it should be obvious from the above description,

	git diff-index -M --cached HEAD -- A

is *NOT* the way for you to ask about "possible renames of A".  You need
to run the diff for the whole tree without path limitation so that you can
pair deletions and creations up in order to deduce renames.
