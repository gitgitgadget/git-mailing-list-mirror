From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rev-parse --parseopt: fix handling of optional arguments
Date: Wed, 16 Oct 2013 15:33:06 -0700
Message-ID: <20131016223306.GN9464@google.com>
References: <1381838425-18244-1-git-send-email-boklm@mars-attacks.org>
 <20131015231427.GF9464@google.com>
 <xmqqfvs29kjc.fsf@gitster.dls.corp.google.com>
 <20131015235739.GI9464@google.com>
 <20131016141411.GB4589@mars-attacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Nicolas Vigier <boklm@mars-attacks.org>
X-From: git-owner@vger.kernel.org Thu Oct 17 00:33:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWZeV-0000Fd-5V
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 00:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759891Ab3JPWdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 18:33:10 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:62496 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729Ab3JPWdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 18:33:09 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so1440978pbc.29
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 15:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jfEAccYSWcwJGbocXv6TXOoicdeRLo9eeS3M1liyK1k=;
        b=EooZnaIkrXKNELRTb6ErwXPMx8eRzplGry1FMGlSedK4rk5ObiXa6Zc94VbsfCA9gV
         2GBOzpOmPqnhXup1uLXoCMKASM602YDnzX55Eb5kvudh4JdMFXlHGAUb0LPgwd2+k79z
         5PuMgy0OzJuD4CBbJ54XtIKtUUBvU/o8m6cLqhGbH5autuKwxeHN4DN9A5TnopmsgHEE
         UZz+cewwYkvaUrLPt26Fq80E/HHgRX6pA6dR6gql1D/Zu4ZSlrmQSMWkdwuMbFhTQxXv
         bjRtLn6UD14QnQ0OQzQlgg8I97j/UDdI7h01Id1OOeupr7X9MP/FGddxw8BTjMn9W14f
         4Xcw==
X-Received: by 10.68.44.33 with SMTP id b1mr5077726pbm.53.1381962788963;
        Wed, 16 Oct 2013 15:33:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id b3sm93389787pbu.38.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Oct 2013 15:33:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20131016141411.GB4589@mars-attacks.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236279>

Nicolas Vigier wrote:

> I'm thinking about a patch to add the following two options to rev-parse :
>
> --sticked-opt-args::
> 	Only meaningful in --parseopt mode. Tells the options parser to
> 	output options with optional arguments in sticked form. The
> 	default is to output them in non-sticked mode, which can be
> 	difficult to parse unambiguously.
>
> --long-options::
> 	Only meaningful in --parseopt mode. Tells the options parser to
> 	output long option names, when available. The default is to use
> 	short option names when available.
>
> When you want to handle optional args unambiguously, you use the
> --sticked-opt-args option. And if you think an empty value can be
> a meaningful value, you add the --long-options option to be able to
> distinguish them.
>
> Would it make sense ?

That would make four distinct output formats:

 --sticked --long:
	Doesn't lose any information that normal use of C parse_options
	would have kept, as long as every short option with optional
	argument has a corresponding long option.


 --sticked --no-long:
	Loses the distinction between --gpg-sign and --gpg-sign=

 --no-sticked --long:
	Semantically equivalent to the existing output, just noisier.

 --no-sticked --no-long:
 	The existing output.

Are all of them needed?  Is it worth tempting people to use --sticked
--no-long when we know its pitfalls?

I would think that only the current normalized form and --sticked
--long would need to be supported.

The fix you originally proposed seems tolerable to me, too --- it is
not very invasive, and while it doesn't distinguish the empty-argument
form "--gpg-sign=", that's a bit of an edge case.

The main reason I slightly prefer the solution that makes the output
use long, sticked options on request is that the "normalized"
commandline would start being an actual equivalent command line the
command expects, instead of a weird, subtly different syntax.  (That
problem already exists with or without your patch --- the patch just
draws attention to it.)
