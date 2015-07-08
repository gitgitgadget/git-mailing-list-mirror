From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Since gc.autodetach=1 you can end up with auto-gc on every command
 with no user notification
Date: Wed, 8 Jul 2015 14:28:25 +0200
Message-ID: <CACBZZX5hUr8TMRXYWRqdb1AQ=oOBpEFuoMwYHczPdHN82ceuTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 08 14:29:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCoTM-0007nx-4x
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 14:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932964AbbGHM2u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 08:28:50 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:34215 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932944AbbGHM2p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2015 08:28:45 -0400
Received: by obbkm3 with SMTP id km3so149077126obb.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 05:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=NV6/vEpLvqruUazvAPzMHI92EgN2t49yFL+S20fk7go=;
        b=V10lthU9ID/2zBSl6+qtDxQBU2HVmC+529q1+xXR/bzidi4U8Jf6CVVgB5sfHhUSrE
         HeLzq3HKW3/IIxXpB2fTtyz33HdXHl2EFaOlAV9AeN9hYXx6COXqU6rlDv5NgCDBuEI+
         PBTdxROPLXdaJPVnCI6GvAzDTHLwH2vEJOds+55sXLFBr0wlgrxQp/sc9FIvgpK2OkZA
         eSYS3FFDFC9NxqcBBLwbwnVboFuTCZilAR1XVUA3V88oLxKO4MJNUIZ/yAnOqVewdCcb
         xquSIJu1hLU8nHcENos77v49tQYxInyIXgCBAYRfgw9uK7mjS5kQfuZ00gGItbR9DyoY
         GZ1g==
X-Received: by 10.202.218.132 with SMTP id r126mr8823954oig.69.1436358524681;
 Wed, 08 Jul 2015 05:28:44 -0700 (PDT)
Received: by 10.76.7.206 with HTTP; Wed, 8 Jul 2015 05:28:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273677>

Someone at work came to me with the problem that they were getting the
"Auto packing the repository in background for optimum performance"
notice on every Git command that they ran.

This problem is a combination of two things:

 * Since Nguy=E1=BB=85n's v1.9-rc0-2-g9f673f9 where we started running =
"git
gc" in the background the user hasn't seen the "There are too many
unreachable loose objects" message added back in v1.5.3.1-27-ga087cc9

 * The checkout has a lot of loose objects. So even after "git prune
--expire=3D2.week.ago" the .git/objects/17 directory has 317 objects.
More than 27 in that directory trigger "git gc --auto".

So it's partly a UI issue. Since the repacking is happening in the
background the user never sees the message suggesting that they run
"git prune".

But perhaps the heuristic of "are there more than 27 objects in
=2Egit/objects/17" could be improved, but I don't know with what
exactly.

But having something fork a gc to the background on every fetch (and
similar object-modifying operations) is quite sub-optimal.
