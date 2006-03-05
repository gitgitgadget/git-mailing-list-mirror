From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] git-blame: Make the output human readable
Date: Sun, 5 Mar 2006 13:38:01 +0100
Message-ID: <20060305123800.GD23448@c165.ib.student.liu.se>
References: <20060305110351.GA23448@c165.ib.student.liu.se> <7vbqwlgkhk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sun Mar 05 13:38:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFsVK-0000KQ-Ia
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 13:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbWCEMiJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 07:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275AbWCEMiJ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 07:38:09 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:12522 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1752272AbWCEMiI
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 07:38:08 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 1CFA64118; Sun,  5 Mar 2006 13:53:21 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FFsUr-0003VM-00; Sun, 05 Mar 2006 13:38:01 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqwlgkhk.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17228>

On Sun, Mar 05, 2006 at 04:10:47AM -0800, Junio C Hamano wrote:
> Fredrik Kuivinen <freku045@student.liu.se> writes:
> 
> > The default output mode is slightly different from git-annotate's.
> > However, git-annotate's output mode can be obtained by using the
> > '-c' flag.
> 
> It might be better to default to human readable and make the
> script consumption format an option, if only to reduce typing.
> 

The default output format is human readable, but it is different from
the output format used by git-annotate. By default, (when the patch is
applied) git-blame outputs lines with on the following form:

   <eight first digits of commit SHA1> (<first 15 letters of committer's name> YYYY-MM-DD HH:MM:SS TZ <line number, right justified>) file contents

where as git-annotate uses

   <eight first digits of commit SHA1>\t(<committer's name, right justified, padded to 10 characters> YYYY-MM-DD HH:MM:SS TZ\t<line number>)file contents

I find the first format easier to read since everything is aligned (we
always output 15 characters for the committer's name padded with
spaces if necessary and the line numbers are padded appropriately). It
also takes up less space on screen since it doesn't use tabs.

However, I wanted to use the tests for git-annotate to test git-blame
too and the tests do, of course, expect the output to be in
git-annotate's format. Hence, the '-c' switch.

We may want to add an output format suitable for scripts too, which
just lists the SHA1. But I don't think it is much more difficult to
parse the format above, at least not if you just want the SHA1s.

> > diff --git a/Makefile b/Makefile
> > index b6d8804..eb1887d 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -534,6 +534,10 @@ git-rev-list$X: rev-list.o $(LIB_FILE)
> >  	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> >  		$(LIBS) $(OPENSSL_LIBSSL)
> >  
> > +git-blame$X: blame.o $(LIB_FILE)
> > +	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> > +		$(LIBS) -lm
> > +
> 
> I wonder what it is about to link this binary different from others...
> 

It uses log(3) to compute the number of digits needed to represent the
last line number. It is probably better to this some other way
though...

> > +char* format_time(unsigned long time, const char* tz)
> > +{
> > +	static char time_buf[128];
> > +	time_t t = time;
> > +
> > +	strftime(time_buf, sizeof(time_buf), "%Y-%m-%d %H:%M:%S ", gmtime(&t));
> > +	strcat(time_buf, tz);
> > +	return time_buf;
> > +}
> 
> I think this shows GMT with time offset, which is compatible
> with the human readable time Johannes did to git-annotate.  I do
> not know what timezone CVS annotate shows its dates offhand (it
> seems to only show dates).  Johannes, is this an attempt to
> match what CVS does?
> 
> I am wondering if we want to be in line with the date formatting
> convention used for our commits and tags, that is, to show local
> timestamp with timezone.  The code to use would be show_date()
> from date.c if we go that route.
> 

I think it is a good idea. Consistency is good.

- Fredrik
