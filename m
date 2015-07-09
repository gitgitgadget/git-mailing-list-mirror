From: Mike Hommey <mh@glandium.org>
Subject: Re: suboptimal behavior of fast-import in some cases with "from"
Date: Thu, 9 Jul 2015 14:03:15 +0900
Message-ID: <20150709050314.GA6013@glandium.org>
References: <20150706220746.GA29367@glandium.org>
 <xmqq4mlgzyl0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 07:03:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZD3zZ-0000xi-Hy
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 07:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbbGIFDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 01:03:22 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:38996 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326AbbGIFDU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 01:03:20 -0400
Received: from glandium by zenigata with local (Exim 4.86_RC4)
	(envelope-from <glandium@glandium.org>)
	id 1ZD3zP-0001fI-18; Thu, 09 Jul 2015 14:03:15 +0900
Content-Disposition: inline
In-Reply-To: <xmqq4mlgzyl0.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273722>

On Mon, Jul 06, 2015 at 03:54:35PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > One of the first things parse_from does is unconditionally throw away
> > the tree for the given branch, and then the "from" tree is loaded. So
> > when the "from" commit is the current head of the branch, that make
> > fast-import do more work than necessary.
> 
> If it is very common that the next commit the input stream wants to
> create is often on top of the commit that was just created, and if
> it is very common that the input stream producer knows what the
> commit object name of the commit that was just created, then
> optimising for that case does not sound too bad.  It really depends
> on two factors:
> 
>  - How likely is it that other people make the same mistake?

Looks like the answer is: very. Assuming my quick glance at the code is
not mistaken, the same mistake is made in at least git-p4.py (yes, the
one that comes with git), felipec's git-remote-hg, and hg-fast-export,
and that's 100% of the sample I looked at.

I won't claim to know what fast-import is doing, not having looked at
more than the parse_from* functions and the commit message for 4cabf858,
but it seems plausible this also skips making tree deltas for those
trees.

>  - How bad the damage to parse_from() would be if we wanted to
>    optimize for this case?

I /think/ it would look like this (untested), which doesn't seem too
damaging:

diff --git a/fast-import.c b/fast-import.c
index e78ca10..cb232e0 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2588,14 +2588,12 @@ static int parse_from(struct branch *b)
 {
        const char *from;
        struct branch *s;
+       unsigned char sha1[20];
 
        if (!skip_prefix(command_buf.buf, "from ", &from))
                return 0;
 
-       if (b->branch_tree.tree) {
-               release_tree_content_recursive(b->branch_tree.tree);
-               b->branch_tree.tree = NULL;
-       }
+       hashcpy(sha1, b->branch_tree.versions[1].sha1);
 
        s = lookup_branch(from);
        if (b == s)
@@ -2626,6 +2624,11 @@ static int parse_from(struct branch *b)
        else
                die("Invalid ref name or SHA1 expression: %s", from);
 
+       if (b->branch_tree.tree && hashcmp(sha1, b->branch_tree.versions[1].sha1)) {
+               release_tree_content_recursive(b->branch_tree.tree);
+               b->branch_tree.tree = NULL;
+       }
+
        read_next_command();
        return 1;
 }

Mike
