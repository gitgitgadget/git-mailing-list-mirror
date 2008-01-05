From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] git stash: one bug and one feature request
Date: Sat, 5 Jan 2008 09:25:59 +0100
Message-ID: <e5bfff550801050025g6758bfb6p751e69e93d4299be@mail.gmail.com>
References: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com>
	 <7vy7b5glmr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 09:26:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB4Mf-0005h5-RS
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 09:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbYAEI0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 03:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752438AbYAEI0H
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 03:26:07 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:25746 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbYAEI0E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 03:26:04 -0500
Received: by rv-out-0910.google.com with SMTP id k20so6396688rvb.1
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 00:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=gf40+G9fRkUazZn7tLX0+KFrMWpj9cva2tJdGlOrMCA=;
        b=Rm3vjwEww1n9D12Gzj1rKRahe6I/jPW490eh5XeSmCbtqag6Tpw0EL3PXatNSodL4KEu676VAO7fb8mWHL9t6rpGZZa1NeeRkEQYNM1aUSMwuQWz/qwNSE7lZ6LKTKPrKKOAykmlTQMdnrdCzS6xBEEIr0rmZrquX1vMUALjEY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=wpv473yS/ZpEdraa8zfzQocc583Jbv77TyRdiDTt4bpYHTSlQV5yT1nedsGPqHh+7qxnUF2BA7R4TeuKjY5Pm4PGkRSSR++H+OTU4sZgU6cPQghJ3qQksZvqK4PyRtRxkUGdzvsJIjObs0zP5fvp6ehn7WN6MJMocvlbv1H/zcY=
Received: by 10.141.37.8 with SMTP id p8mr4057097rvj.150.1199521559477;
        Sat, 05 Jan 2008 00:25:59 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sat, 5 Jan 2008 00:25:59 -0800 (PST)
In-Reply-To: <7vy7b5glmr.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69650>

On Jan 5, 2008 1:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > Otherwise git-stash is unusable by scripts that check
> > stderr to detect fail/success of launched command.
>
> Sorry, but I happen to disagree with your notion of "having
> something on stderr is an error" to begin with.  I think scripts
> written that way are either simply bogus, or are working around
> a defect in the underlying command it calls (perhaps it does not
> signal error with exit status properly).
>

I understand your point. The problem is that in git there isn't an
unique way to test success/fail for any command, as example, regarding
checking the exit status:

$ git status; echo $?
# On branch master
nothing to commit (working directory clean)
1


You get a value different from zero also in case of no error. The
checking for stderr I have found is more reliable for the git
command/scripts I use.

> A command that produces machine parsable output should write
> that out to stdout, and if it needs to emit other informational
> messages meant for human consumption (this includes progress
> bars), that should be sent to stderr so that scripts can get the
> meat of the output without having to filter cruft out.
>

I agree with this, but I fail to see the machine parsable output and
human consumption sideband info in case of git-stash that I would say
does not foreseen machine  parsable output at all, so in this case
choice of writing to stderr is less clear to me.

> If the command does not signal an error by exiting with non-zero
> status, that would be a bug indeed and you can fix that instead,
> I think.
>

If we don't want to have general rule for exit status and stderr at
least we could add a -q option to git stash, altough I would prefer
git stash writing on stdout if is not an error.

Please let me explain again why I need a reliable way to detect
success/fail of a command. When a function wants to execute a git
command it passes a string with the command + arguments to a low level
routine, say run(), that is command agnostic. This run() function
adapts and formats the command line according to the OS environment
then runs the command, saves the results and check for an error, the
result buffer is then passed as is to the caller that has the semantic
knowledge of what the command have produced.

This low level run() should know nothing about the semantic of the
command or the outputted data, but should detect command failing,
because failing reporting framework is unified and is the same for
each type of command.

A good and reliable way is to check for stderr, because it happens to
be more reliable then exit codes.

Please note that also gitk uses the same approach, indeed from
http://ftp.tcl.tk/man/tcl8.5/tutorial/Tcl26.html you can read:

--------------------

The 'exec' treats any output to standard error to be an indication
that the external program failed. This is simply a conservative
assumption: many programs behave that way and they are sloppy in
setting return codes.

Some programs however write to standard error without intending this
as an indication of an error. You can guard against this from
upsetting your script by using the catch command:

if { [catch { exec ls *.tcl } msg] } {
   puts "Something seems to have gone wrong but we will ignore it"
}

-------------------------

Indeed in gitk you find something like

    # Unfortunately git-cherry-pick writes stuff to stderr even when
    # no error occurs, and exec takes that as an indication of error...
    if {[catch {exec sh -c "git cherry-pick -r $rowmenuid 2>&1"} err]} {
	notbusy cherrypick
	error_popup $err
	return
    }



I can also black list not commonly behaving programs, but in case of
git-stash a fail to see why to choose a not standard behaviour when
not needed.


Thanks
Marco
