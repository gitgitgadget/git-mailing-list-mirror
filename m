X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eran Tromer <git2eran@tromer.org>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 04:42:13 +0200
Message-ID: <45417205.6020805@tromer.org>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610261105200.12418@xanadu.home> <45413209.2000905@tromer.org> <Pine.LNX.4.64.0610262038320.11384@xanadu.home> <20061027014229.GA28407@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 02:43:50 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060913 Fedora/1.5.0.7-1.fc5 Thunderbird/1.5.0.7 Mnenhy/0.7.4.0
In-Reply-To: <20061027014229.GA28407@spearce.org>
X-Enigmail-Version: 0.94.1.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30282>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdHh7-000717-7i for gcvg-git@gmane.org; Fri, 27 Oct
 2006 04:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946132AbWJ0CnL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 22:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946117AbWJ0CnL
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 22:43:11 -0400
Received: from line108-16.adsl.actcom.co.il ([192.117.108.16]:17627 "EHLO
 lucian.tromer.org") by vger.kernel.org with ESMTP id S1946132AbWJ0CnJ (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 22:43:09 -0400
Received: from [192.168.4.6] ([192.168.4.6]) by lucian.tromer.org
 (8.13.7/8.12.11) with ESMTP id k9R2gUeY030415; Fri, 27 Oct 2006 04:42:36
 +0200
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On 2006-10-27 03:42, Shawn Pearce wrote:
> Nicolas Pitre <nico@cam.org> wrote:
>> On Fri, 27 Oct 2006, Eran Tromer wrote:
>> Well, the race does exist.  Don't do repack -a -d at the same time then.
> 
> This is an issue for "central" repositories that people push into
> and which might be getting repacked according to a cronjob.

AFAICT, the bottom line of the "Re: auto-packing on kernel.org? please?"
thread last October was "sure, go ahead".


> Unfortunately I don't have a solution.  I tried to come up with
> one but didn't.  :-)

Here's one way to do it.
Change git-repack to follow references under $GIT_DIR/tmp/refs/ too.
To receive or fetch a pack:
1. Add references to the new heads in
   `mktemp $GIT_DIR/tmp/refs/XXXXXX`.
2. Put the new .pack under $GIT_DIR/objects/pack/.
3. Put the new .idx under $GIT_DIR/objects/pack/.
4. Update the relevant heads under $GIT_DIR/refs/.
5. Delete the references from step 1.

This is repack-safe and never corrupts the repo. The worst-case failure
mode is if you die before cleaning the refs from $GIT_DIR/tmp/refs. That
may mean some packed objects will never be removed by "repack -a -d"
even if they lose all references from $GIT_DIR/refs, so do "tmpwatch -m
240 $GIT_DIR/tmp/refs" to take care of that.

  Eran
