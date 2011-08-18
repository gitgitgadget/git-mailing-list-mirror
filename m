From: Junio C Hamano <gitster@pobox.com>
Subject: Re: update-index --index-info producing spurious submodule commits
Date: Thu, 18 Aug 2011 15:49:27 -0700
Message-ID: <7vd3g272tk.fsf@alter.siamese.dyndns.org>
References: <rmivctuv12s.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Richard Hansen <rhansen@bbn.com>
To: Greg Troxel <gdt@ir.bbn.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 00:49:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuBP5-0004ef-5T
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817Ab1HRWta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:49:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54067 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754710Ab1HRWt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:49:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 435524747;
	Thu, 18 Aug 2011 18:49:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1/GF7iiWkJ8rdP+YjybNNZ/ITrU=; b=gsVE6k
	XWb1RHGcbsNH2hQCA0OdBG0BIUNHqMHdy9GqgcDQEBZQBs0WRBeVG8C9+AyMXX4v
	YBVLMVQ4xd33ZspGLL2J6k6Jf9X7ADctyhzTMgDjw8CCjCd5Elfnv7h3tzTWi/Xg
	pE8pT+PqJcxuOxZHG7WoqeS5YrxJbRzc5hf9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a8M+wpOK1RHxXqJzSeraXc0YTa04acd5
	pXf7FzMObn7eBNXXgPadcPVWsdnvJI3upDakXxn4BcJD86s3O/pioEG6GKxKxYwI
	fqNYa+56Km7l4WA2lql3Q95qj1esqHTc7aeCHScTkQVKKNn3hAqHCAGFe7nTBnOD
	GSqKal3yJmQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A7CF4746;
	Thu, 18 Aug 2011 18:49:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B57584745; Thu, 18 Aug 2011
 18:49:28 -0400 (EDT)
In-Reply-To: <rmivctuv12s.fsf@fnord.ir.bbn.com> (Greg Troxel's message of
 "Thu, 18 Aug 2011 17:53:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54754170-C9EC-11E0-B8CC-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179652>

Greg Troxel <gdt@ir.bbn.com> writes:

> git ls-tree HEAD foo
> git ls-tree HEAD foo | git update-index --index-info

This --index-info definitely looks wrong, if "foo" is a directory, as the
entries in the index are supposed to be either blobs or commits.

As "update-index --index-info" predates "submodule" by a few years or
more, I wouldn't be surprised if the code didn't notice it was fed a wrong
input and produced nonsensical result that happened to be a commit.

The command could just instead barf, saying the input is wrong, but the
option was so low-level that it was deliberately written to accept and
store anything you throw at it --- even when it is nonsensical for the
version of plumbing, later updates to the data structure might have made
it making sense, which was the way to ease development of the system.

By now, we should start enforcing more sanity on its input.

 builtin/update-index.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index a6a23fa..4b32bfe 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -220,6 +220,12 @@ static int process_path(const char *path)
 	return add_one_path(ce, path, len, &st);
 }
 
+static int verify_mode(unsigned int mode)
+{
+	return (mode == 0160000 || mode == 0120000 ||
+		mode == 0100644 || mode == 0100755);
+}
+
 static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 			 const char *path, int stage)
 {
@@ -229,6 +235,9 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 	if (!verify_path(path))
 		return error("Invalid path '%s'", path);
 
+	if (!verify_mode(mode))
+		return error("Invalid mode '%o'", mode);
+
 	len = strlen(path);
 	size = cache_entry_size(len);
 	ce = xcalloc(1, size);
