From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: Re: [PATCH] rev-parse --parseopt: fix handling of optional arguments
Date: Wed, 16 Oct 2013 12:58:11 +0200
Message-ID: <20131016105811.GA4589@mars-attacks.org>
References: <1381838425-18244-1-git-send-email-boklm@mars-attacks.org>
 <20131015231427.GF9464@google.com>
 <xmqqfvs29kjc.fsf@gitster.dls.corp.google.com>
 <20131015235739.GI9464@google.com>
 <525E3A80.5000500@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 16 12:58:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWOo1-0005sg-8c
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 12:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760636Ab3JPK6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 06:58:17 -0400
Received: from mx0.mars-attacks.org ([92.243.25.60]:45773 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760524Ab3JPK6N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 06:58:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id 438084E6B;
	Wed, 16 Oct 2013 12:58:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ib9n4fzy1TpT; Wed, 16 Oct 2013 12:58:25 +0200 (CEST)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 9E9C93EE6;
	Wed, 16 Oct 2013 12:58:25 +0200 (CEST)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 2880043928; Wed, 16 Oct 2013 12:58:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <525E3A80.5000500@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236244>

On Wed, 16 Oct 2013, Johannes Sixt wrote:

> Am 10/16/2013 1:57, schrieb Jonathan Nieder:
> > Junio C Hamano wrote:
> > 
> >> You just made these two that the user clearly meant to express two
> >> different things indistinguishable.
> >>
> >> 	opt.sh -S
> >>       opt.sh -S ''
> > [...]
> >> And that is exactly why gitcli.txt tells users to use the 'sticked'
> >> form, and ends the bullet point with:
> >>
> >>    An option that takes optional option-argument must be written in
> >>    the 'sticked' form.
> > 
> > Yes, another possibility in that vein would be to teach rev-parse
> > --parseopt an OPTIONS_LONG_STICKED output format, and then parse with
> 
> Aren't you people trying to solve something that can't besolved? What does
> 
>   git commit -S LICENSE
> 
> mean? Commit the index and sign with the key-id "LICENSE" or commit just
> the file "LICENSE" with the default key-id?

The later, as optional arguments needs to be sticked, but I think this
is not related to the problems with --parseopt.

Here is a summary the problems I think we have with --parseopt and
proposed solutions. This command makes it possible to parse arguments
with a loop like this :

  while test $# != 0
  do
        case "$1" in
        -q)
                GIT_QUIET=t ;;
        -S)
                # do something with $2
                # shift if you think $2 is an optional arg
                ;;
        --)
                shift; break ;;
        esac
        shift
  done
  # do something with the other arguments

And I think the problems with the '?' flag when using this kind of loop
are :

 - You don't know if $2 is the optional argument for -S, or the next option
 
 - You can't use '--' as an optional argument to -S, because you don't
   know if '--' is the optional argument to -S, or the separator between
   options and non options.

To fix this, solution 1) is to always include the optional argument in
$2, and set it to '' if it is not set. However this brings the problem
that you can't distinguish between unset argument and empty argument.
The following two become the same :
  ./opt.sh --gpg-id
  ./opt.sh --gpg-id=

Solution 2) is to use a flag like ?<default> as suggested by Jonathan.
Now you can distinguish between unset and empty args, but you can't
between <default> and unset, but this is probably not a big problem as
you can select <default> so that it is a value nobody would want to use.

Solution 3) is the OPTIONS_LONG_STICKED output format suggested by
Jonathan. I can't see any problem with this one.
