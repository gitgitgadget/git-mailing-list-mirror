From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: Re: [BUG/TEST] git-svn: fetch fails with deleted tag
Date: Wed, 11 Aug 2010 22:18:39 -0700 (PDT)
Message-ID: <765385.99383.qm@web30004.mail.mud.yahoo.com>
References: <1281159415-60900-1-git-send-email-ddkilzer@kilzer.net>
Reply-To: "David D. Kilzer" <ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	"David D. Kilzer" <ddkilzer@kilzer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 12 07:18:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjQBi-0006rh-Ef
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 07:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab0HLFSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 01:18:41 -0400
Received: from web30004.mail.mud.yahoo.com ([209.191.69.21]:27647 "HELO
	web30004.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751971Ab0HLFSk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 01:18:40 -0400
Received: (qmail 99402 invoked by uid 60001); 12 Aug 2010 05:18:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1281590319; bh=Qc+uDBchJwrqKrLz4UAvnp1X1sWOvolR9uK/LiyGXZs=; h=Message-ID:X-YMail-OSG:Received:X-RocketYMMF:X-Mailer:References:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type; b=L4CSkfmd5OMFblvPoyL3vCY6jSbAp8LmAWfgk/Q5tjhM9C3lv+lc7IYsWsr2mJLLjN3lbDkbEPGy+goSjPjxKmY3UMv+qDJKZQ6U9oHMlx+EIFB7NLoagev9BdgegaYzb0+zkGfyHT8SviXCdxASYl7acppmfbePXHa4LftmSuw=
X-YMail-OSG: VfChJiUVM1lWs_LyJfRgg8rbXif3HZoblmKv6qToHtiaqfO
 _QL.BWcSNKSnkf7X6SEv4_i8bzrIRyzkzud2yMZPRSuJm2Qr7M1WAlSWOVRG
 RAJk1Y1RK5XeuvgHtCkeqY1SrO.y5.CIvvX9uLeesqvwzYj337gc7J266HQR
 ljGbHFucWMghq4aLVkADEOFe4xtULqPFhlQDbACbL6KODCf1Yna_Q8UDqSbw
 32TtnaKVwvsegMcDp70mS91rAp.MOPbKRKhMufzH9_3paibHUlMiu4dINCeT
 rNP6lp_75sTzw30S3JJ6bcHQbHCTFar2A86.cpFggUuYA7SeZ4x3WDg--
Received: from [67.188.213.238] by web30004.mail.mud.yahoo.com via HTTP; Wed, 11 Aug 2010 22:18:39 PDT
X-RocketYMMF: ddkilzer
X-Mailer: YahooMailRC/470 YahooMailWebService/0.8.105.279950
In-Reply-To: <1281159415-60900-1-git-send-email-ddkilzer@kilzer.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153339>

On Fri, August 6, 2010 at 10:36:55 PM, David D. Kilzer wrote:

> The attached test fails when fetching the svn repo:
> 
>      Checksum mismatch: ChangeLog 065854....
>     expected:  ce771b....
>          got: 9563fd....
> 
> The issue  seems to be that the tag was created, deleted and then
> recreated from the  same source revision but at different paths.


I have a fix for this.  I hope to send it out by Friday for further review.

This bug affects svn tags that are created, deleted and recreated with the 
following criteria:

- Both tags have the same name (since the second one replaces the first one 
after it's deleted).
- Both tags were created from the same revision in the repository.
- Each tag used a different repository path, e.g., one was from trunk while the 
other was from a branch.
- [Optional] Both tags had a file with the same path name but different content.

If the optional fourth criteria is met, the checksum mismatch occurs and git-svn 
fails during import.

However, if only the first three criteria are met, git-svn actually creates a 
tag with the first (deleted) tag's content!  The second tag's content is never 
imported, leaving the user with a tag in git whose content doesn't match the 
latest tag in svn.

Dave
