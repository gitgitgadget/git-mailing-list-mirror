From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 2/8] cherry-pick: treat CHERRY_PICK_HEAD and
 REVERT_HEAD as refs
Date: Wed, 08 Jul 2015 19:44:18 -0400
Organization: Twitter
Message-ID: <1436399058.4542.26.camel@twopensource.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
	 <1436316963-25520-2-git-send-email-dturner@twopensource.com>
	 <559D6208.8090607@kdbg.org> <1436382962.4542.8.camel@twopensource.com>
	 <559D92CF.7000408@kdbg.org> <xmqq4mlexmh3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 01:44:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCz0t-0006F0-L4
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 01:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbbGHXoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 19:44:24 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35024 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbbGHXoV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 19:44:21 -0400
Received: by qkbp125 with SMTP id p125so175135133qkb.2
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 16:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=oDcZNu3Mnfjr1lfkq7SJmuqeFA3yj6qaH/95ZVnB7+0=;
        b=m62wbe9yKIO+kCGzJOlmw3d5r+4IXglWHC1jDAbrnKAzixyUWw5epx6P3zCNJA6vzr
         86nohnoUGCzRChpFGDTKbAvVv3RnYAJ15pPEzHjffrdcj9mYNhnB7jj2GFve6Fh1OaFa
         xhmh5iD9VE9wWLuLNaNJ+ZHz9Mb/4lOD1Xxv2EwlI/nHRbIqD2xiFLPNkD/nUEkrTXbc
         WU79/lP2XPjFdkzODHtYfFFu75JO6IzYe4GEjmcsM1TTal/KSUt9nXMc+tbweV+dE4Z9
         k6CzE0Jvu80Wb/h6SoiLJ2K57cRqJaaoEchsgzHouijMOfn7T6JOW/l6Svt6/TPwmTyK
         J/NA==
X-Gm-Message-State: ALoCoQnzEiC85i+Za09HjYefZN54VZRKFhjewz0QjTkLA3ejUBZ6nLknSLI5tuIpjOb55prxgEXt
X-Received: by 10.140.23.147 with SMTP id 19mr20088836qgp.84.1436399060812;
        Wed, 08 Jul 2015 16:44:20 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id r198sm2381014qha.2.2015.07.08.16.44.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2015 16:44:19 -0700 (PDT)
In-Reply-To: <xmqq4mlexmh3.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273720>

On Wed, 2015-07-08 at 16:23 -0700, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
> >> We could reduce the number from two to one by providing a new
> >> git-am-status command which outputs one of "CHERRY-PICKING",
> >> "REVERTING", or "" (or maybe it would also handle rebase and am).  We
> >> could also generalize it to "git-prompt-helper" or something by moving
> >> that entire bunch of if statements inside.  This would replace calls to
> >> "git describe".
> >>
> >> But you probably have a better idea.
> >
> > Isn't it mere coincidence that the content of these two files looks
> > like a non-packed ref? Wouldn't it be better to consider the two akin
> > to MERGE_HEAD (which is not a ref because it records more than just a
> > commit name)?
> 
> That is an excellent thought that seems to have escaped everybody
> involved in the review.
> 
> These things do not behave like refs.  They do not want reflogs (and
> even if they had, the log would not mean much), and if we want to
> add more information on the cherry-pick and revert in progress, they
> are the most natural place to do so.
> 
> Another thing that makes me vote for treating them just like
> FETCH_HEAD, MERGE_HEAD and other ALL_CAPS files like COMMIT_MSG is
> what should happen in a repository with more than one working trees.
> You do not want to share what "CHERRY_PICK_HEAD" means across them
> only because they happen to record an object name.

I didn't see this until after I had sent my previous message.  I think
the "multiple working trees" argument is strong enough that I will
change the code (and tests). 
