From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] vcs-svn: Refactor dump_export code into dispatch
 table
Date: Wed, 2 Feb 2011 08:26:31 +0530
Message-ID: <20110202025626.GC11339@kytes>
References: <1296570403-9082-1-git-send-email-artagnon@gmail.com>
 <1296570403-9082-4-git-send-email-artagnon@gmail.com>
 <20110201174241.GB3771@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 02 03:55:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkSsi-0003QB-6G
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 03:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799Ab1BBCzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 21:55:39 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58485 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab1BBCzi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 21:55:38 -0500
Received: by gyb11 with SMTP id 11so2777773gyb.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 18:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=eHdE81sB3qfFWxdJJdRJ9h+bXDok3B9MsXnJmB48cew=;
        b=nTiTwci7yaVCOcnQgbj0xPBI/PPaNohN1rO2Icg2kuQN0nGQVZIBwwdcpyCiv88/1w
         F4aDQT3YeWOg1ULfUouG4CcisN6GjlKtgKZQdDBfv7TpkURohYVXSNKnC1y+uEmLfNPT
         XfDc1+dIzndY+JeDzQsUCpOVtbNZBGZ6Hwqtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=d2nVV36/KKpzI84Wkfsn8Cq17D8i7nEwOtVv40BoljF9bpcF9JXJJ3a17oe/IQUMgO
         046H6ynDd19vcf3X6QbdxxJVcLaogDfLRPaI7oNHGoVaApxKig6i9vxK3LsfU3fwr0YR
         i2iqxluWwJ+9horqnovijchpWfP1Tz0eq5AVA=
Received: by 10.151.153.1 with SMTP id f1mr10190304ybo.144.1296615338274;
        Tue, 01 Feb 2011 18:55:38 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id k1sm14622168ybj.0.2011.02.01.18.55.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 18:55:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110201174241.GB3771@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165890>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> 
> > +++ b/vcs-svn/dump_export.c
> > @@ -11,6 +11,48 @@
> [...]
> > +static state_fn *const dispatch_table[NODE_KIND_COUNT][NODE_ACTION_COUNT] = {
> > +	/* NODE_KIND_UNKNOWN */
> > +	{abort, abort, abort, Adelete, abort},
> > +	/* NODE_KIND_NORMAL */
> > +	{abort, Nchange, Nadd, Adelete, Nreplace},
> > +	/* NODE_KIND_EXECUTABLE */
> > +	{abort, Echange, Eadd, Adelete, Ereplace},
> > +	/* NODE_KIND_SYMLINK */
> > +	{abort, Schange, Sadd, Adelete, Sreplace},
> > +	/* NODE_KIND_GITLINK */
> > +	{abort, abort, abort, abort, abort},
> > +	/* NODE_KIND_DIR */
> > +	{abort, Dchange, Dadd, Adelete, Dreplace},
> > +	/* NODE_KIND_SUBDIR */
> > +	{abort, abort, abort, abort, abort}
> > +};
> 
> Heh.  I think that Junio was suggesting making the _parser_
> table-driven, meaning something like

Oops :p I'll fix this in the next round.

> 	... node_kinds[] = {
> 		{ "100644", sizeof("100644"), "file" },
> 		{ "100755", sizeof("100755"), "file", "svn:executable" },
> 		{ "120000", sizeof("120000"), "file", "svn:special" },
> 		{ "160000", sizeof("160000"), "file" },	/* NEEDSWORK: seems wrong" */
> 		{ "040000", sizeof("040000"), "dir" }
> 	};
> 
> (Side note: remember that 644 and 755 are permitted synonyms for
> 100644 and 100755!)
> 
> I personally think that simple state machines tend to be easier to
> follow if the current state is represented by the instruction pointer
> rather than a variable, as in the current fast-import.c.  But maybe
> that's a matter of taste?
> 
> Anyway, my other complaints about this dispatch_table are that the
> function names leave me rubbing my head and I can't keep the list
> of states you're transitioning between straight in my head.  I guess
> "Adelete" is an abbreviation for print_delete_node_action?  Is a
> callback needed at all (rather than just a string) for such actions?

True -- there are many intermediate layers where all kinds of
variables are getting set. It'll probably be a good idea to remove all
these abstraction layers and map fast-import commands directly to
dumpstream strings. I'll do this in the next iteration.

-- Ram
