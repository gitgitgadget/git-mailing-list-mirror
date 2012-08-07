From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v2 06/16] t3700: sleep for 1 second, to avoid
 interfering with the racy code
Date: Tue, 7 Aug 2012 18:59:47 +0200
Message-ID: <20120807165947.GD913@tgummerer>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-7-git-send-email-t.gummerer@gmail.com>
 <7vsjc023sr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pcouds@gmail.com, robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 19:00:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Syn8T-0007C1-Py
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 19:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644Ab2HGQ74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 12:59:56 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45245 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593Ab2HGQ7z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 12:59:55 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so4579397pbb.19
        for <git@vger.kernel.org>; Tue, 07 Aug 2012 09:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9WnUgmgv0bYVKVZw3CPP4zSQhnJB7PXARPonp9HDuCg=;
        b=o3aL/6TFZyHRX+tqrzcX4XNsiB9u0JGsSI+yUBAsClLQvphOt15tDQvIqnShjquyAw
         HY0L72DRNux4dBluAt0/pmPMjHGBDcAhOjA2nHPv8xpiYFqIP59oPQEDszr/QEXONBwk
         T32KMX1wxqOOqsjLZEkbypHlX2arTkURjzLoUYDRb4xv1hY8AwHTB3Feq68pOnl72uvA
         LtmuH0aDnSsOSko67l1VbnOUH6IJbzKdYrqg1MYKLJxXPguaZ37n+Q8MlVDWGplF/5ZT
         fxEfg84Dnq9zN1a7r6OB+h+w6I43vIa7FSd/oegrZvhIzIj5aFvO/pOfOOP3CRPScBVd
         HUig==
Received: by 10.68.200.8 with SMTP id jo8mr29129879pbc.148.1344358795556;
        Tue, 07 Aug 2012 09:59:55 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPS id nr8sm8080972pbc.43.2012.08.07.09.59.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Aug 2012 09:59:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vsjc023sr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203032>

On 08/05, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > The new git racy code uses the mtime of cache-entries to smudge
> > a racy clean entry, and loads the work, of checking the file-system
> 
> -ECANTPARSE.

The git racy code for index-v5 uses the mtime of the cache-entries as
smudge markers. The work of checking the file-system is loaded of to
the reader.

> > if the entry has really changed, off to the reader. This interferes
> > with this test, because the entry is racily smudged and thus has
> > mtime 0. We wait 1 second to avoid smudging the entry and getting
> > correct test results.
> 
> Mild NAK, especially it is totally unclear why you even need to muck
> with racy-git check in the current format of the index in the first
> place, and even if it were necessary, it is unclear why this cannot
> be done with test-chmtime.

The racy-git code needs to be changed, to avoid problems when implementing
the partial writing for index-v5. Otherwise it could cause problems, when
we have entries that should be smudged, but are not due to the different
racy algorithms.

I'll do it with test-chmtime in the reroll though.

> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  t/t3700-add.sh |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> > index 874b3a6..4d70805 100755
> > --- a/t/t3700-add.sh
> > +++ b/t/t3700-add.sh
> > @@ -184,6 +184,7 @@ test_expect_success 'git add --refresh with pathspec' '
> >  	echo >foo && echo >bar && echo >baz &&
> >  	git add foo bar baz && H=$(git rev-parse :foo) && git rm -f foo &&
> >  	echo "100644 $H 3	foo" | git update-index --index-info &&
> > +	sleep 1 &&
> >  	test-chmtime -60 bar baz &&
> >  	>expect &&
> >  	git add --refresh bar >actual &&
