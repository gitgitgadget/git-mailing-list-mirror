From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/8] Add function strbuf_addstr_xml_quoted() and more
Date: Sun, 25 Nov 2012 12:08:33 +0100
Message-ID: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 12:09:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tca5Z-00048V-D6
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 12:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117Ab2KYLJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 06:09:09 -0500
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:64603 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753087Ab2KYLJH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Nov 2012 06:09:07 -0500
X-AuditID: 1207440e-b7f036d0000008b5-fd-50b1fc5215ed
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id B5.55.02229.25CF1B05; Sun, 25 Nov 2012 06:09:06 -0500 (EST)
Received: from michael.fritz.box (p57A25314.dip.t-dialin.net [87.162.83.20])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qAPB90UC002898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 25 Nov 2012 06:09:04 -0500
X-Mailer: git-send-email 1.8.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsUixO6iqBv0Z2OAwed5WhZdV7qZLBp6rzBb
	9C/vYrO4fHIuo8XtFfOZHVg9/r7/wOTx5Wojk8eHj3EeFy8pe3zeJBfAGsVtk5RYUhacmZ6n
	b5fAnbHwTnRBH3fFuolLmBsY/3B0MXJySAiYSDw+vJwVwhaTuHBvPRuILSRwmVFi4dNKCPsM
	k0TbZ7AaNgFdiUU9zUwgtoiAmsTEtkMsXYxcHMwCqxklJm85zw6SEBZwlZh8dxsLiM0ioCox
	e/lBZhCbV8BFonPPBBaIZXISH/Y8Yp/AyL2AkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6x
	Xm5miV5qSukmRkh48O1gbF8vc4hRgINRiYf3VuLGACHWxLLiytxDjJIcTEqivHO/AoX4kvJT
	KjMSizPii0pzUosPMUpwMCuJ8IY+A8rxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphak
	FsFkZTg4lCR4238DNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDwjy+GBjoICke
	oL3zQdp5iwsSc4GiEK2nGHU55sxsf8IoxJKXn5cqJc5bD1IkAFKUUZoHtwKWDF4xigN9LMy7
	FqSKB5hI4Ca9AlrCBLQk+TrYkpJEhJRUAyOz/93IdTw9W4sE+d+XHKhUfntlxqqtF09dPS7l
	8IoxzaZrfeE1g1bmReqFT3dHlLbz8/qEZ8bf1zB1Zy9uCQlIf8SrfmMhmw1LyUTb6Ss6xLUE
	JnDfZdB62q71+uD7f0uli3nYvC89fHY0N6h7gmPisz+ni/dbxWZNOvaLi/HCp6ZF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210355>

There were two functions doing almost the same XML quoting of
character entities, so implement a library function
strbuf_addstr_xml_quoted() and use that in both places.

Along the way, do a lot of simplification within imap-send.c, which
was doing a lot of its own string management instead of using strbuf.

Please note that "git imap-send" is utterly absent from the test
suite, probably due to the difficulty of testing without a real IMAP
server.  I ran some manual tests after my changes and didn't find any
problems.

The bug that I reported on 2012-11-12, namely that

    git format-patch --signoff --stdout --attach origin | git imap-send

is broken, is not addressed by these patches.

Michael Haggerty (8):
  Add new function strbuf_add_xml_quoted()
  xml_entities(): use function strbuf_addstr_xml_quoted()
  lf_to_crlf(): NUL-terminate msg_data::data
  imap-send: store all_msgs as a strbuf
  imap-send: correctly report errors reading from stdin
  imap-send: change msg_data from storing (char *, len) to storing
    strbuf
  wrap_in_html(): use strbuf_addstr_xml_quoted()
  wrap_in_html(): process message in bulk rather than line-by-line

 http-push.c |  23 +--------
 imap-send.c | 157 +++++++++++++++++++++++++++---------------------------------
 strbuf.c    |  26 ++++++++++
 strbuf.h    |   6 +++
 4 files changed, 104 insertions(+), 108 deletions(-)

-- 
1.8.0
