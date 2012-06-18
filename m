From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/9] Extending the shelf life of "git describe" output
Date: Mon, 18 Jun 2012 15:05:29 -0700
Message-ID: <1340057139-8311-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 00:05:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgk4y-00088o-Fl
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 00:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084Ab2FRWFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 18:05:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57294 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421Ab2FRWFm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 18:05:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21F3197D8
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=tPrBjppjGl+EGJuoBJwz6eigdfw
	=; b=oovO9be4jVCu1iDXeFSo1Cw1gQE/OBz0XMsfA00/IdGFjKx9FtM3fC6KoEC
	Hwh2cdLMwpkoXumSYPMB9Nfhf1hhHXbUmzpovQUrU3G9CvJ1c0kRa6EqbMlVfByj
	W0p6kz6ViRNbqVum1Ng9g/3yAGygYgJuORZmSaJwrt3Ernsk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=ufS6QxT6fWd14IMmCU68FdCfpg4cw
	Le6sMFT3FPmV6CR1sFsXAm7W51oJlcCnChlcTNsnFf/J7HGvfDjkUcCaqkAHAb+3
	2JWESSu+osJi+SVLIu4WnCoERUijduYnjodsxafyXskM0ZmLCekl0x7fcB/iowF6
	mE/Na4Vnj7tBuI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 194C197D7
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0FC497D6 for
 <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:40 -0400 (EDT)
X-Mailer: git-send-email 1.7.11
X-Pobox-Relay-ID: BDFCE752-B991-11E1-9BCC-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200165>

The output from "git describe" is a tagname, dash, number, dash, and
'g' followed by an abbreviated commit object name, and it can be
used anywhere we expect an object name.  This is so that people can
use it to name an exact commit in the inter-human communication. The
recipients are expected to be able to cut & paste it to their
command line.

Because it uses an abbreviated commit object name, it is possible
that a "git describe" name taken earlier can become ambiguous over
time, even though "git describe" ensures the uniqueness of its
output in the repository when it runs.

This series teaches the sha1_name machinery to only look for
unambigous commit object names when the caller knows that the name
must refer to a commit object.  By taking advantage of the fact that
there are more trees and blobs in a project's history than commits
by definition, this reduces the potential of collisions, extending
the shelf life of "git describe" output by a little bit.

Building on the foundation this series lays, I can see two separate
avenues to further extend this work:

 - You will further be able to extend the lifetime of uniqueness of
   "git describe" output if you take advantage of the "tagname" or
   "number". The current parser does not do this.

   There are a number of ways to do this, but probably the cleanest
   would be to (you only can do this when you have "tagname" tag
   locally; you may not have it) pass the tag and the number down to
   the find_short_*() routines with commit_only set, and when they
   find a commit that match the prefix, inside is_commit_object()
   test, check also that the commit reaches the given tag object in
   the given number steps (otherwise discard it as it is not the one
   you are looking for).

 - Some callers that are involved in the get_sha1_1() callpath know
   that the name they have must be referring to commit objects (e.g.
   get_parent() and get_nth_ancestor()).  It might be worthwhile to
   let get_sha1_1() know that the caller knows the name it is
   feeding must refer to a commit object, and have the uniqueness
   logic take advantage of it.

   I think that most of these callers are expecting to parse a
   committish and the user may have given them the name of a a tag
   object that peels to a commit, so you would need to add a new
   GET_SHORT_COMMITTISH that allows any committish, in addition to
   the GET_SHORT_COMMIT_ONLY this series adds, if you want to do
   this.

I do not claim the ownership rights on either of the above ideas;
people who find them interesting are welcome to pursue them (hint,
hint).

Junio C Hamano (9):
  sha1_name.c: indentation fix
  sha1_name.c: clarify what "fake" is for in find_short_object_filename()
  sha1_name.c: rename "now" to "current"
  sha1_name.c: refactor find_short_packed_object()
  sha1_name.c: teach find_short_object_filename() a commit-only option
  sha1_name.c: teach find_short_packed_object() a commit-only option
  sha1_name.c: allow get_short_sha1() to take other flags
  sha1_name.c: teach get_short_sha1() a commit-only option
  sha1_name.c: get_describe_name() by definition groks only commits

 sha1_name.c | 157 ++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 101 insertions(+), 56 deletions(-)

-- 
1.7.11
