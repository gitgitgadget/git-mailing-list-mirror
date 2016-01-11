From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 2/2] interpret-trailers: add option for in-place editing
Date: Mon, 11 Jan 2016 18:13:45 +0100
Message-ID: <20160111171345.GA26950@distanz.ch>
References: <1452519213-1819-1-git-send-email-tklauser@distanz.ch>
 <1452519213-1819-3-git-send-email-tklauser@distanz.ch>
 <vpqziwc3wjv.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jan 11 18:13:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIg2T-000192-9S
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 18:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934297AbcAKRNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 12:13:49 -0500
Received: from sym2.noone.org ([178.63.92.236]:35311 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934254AbcAKRNs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 12:13:48 -0500
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3pfM7v2DhnzQWhD; Mon, 11 Jan 2016 18:13:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <vpqziwc3wjv.fsf@anie.imag.fr>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283676>

Oops, I just realized I forgot the v2 in the subject line :-( Sorry
about that.

On 2016-01-11 at 17:33:56 +0100, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Tobias Klauser <tklauser@distanz.ch> writes:
> 
> > @@ -843,7 +844,9 @@ static void free_all(struct trailer_item **first)
> >  	}
> >  }
> >  
> > -void process_trailers(const char *file, int trim_empty, struct string_list *trailers)
> > +static struct tempfile trailers_tempfile;
> 
> Does this need to be a static global? I'd rather have this be a local
> variable of process_trailers.

I'm using a static global in order to have it automatically zeroed out
and according to the documentation in tempfile.h it can be reused. Also,
all other users of struct tempfile (except for lockfile.h) are using it
this way.

> 
> > +			die_errno(_("could not fdopen tempfile"));
> 
> I think you should spell it "could not open temporary file" to be more
> user-friendly.

Ok, will adjust.

> > @@ -872,5 +900,10 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
> >  	/* Print the lines after the trailers as is */
> >  	print_lines(outfile, lines, trailer_end, INT_MAX);
> >  
> > +	if (in_place) {
> > +		if (rename_tempfile(&trailers_tempfile, file))
> > +			die_errno(_("could not rename tempfile"));
> > +	}
> 
> When this happens, I think you also want to try removing the temporary
> file. Not sure, though: it may be nice to leave the tempfile for the
> user to debug. What do we do in other places of the code?

According to the comment in tempfile.h an atexit(3) handler is installed
by prepare_tempfile_object() (which in turn is called by
x?mks_tempfile_*) which will remove the file in this case. Or did I miss
something here?

AFAICS the two other current users of rename_tempfile() also don't
explicitely treat the tempfile on error.

> It may help the user to get "could not rename temporary file %s to %s"
> in case this happens.

I think if we keep the current semantics (where the tempfile will be
deleted by the atexit(3) handler), it doesn't make sense to mention the
filename in the error message as the file will be gone by the time the
user has any chance to react. I'd suggest somethin like "could not
rename temporary file to %s".

> On overall, the split makes the series much more pleasant to review, and
> other than these details, this sounds good to me. Thanks!

Thanks a lot for your feedback!
