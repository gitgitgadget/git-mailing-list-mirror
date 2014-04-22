From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc0
Date: Tue, 22 Apr 2014 11:58:29 -0700
Message-ID: <20140422185829.GB15516@google.com>
References: <xmqqk3ambf9k.fsf@gitster.dls.corp.google.com>
 <475e137b5095e45c92a87a9969f58f0@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 20:59:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcfud-0004Zu-7l
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 20:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965AbaDVS64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 14:58:56 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:53021 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254AbaDVS6d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 14:58:33 -0400
Received: by mail-pa0-f48.google.com with SMTP id hz1so5247663pad.21
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=297zRxMgJUtNMuWBSEcI9m3vpKk0aM5ckslvb/9AzdU=;
        b=vwRjerQQ6PXZBbOJgUHgxpnnZqQaC0KdCSTn+9xVXoCUhQ24VKl28rmpPAab1UTiRl
         jGKsJvFpoAygoX14ex0zKQpMy9f4Sp6427Un+uXtqA+0XZ0yTxFHZBFaNdKKTyUws3DL
         Qx5sfjXJur4s0vwddS/oVD/NeTwDa0G8konuMuikCdQbKnUwzJb4rbv3bd7Eh6YY0E2Q
         fHN7+SWO0HlsneOIwe8I2XCLC0bCUTJQiG45AZAAl+EY6SLd8Y3kyPliv9lZw0dbeh07
         pTFaXAxZURu0SHsaZTKnW7p1bAEmUkwBQoaDEifiZgskS5gxcFWypXV3yQTBB395mfpL
         z0Sg==
X-Received: by 10.68.131.202 with SMTP id oo10mr46648468pbb.35.1398193112270;
        Tue, 22 Apr 2014 11:58:32 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id bc4sm86568639pbb.2.2014.04.22.11.58.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 22 Apr 2014 11:58:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <475e137b5095e45c92a87a9969f58f0@74d39fa044aa309eaea14b9f57fe79c>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246770>

Kyle J. McKay wrote:

> The problem with --prefix="" is this (from the Getopt::Long CHANGES file):
>
> Changes in version 2.37
> -----------------------
>
>  * Bugfix: With gnu_compat, --foo= will no longer trigger "Option
>    requires an argument" but return the empty string.
>
> The system I ran the tests on happens to have Getopt::Long version 2.35.

Thanks for catching it.

Getopt::Long was updated to 2.37 in perl 5.8.9 (in 5.8.8 it was
updated to 2.35).  INSTALL still only recommends Perl 5.8 so that's an
issue.

> The --prefix="" option can be rewritten --prefix "" in both tests and then  
> they pass.

Hm, perhaps we should introduce a 'no-prefix' option to work around
this.

> |diff --git a/git-svn.perl b/git-svn.perl
> |index 7349ffea..284f458a 100755
> |--- a/git-svn.perl
> |+++ b/git-svn.perl
> |@@ -149,7 +149,7 @@ my ($_trunk, @_tags, @_branches, $_stdlayout);
>   my %icv;
>   my %init_opts = ( 'template=s' => \$_template, 'shared:s' => \$_shared,
>                     'trunk|T=s' => \$_trunk, 'tags|t=s@' => \@_tags,
>                     'branches|b=s@' => \@_branches, 'prefix=s' => \$_prefix,
  +		      'no-prefix' => sub { $_prefix = "" },

>                     'stdlayout|s' => \$_stdlayout,
>                     'minimize-url|m!' => \$Git::SVN::_minimize_url,
>                    'no-metadata' => sub { $icv{noMetadata} = 1 },

That way, normal usage of --prefix would still be consistent with
other git commands that prefer the form with argument attached
(--prefix=foo, not --prefix foo; see gitcli(7)).

Thoughts?
Jonathan
