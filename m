From: Lars Noschinski <lars-2008-2@usenet.noschinski.de>
Subject: Re: [PATCH] post-receive-email: do not call sendmail if no mail was generated
Date: Tue, 8 Sep 2009 22:59:35 +0200
Message-ID: <20090908205935.GB3858@lars.home.noschinski.de>
References: <20090908185555.GA3858@lars.home.noschinski.de> <1252436418-7660-1-git-send-email-lars@public.noschinski.de> <7v4ord19da.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, andyparkins@gmail.com, pape@smarden.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 23:07:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml7uo-0007DR-Cl
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 23:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbZIHVHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 17:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbZIHVHk
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 17:07:40 -0400
Received: from smtprelay10.ispgateway.de ([80.67.31.33]:54929 "EHLO
	smtprelay10.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbZIHVHk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 17:07:40 -0400
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Sep 2009 17:07:39 EDT
Received: from [87.78.95.112] (helo=fruehjahrsmuede.home.noschinski.de)
	by smtprelay10.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars-2008-2@usenet.noschinski.de>)
	id 1Ml7mq-0003Ku-1B; Tue, 08 Sep 2009 22:59:36 +0200
Received: from lars by fruehjahrsmuede.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars-2008-2@usenet.noschinski.de>)
	id 1Ml7mp-0002Tf-9u; Tue, 08 Sep 2009 22:59:35 +0200
Content-Disposition: inline
In-Reply-To: <7v4ord19da.fsf@alter.siamese.dyndns.org>
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128035>

* Junio C Hamano <gitster@pobox.com> [09-09-08 22:15]:
> Lars Noschinski <lars@public.noschinski.de> writes:
> 
> > contrib/hooks/post-receive-email used to call the send_mail function
> > (and thus, /usr/sbin/sendmail), even if generate_mail generated no
> > output.  This is problematic, as the sendmail binary provided by exim4
> > generates an error mail if provided with an empty input.
> 
> I actually have a bigger question, not about the implementation but about
> the cause.
> 
> If generate_email results in an empty output in this codepath:
> 
> 	# Check if we've got anyone to send to
> 	if [ -z "$recipients" ]; then
> 		...
> 		echo >&2 "*** $config_name is not set so no email will be sent"
> 		echo >&2 "*** for $refname update $oldrev->$newrev"
> 		exit 0
> 	fi
> 
> shouldn't we rather receive an error e-mail than let the
> misconfiguration go undetected?

Probably not. The error message is displayed to the user who did the
push. Normally (if no explicit From: address is configured), this is the
same user, which would receive the error mail.

> Before this check, I do not see anywhere generate_email would return nor
> exit, and after this check, there is a call to generate_email_header and
> that guarantees that the output from the generate_email function is not
> empty, so it looks to me that triggering this check is the only case your
> patch would change the behaviour of the script.

Actually, there are a two cases in the case statement before, where
generate_email would return:

    refs/remotes/*,commit)
        # tracking branch
        refname_type="tracking branch"
        short_refname=${refname##refs/remotes/}
        echo >&2 "*** Push-update of tracking branch, $refname"
        echo >&2 "***  - no email generated."
        exit 0
        ;;
    *)
        # Anything else (is there anything else?)
        echo >&2 "*** Unknown type of update to $refname ($rev_type)"
        echo >&2 "***  - no email generated"
        exit 1
        ;;

i.e. if we are pushing to a branch neither in refs/tags nor refs/heads.

In our setting, the build process pushes to refs/builds, so we can track
code changes between different builds, without displaying a whole lot of
mostly useless branches or tags to the user.

> > diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
> > index 2a66063..c855c31 100755
> > --- a/contrib/hooks/post-receive-email
> > +++ b/contrib/hooks/post-receive-email
> > @@ -637,6 +637,16 @@ show_new_revisions()
> >  
> >  send_mail()
> >  {
> > +	OIFS=$IFS
> > +	IFS='
> > +'
> > +	read FIRSTLINE || exit 1
> 
> Shouldn't this be merely a "return"?  The caller looks like this:

Yes.

I'll fix it in the next patch (when there are further comments); but you
may fold it in (and add the SOB if forgot), if you prefer.
