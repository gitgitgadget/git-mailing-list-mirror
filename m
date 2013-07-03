From: John Keeping <john@keeping.me.uk>
Subject: Re: Review of git multimail
Date: Wed, 3 Jul 2013 09:29:02 +0100
Message-ID: <20130703082902.GE9161@serenity.lan>
References: <1372793019-12162-1-git-send-email-artagnon@gmail.com>
 <7vsizwiowt.fsf@alter.siamese.dyndns.org>
 <51D3DA9A.9090604@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 03 10:29:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuIRF-0003He-2X
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 10:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739Ab3GCI3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 04:29:15 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:44597 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab3GCI3M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 04:29:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 6E7F4606519;
	Wed,  3 Jul 2013 09:29:11 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o2c+xWTfY38q; Wed,  3 Jul 2013 09:29:10 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id EC65B606529;
	Wed,  3 Jul 2013 09:29:04 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <51D3DA9A.9090604@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229465>

On Wed, Jul 03, 2013 at 10:02:34AM +0200, Michael Haggerty wrote:
> On 07/03/2013 12:21 AM, Junio C Hamano wrote:
> > Ramkumar Ramachandra <artagnon@gmail.com> writes:
> > 
> >>>     def get(self, name, default=''):
> >>>         try:
> >>>             values = self._split(read_git_output(
> >>>                     ['config', '--get', '--null', '%s.%s' % (self.section, name)],
> >>>                     env=self.env, keepends=True,
> >>>                     ))
> >>
> >> Wait, what is the point of using --null and then splitting by hand
> >> using a poorly-defined static method?  Why not drop the --null and
> >> splitlines() as usual?
> > 
> > You may actually have spotted a bug or misuse of "--get" here.
> > 
> > With this sample configuration:
> > 
> >         $ cat >sample <<\EOF
> >         [a]
> >                 one = value
> >                 one = another
> > 
> >         [b]
> >                 one = "value\nanother"
> >         EOF
> > 
> > A script cannot differentiate between them without using '--null'.
> > 
> > 	$ git config -f sample --get-all a.one
> >         $ git config -f sample --get-all b.one
> > 
> > But that matters only when you use "--get-all", not "--get".  If
> > this method wants to make sure that the user did not misuse a.one
> > as a multi-valued configuration variable, use of "--null --get-all"
> > followed by checking how many items the command gives you back would
> > be a way to do so.
> 
> No, the code in question was a simple sanity check (i.e., mostly a check
> of my own sanity and understanding of "git config" behavior) preceding
> the information-losing next line "return values[0]".  If it had been
> meant as a check that the user hadn't misconfigured the system, then I
> wouldn't have used assert but rather raised a ConfigurationException
> with an explanatory message.
> 
> I would be happy to add the checking that you described, but I didn't
> have the impression that it is the usual convention.  Does code that
> wants a single value from the config usually verify that there is
> one-and-only-one value, or does it typically just do the equivalent of
> "git config --get" and use the returned (effectively the last) value?

Doesn't "git config --get" return an error if there are multiple values?
The answer is apparently "no" - I wrote the text below from
git-config(1) and then checked the behaviour.  This seems to be a
regression in git-config (bisect running now).

I think the "correct" answer is what's below, but it doesn't work like
this in current Git:

    If you want a single value then I think it's normal to just read the
    output of "git config" and let it handle the error cases, without
    needing to split the result at all.

    I think there is a different issue in the "except" block following
    the code quoted at the top though - you will return "default" if a
    key happens to be multi-valued.  The script should check the return
    code and raise a ConfigurationException if it is 2.
