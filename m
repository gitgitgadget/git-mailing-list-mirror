From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/3 v3] Make git builtins not link against libcurl
Date: Fri, 31 Jul 2009 01:26:35 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907310054570.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 07:26:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWkdg-0001ud-DK
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 07:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbZGaF0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 01:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbZGaF0g
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 01:26:36 -0400
Received: from iabervon.org ([66.92.72.58]:54988 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbZGaF0g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 01:26:36 -0400
Received: (qmail 5889 invoked by uid 1000); 31 Jul 2009 05:26:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Jul 2009 05:26:35 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124501>

This series makes the main git executable not link against libcurl, which 
greatly improves performance of running large numbers of simple git 
commands on systems where libcurl in turn links against complex libraries.

This version makes the helper program interface more extensible, allowing 
it to not support the native-object "fetch" command, and requiring it to 
support a "capabilities" command that the transport code can call to find 
out what is supported.

It also makes the transport code call git-remote-<method> for suitable URL 
methods; future work could make transport.c not have to know about 
particular helpers at all, although this requires futher infrastructure 
beyond the scope of this series to do without regressing useability.

I believe it addresses all of the review comments, except for those 
pertaining to future directions; I believe this version supports 
extensibility in the relevant ways, so the details are outside the scope 
of this series.

Daniel Barkalow (3):
  Add support for external programs for handling native fetches
  Use an external program to implement fetching with curl

Linus Torvalds (1):
  git-http-fetch: not a builtin

 Documentation/git-remote-helpers.txt |   72 +++++++++++++++
 Makefile                             |   16 +++-
 git.c                                |    3 -
 builtin-http-fetch.c => http-fetch.c |    5 +-
 remote-curl.c                        |  139 ++++++++++++++++++++++++++++
 transport-helper.c                   |  168 ++++++++++++++++++++++++++++++++++
 transport.c                          |  136 +---------------------------
 transport.h                          |    3 +
 8 files changed, 399 insertions(+), 143 deletions(-)
 create mode 100644 Documentation/git-remote-helpers.txt
 rename builtin-http-fetch.c => http-fetch.c (95%)
 create mode 100644 remote-curl.c
 create mode 100644 transport-helper.c
