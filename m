From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 0/2] Allow detached forms (--option arg) for git
 log options.
Date: Sun, 1 Aug 2010 00:24:37 -0500
Message-ID: <20100801052437.GA10438@burratino>
References: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr>
 <20100726193109.GA1043@burratino>
 <20100727144639.GU2504@madism.org>
 <m37hkhklll.fsf@localhost.localdomain>
 <20100728130610.GG6895@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Aug 01 07:26:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfR3f-0000IM-DX
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 07:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181Ab0HAFZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Aug 2010 01:25:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39342 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007Ab0HAFZx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Aug 2010 01:25:53 -0400
Received: by iwn7 with SMTP id 7so2869060iwn.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 22:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=KUJWS+vrHq9cXRNRjee8kZemh7FB4VhfrVm4GD1AH5Y=;
        b=v5bLaZ3Q57tG+vDoqd8Kvle+3p47vO7ntOxDKAeMBOIhOvaft8t1WJAhy3IMSvd2l5
         cC2b+Ik6lPYZp1kaB1H40zjgwv2CjTyDDtXVb+vs1skZ1S320uTYvgacuf8xbBsSCNd7
         v/XzFyB9Aq4sGAjkP0n1gklKI5DXKzC5xxDGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=f3YMq4VKiatPwGmIxr5EkUHgp6zvTVcKM1W5o3KxjTMIEY0tz2dLvRY7+424DH3D06
         91x44IqXAJ/YD8cfvTqDMiTcW8otXYa5flFvWRtVTDBsNgj4VCFZwviyxAGrfrbC4p14
         MyCGLqTVB7vizHpwQ+P4/lX4nJ7+sUwD9fDgo=
Received: by 10.231.29.33 with SMTP id o33mr4439827ibc.164.1280640352703;
        Sat, 31 Jul 2010 22:25:52 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r3sm3912680ibk.7.2010.07.31.22.25.51
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 22:25:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100728130610.GG6895@madism.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152368>

Pierre Habouzit wrote:

> you cannot take the address of a bit portably in C, so you can't let
> parseopt set/clear bits through bitfields (as in unsigned field : 1 in a
> struct in C I mean).

For the curious: I think this means doing something like
v1.5.4-rc0~186^2~1 (Make the diff_options bitfields be an unsigned
with explicit masks, 2007-11-10), which means instead of writing

	revs->topo_order = 1;

one would write something like

	REV_TRAV_SET(revs, TOPO_ORDER);

See [1] and [2].  Looks simple and reasonable.

While we are exploring ancient history, I find[3]:

	  I came up with the relocation thing because I feared
	that the msys port (and maybe other ?) that are about to
	use (or already do) threads would step on each other toes
	while recursing into a sub-array of options.

	  Johannes thinks that this never happens in our
	codebase, hence that my patches are an overkill.

	  The likely users of this feature are currently diff
	options (diff.c diff_opt_parse) and revisions
	(builtin-log.c setup_revisions).

	  Using Johannes patch, we will have to export a global
	struct diff_option (resp. struct rev_info) from diff.c
	(resp. revisions.c) and no function (or almost) would
	take struct diff_option (resp struct rev_info) as an
	argument because everyone would work on the global
	variable[0].

	  With my patches, we can work like we do now, with a
	more functional approach.

Is the relocation thing worth thinking about?  (Mind you, I was not
there, so I do not know what it is nor whether it was a dead end.)  If
so, is it documented anywhere?

The table-inclusion method[4] still appeals to me very much.  Well,
whatever seems to work best.

[1] http://thread.gmane.org/gmane.comp.version-control.git/63797/focus=63937
[2] http://thread.gmane.org/gmane.comp.version-control.git/83083/focus=83114
[3] http://thread.gmane.org/gmane.comp.version-control.git/63502/focus=63506
[4] http://thread.gmane.org/gmane.comp.version-control.git/63505/focus=63517
