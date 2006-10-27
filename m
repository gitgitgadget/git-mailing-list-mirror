X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eran Tromer <git2eran@tromer.org>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 06:03:23 +0200
Message-ID: <4541850B.8060608@tromer.org>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610261105200.12418@xanadu.home> <45413209.2000905@tromer.org> <Pine.LNX.4.64.0610262038320.11384@xanadu.home> <20061027014229.GA28407@spearce.org> <45417205.6020805@tromer.org> <20061027030054.GB28407@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 04:04:40 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060913 Fedora/1.5.0.7-1.fc5 Thunderbird/1.5.0.7 Mnenhy/0.7.4.0
In-Reply-To: <20061027030054.GB28407@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30287>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdIxG-00080I-Pt for gcvg-git@gmane.org; Fri, 27 Oct
 2006 06:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161484AbWJ0EEV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 00:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423484AbWJ0EEV
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 00:04:21 -0400
Received: from line108-16.adsl.actcom.co.il ([192.117.108.16]:17538 "EHLO
 lucian.tromer.org") by vger.kernel.org with ESMTP id S1161485AbWJ0EEU (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 00:04:20 -0400
Received: from [192.168.4.6] ([192.168.4.6]) by lucian.tromer.org
 (8.13.7/8.12.11) with ESMTP id k9R43cvo031074; Fri, 27 Oct 2006 06:03:39
 +0200
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Hi,

On 2006-10-27 05:00, Shawn Pearce wrote:
>> Change git-repack to follow references under $GIT_DIR/tmp/refs/ too.
>> To receive or fetch a pack:
>> 1. Add references to the new heads in
>>    `mktemp $GIT_DIR/tmp/refs/XXXXXX`.
>> 2. Put the new .pack under $GIT_DIR/objects/pack/.
>> 3. Put the new .idx under $GIT_DIR/objects/pack/.
>> 4. Update the relevant heads under $GIT_DIR/refs/.
>> 5. Delete the references from step 1.

> That was actually my (and also Sean's) solution.  Except I would
> put the temporary refs as "$GIT_DIR/refs/ref_XXXXXX" as this is
> less code to change and its consistent with how temporary loose
> objects are created.

If you do that, other programs (e.g., anyone who uses rev-list --all)
may try to walk those heads or consider them available before the pack
is really there. The point about $GIT_DIR/tmp/refs is that only programs
meddling with physical packs (git-fetch, git-receive-pack, git-repack)
will know about it.


> What happens when the incoming pack (steps #2 and #3) takes 15
> minutes to upload (slow ADSL modem, lots of objects) and the
> background repack process sees those temporary refs and starts
> trying to include those objects?  It can't walk the DAG that those
> refs point at because the objects aren't in the current repository.
> 
>>From what I know of that code the pack-objects process will fail to
> find the object pointed at by the ref, rescan the packs directory,
> find no new packs, look for the object again, and abort over the
> "corruption".

Good point. Then I guess we'll need to change git-repack to ignore
missing objects if they're referenced from $GIT_DIR/tmp/refs but not
from $GIT_DIR/refs. Ugly, but shouldn't be too hard.


