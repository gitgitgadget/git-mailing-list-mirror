From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v4 2/2] interpret-trailers: add option for in-place
 editing
Date: Fri, 15 Jan 2016 11:34:02 +0100
Message-ID: <20160115103402.GC21205@distanz.ch>
References: <1452790676-11937-1-git-send-email-tklauser@distanz.ch>
 <1452790676-11937-3-git-send-email-tklauser@distanz.ch>
 <xmqqio2vki0i.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 11:34:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK1hv-0000Zy-Al
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 11:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbcAOKeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 05:34:09 -0500
Received: from sym2.noone.org ([178.63.92.236]:53141 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396AbcAOKeG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 05:34:06 -0500
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3phf4r0k52zQWhJ; Fri, 15 Jan 2016 11:34:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqio2vki0i.fsf@gitster.mtv.corp.google.com>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284156>

On 2016-01-14 at 21:45:01 +0100, Junio C Hamano <gitster@pobox.com> wrote:
> Tobias Klauser <tklauser@distanz.ch> writes:
> 
> > Add a command line option --in-place to support in-place editing akin to
> > sed -i.  This allows to write commands like the following:
> >
> >   git interpret-trailers --trailer "X: Y" a.txt > b.txt && mv b.txt a.txt
> >
> > in a more concise way:
> >
> >   git interpret-trailers --trailer "X: Y" --in-place a.txt
> >
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> 
> Thanks, will replace.  I found some micronits, none of which I think
> is big enough to require another reroll, but since I found them
> already, I'll just point them out.

Thanks a lot for your review!

> > diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
> > index 322c436a494c..aee785cffa8d 100755
> > --- a/t/t7513-interpret-trailers.sh
> > +++ b/t/t7513-interpret-trailers.sh
> > @@ -326,6 +326,46 @@ test_expect_success 'with complex patch, args and --trim-empty' '
> >  	test_cmp expected actual
> >  '
> >  
> > +test_expect_success 'in-place editing with basic patch' '
> > +	cat basic_message >message &&
> > +	cat basic_patch >>message &&
> > +	cat basic_message >expected &&
> > +	echo >>expected &&
> > +	cat basic_patch >>expected &&
> > +	git interpret-trailers --in-place message &&
> > +	test_cmp expected message
> > +'
> > +
> > +test_expect_success 'in-place editing with additional trailer' '
> > +	cat basic_message >message &&
> > +	cat basic_patch >>message &&
> > +	cat basic_message >expected &&
> > +	echo >>expected &&
> > +	cat >>expected <<-\EOF &&
> > +		Reviewed-by: Alice
> > +	EOF
> 
> The "echo" is not needed, if you just include a leading blank line
> in the here-document you use with this "cat".

Classical case of copy&paste and me not thinking enough what could be
simplified ;)

> > +test_expect_success POSIXPERM,SANITY "in-place editing doesn't clobber original file on error" '
> > +	cat basic_message >message &&
> > +	chmod -r message &&
> > +	test_must_fail git interpret-trailers --trailer "Reviewed-by: Alice" --in-place message &&
> > +	chmod +r message &&
> > +	test_cmp message basic_message
> > +'
> 
> If for some reason interpret-trailers fails to fail, this would
> leave an unreadable 'message' in the trash directory.  Maybe no
> other tests that come after this one want to be able to read the
> contents of the file right now, but this is an accident waiting to
> happen:
> 
> 	cat basic_message >message &&
> +       test_when_finished "chmod +r message" &&
>         chmod -r message &&
>         test_must_fail ... &&
> 	chmod +r message &&
>         test_cmp ...

Indeed, I forgot about this. I saw you already folded in the missing
'chmod +r message' in your tree. Thanks for that!

> 
> > +	if (!S_ISREG(st.st_mode))
> > +		die(_("file %s is not a regular file"), file);
> > +	if (!(st.st_mode & S_IWUSR))
> > +		die(_("file %s is not writable by user"), file);
> 
> Hmph, are these two necessary, and do they make sense?

The check for S_ISREG I added because it's also done in sed:

	$ mkdir /tmp/foobar
	$ sed -i 's/foo/baz/' /tmp/foobar
	sed: couldn't edit foobar: not a regular file

I quickly checked their source and they do indeed a check for S_ISREG in
case of in-place editing (sed v4.2.2-98-g61c0a53ec997,
sed/execute.c:600)

But the writable check is probably too strict, I agree.

> When doing an in-place thing, the primary thing you care about is
> that you can read from the file and you can deposit the result of
> the rewrite under the original name.  If for some reason a system
> allowed you to read from a non-regular file and interpret-trailers
> can do a sensible thing to the contents you read from there, do you
> have to insist that original must be S_ISREG()?  Also, a funny file
> (e.g. "interpret-trailers -i .") is likely to fail on the input
> side.
> 
> For the latter,
> 
>     $ chmod a-w COPYING
>     $ sed -i -e 's/a/b/' COPYING
> 
> seems to succeed _and_ leave the permission bits intact, i.e.
> I get this before and after "sed -i"
> 
>     $ ls -l COPYING
>     -r--r----- 1 jch eng 18765 Jan 14 12:34 COPYING
> 
> which hints at two points:
> 
>  - The users (of "sed -i") may have demanded that in-place update of
>    read-only file must be allowed, and there may have been a good
>    reason for wanting to do so.  That reason may apply equally to us
>    here.

True. AFAIK rename(2) only need write permissions on the containing directory,
not the source/destination file itself. And rename_tempfile should barf
about that. So the S_IWUSR is unnecessarily strict...

>  - If we were to follow suit, then we should not forget to restore
>    the permission bits on the new file.

This should already be the case to to st.st_mode being passed to
xmks_tempfile_m, no?

> In any case, these are something we could loosen after people gain
> experience with the feature, so I think it is OK as-is, at least for
> now.

I agree.

> > +	if (in_place)
> > +		if (rename_tempfile(&trailers_tempfile, file))
> > +			die_errno(_("could not rename temporary file to %s"), file);
> > +
> 
> I briefly wondered if this should be
> 
> 	if (in_place && rename_tempfile(...))
> 		die_errno(...);
> 
> to save one indentation level, but I think it is a bad idea,
> i.e. the above code should stay as-is.

Thought about this for a while too, but I concluded that it would hurt
readability more than it would help.
