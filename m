From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: Re: [PATCH 1/2] parse_options: Add flag to prevent errors for
	further processing
Date: Thu, 19 Jun 2008 09:25:27 -0500
Message-ID: <20080619142527.GA8429@mediacenter>
References: <1213758236-979-1-git-send-email-shawn.bohrer@gmail.com> <1213758236-979-2-git-send-email-shawn.bohrer@gmail.com> <7v1w2v2zsh.fsf@gitster.siamese.dyndns.org> <20080618033010.GA19657@sigill.intra.peff.net> <7vwskn1g2p.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806181709300.6439@racer> <7v8wx2zibp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	madcoder@debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 16:27:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9L6N-0004Nw-9P
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 16:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbYFSO0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 10:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754201AbYFSO0G
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 10:26:06 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:10796 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbYFSO0E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 10:26:04 -0400
Received: by rv-out-0506.google.com with SMTP id k40so5183358rvb.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=G0mRpg833Or+XpE0hfNDKYeON11g4+7WHX9Bj+lSEZ4=;
        b=rp1iqMWSxh2WvprROMaoSw/RS3pCrBJTe3Z+6oXyQh9VR8dyq0Ef1ED4aM5sdy5hCV
         1XyjzlBmzIoJCiBmj6VhbfAyHDeW+I7xAtSOTZqjewejg/x5PcGlFcsF3EFaKVO3LOXu
         ZawArtgeiy5vmrWkKMRe0coeQHSuHIgywTrVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iSDfK3npQ/l5af9SXk1S9jBjK0Rh4yutUyLyM0DJAXPGAi8I6YSdoiPG0ZeR6hnPDq
         Bpfse9BEA4lWjhNd9CyHEFJ2Wl07sOYt8qmv0ZBXVJ7bkDeWfbymB7CSLL6NL6MdD4Uz
         Fr30Xc0E9H9foEv/sCvt/u09bxW6asDj3NbVA=
Received: by 10.140.200.16 with SMTP id x16mr6523148rvf.120.1213885560565;
        Thu, 19 Jun 2008 07:26:00 -0700 (PDT)
Received: from @ ( [70.114.134.204])
        by mx.google.com with ESMTPS id 7sm768867ywo.7.2008.06.19.07.25.58
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Jun 2008 07:25:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8wx2zibp.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85479>

On Wed, Jun 18, 2008 at 11:52:42AM -0700, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 17 Jun 2008, Junio C Hamano wrote:
> >
> >> Jeff King <peff@peff.net> writes:
> >> 
> >> > I think the only right way to accomplish this is to convert the revision
> >> > and diff parameters into a parseopt-understandable format.
> >> 
> >> Not necessarily.  You could structure individual option parsers like how 
> >> diff option parsers are done.  You iterate over argv[], feed diff option 
> >> parser the current index into argv[] and ask if it is an option diff 
> >> understands, have diff eat the option (and possibly its parameter) to 
> >> advance the index, or allow diff option to say "I do not understand 
> >> this", and then handle it yourself or hand it to other parsers.
> >
> > AFAIR Pierre tried a few ways, and settled with a macro to introduce the 
> > diff options into a caller's options.
> >
> > IOW it would look something like this:
> >
> > static struct option builtin_what_options[] = {
> > 	[... options specific to this command ...]
> > 	DIFF__OPT(&diff_options)
> > };
> 
> I think that is the more painful approach Jeff mentioned, and my comment
> was to show that it is not the only way.
> 

It seems to me that you could implement Jeff's
PARSE_OPT_STOP_AT_UNKNOWN, and then if multiple option parsers are
needed you would simply loop over parse_options for each of the
commands, waiting for argc to stop changing.  Of course Jeff's flag
would also need to stop parse_options from eating the first argument.
Is this sort of what you are suggesting Junio?

--
Shawn
