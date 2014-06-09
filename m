From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH/RFC v1 0/5] add strbuf_set operations
Date: Mon,  9 Jun 2014 01:36:24 -0700
Message-ID: <cover.1402301815.git.jmmahler@gmail.com>
Cc: Jeremiah Mahler <jmmahler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 10:37:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wtv51-00075R-E4
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 10:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712AbaFIIhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 04:37:17 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:61373 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821AbaFIIhP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 04:37:15 -0400
Received: by mail-pa0-f53.google.com with SMTP id kx10so515421pab.40
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/zfNjvbcbcjD8zV//TC7UrAp72Xm7HgjVtCqPTvn+bo=;
        b=kDRsSAIa8hdhJTbqOX7MGlx/j6pxh8lzmnwJZQq5LnuZtzM6QUdCYW0jujYiamG2A7
         YFEPBifB9ER//YIE0eCj4zPytH5HpqnpqZFrq+huFAoNIS0OIrCaQ0ipWw7ySs63Hp9L
         iYqWuMQ6HaEkxJOvexzs+JoY8scckvKxY8x+3qLUui7KH7WmgR4cAyU/BxRJ1eKmB8Ya
         rRNDWaaTUMAmlZDT3UA8ISf/2m0YMaIXsJGHQgjoKIncSmCN/KpmpNLxQbkJF8gJ9U2u
         6UsLitp+Qna04hcRSjxEnyycqPKGQB5eoe2pD+5CcEIBAFp6Qo1yz1mJJA4VpB1ixLq1
         RjOQ==
X-Received: by 10.66.163.38 with SMTP id yf6mr3051945pab.46.1402303034906;
        Mon, 09 Jun 2014 01:37:14 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id y2sm9012799pas.45.2014.06.09.01.37.11
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 01:37:13 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 01:37:10 -0700
X-Mailer: git-send-email 2.0.0.573.ged771ce.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251059>

Currently, the data in a strbuf is modified using add operations.  To
set the buffer to some data a reset must be performed before an add.
    
  strbuf_reset(buf);
  strbuf_add(buf, cb.buf.buf, cb.buf.len);
    
And this is a common sequence of operations with 70 occurrences found in
the current source code.  This includes all the different variations
(add, addf, addstr, addbuf, addch).
    
  FILES=`find ./ -name '*.c'`
  CNT=$(pcregrep -M "strbuf_reset.*\n.*strbuf_add" $FILES | wc -l)
  CNT=$(echo "$CNT / 2" | bc)
  echo $CNT
  70
    
These patches add strbuf_set operations which allow this common sequence
to be performed in one line instead of two.
    
  strbuf_set(buf, cb.buf.buf, cb.buf.len);

Only the first few files have been converted in this preliminary patch set.

Jeremiah Mahler (5):
  add strbuf_set operations
  add strbuf_set operations documentation
  sha1_name.c: cleanup using strbuf_set operations
  fast-import.c: cleanup using strbuf_set operations
  builtin/remote.c: cleanup using strbuf_set operations

 Documentation/technical/api-strbuf.txt | 18 ++++++++++++
 builtin/remote.c                       | 51 ++++++++++++----------------------
 fast-import.c                          | 19 ++++---------
 sha1_name.c                            | 15 ++++------
 strbuf.c                               | 21 ++++++++++++++
 strbuf.h                               | 14 ++++++++++
 6 files changed, 81 insertions(+), 57 deletions(-)

-- 
2.0.0.573.ged771ce.dirty
