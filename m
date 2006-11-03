X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git bug? + question
Date: Fri, 3 Nov 2006 20:06:26 +0100
Message-ID: <200611032006.26337.Josef.Weidendorfer@gmx.de>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <200611031815.49553.Josef.Weidendorfer@gmx.de> <eiftb1$ild$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 18:35:02 +0000 (UTC)
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.3
In-Reply-To: <eiftb1$ild$1@sea.gmane.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30871>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg3sJ-0003yg-OK for gcvg-git@gmane.org; Fri, 03 Nov
 2006 19:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753435AbWKCSea (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 13:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753433AbWKCSea
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 13:34:30 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:59834 "EHLO
 tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP id
 S1753435AbWKCSea (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006
 13:34:30 -0500
Received: from dhcp-3s-57.lrr.in.tum.de (dhcp-3s-57.lrr.in.tum.de
 [131.159.35.57]) by mail.in.tum.de (Postfix) with ESMTP id 0E61F27FB; Fri,  3
 Nov 2006 19:33:26 +0100 (MET)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Friday 03 November 2006 18:13, Jakub Narebski wrote:
> Josef Weidendorfer wrote:
> 
> > Other option: Introduce "fetchonly" line which ignores the original
> > fetch lines in the remote section.
> 
> I like this.

That's implementing it:

=================================
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -156,6 +156,18 @@ canon_refs_list_for_fetch () {

 # Returns list of src: (no store), or src:dst (store)
 get_remote_default_refs_for_fetch () {
+       # if there are any branch.${curr_branch}.fetchonly entries,
+       # only use them as default
+       curr_branch=$(git-symbolic-ref HEAD | \
+               sed -e 's|^refs/heads/||')
+       fetchonly_branches=$(git-repo-config \
+               --get-all "branch.${curr_branch}.fetchonly")
+       if test ! -z $fetchonly_branches
+       then
+               canon_refs_list_for_fetch -d "$1" $fetchonly_branches
+               return
+       fi
+
        data_source=$(get_data_source "$1")
        case "$data_source" in
        '' | config-partial | branches-partial)
=================================

The problem with this small patch is that with

       [remote."gitster"]
               url = gitster.example.com:/home/junio/git.git/
               fetch = heads/master:remotes/gitster/master
               fetch = heads/next:remotes/gitster/next
       [branch."master"]
               remote = gitster
               fetchonly = heads/master:remotes/gitster/master
               merge = remotes/gitster/master

and current branch "master", even "git fetch gitster" does not
fetch both branches, which is expected IMHO. We would need to
pass the info that an explicit repository was given down to
get_remote_default_refs_for_fetch().

