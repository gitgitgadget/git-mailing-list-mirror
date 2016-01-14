From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v3 2/2] interpret-trailers: add option for in-place
 editing
Date: Thu, 14 Jan 2016 10:31:57 +0100
Message-ID: <20160114093157.GF26950@distanz.ch>
References: <1452688989-13746-1-git-send-email-tklauser@distanz.ch>
 <1452688989-13746-3-git-send-email-tklauser@distanz.ch>
 <CAPig+cSX04OSLQVk-LHm2UQOAqThQUJuFhuhUfoNmUvHmZpPsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 10:32:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJeGJ-0002Xk-Tb
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 10:32:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbcANJcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 04:32:08 -0500
Received: from sym2.noone.org ([178.63.92.236]:55587 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752096AbcANJcB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 04:32:01 -0500
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3ph0lg1kFyzQWhD; Thu, 14 Jan 2016 10:31:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAPig+cSX04OSLQVk-LHm2UQOAqThQUJuFhuhUfoNmUvHmZpPsA@mail.gmail.com>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284024>

On 2016-01-13 at 19:15:54 +0100, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jan 13, 2016 at 7:43 AM, Tobias Klauser <tklauser@distanz.ch> wrote:
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
> > diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
> > @@ -326,6 +326,38 @@ test_expect_success 'with complex patch, args and --trim-empty' '
> > +test_expect_success 'in-place editing on stdin' '
> 
> Maybe say:
> 
>     "in-place editing on stdin disallowed"
> 
> or something?

Agree, will change in v4.

> > +       test_must_fail git interpret-trailers --trailer "Reviewed-by: Alice" --in-place < basic_message
> > +'
> > +
> > +test_expect_success 'in-place editing on non-existing file' '
> > +       test_must_fail git interpret-trailers --trailer "Reviewed-by: Alice" --in-place nonexisting &&
> > +       test_path_is_missing nonexisting
> > +'
> 
> An significant shortcoming of the first version of this patch series
> was that it did not treat the input file as precious, and would
> happily delete it if trailer processing failed for any reason. This is
> behavior we'd like to protect against. Toward that end, have you
> considered adding a test to verify that the input file is indeed
> considered precious, and not deleted upon failure? One way to do so
> would be to write a test which triggers one of the failure conditions
> of the interpret-trailers framework. Looking at the source code, one
> possible way would be to make trailer.c:read_input_file() fail, for
> instance, by making the file unreadable (with 'chmod -r', though you'd
> have to protect the test with the POSIXPERM prerequisite).

Good point. Yes, such a test should definitely be added, I forgot about
it during the reroll. I'll look into your suggestion and add a test in
v4.

> More below.
> 
> > diff --git a/trailer.c b/trailer.c
> > @@ -858,6 +861,31 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
> >
> >         lines = read_input_file(file);
> >
> > +       if (in_place) {
> > +               struct stat st;
> > +               struct strbuf template = STRBUF_INIT;
> > +               const char *tail;
> > +
> > +               if (stat(file, &st))
> > +                       die_errno(_("could not stat %s"), file);
> > +               if (!S_ISREG(st.st_mode))
> > +                       die(_("file %s is not a regular file"), file);
> > +               if (!(st.st_mode & S_IWUSR))
> > +                       die(_("file %s is not writable by user"), file);
> > +
> > +               /* Create temporary file in the same directory as the original */
> > +               tail = strrchr(file, '/');
> > +               if (tail != NULL)
> > +                       strbuf_add(&template, file, tail - file + 1);
> > +               strbuf_addstr(&template, "git-interpret-trailers-XXXXXX");
> > +
> > +               xmks_tempfile_m(&trailers_tempfile, template.buf, st.st_mode);
> > +               strbuf_release(&template);
> > +               outfile = fdopen_tempfile(&trailers_tempfile, "w");
> > +               if (!outfile)
> > +                       die_errno(_("could not open temporary file"));
> > +       }
> 
> Hmm, the current logic of process_trailers() is pretty easily
> understood at a glance, but this new (relatively huge) chunk of code
> obscures the overall operation. Have you considered factoring the new
> code out into its own function in order to keep the overall flow of
> process_trailers() clean? (Genuine question; I don't necessarily feel
> so strongly about it to demand such a change.)

No, I haven't considered this yet. But I agree that moving this code to
a separate function certainly will keep process_trailers() much more
readable. Also it would simplify future reusability if anyone else would
need similar functionality.

> >         /* Print the lines before the trailers */
> >         trailer_end = process_input_file(outfile, lines, &in_tok_first, &in_tok_last);
> >
> > @@ -872,5 +900,10 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
> >         /* Print the lines after the trailers as is */
> >         print_lines(outfile, lines, trailer_end, INT_MAX);
> >
> > +       if (in_place) {
> > +               if (rename_tempfile(&trailers_tempfile, file))
> > +                       die_errno(_("could not rename temporary file to %s"), file);
> > +       }
> 
> You could drop the unnecessary braces.

Ok, I'll drop the braces for v4.

Thanks a lot for your review!
