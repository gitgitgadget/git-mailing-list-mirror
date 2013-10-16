From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: Re: [PATCH] rev-parse --parseopt: fix handling of optional arguments
Date: Wed, 16 Oct 2013 16:14:11 +0200
Message-ID: <20131016141411.GB4589@mars-attacks.org>
References: <1381838425-18244-1-git-send-email-boklm@mars-attacks.org>
 <20131015231427.GF9464@google.com>
 <xmqqfvs29kjc.fsf@gitster.dls.corp.google.com>
 <20131015235739.GI9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 16:14:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWRsG-0007gF-Dp
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 16:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934745Ab3JPOOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 10:14:52 -0400
Received: from mx0.mars-attacks.org ([92.243.25.60]:47087 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935029Ab3JPOOO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 10:14:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id 8B7EC4E6B;
	Wed, 16 Oct 2013 16:14:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zl4XmZCg7ToG; Wed, 16 Oct 2013 16:14:26 +0200 (CEST)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id EC5B03ECC;
	Wed, 16 Oct 2013 16:14:25 +0200 (CEST)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 546E743928; Wed, 16 Oct 2013 16:14:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20131015235739.GI9464@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236246>

On Tue, 15 Oct 2013, Jonathan Nieder wrote:

> Junio C Hamano wrote:
> 
> > You just made these two that the user clearly meant to express two
> > different things indistinguishable.
> >
> > 	opt.sh -S
> >       opt.sh -S ''
> [...]
> > And that is exactly why gitcli.txt tells users to use the 'sticked'
> > form, and ends the bullet point with:
> >
> >    An option that takes optional option-argument must be written in
> >    the 'sticked' form.
> 
> Yes, another possibility in that vein would be to teach rev-parse
> --parseopt an OPTIONS_LONG_STICKED output format, and then parse with
> 
> 	while :
> 	do
> 		case $1 in
> 		--gpg-sign)
> 			... no keyid ...
> 			;;
> 		--gpg-sign=*)
> 			keyid=${1#--gpg-sign=}
> 			...
> 			;;
> 		esac
> 		shift
> 	done
> 
> This still leaves
> 
> 	opt.sh -S
> 	
> and
> 
> 	opt.sh -S''
> 
> indistinguishable.  Given what the shell passes to execve, I think
> that's ok.
> 
> The analagous method without preferring long options could work almost
> as well:
> 
> 	while :
> 	do
> 		case $1 in
> 		-S)
> 			... no keyid ...
> 			;;
> 		-S?*)
> 			keyid=${1#-S}
> 			...
> 			;;
> 		esac
> 		shift
> 	done
> 
> but it mishandles "--gpg-sign=" with empty argument.

I'm thinking about a patch to add the following two options to rev-parse :

--sticked-opt-args::
	Only meaningful in --parseopt mode. Tells the options parser to
	output options with optional arguments in sticked form. The
	default is to output them in non-sticked mode, which can be
	difficult to parse unambiguously.

--long-options::
	Only meaningful in --parseopt mode. Tells the options parser to
	output long option names, when available. The default is to use
	short option names when available.


When you want to handle optional args unambiguously, you use the
--sticked-opt-args option. And if you think an empty value can be
a meaningful value, you add the --long-options option to be able to
distinguish them.

Would it make sense ?
