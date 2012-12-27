From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] log: grep author/committer using mailmap
Date: Thu, 27 Dec 2012 10:45:38 -0800
Message-ID: <7v1uebmizx.fsf@alter.siamese.dyndns.org>
References: <7vy5gkmr53.fsf@alter.siamese.dyndns.org>
 <1356622318-19523-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 19:46:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToISt-0000bZ-D0
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 19:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362Ab2L0Spn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2012 13:45:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60479 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753361Ab2L0Spm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 13:45:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3612C9E95;
	Thu, 27 Dec 2012 13:45:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UEUJ1/QCFevl7Md+Lgz3ko1/Ro0=; b=D1CrRG
	+fRUMwiALYAND1FoNu6DUpokySrwusKPd63UTCLxXtEy7Vme+fSeMpTszyqDk37P
	CedYaq6bqDEzveFSHS4WYPwSQqDYEPeqjKrfXOd1kmcqvSxamn+/vnJURMrfBq6J
	C5kN4o2Kll3LtUkklYzQxumCs3kmmJQ4vfhYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=it6/2mmIhf+tLN1pseZHYJUYmQW/mqPk
	4qJUETWRH2o4R79WlNMShBC8euuY4c7R7267tycStrPiEfbX0fo3egDdkCyJN+S8
	L3bfijJ2GHv0PedDkU6QfBl9zNO3aqAQpLRkOfa4q+Sds6HGIvRMs76HuQVG4N5i
	fqgUIrhAocM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21FAE9E93;
	Thu, 27 Dec 2012 13:45:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5392D9E8F; Thu, 27 Dec 2012
 13:45:40 -0500 (EST)
In-Reply-To: <1356622318-19523-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Thu, 27 Dec 2012 16:31:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C92E0DE-5055-11E2-911F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212208>

Antoine Pelisse <apelisse@gmail.com> writes:

> Currently you can use mailmap to display log authors and committers
> but you can't use the mailmap to find commits with mapped values.
>
> This commit allows you to run:
>
>     git log --use-mailmap --author mapped_name_or_email
>     git log --use-mailmap --committer mapped_name_or_email
>
> Of course it only works if the --use-mailmap option is used.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---

Thanks.  I'll queue this on top.

-- >8 --
Subject: [PATCH] log --use-mailmap: optimize for cases without --author/--committer search

When we taught the commit_match() mechanism to pay attention to the
new --use-mailmap option, we started to unconditionally copy the
commit object to a temporary buffer, just in case we need the author
and committer lines updated via the mailmap mechanism.

It turns out that this has a rather unpleasant performance
implications.  In the linux kernel repository, running

  $ git log --author='Junio C Hamano' --pretty=short >/dev/null

under /usr/bin/time, with and without --use-mailmap (the .mailmap
file is 118 entries long, the particular author does not appear in
it), cost (with warm cache):

  [without --use-mailmap]
  5.34user 0.25system 0:05.60elapsed 100%CPU (0avgtext+0avgdata 2004832maxresident)k
  0inputs+0outputs (0major+137600minor)pagefaults 0swaps

  [with --use-mailmap]
  6.87user 0.24system 0:07.11elapsed 99%CPU (0avgtext+0avgdata 2006352maxresident)k
  0inputs+0outputs (0major+137696minor)pagefaults 0swaps

which is with about 29% overhead.  The command is doing extra work,
so the extra cost may be justified.

But it is inexcusable to pay the cost when we do not need
author/committer match.  In the same repository,

  $ git log --grep='fix menuconfig on debian lenny' --pretty=short >/dev/null

shows very similar numbers as the above:

  [without --use-mailmap]
  5.30user 0.24system 0:05.55elapsed 99%CPU (0avgtext+0avgdata 2004896maxresident)k
  0inputs+0outputs (0major+137604minor)pagefaults 0swaps

  [with --use-mailmap]
  6.82user 0.26system 0:07.07elapsed 100%CPU (0avgtext+0avgdata 2006352maxresident)k
  0inputs+0outputs (0major+137697minor)pagefaults 0swaps

The latter case is an unnecessary performance regression.  We may
want to _show_ the result with mailmap applied, but we do not have
to copy and rewrite the author/committer of all commits we try to
match if we do not query for these fields.

Trivially optimize this performace regression by limiting the
rewrites for only when we are matching with author/committer fields.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index fa16b9d..56b72f7 100644
--- a/revision.c
+++ b/revision.c
@@ -2283,7 +2283,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	if (buf.len)
 		strbuf_addstr(&buf, commit->buffer);
 
-	if (opt->mailmap) {
+	if (opt->grep_filter.header_list && opt->mailmap) {
 		if (!buf.len)
 			strbuf_addstr(&buf, commit->buffer);
 
-- 
1.8.1.rc3.221.g8d09d94
