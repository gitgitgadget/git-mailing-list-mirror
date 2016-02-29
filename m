From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v4 0/7] replacing strbuf_getline_lf() by strbuf_getline()
Date: Mon, 29 Feb 2016 09:30:58 +0100
Message-ID: <56D401C2.8020100@moritzneeb.de>
References: <56D28092.9090209@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 09:38:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaJLU-0003mU-Ly
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 09:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbcB2IiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 03:38:20 -0500
Received: from moritzneeb.de ([78.47.1.106]:39551 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752247AbcB2IiU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 03:38:20 -0500
Received: from [192.168.1.3] (x4db4d1fb.dyn.telefonica.de [77.180.209.251])
	by moritzneeb.de (Postfix) with ESMTPSA id 58AEA1C045;
	Mon, 29 Feb 2016 09:38:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456735098;
	bh=zMbS24wDbl83gzzuLzFkqYstMiVAwW3Yj81JlfVHwp4=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=pWBbsamS1nZMTYjf/BPghVGbC8MbMfIxIMn2zr7XUhvRPNz93fbpaqbYUKm+Ls087
	 i/UWRCrlnid6gT/cKGZZESfBfA8aM8CXWtDl1VBmnmaKSGWTlnvHmheVKwQBeyM3Nh
	 QTZVZBOYlkGJyP09yOdyeSgdIhVyZRDGS2opf41c=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56D28092.9090209@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287804>

Although I was not sure [4], I decided to roll out v4, in the hope that the next
reviewers will profit by the more polished commit messages and order.

This series deals with strbuf_getline_lf() in certain codepaths:
Those, where the input that is read, is/was trimmed before doing anything that
could possibly expect a CR character. Those places can be assumed to be "text"
input, where a CR never would be a meaningful control character.

The purpose of this series is to document these places to have this property,
by using strbuf_getline() instead of strbuf_getline_lf(). Also in some codepaths,
the CR could be a leftover of an editor and is thus removed.

Every codepath was examined, if after the change it is still necessary to have
trimming or if the additional CRLF-removal suffices.

The series is an idea out of [1], where Junio proposed to replace the calls
to strbuf_getline_lf() because it 'would [be] a good way to document them as
dealing with "text"'. 

Changes since v3 [3] (the changes to single patches are indicated below):

 * Commit messages refined
 * Order of patch 4 and 5 in v2 was switched.

The interdiff only removes an empty line (I noticed, when changing the order of
commits, that the splitting operation had no newline before this whole series,
so I left it that way):

diff --git a/builtin/notes.c b/builtin/notes.c
index 660c0b7..715fade 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -296,7 +296,6 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
         int err;
 
         string_list_split(&split, buf.buf, ' ', -1);
-
         if (split.nr != 2)
             die(_("Malformed input line: '%s'."), buf.buf);
         if (get_sha1(split.items[0].string, from_obj))

-Moritz

[1], idea: http://thread.gmane.org/gmane.comp.version-control.git/284104
[2], v2: http://thread.gmane.org/gmane.comp.version-control.git/285118/focus=286865
[3], v3: http://thread.gmane.org/gmane.comp.version-control.git/285118/focus=287747
[4] http://thread.gmane.org/gmane.comp.version-control.git/285118/focus=287760

Moritz Neeb (7):
  quote: remove leading space in sq_dequote_step -- as in v2
  bisect: read bisect paths with strbuf_getline() -- refined commit message
  clean: read user input with strbuf_getline() -- simplified commit message
  notes copy --stdin: read lines with strbuf_getline() -- switched with below
  notes copy --stdin: split lines with string_list_split() -- switched with above
  remote: read $GIT_DIR/branches/* with strbuf_getline() -- as in v3
  wt-status: read rebase todolist with strbuf_getline() -- as in v2

 bisect.c        |  5 ++---
 builtin/clean.c |  6 +++---
 builtin/notes.c | 22 ++++++++++------------
 quote.c         |  2 ++
 remote.c        |  2 +-
 wt-status.c     |  3 +--
 6 files changed, 19 insertions(+), 21 deletions(-)

-- 
2.4.3
