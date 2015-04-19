From: Jeff King <peff@peff.net>
Subject: Re: [BUG] "git pull" will regress between 'master' and 'pu'
Date: Sun, 19 Apr 2015 14:19:00 -0400
Message-ID: <20150419181900.GA25649@peff.net>
References: <xmqqbnikoq0n.fsf@gitster.dls.corp.google.com>
 <20150419130745.GA20476@peff.net>
 <20150419173825.GD652025@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 19 20:19:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjtoD-0004cb-B1
	for gcvg-git-2@plane.gmane.org; Sun, 19 Apr 2015 20:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbbDSSTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2015 14:19:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:47354 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752179AbbDSSTD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2015 14:19:03 -0400
Received: (qmail 11495 invoked by uid 102); 19 Apr 2015 18:19:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Apr 2015 13:19:03 -0500
Received: (qmail 19080 invoked by uid 107); 19 Apr 2015 18:19:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Apr 2015 14:19:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Apr 2015 14:19:00 -0400
Content-Disposition: inline
In-Reply-To: <20150419173825.GD652025@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267444>

On Sun, Apr 19, 2015 at 05:38:26PM +0000, brian m. carlson wrote:

> >  	eval="git-rebase $diffstat $strategy_args $merge_args $rebase_args $verbosity"
> > @@ -334,7 +333,7 @@ true)
> >  	eval="git-merge $diffstat $no_commit $verify_signatures $edit $squash $no_ff $ff_only"
> >  	eval="$eval $log_arg $strategy_args $merge_args $verbosity $progress"
> >  	eval="$eval $gpg_sign_args"
> > -	eval="$eval -m \"\$merge_name\" $merge_head"
> > +	eval="$eval FETCH_HEAD"
> >  	;;
> >  esac
> >  eval "exec $eval"
> > 
> > as we seem to special-case the name FETCH_HEAD. It assumes that
> > git-merge's parsing of FETCH_HEAD is the same as what we do in git-pull,
> > but that seems safe. Unfortunately we still have to compute $merge_head
> > ourselves here for the "git pull --rebase" case.
> 
> I agree that this is a better choice.  My concern with your other
> suggestion is that it looks like it wouldn't honor the --no-edit flag or
> GIT_MERGE_AUTOEDIT=no.  That might break some use cases, such as
> non-interactive applications.

Yeah, you're right. I think you could work around it by munging the
$edit variable as appropriate. But the whole thing is still gross. We
should be able to convince "git merge" to do the fmt-merge-msg bit for
us, and if not, then I think it needs to be extended.

-Peff
