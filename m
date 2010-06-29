From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 4/5] merge_recursive: Fix renames across paths below D/F 
	conflicts
Date: Tue, 29 Jun 2010 15:36:58 +0200
Message-ID: <AANLkTil7CdCoP3wLVKX0MEiwp8KaKWFLvRtUWzt2a3Nh@mail.gmail.com>
References: <1277773936-12412-1-git-send-email-newren@gmail.com>
	<1277773936-12412-5-git-send-email-newren@gmail.com>
	<20100629075442.GB31048@genesis.frugalware.org>
	<AANLkTimFBlWiK76quLW1TiUfueGISsW7ZIHgFUcFg4j8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, gitster@pobox.com, spearce@spearce.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 15:37:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTazs-0004uV-NF
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 15:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665Ab0F2NhB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 09:37:01 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42164 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988Ab0F2NhA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jun 2010 09:37:00 -0400
Received: by ewy23 with SMTP id 23so335497ewy.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 06:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qSgSmq9IN6QH/1eH/TwlbQWJM78AFVUZ2rwV1U/YqOg=;
        b=E8dPIAYmoEvO6KfgOVDGBD/wJnjulwsYftFFLhXngvZsn7tuaHYgXlW1gZKMkX00tU
         aEJoZHRaOArpbjW1/mPMncLsRFO30m7EiqIEEqkQoQtrOrMSLHioAIFCaBJczOvxW0z1
         XHge/oavUpf68LYq8/W8WEEHuAubDleDT0Yt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ES3X86CGA8sXhPw2jwoH8RmaRkXT9Wz+L9Hh3HDViKsNm+k09tAljxAoePLUxKS8va
         V69e5lKPWmAjC6GTjEwnTFXAF1VWe7/jqHtrlHZ23JkOFyOEfuXy31eFNm4kBTDf9sYA
         zQycezAbv//404/j4ayrdHjmJ8zGda0QF+c/A=
Received: by 10.213.33.199 with SMTP id i7mr2281591ebd.65.1277818618276; Tue, 
	29 Jun 2010 06:36:58 -0700 (PDT)
Received: by 10.213.105.148 with HTTP; Tue, 29 Jun 2010 06:36:58 -0700 (PDT)
In-Reply-To: <AANLkTimFBlWiK76quLW1TiUfueGISsW7ZIHgFUcFg4j8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149905>

On Tue, Jun 29, 2010 at 14:52, Elijah Newren <newren@gmail.com> wrote:
> On Tue, Jun 29, 2010 at 1:54 AM, Miklos Vajna <vmiklos@frugalware.org=
> wrote:
>> On Mon, Jun 28, 2010 at 07:12:15PM -0600, newren@gmail.com wrote:
>>> I'm a little uneasy with this change, mainly because I don't fully
>>> understand the rename processing logic (I was actually kind of surp=
rised
>>> when I made these changes and it worked). =C2=A0Although I verified=
 that
>>> these changes (and my others in this patch series) introduce no new
>>> breakages in the testsuite and even fix a known issue, I'm still no=
t
>>> quite sure I follow the logic well enough to feel fully confident i=
n
>>> this change. =C2=A0I'm particularly worried I may have neglected so=
me closely
>>> related cases that I should have fixed but which may still be broke=
n.
>
> Alex: I think the basic idea is just that the rename logic isn't awar=
e
> that there may be higher stage entries in the index due to D/F
> conflicts; by checking for such cases and marking the entry as not
> processed, it allows process_entry() later to look at it and handle
> those higher stages. =C2=A0But I'm not sure if that's the right way t=
o
> handle it, or if just having process_renames() should take care of
> clearing out the higher stage entries, or if something else entirely
> should be done.

Nor am I. You may be still off by some commits in detecting the authors=
hip :)
This code was seldom touched since it was written (by Johannes). It has
survived in this sorry state all (at least my) attempts to fix it. OTOH=
 I never
tried really hard. Maybe because the D/F conflicts are rare and are rel=
atively
simple to work around.

I cannot say much about your change... Are you sure about D/F conflict
detection, though? You just test if target mode not 0.
