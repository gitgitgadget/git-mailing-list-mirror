From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git ls-files -m --with-tree does double output
Date: Sun, 16 Nov 2008 00:03:58 -0800
Message-ID: <7vr65c3xn5.fsf@gitster.siamese.dyndns.org>
References: <37512.N1gUGH5fRhE=.1226613228.squirrel@webmail.hotelhot.dk>
 <7vod0jfe51.fsf@gitster.siamese.dyndns.org>
 <57320.N1gUGH5fRhE=.1226617873.squirrel@webmail.hotelhot.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Sun Nov 16 09:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1cdM-0005RR-Lo
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 09:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbYKPIEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 03:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbYKPIEM
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 03:04:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbYKPIEM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 03:04:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B55D716CC5;
	Sun, 16 Nov 2008 03:04:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 06FDA16CBD; Sun,
 16 Nov 2008 03:04:00 -0500 (EST)
In-Reply-To: <57320.N1gUGH5fRhE=.1226617873.squirrel@webmail.hotelhot.dk>
 (Anders Melchiorsen's message of "Fri, 14 Nov 2008 00:11:13 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 25E69E6C-B3B5-11DD-A3BD-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101117>

"Anders Melchiorsen" <mail@cup.kalibalik.dk> writes:

> Junio C Hamano wrote:
>
>> What's the use case of using -m together with --with-tree to begin with?
>
> The script runs
>
>    git ls-files -d -m -o -t --with-tree=HEAD
>
> to get a parseable "git status"-like output. If I leave out
> --with-tree=HEAD, I do not get information about staged changes.

I think a machine parsable "status equivalent" is a good thing to have,
but I do not think the internal machinery of ls-files is equipped to do
that.  Didn't I send "here is how you would do it" patch some time ago, so
that interested parties can build on it to do that?

I lack the context to interpret what you mean by "The script", but in any
case, the only use case --with-tree was designed for was to use it in
conjunction with --error-unmatch inside the scripted version of "git
commit", to see if the paths given by the users make sense as a request to
create a partial commit.  It is not entirely surprising if any other funny
options do not work with it at all.

Having said all that, I think this would fix it.

 builtin-ls-files.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git c/builtin-ls-files.c i/builtin-ls-files.c
index b48327d..b28a185 100644
--- c/builtin-ls-files.c
+++ i/builtin-ls-files.c
@@ -227,6 +227,8 @@ static void show_files(struct dir_struct *dir, const char *prefix)
 			int dtype = ce_to_dtype(ce);
 			if (excluded(dir, ce->name, &dtype) != dir->show_ignored)
 				continue;
+			if (ce->ce_flags & CE_UPDATE)
+				continue;
 			err = lstat(ce->name, &st);
 			if (show_deleted && err)
 				show_ce_entry(tag_removed, ce);
