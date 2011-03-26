From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSOC idea: build in scripts and cleanups
Date: Fri, 25 Mar 2011 21:14:35 -0500
Message-ID: <20110326021435.GA2352@elie>
References: <201103260141.20798.robert.david.public@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Robert David <robert.david.public@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 03:14:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3J1d-0008HD-P9
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 03:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934302Ab1CZCOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 22:14:44 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48387 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934174Ab1CZCOn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 22:14:43 -0400
Received: by iyb14 with SMTP id 14so1117125iyb.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 19:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=4KnnairTJ14p4s/ViA9QVvs4lQYC5Zb0BHBSdV4fQHo=;
        b=yFArBeTo4ccKSHBJyZLVmSfzJcYzpvdw9q/fq6s9j1Ua1gS3Id+VJ7gKJ8SspEQ2Mp
         vSUXdK31pY0OrrHb2icXVEWlmiMINi5+gD5Z8Kc77sivBaXmOgYyMJBRK06V7Vbt16/M
         SKVc12RFCZQ3j+V2L3EatNVNT4B/01pOCJCpk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MwYNInRIl2aSO8TXnlhez2J4ImWGbnqOOhh9QGLc1epfLRAtmgZvSVY93d+kHkzEup
         rW+Xjs3V8CD8aIFXUIiEw5mh1enUMbM9hAr9ws0Job2ME2SDlRm8Go4Hdj4guIQlD1VG
         ihrLtDA2I3xU2sU/nJTHtTn57tvXhtjSFwWwA=
Received: by 10.43.45.8 with SMTP id ui8mr2504423icb.197.1301105681887;
        Fri, 25 Mar 2011 19:14:41 -0700 (PDT)
Received: from elie (adsl-68-255-102-141.dsl.chcgil.ameritech.net [68.255.102.141])
        by mx.google.com with ESMTPS id g4sm980648ick.23.2011.03.25.19.14.40
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 19:14:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201103260141.20798.robert.david.public@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170038>

(+cc: various relevant people for ideas)
Hi,

Robert David wrote:

> I'm long time user of git and very interested in development participation. 

Welcome!

> Having passing your GSOC ideas, keep my eyes on scripts building in and also 
> git add -p cleanups. Because I like this kind of work. 
>
> Because there are more thinks to do in the cleanup and rewrite task, I would 
> like to ask if there is some priority in these tasks? To let me focus on the 
> most important parts. 

Looking at the git-add--interactive.perl source, I see:

	process_args();
	refresh();
	if ($patch_mode) {
		patch_update_cmd();
	}
[...]

and patch_update_cmd looks like

	my @all_mods = list_modified($patch_mode_flavour{FILTER});
	my @mods = grep { !($_->{BINARY}) } @all_mods;
[...]
	if ($patch_mode) {
		@them = @mods;
	}
[...]
	for (@them) {
		return 0 if patch_update_file($_->{VALUE});
	}

patch_update_file loops over hunks in the diff for that file and acts
on them one at a time.  So a natural step might be to eliminate this
outer "for (@them)" loop, so the person at the keyboard could decide
to go back to a previous file or list all files and choose one.

Others may have more to say.  If there are things you wished "git
checkout --patch" was able to do, that can also help.

> I was also thinking if there isn't PERL a better choice in rewriting shell 
> scripts, due to planed porting (android, etc). Better than C. But I don't know 
> android and other platform so much, so thats why I'm asking.

So far (on Windows and various Unixen) it seems that C is much easier
to work with as far as porting goes.[2]

Jonathan

[1] Android is an odd example because the platform uses Java heavily
(so JGit might be a better fit for it).  Perhaps the wish for android
support should have been put on the Eclipse ideas page[2] and a link
added to git's; I dunno.
[2] http://wiki.eclipse.org/Google_Summer_of_Code_2011_Ideas#Ideas_submission
