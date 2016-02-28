From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v3 0/7] replacing strbuf_getline_lf() by strbuf_getline()
Date: Sun, 28 Feb 2016 06:07:30 +0100
Message-ID: <56D28092.9090209@moritzneeb.de>
References: <56CA5DBB.8040006@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 28 06:15:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZthn-00036z-BZ
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 06:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbcB1FPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 00:15:38 -0500
Received: from moritzneeb.de ([78.47.1.106]:36999 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748AbcB1FPc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 00:15:32 -0500
Received: from [192.168.1.3] (x4db4d017.dyn.telefonica.de [77.180.208.23])
	by moritzneeb.de (Postfix) with ESMTPSA id 09BE51C002;
	Sun, 28 Feb 2016 06:15:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456636528;
	bh=40fpn4mZ/ta8ebD3SbzKhIWng3vu0GmSYWbSzCmnIr8=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=W9hRd3D6uxJE0h54QISV0h5MMcu1K/NN0thXmlnHzM0Em+gFqkXv4PvagyyHFHQKH
	 K5v6ZTxXae+0uPcB2tNND3WiIfr5B+IdKaf7W727GVcQVHeSV+sPAeZoVEcU0oD5zU
	 x2jNdhI1QOnM/RnD2D9lIYZAoTDDb376hwpFHVME=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56CA5DBB.8040006@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287747>

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

Changes since v2:

* Line splitting in notes_copy_from_stdin() is changed to string_list_split as
  suggested by Eric Sunshine.
* The behavior change in interactive cleaning from patch v2 is undone.
* Some of the previous patches were broken because of some unexpected
  whitespace. This should be fixed now.

-Moritz

[1] http://thread.gmane.org/gmane.comp.version-control.git/284104

Moritz Neeb (7):
  quote: remove leading space in sq_dequote_step
  bisect: read bisect paths with strbuf_getline()
  clean: read user input with strbuf_getline()
  notes copy --stdin: split lines with string_list_split()
  notes copy --stdin: read lines with strbuf_getline()
  remote: read $GIT_DIR/branches/* with strbuf_getline()
  wt-status: read rebase todolist with strbuf_getline()

 bisect.c        |  5 ++---
 builtin/clean.c |  6 +++---
 builtin/notes.c | 23 +++++++++++------------
 quote.c         |  2 ++
 remote.c        |  2 +-
 wt-status.c     |  3 +--
 6 files changed, 20 insertions(+), 21 deletions(-)

-- 
2.7.1.346.gc0ef946
