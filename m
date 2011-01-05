From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/4] gitweb: remove unnecessary test when closing file descriptor
Date: Tue, 04 Jan 2011 16:50:25 -0800 (PST)
Message-ID: <m3y670b2ef.fsf@localhost.localdomain>
References: <1293744031-17790-1-git-send-email-sylvain@abstraction.fr>
	<1293744031-17790-3-git-send-email-sylvain@abstraction.fr>
	<7vaajgdx35.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sylvain Rabot <sylvain@abstraction.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 01:50:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaHaD-0007pg-QN
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 01:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238Ab1AEAu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 19:50:28 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:54091 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab1AEAu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 19:50:28 -0500
Received: by wwi17 with SMTP id 17so15443613wwi.1
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 16:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=2LOsOEYNnx/WEbtuqDaWr2DdnxtopP+LEsxb7Wy+zUE=;
        b=GxtPaaMJ0hWRqZK36Sat3bNDTV6fTuJdzJ202f8hZdFEc1RjZe7Kx0DQw0j99e6G1C
         hbDyhl+NPN2vdCYD99rYIHXGVzYt6Dz1B/hNsRZERYLEjbn2tKlBIU1U027yVC3ghfDY
         qclZ8ClzZDdkHT69SIw9crp6di3Yp7vmW66G0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=LyJoAk7875YJavvZGg8HXKLcIddqWqKxDmtfNndWObpLWgjb3xPna+C/zGk59V70CS
         7213gNSpDWCmO9ZJvJMVr26MUB1iDPlJuIossJsJNCf33T2cRnHT/U2TAXIL7LWQ7T60
         Oc4sFaciTzw9rY8o0a0SZHc/drvV+9poY2edI=
Received: by 10.227.126.204 with SMTP id d12mr13057455wbs.174.1294188626674;
        Tue, 04 Jan 2011 16:50:26 -0800 (PST)
Received: from localhost.localdomain (abwq27.neoplus.adsl.tpnet.pl [83.8.240.27])
        by mx.google.com with ESMTPS id m10sm15504595wbc.16.2011.01.04.16.50.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Jan 2011 16:50:25 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p050noCT014869;
	Wed, 5 Jan 2011 01:50:00 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p050nSm6014864;
	Wed, 5 Jan 2011 01:49:28 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vaajgdx35.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164535>

Junio C Hamano <gitster@pobox.com> writes:

> Sylvain Rabot <sylvain@abstraction.fr> writes:
> 
> > it happens that closing file descriptor fails whereas
> > the blob is perfectly readable. According to perlman
> > the reasons could be:
> >
> >    If the file handle came from a piped open, "close" will additionally
> >    return false if one of the other system calls involved fails, or if the
> >    program exits with non-zero status.  (If the only problem was that the
> >    program exited non-zero, $! will be set to 0.)  Closing a pipe also waits
> >    for the process executing on the pipe to complete, in case you want to
> >    look at the output of the pipe afterwards, and implicitly puts the exit
> >    status value of that command into $?.
> >
> >    Prematurely closing the read end of a pipe (i.e. before the process writ-
> >    ing to it at the other end has closed it) will result in a SIGPIPE being
> >    delivered to the writer.  If the other end can't handle that, be sure to
> >    read all the data before closing the pipe.
> >
> > In this case we don't mind that close fails.
> >
> > Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
> 
> Hmm, do you want a few helped-by lines here?
> 
> I'll queue this to 'pu', but only because I do not care too much about
> this part of the codepath, not because I think this is explained well.

True, I might now agree with code, but I still don't like the
explanation...

> 
> For example, what does "the reasons could be" mean?  If the reasons turned
> out to be totally different, that would make this patch useless?  IOW, is
> it fixing the real issue?  Without knowing the reasons, how can we
> conclude that "In this case" we don't mind?

Well, "in this case" of run_highlighter() we close filehandle from
git-cat-file, which was used only to test if it passes -T test (file
is an ASCII text file (heuristic guess)), to _reopen_ it with
highlighter as a filter.

Also, with test if failed for Sylvain, with test removed it works all
right.

> Having said all that, I agree that you are seeing a failure exactly
> because of the reason you stated above with an unnecessary weak "could
> be".  A filehandle to a pipe to cat-file is opened by the caller of
> blob_mimetype(), it gets peeked at with -T inside the function, then it
> gets peeked at with -B inside the caller (by the way, didn't anybody find
> this sloppy?  Why isn't blob_mimetype() doing all of that itself?), and

I think the -B test is here because -T test is last resort in
blob_mimetype; depending on used mime.types one can get something
other than application/octet-stream for non-text file.  But I agree
that it could have been done better.

> then after that the run_highligher closes the filehandle, because it does
> not want to read from the unadorned cat-file output at all.  Of course,
> cat-file may receive SIGPIPE if we do that, and we know we don't care how
> cat-file died in that particular case.
> 
> But do we care if the first cat-file died due to some other reason?  Is
> there anything that catches the failure mode?

Well, the alternate would be to examine $! or %!, e.g.

> > @@ -3465,8 +3465,7 @@ sub run_highlighter {
> >  	my ($fd, $highlight, $syntax) = @_;
> >  	return $fd unless ($highlight && defined $syntax);
> >  
> > 	close $fd
> > -		or die_error(404, "Reading blob failed");
> > +		or $!{EPIPE} or die_error(404, "Reading blob failed");
> >  	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
> >  	          quote_command($highlight_bin).
> >  	          " --xhtml --fragment --syntax $syntax |"

Though this version is cryptic (but compact).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
