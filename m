From: Paul Smith <paul@mad-scientist.net>
Subject: Re: [PATCH] git-new-workdir: Don't fail if the target directory is
 empty
Date: Fri, 21 Nov 2014 10:08:37 -0500
Message-ID: <1416582517.23953.18.camel@mad-scientist.net>
References: <1416498395.23953.8.camel@mad-scientist.net>
	 <xmqqioi94wy0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 16:08:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrppO-0000ru-Mp
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 16:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758566AbaKUPIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 10:08:50 -0500
Received: from gproxy2-pub.mail.unifiedlayer.com ([69.89.18.3]:54311 "HELO
	gproxy2-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751175AbaKUPIs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2014 10:08:48 -0500
Received: (qmail 5296 invoked by uid 0); 21 Nov 2014 15:08:48 -0000
Received: from unknown (HELO cmgw4) (10.0.90.85)
  by gproxy2.mail.unifiedlayer.com with SMTP; 21 Nov 2014 15:08:48 -0000
Received: from box531.bluehost.com ([74.220.219.131])
	by cmgw4 with 
	id JF8l1p0052qhmhE01F8oT4; Fri, 21 Nov 2014 08:08:48 -0700
X-Authority-Analysis: v=2.1 cv=B+wqjodM c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17 a=cNaOj0WVAAAA:8
 a=f5113yIGAAAA:8 a=IkcTkHD0fZMA:10 a=pBbsfl06AAAA:8 a=cdVwids0oJMA:10
 a=2NV5t7OSZ7cA:10 a=5y4faFyK3SkA:10 a=D_rlwcduhaTHg7NyP6AA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mad-scientist.net; s=default;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=EsR7L0dnxqiZYrRtV973fyQGuprr3eWxihDg14Uj4lE=;
	b=e9/oqtTfhFozrfoJN+hIOV9eFtKgQ5rm+s9D2S80M1QUmZhlMXwwLCw+cb09DGqKXtAh26W3g2wDiVzHSqwIunBCWA0gs3mwo8kaVi3vA+/KtghBvO9qFfnmq/RaY5F3;
Received: from [173.9.45.73] (port=53715 helo=pdsdesk)
	by box531.bluehost.com with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.82)
	(envelope-from <paul@mad-scientist.net>)
	id 1XrppE-0000qb-P4; Fri, 21 Nov 2014 08:08:44 -0700
In-Reply-To: <xmqqioi94wy0.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.7-0ubuntu1 
X-Identified-User: {678:box531.bluehost.com:madscie1:mad-scientist.us} {sentby:smtp auth 173.9.45.73 authed with paul@mad-scientist.us}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2014-11-20 at 09:13 -0800, Junio C Hamano wrote:
> Paul Smith <paul@mad-scientist.net> writes:
> > +# don't recreate a workdir over an existing directory, unless it's empty
> > +if test -d "$new_workdir"
> >  then
> > -	die "destination directory '$new_workdir' already exists."
> > +	if test $(ls -a1 "$new_workdir"/. | wc -l) -ne 2
> 
> You used to quote this as
> 
> 	if test $(ls -a1 "$new_workdir/." | wc -l) -ne 2
> 
> and I think that made a lot more sense than the new quoting.

Just personal script coding style.  I tend to quote just variables, in
case I want to add globbing or whatever later.  I've run into people who
think that "$foo/bar" needs quotes because it concatenates two strings,
but you don't need to quote $foo by itself; quoting just the variable
helps avoid that impression.

But this doesn't matter much to me.

> Case arms come at the same indentation level as "case/esac".

OK.

> Why these changes?  I thought you are making sure $cleandir is
> absolute so that you do not have to do this and can just "cd" into
> the new working tree, the same way the user would do once it is set
> up.

I made cleandir absolute mainly because you asked me to :-).  I didn't
realize that the implication behind that request was that I'd put back
the original "cd" as well.

I personally distrust and avoid raw cd in shell scripts.  It's
action-at-a-distance and can cause all sorts of problems, sometimes
disastrous ones.  If I need to change directories I localize it, e.g.:

  (cd "$somedir" && do some command)

so it's clear that it's in effect only for that command.

I understand that in this particular situation the "cd" is right before
the end so this doesn't hurt (as the script stands today).  If you
prefer the "cd" explicitly I'll add it back.  You're the one that needs
to be happy with it :-).

What if I move the cd down to right before the checkout command, and use
$new_workdir in the copy of HEAD?  At least it won't be in effect until
after the workdir is completely set up.  I would feel better about it
then :-).

> > -# now setup the workdir
> > -cd "$new_workdir"
> >  # copy the HEAD from the original repository as a default branch
> > -cp "$git_dir/HEAD" .git/HEAD
> > -# checkout the branch (either the same as HEAD from the original repository, or
> > -# the one that was asked for)
> > -git checkout -f $branch
