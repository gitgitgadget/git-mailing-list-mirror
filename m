From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] report which $PATH entry had trouble running execvp(3)
Date: Wed, 20 Apr 2011 06:21:22 -0500
Message-ID: <20110420112122.GA6580@elie>
References: <7v8vv78eld.fsf@alter.siamese.dyndns.org>
 <7vipub6r3s.fsf@alter.siamese.dyndns.org>
 <7vaafl371q.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 13:21:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCVTT-0004M7-0j
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 13:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab1DTLV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 07:21:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46374 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241Ab1DTLV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 07:21:29 -0400
Received: by iwn34 with SMTP id 34so508335iwn.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 04:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=UR+51JASmw729BdIOoc7iJmbbJfp4+xCVGEJnUOpg7M=;
        b=wCc8xf64fTaFJq/wxD8agj9PJiHY1o6MCX+lqIQvDSxjWQCZqre2n+xGUddbRj0jhd
         VxB3PRSM4clf588ktGsdOykF7Vaxb0Jxix/s65+avpZADkATV8y5ZJw1bnaI5EdZ/Q/C
         6ASDAWg+PJQKNYQ1PFgwOXgVIDNn3RtmhJ/GM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WVGCJ9Q3HWd0TYnp0Zu6/DQLXbGALzYE2YlydomIgYrSJcdTm6KhIDchjM57lLot1P
         fSpJOSTi7lq5EuzWKsboxtuA321j+Ed3gG53FeoE+6jXrF69dLbwYxH/MKZZ6lbtFOl+
         1mvOz1BN2SQYcX8dNa8/sfVZwuqL1RH6d40O0=
Received: by 10.42.88.194 with SMTP id d2mr8581367icm.382.1303298488360;
        Wed, 20 Apr 2011 04:21:28 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.sbcglobal.net [69.209.64.141])
        by mx.google.com with ESMTPS id xe15sm307416icb.8.2011.04.20.04.21.26
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Apr 2011 04:21:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vaafl371q.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171860>

Hi,

Junio C Hamano wrote:

> You can add your own custom subcommand 'frotz' to the system by adding
> 'git-frotz' in a directory somewhere in your $PATH environment variable.
> When you ask "git frotz" from the command line, "git-frotz" is run via
> execvp(3).
>
> Three plausible scenarios that the execvp(3) would fail for us are:
[...]
> The first one is easy to understand and to rectify.  Most likely, the user
> made a typo, either on the command line, or when creating the custom
> subcommand.  However, the latter two cases are harder to notice, as we do
> not report 'git-frotz' in which directory we had trouble with.  We could
> do better if we implemented the command search behaviour of execvp(3)
> ourselves.

My first reaction was the same as Hannes's.  I suppose I would be
happier about something like an optional dependency on something
generic like libexplain[1] (though I'm not thrilled about the style of
its error messages).  If we are to implement it ourselves, using
standard execvp and then trying to track down a guess for the cause
after it fails might be okay.

[1] http://libexplain.sourceforge.net/

I was also reminded that anyone writing scripts following the advice
of POSIX (meaning no #!) would find their custom git commands broken.
Luckily that is easily fixed by using execvp with absolute path.

A part of this is tempting: as Jeff mentioned, it would be nice to
avoid commit_pager_choice when checking for a dashed external before
executing an alias to an internal command that doesn't want a pager
(see v1.7.2~16^2, git --paginate: paginate external commands again,
2010-07-14).  Hm.
