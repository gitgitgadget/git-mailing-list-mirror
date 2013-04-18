From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 1/2] rev-parse: add --filename-prefix option
Date: Thu, 18 Apr 2013 15:42:57 +0100
Message-ID: <20130418144257.GZ2278@serenity.lan>
References: <cover.1365364193.git.john@keeping.me.uk>
 <cover.1365539059.git.john@keeping.me.uk>
 <0d570e110dbf714310f9cbc4fa47e711630707f2.1365539059.git.john@keeping.me.uk>
 <CALkWK0nir7pJF-7YLRQF0jCR4dbb-JNBheD-4zKeQR0K9F9nZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 16:43:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USq3V-0002Qr-E8
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 16:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967152Ab3DROnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 10:43:15 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:41423 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966753Ab3DROnO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 10:43:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A40E0CDA5E7;
	Thu, 18 Apr 2013 15:43:12 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5jDJgwWsXvIl; Thu, 18 Apr 2013 15:43:08 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id AF87DCDA525;
	Thu, 18 Apr 2013 15:42:59 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CALkWK0nir7pJF-7YLRQF0jCR4dbb-JNBheD-4zKeQR0K9F9nZg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221660>

On Thu, Apr 18, 2013 at 07:58:25PM +0530, Ramkumar Ramachandra wrote:
> John Keeping wrote:
> > This adds a prefix string to any filename arguments encountered after it
> > has been specified.
> 
> Very nice.  I thought we'd have to resort to path mangling in shell to
> fix git-submodule.sh.  Glad to see that we can go with something
> cleaner.
> 
> Perhaps pull some bits from your nice Documentation into the commit message?

Good idea.  I intended to re-write the commit message for v2 since the
patch was completely re-written but forgot by the time I'd sorted out
patch 2 as well.  I will do for v3.

> > diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> > index f267a1d..de894c7 100644
> > --- a/builtin/rev-parse.c
> > +++ b/builtin/rev-parse.c
> > @@ -212,11 +212,17 @@ static void show_datestring(const char *flag, const char *datestr)
> >         show(buffer);
> >  }
> >
> > -static int show_file(const char *arg)
> > +static int show_file(const char *arg, int output_prefix)
> 
> Okay, so you've essentially patched show_file() to accept an
> additional argument, and modified callers to call with this additional
> argument.  I suppose
> show_(rev|reference|default|flag|rev|with_type|datestring|abbrev)
> don't need to be patched, as they are path-independent.
> 
> >  {
> >         show_default();
> >         if ((filter & (DO_NONFLAGS|DO_NOREV)) == (DO_NONFLAGS|DO_NOREV)) {
> > -               show(arg);
> > +               if (output_prefix) {
> > +                       const char *prefix = startup_info->prefix;
> > +                       show(prefix_filename(prefix,
> > +                                            prefix ? strlen(prefix) : 0,
> > +                                            arg));
> > +               } else
> > +                       show(arg);
> 
> Uh, why do you need output_prefix?  If startup_info->prefix is set,
> use it.  Is startup_info->prefix set by anyone by cmd_rev_parse()?

output_prefix is a flag to say "do we want to show the prefix".  We need
it because show_file is used for the "--" argument separator as well as
file paths.  Without a separate flag we end up prefixing "--" with the
prefix path.

> > @@ -470,6 +476,7 @@ N_("git rev-parse --parseopt [options] -- [<args>...]\n"
> >  int cmd_rev_parse(int argc, const char **argv, const char *prefix)
> > @@ -535,6 +542,13 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
> >                                 i++;
> >                                 continue;
> >                         }
> > +                       if (!strcmp(arg, "--prefix")) {
> > +                               prefix = argv[i+1];
> > +                               startup_info->prefix = prefix;
> > +                               output_prefix = 1;
> > +                               i++;
> > +                               continue;
> > +                       }
> 
> Wait, why isn't prefix filled in when run_builtin() calls this?  Oh,
> right: because we didn't mark this builtin with RUN_SETUP or
> RUN_SETUP_GENTLY.  Okay, now why didn't we change that?  Because it
> would be a major problem (all our scripts would break) if rev-parse
> did cd-to-toplevel.

prefix is already set, by setup_git_git_directory.  The point is that we
just change the values set in setup_git_directory so that the command
behaves as if it were run from a subdirectory.

> Why are you setting prefix to argv[i+1], and then setting
> startup_info->prefix to that?  Is anyone else in cmd_rev_parse() going
> to use it?
> 
> > +prefix=$(git rev-parse --show-prefix)
> > +cd "$(git rev-parse --show-toplevel)"
> > +eval "set -- $(git rev-parse --sq --prefix "$prefix" "$@")"
> 
> I'm wondering if you need such a convoluted usage though.  Will you
> ever need to specify a prefix by hand that is different from what git
> rev-parse --show-toplevel returns?  If not, why don't you just
> rev-parse --emulate-toplevel, and get rid of specifying prefix by hand
> altogether?  Then again, this is a plumbing command, so the simplicity
> is probably more valuable.

How does that work?  When we run rev-parse with the --prefix argument
we're no longer in the subdirectory.

While this may look convoluted here, I don't think it is in normal usage
inside a script.  If you look at the way it's used in patch 2 we're
careful not to just remap all the arguments but to extract the flags
before remapping file paths when we know that everything we have is a
file path.

> > diff --git a/t/t1513-rev-parse-prefix.sh b/t/t1513-rev-parse-prefix.sh
> > new file mode 100755
> > index 0000000..5ef48d2
> > --- /dev/null
> > +++ b/t/t1513-rev-parse-prefix.sh
> > +test_expect_success 'empty prefix -- file' '
> > +       git rev-parse --prefix "" -- top sub1/file1 >actual &&
> > +       cat <<-EOF >expected &&
> 
> Nit: when you're not putting in variables, you can cat <<-\EOF.
> 
> > +test_expect_success 'empty prefix HEAD:./path' '
> > +       git rev-parse --prefix "" HEAD:./top >actual &&
> > +       git rev-parse HEAD:top >expected &&
> 
> Nit: why did you change "./top" to "top"?  Your --prefix option
> doesn't require you to change your arguments accordingly, does it?

The point is to show that the case where a prefix is applied
("HEAD:./top") is the same as the canonical form ("HEAD:top").

I should probably add a test for "HEAD:top" with a prefix to ensure that
we don't modify arguments like that.
