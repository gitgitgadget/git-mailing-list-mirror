X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3] gitweb: Better symbolic link support in "tree" view
Date: Sun, 10 Dec 2006 13:25:44 +0100
Message-ID: <11657535491406-git-send-email-jnareb@gmail.com>
References: <7vk616ezu5.fsf@assigned-by-dhcp.cox.net>
NNTP-Posting-Date: Sun, 10 Dec 2006 12:24:11 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=guC/jJ+enSswaLBIKi0doQEjMaUPmIgVEye1ddNaGaP6QQumYd1znks+ykBeny6Hoo4bSKchaz5yvfVSX1+P+TSdx69ZUSuVLS4kI3b8zlPixb4QOXV7DU/W2JQG0gWqt6ncqVJ91keuKgRZu0RyDOlbniK7FQ4GdgXHQ/ketDI=
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <7vk616ezu5.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33879>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtNiy-0001ks-EQ for gcvg-git@gmane.org; Sun, 10 Dec
 2006 13:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757574AbWLJMYF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 07:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758430AbWLJMYF
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 07:24:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:22549 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1757574AbWLJMYC (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 07:24:02 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1088384uga for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 04:24:01 -0800 (PST)
Received: by 10.67.117.18 with SMTP id u18mr8208861ugm.1165753441410; Sun, 10
 Dec 2006 04:24:01 -0800 (PST)
Received: from roke.D-201 ( [81.190.25.107]) by mx.google.com with ESMTP id
 x26sm4437169ugc.2006.12.10.04.24.00; Sun, 10 Dec 2006 04:24:01 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kBACPqe0025870; Sun, 10 Dec 2006 13:25:58 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kBACPon4025869; Sun, 10 Dec 2006 13:25:50 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote in
"Re: [PATCH] gitweb: Better symbolic link support in "tree" view":

> If you wanted to do this, a better way would be to have a new
> view that takes a commit/tree object and a path from the top of
> the repository, and shows either "no such path in that tree" or
> "here is the view for that object, by the way it was a blob."
> page.  Then your list drawing would still need to open each
> symlink blob to show " -> link_target", and need to check if it
> goes outside the repository (I would assume you are handling
> relative links as well), but you do not need to do expensive
> ls-tree step one per symlink on the page.  The href attr of the
> A element " -> link_target" would point at that "universal
> object view" with the link_target pathname (that is, the blob
> contents) and the commit/tree object name (h or hb I do not know
> which) and you will spend cycles to run ls-tree only when the
> user actually asks to follow that link.
> 
> In other words, I think trying to be lazy is extremely important
> while drawing a big list.

I not necessarily agree; I think that symbolic links are sufficnetly
rare that a bit more time spent to make the view better for end user
(link only if target exists) is worth it. But...

Here follows the implementation of this idea: first to read link
target and show it in "tree" view _without_ hyperlink, then
introduction of generic "object" view which does the verification and
redirect to correct view accorting to the type of object, and last
show link target hyperlinked in "tree" view using "object" view/action
link.

While at it implement the same "lazy" solution in commitsha1 commitag
in format_log_line_html subroutine.

Table of contents:
 [PATCH 1/3] gitweb: Show target of symbolic link in "tree" view
 [PATCH 2/3] gitweb: Add generic git_object subroutine to display object of any type
 [PATCH 3/3] gitweb: Hyperlink target of symbolic link in "tree" view (if possible)
 [PATCH/RFC 4/3] gitweb: SHA-1 in commit log message links to "object" view

Diffstat:
 gitweb/gitweb.perl |  152 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 137 insertions(+), 15 deletions(-)

-- 
Jakub Narebski
ShadeHawk on #git
