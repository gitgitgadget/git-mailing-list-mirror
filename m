From: Michel Marti <mma@objectxp.com>
Subject: Re: [PATCH REPLACEMENT for 2/2] git status: show relative paths when
   run in a subdirectory
Date: Sat, 10 Nov 2007 13:08:30 +0100
Message-ID: <fh46vv$ooj$1@ger.gmane.org>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com> <Pine.LNX.4.64.0711072242230.4362@racer.site> <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com> <Pine.LNX.4.64.0711072255420.4362@racer.site> <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com> <243E1E6E-4723-42D3-933C-D2A0D1ACE287@silverinsanity.com> <ee77f5c20711071531q5acc4d06u264f5daad7c04cc4@mail.gmail.com> <Pine.LNX.4.64.0711080011170.4362@racer.site> <7v8x593zyv.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711091529570.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 13:09:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqp9A-00035e-3c
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 13:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbXKJMIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 07:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbXKJMIu
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 07:08:50 -0500
Received: from main.gmane.org ([80.91.229.2]:44039 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbXKJMIt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 07:08:49 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iqp8j-0003pu-Bf
	for git@vger.kernel.org; Sat, 10 Nov 2007 12:08:41 +0000
Received: from 84-73-13-217.dclient.hispeed.ch ([84.73.13.217])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Nov 2007 12:08:41 +0000
Received: from mma by 84-73-13-217.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Nov 2007 12:08:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 84-73-13-217.dclient.hispeed.ch
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <Pine.LNX.4.64.0711091529570.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64337>

Untracked files in the current dir don't include the relative path 
to the project-root, but changed/updated files do:

# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       new file: ../subdir/hello
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       world

With the patch below (on top of your changes), the output becomes

# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       new file: hello
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       world

Cheers,

- Michel

diff --git a/wt-status.c b/wt-status.c
index 0d25362..2cdc8ce 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -133,8 +133,8 @@ static void wt_status_print_filepair(struct wt_status *s,
 
        strbuf_init(&onebuf, 0);
        strbuf_init(&twobuf, 0);
-       one = quote_path(p->one->path, -1, &onebuf, s->prefix);
-       two = quote_path(p->two->path, -1, &twobuf, s->prefix);
+       one = quote_path(p->one->path, strlen(p->one->path), &onebuf, s->prefix);
+       two = quote_path(p->two->path, strlen(p->two->path), &twobuf, s->prefix);
 
        color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
        switch (p->status) {
@@ -233,7 +233,8 @@ static void wt_status_print_initial(struct wt_status *s)
        for (i = 0; i < active_nr; i++) {
                color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
                color_fprintf_ln(s->fp, color(WT_STATUS_UPDATED), "new file: %s",
-                               quote_path(active_cache[i]->name, -1,
+                               quote_path(active_cache[i]->name,
+                                       strlen(active_cache[i]->name),
                                           &buf, s->prefix));
        }
        if (active_nr)
