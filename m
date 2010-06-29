From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/5] merge_recursive: Fix renames across paths below D/F 
	conflicts
Date: Tue, 29 Jun 2010 09:55:38 -0600
Message-ID: <AANLkTilggM9-vBabNvJiYMiQZyZtJMLhfWleYKvuJNMv@mail.gmail.com>
References: <1277773936-12412-1-git-send-email-newren@gmail.com>
	<1277773936-12412-5-git-send-email-newren@gmail.com>
	<20100629075442.GB31048@genesis.frugalware.org>
	<AANLkTimFBlWiK76quLW1TiUfueGISsW7ZIHgFUcFg4j8@mail.gmail.com>
	<AANLkTil7CdCoP3wLVKX0MEiwp8KaKWFLvRtUWzt2a3Nh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, gitster@pobox.com, spearce@spearce.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 17:55:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTdA6-0005yT-4g
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 17:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071Ab0F2Pzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 11:55:42 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55241 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756608Ab0F2Pzl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jun 2010 11:55:41 -0400
Received: by gwaa18 with SMTP id a18so2547315gwa.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 08:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2g6I0lvPGomQoQGyWloJICwXH8bbwFizKARhHQy3yo0=;
        b=QgkaAeYui7JypxXl8OaDe7o1R60HzJlBp3wPyJUwcev+A7yrMEBg1ZnDKLMtjc4IUC
         DmZewVaUJQN1jyZIc4fBxsE4Sm1R0HnVtzXOj+6EhCHCh/c2g4WQ+OqI9QdtoBiIf4JW
         ry+Kv6/pgjZeYHeUcSMjjOw7vLRXuZkh1zHaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lOyj0lM7mxG2FZjsvhAOOTRVCm+sSZcmkBGuRNTQpDfOd4UhmiaxueDRv2hEpstyK5
         FYJvpTLkeMhOz15152xrYY2zLjXFlUJPz73rbrbngMVMcCYJdtNz+IGZRybLGKf6KFpD
         WCLYLCSZE3AKaNrmC8GAwgEYD3rS30tc99ytc=
Received: by 10.102.16.36 with SMTP id 36mr2110802mup.124.1277826938544; Tue, 
	29 Jun 2010 08:55:38 -0700 (PDT)
Received: by 10.220.83.138 with HTTP; Tue, 29 Jun 2010 08:55:38 -0700 (PDT)
In-Reply-To: <AANLkTil7CdCoP3wLVKX0MEiwp8KaKWFLvRtUWzt2a3Nh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149911>

On Tue, Jun 29, 2010 at 7:36 AM, Alex Riesen <raa.lkml@gmail.com> wrote=
:
> On Tue, Jun 29, 2010 at 14:52, Elijah Newren <newren@gmail.com> wrote=
:
>> Alex: I think the basic idea is just that the rename logic isn't awa=
re
>> that there may be higher stage entries in the index due to D/F
>> conflicts; by checking for such cases and marking the entry as not
>> processed, it allows process_entry() later to look at it and handle
>> those higher stages. =C2=A0But I'm not sure if that's the right way =
to
>> handle it, or if just having process_renames() should take care of
>> clearing out the higher stage entries, or if something else entirely
>> should be done.
>
> Nor am I. You may be still off by some commits in detecting the autho=
rship :)
> This code was seldom touched since it was written (by Johannes). It h=
as
> survived in this sorry state all (at least my) attempts to fix it. OT=
OH I never
> tried really hard. Maybe because the D/F conflicts are rare and are r=
elatively
> simple to work around.
>
> I cannot say much about your change... Are you sure about D/F conflic=
t
> detection, though? You just test if target mode not 0.

Well, as far as this particular if-block is concerned, blame suggests
that you and Miklos were responsible (I apologize if gmail screws up
and inserts line wrapping)::

$ git blame -C -C -L 1020,1038 merge-recursive.c
9047ebbc (Miklos Vajna  2008-08-12 18:45:14 +0200 1020)
                 if (mfi.clean &&
9047ebbc (Miklos Vajna  2008-08-12 18:45:14 +0200 1021)
                     sha_eq(mfi.sha, ren1->pair->two->sha1) &&
de4d7dc3 (Elijah Newren 2010-06-28 09:38:58 -0600 1022)
                     mfi.mode =3D=3D ren1->pair->two->mode) {
8a359819 (Alex Riesen   2007-04-25 22:07:45 +0200 1023)
                         /*
8a359819 (Alex Riesen   2007-04-25 22:07:45 +0200 1024)
                          * This messaged is part of
8a359819 (Alex Riesen   2007-04-25 22:07:45 +0200 1025)
                          * t6022 test. If you change
8a359819 (Alex Riesen   2007-04-25 22:07:45 +0200 1026)
                          * it update the test too.
8a359819 (Alex Riesen   2007-04-25 22:07:45 +0200 1027)
                          */
8a2fce18 (Miklos Vajna  2008-08-25 16:25:57 +0200 1028)
                         output(o, 3, "Skipped %s (merged same as
existing)", ren1_
de4d7dc3 (Elijah Newren 2010-06-28 09:38:58 -0600 1029)
de4d7dc3 (Elijah Newren 2010-06-28 09:38:58 -0600 1030)
                         /* If this was a rename across a path
involved
de4d7dc3 (Elijah Newren 2010-06-28 09:38:58 -0600 1031)
                          * in a D/F conflict, there may be more work
to
de4d7dc3 (Elijah Newren 2010-06-28 09:38:58 -0600 1032)
                          * do.
de4d7dc3 (Elijah Newren 2010-06-28 09:38:58 -0600 1033)
                          */
de4d7dc3 (Elijah Newren 2010-06-28 09:38:58 -0600 1034)
                         for (i=3D1; i<=3D3; ++i) {
de4d7dc3 (Elijah Newren 2010-06-28 09:38:58 -0600 1035)
                                 if (ren1->dst_entry->stages[i].mode)
de4d7dc3 (Elijah Newren 2010-06-28 09:38:58 -0600 1036)
                                         ren1->dst_entry->processed =3D
0;
de4d7dc3 (Elijah Newren 2010-06-28 09:38:58 -0600 1037)
                         }
de4d7dc3 (Elijah Newren 2010-06-28 09:38:58 -0600 1038)
                 } else {

With D/F conflicts, the files would be loaded into higher stages in
the index (before it gets to process_renames()), which I detected via
a non-zero mode.  If there's a different way I should be checking for
higher stage entries that still need to be resolved, I'd be happy to
use it.
