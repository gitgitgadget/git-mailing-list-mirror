From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v2 0/6] replacing strbuf_getline_lf() by strbuf_getline() on
 trimmed input
Date: Mon, 22 Feb 2016 02:00:43 +0100
Message-ID: <56CA5DBB.8040006@moritzneeb.de>
References: <56ACF82B.2030005@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 02:24:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXfEI-00062t-40
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 02:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbcBVBXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 20:23:50 -0500
Received: from moritzneeb.de ([78.47.1.106]:55728 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304AbcBVBXr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 20:23:47 -0500
Received: from [192.168.1.3] (x55b377aa.dyn.telefonica.de [85.179.119.170])
	by moritzneeb.de (Postfix) with ESMTPSA id A75911C0F6;
	Mon, 22 Feb 2016 02:23:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456104226;
	bh=gu+MefORFZRfkUhRsbRdXGTWdeUBJcqC5lNZ8cP0oy4=;
	h=From:Subject:References:To:Cc:Date:In-Reply-To:From;
	b=ja7s9JTX/0/UN2sagSJSF+flc3KOyp2wpKmCKrlBN0iZ0wqsP6sJqM16HHn4ovLKI
	 o3y3SDnBmcMgzqA7QfpprbbS6wTXI9pnd91FdqzYZUsZMhQs+fSZN9RSSvoTKQf0Wn
	 n3eJtzcbS/D1TTuDXN8CGbPQ6QmMRt3wiM2rRuVM=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56ACF82B.2030005@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286865>

This series deals with strbuf_getline_lf() in certain codepaths:
Those, where the input that is read, is/was trimmed before doing anything that
could possibly expect a CR character. Those places can be assumed to be "text"
input, where a CR never would be a meaningful control character.

The purpose of this series is to document these places to have this property,
by using strbuf_getline() instead of strbuf_getline_lf(). Also in some codepaths,
the CR could be a leftover of an editor and is thus removed.

Every codepath was examined, if after the change it is still necessary to have
trimming or if the additional CRLR-removal suffices.

The series is an idea out of [1], where Junio proposed to replace the calls
to strbuf_getline_lf() because it 'would [be] a good way to document them as
dealing with "text"'. 
Changes since v1:

* adapting the behaviour of sq_(de)quote to be a one-to-one transformation
* removing some unneccesary trimming calls in:
    * wt-status.c
    * builting/notes.c
    * builtin/clean.c
    * bisect.c

-Moritz

[1] http://thread.gmane.org/gmane.comp.version-control.git/284104

Moritz Neeb (6):
  quote: remove leading space in sq_dequote_step
  bisect: read bisect paths with strbuf_getline()
  clean: read user input with strbuf_getline()
  notes: read copied notes with strbuf_getline()
  remote: read $GIT_DIR/branches/* with strbuf_getline()
  wt-status: read rebase todolist with strbuf_getline()

 bisect.c        |  5 ++---
 builtin/clean.c | 12 +++---------
 builtin/notes.c |  3 +--
 quote.c         |  2 ++
 remote.c        |  2 +-
 wt-status.c     |  3 +--
 6 files changed, 10 insertions(+), 17 deletions(-)

-- 
2.7.1.345.gc14003e
