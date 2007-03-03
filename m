From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Add core.symlinks to mark filesystems that do not support symbolic links.
Date: Sat, 3 Mar 2007 13:20:13 +0100
Message-ID: <200703031320.13535.johannes.sixt@telecom.at>
References: <200703022211.30322.johannes.sixt@telecom.at> <7vvehjchsp.fsf@assigned-by-dhcp.cox.net> <7vr6s7chim.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 13:20:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNTE1-0002Mg-72
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 13:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965235AbXCCMUT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 3 Mar 2007 07:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965261AbXCCMUS
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 07:20:18 -0500
Received: from smtp3.noc.eunet-ag.at ([193.154.160.89]:54332 "EHLO
	smtp3.noc.eunet-ag.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965235AbXCCMUR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 07:20:17 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.noc.eunet-ag.at (Postfix) with ESMTP
	id 71B81362A4; Sat,  3 Mar 2007 13:20:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 14A764CBB6;
	Sat,  3 Mar 2007 13:20:14 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <7vr6s7chim.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41289>

On Saturday 03 March 2007 01:12, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> > This code (I am the guilty one before your change above) always
> > confused me.  How about doing something like this instead?
> >
> >     static inline unsigned int ce_mode_from_stat(struct cache_entry
> > *ce,... {
> >         /*
> >          * A regular file that appears on the filesystem can have
> >          * a "wrong" st_mode information.  A few repository config
> >          * variables can tell us to trust the mode recorded in the
> >          * index more than what we get from the filesystem.
> >          */
> >         if (ce && S_ISREG(mode)) {
> >             extern int trust_executable_bit, has_symlinks;
> >
> >             if (!has_symlinks && S_ISLNK(ntohl(ce->ce_mode)))
> >                 return ce->ce_mode;
>
> Oops, these three lines
>
> >             if (!trust_executable_bit && S_ISREG(ntohl(ce->ce_mode)=
))
> >                 return ce->ce_mode;
> >             return create_ce_mode(0666);
>
> should be:
>
> 		if (!trust...) {
>                 	if (S_ISREG(...))
>                         	return ce->ce_mode;
> 			return create_ce_mode(0666);
> 		}

I think that's still not correct. Because in the case of !trust_executa=
ble_bit=20
we want create_ce_mode(0666) regardless of whether a ce exists or not. =
Maybe=20
this way:

=A0 =A0 static inline unsigned int ce_mode_from_stat(struct cache_entry=
 *ce,...
=A0 =A0 {
=A0 =A0 =A0 =A0 /*
=A0 =A0 =A0 =A0 =A0* A regular file that appears on the filesystem can =
have
=A0 =A0 =A0 =A0 =A0* a "wrong" st_mode information. =A0A few repository=
 config
=A0 =A0 =A0 =A0 =A0* variables can tell us to trust the mode recorded i=
n the
=A0 =A0 =A0 =A0 =A0* index more than what we get from the filesystem.
=A0 =A0 =A0 =A0 =A0*/
=A0 =A0 =A0 =A0 if (S_ISREG(mode)) {
=A0 =A0 =A0 =A0 =A0 =A0 extern int trust_executable_bit, has_symlinks;

=A0 =A0 =A0 =A0 =A0 =A0 if (!has_symlinks && ce && S_ISLNK(ntohl(ce->ce=
_mode)))
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ce->ce_mode;
=A0 =A0 =A0 =A0 =A0 =A0 if (!trust_executable_bit) {
                if (ce && S_ISREG(ntohl(ce->ce_mode)))
        =A0 =A0 =A0 =A0 =A0 =A0 return ce->ce_mode;
=A0 =A0 =A0 =A0         return create_ce_mode(0666);
            }
=A0 =A0 =A0 =A0 }
=A0 =A0 =A0 =A0 return create_ce_mode(mode);
=A0 =A0 }


-- Hannes
