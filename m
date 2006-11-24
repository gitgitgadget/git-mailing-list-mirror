X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Salikh Zakirov <salikh@gmail.com>
Subject: Re: [PATCH] Make git-clone --use-separate-remote the default
Date: Sat, 25 Nov 2006 02:28:02 +0300
Message-ID: <ek7v61$k89$1@sea.gmane.org>
References: <20061123225835.30071.99265.stgit@machine.or.cz>	<7vejrtiwqd.fsf@assigned-by-dhcp.cox.net>	<20061123234203.GN7201@pasky.or.cz>	<7vlkm1hf57.fsf@assigned-by-dhcp.cox.net>	<7vzmahe6qe.fsf@assigned-by-dhcp.cox.net>	<7vpsbde4fy.fsf@assigned-by-dhcp.cox.net> <ek6glc$pn$1@sea.gmane.org> <7vslg9axzv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 24 Nov 2006 23:45:23 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 48
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 466.dialup.orc.ru
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <7vslg9axzv.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32246>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnkjO-0004mI-7I for gcvg-git@gmane.org; Sat, 25 Nov
 2006 00:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933777AbWKXXpI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 18:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934190AbWKXXpH
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 18:45:07 -0500
Received: from main.gmane.org ([80.91.229.2]:27858 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S933777AbWKXXpE (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 18:45:04 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1Gnkj8-0004jh-B8 for git@vger.kernel.org; Sat, 25 Nov 2006 00:45:02 +0100
Received: from 466.dialup.orc.ru ([212.48.131.210]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Sat, 25 Nov 2006 00:45:02 +0100
Received: from salikh by 466.dialup.orc.ru with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 25 Nov 2006 00:45:02
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> The way this command:
> 
> 	git push $remote $src:$dst
> 
> is handled is:
> 
>  (0) send-pack gets ls-remote equivalent from the remote.  This
>      tells us the set of refs the remote has and the value of
>      each of them.
> 
>  (1) $src can be a ref that is resolved locally the usual way.
>      You could have any valid SHA-1 expression (e.g. HEAD~6).

>  (2) $dst is compared with the list of refs that the remote
>      has, and unique match is found.

I think that remote matching semantics is confusing, and the following change
would make understanding easier.

I was understanding the manual incorrectly for a long time until you've
explained its true meaning today (thanks!).

As a side effect, making 'git push repo master' unambiguously expanded
to 'git push repo refs/heads/master:refs/heads/master' will make
the syntax 'git push repo tag v1' unneeded at all, because it would be
exactly the same as 'git push repo v1'
(expanded to 'git push repo refs/tags/v1:refs/tags/v1').

--- connect.c
+++ connect.c
@@ -277,6 +277,16 @@ static int match_explicit_refs(struct re
                              rs[i].src);
                        break;
                }
+               if (!strcmp(rs[i].src,rs[i].dst)) {
+                       /* src refspec is the same as dst,
+                        * take the remote refpath exactly the same
+                        * as existing local reference
+                        */
+                       int len = strlen(matched_src->name) + 1;
+                       matched_dst = xcalloc(1, sizeof(*dst) + len);
+                       memcpy(matched_dst->name, matched_src->name, len);
+                       link_dst_tail(matched_dst, dst_tail);
+               } else
                switch (count_refspec_match(rs[i].dst, dst, &matched_dst)) {
                case 1:
                        break;
