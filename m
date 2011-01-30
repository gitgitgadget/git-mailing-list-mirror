From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Add --create-cache to repack
Date: Sun, 30 Jan 2011 14:13:45 -0800
Message-ID: <AANLkTin6dcfMAD1tg+ROujy-_Dvi6KG-+-nfgG44u=Mh@mail.gmail.com>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net> <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
 <alpine.LFD.2.00.1101281304270.8580@xanadu.home> <AANLkTikPcp5CUTWfhy6FYbCEkNG6epGBAMNT5vTfSbvy@mail.gmail.com>
 <alpine.LFD.2.00.1101281502170.8580@xanadu.home> <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	John Hawley <warthog19@eaglescrag.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Jan 30 23:14:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjfXN-00072h-Rh
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 23:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978Ab1A3WOI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jan 2011 17:14:08 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63634 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab1A3WOH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jan 2011 17:14:07 -0500
Received: by fxm20 with SMTP id 20so5024453fxm.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 14:14:06 -0800 (PST)
Received: by 10.103.246.14 with SMTP id y14mr1954995mur.77.1296425645873; Sun,
 30 Jan 2011 14:14:05 -0800 (PST)
Received: by 10.103.1.2 with HTTP; Sun, 30 Jan 2011 14:13:45 -0800 (PST)
In-Reply-To: <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165706>

On Fri, Jan 28, 2011 at 17:32, Shawn Pearce <spearce@spearce.org> wrote=
:
>
> I fully implemented the reuse of a cached pack behind a thin pack ide=
a
> I was trying to describe in this thread. =A0It saved 1m7s off the JGi=
t
> running time, but increased the data transfer by 25 MiB. =A0I didn't
> expect this much of an increase, I honestly expected the thin pack
> portion to be well, thinner.

JGit's thin pack creation is crap.  For example, this is the same fetch=
:

$ git fetch ../tmp_linux26
remote: Counting objects: 61521, done.
remote: Compressing objects: 100% (12096/12096), done.
remote: Total 50275 (delta 42578), reused 45220 (delta 37524)
Receiving objects: 100% (50275/50275), 11.13 MiB | 7.29 MiB/s, done.
Resolving deltas: 100% (42578/42578), completed with 4968 local objects=
=2E

$ git fetch git://localhost/tmp_linux26
remote: Counting objects: 144190, done
remote: Finding sources: 100% (50275/50275)
remote: Compressing objects: 100% (106568/106568)
remote: Compressing objects: 100% (12750/12750)
Receiving objects: 100% (50275/50275), 24.66 MiB | 10.93 MiB/s, done.
Resolving deltas: 100% (40345/40345), completed with 2218 local objects=
=2E


JGit produced an extra 13.53 MiB for this pack, because it missed
about 2,233 delta opportunities.  It turns out we are too aggressive
at pushing objects from the edges into the delta windows.  JGit pushes
*everything* in the edge commits, rather than only the paths that are
actually used by the objects we need to send.  This floods the delta
search window with garbage, and makes it less likely that an object to
be sent will find a relevant delta base in the search window.

--=20
Shawn.
