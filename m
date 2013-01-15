From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 3/3] cvsimport: start adding cvsps 3.x support
Date: Tue, 15 Jan 2013 00:19:43 -0600
Message-ID: <CAEUsAPZV6rdFz5R6NN55qYr5se4bFJftE0xGSPAtXLp8jcO0vw@mail.gmail.com>
References: <7v8v7wiv3a.fsf@alter.siamese.dyndns.org>
	<1358127629-7500-1-git-send-email-gitster@pobox.com>
	<1358127629-7500-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, jrnieder@gmail.com, mhagger@alum.mit.edu,
	esr@thyrsus.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 07:20:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzsV-00072K-Lc
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 07:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205Ab3AOGTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 01:19:46 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:47875 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818Ab3AOGTp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 01:19:45 -0500
Received: by mail-lb0-f178.google.com with SMTP id l5so3547568lbo.9
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 22:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=3UTtKS6GZSREJYPXlERQuFg5jjwW4MtnhQxu0KO8rtU=;
        b=eoOMVYTJbXFuKaA80mpOlOItUDppy1Y03ysxKxKcQemF560vxdhlwgXIyfW4FuXQww
         PXMKhrDuf4JHSuok0KINO7T9SPH4TYaCSJRUyhK0A1fGR9R5jSKsL4JaizELoEfXGrj9
         szxLaQ0qnjAaG+NOz04EoIa+BxVLLpedK0PEnCTXnEVbYn59Qr632AFlnO/JBfglSdSK
         QvccLjq8pgtuYbo4pO10WtBBpcAfx9g5j+DSmYukMSqPDjoCMMk6YC5mYHnTX4Bcr2V5
         jn5ErOHXkluvwiJ181Vvn1M1hfK+50rkCUm8OEnN7Dp1WnKwLVFEPVyrPMaagNV+SpAM
         E9Qg==
Received: by 10.112.82.202 with SMTP id k10mr36549989lby.22.1358230783497;
 Mon, 14 Jan 2013 22:19:43 -0800 (PST)
Received: by 10.114.94.228 with HTTP; Mon, 14 Jan 2013 22:19:43 -0800 (PST)
In-Reply-To: <1358127629-7500-4-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: JfGXJUOtBszKefe2zjjopQk8FcE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213597>

On Sun, Jan 13, 2013 at 7:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The new cvsps 3.x series lacks support of some options cvsps 2.x
> series had and used by cvsimport-2; add a replacement program from
> the author of cvsps 3.x and allow users to choose it by setting the
> GIT_CVSPS_VERSION environment variable to 3.  We would later add
> support to auto-detect the version of installed cvsps to this code
> when the environment variable is not set.
>
> Note that in this step, cvsimport-3 that relies on cvsps 3.x does
> not have any test coverage.  As cvsimport-3 supports most of the
> command line options cvsimport-2, we should be able to tweak some of
> t96xx tests and run them with GIT_CVSPS_VERSION set to both 2 and 3,
> but that is a topic of later patches that should come on top.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Makefile           |  18 ++-
>  git-cvsimport-3.py | 344 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  git-cvsimport.sh   |   4 +-
>  3 files changed, 359 insertions(+), 7 deletions(-)
>  create mode 100755 git-cvsimport-3.py
>
> diff --git a/Makefile b/Makefile
> index b022db2..060cdc2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -470,8 +470,9 @@ SCRIPT_PERL += git-relink.perl
>  SCRIPT_PERL += git-send-email.perl
>  SCRIPT_PERL += git-svn.perl
>
> -SCRIPT_PYTHON += git-remote-testpy.py
> +SCRIPT_PYTHON += git-cvsimport-3.py
>  SCRIPT_PYTHON += git-p4.py
> +SCRIPT_PYTHON += git-remote-testpy.py
>
>  SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
>           $(patsubst %.perl,%,$(SCRIPT_PERL)) \
> @@ -575,8 +576,11 @@ endif
>  ifndef CVSPS2_PATH
>         CVSPS2_PATH = cvsps
>  endif
> +ifndef CVSPS3_PATH
> +       CVSPS3_PATH = cvsps
> +endif
>
> -export PERL_PATH PYTHON_PATH CVSPS2_PATH
> +export PERL_PATH PYTHON_PATH CVSPS2_PATH CVSPS3_PATH
>
>  LIB_FILE = libgit.a
>  XDIFF_LIB = xdiff/lib.a
> @@ -1515,6 +1519,7 @@ PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
>  PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
>  TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
>  CVSPS2_PATH_SQ = $(subst ','\'',$(CVSPS2_PATH))
> +CVSPS3_PATH_SQ = $(subst ','\'',$(CVSPS3_PATH))
>  DIFF_SQ = $(subst ','\'',$(DIFF))
>
>  LIBS = $(GITLIBS) $(EXTLIBS)
> @@ -1757,12 +1762,15 @@ ifndef NO_PYTHON
>  $(patsubst %.py,%,$(SCRIPT_PYTHON)): GIT-CFLAGS GIT-PREFIX GIT-PYTHON-VARS
>  $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
>         $(QUIET_GEN)$(RM) $@ $@+ && \
> -       INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C git_remote_helpers -s \
> +       INSTLIBDIR_SQ=`MAKEFLAGS= $(MAKE) -C git_remote_helpers -s \
>                 --no-print-directory prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' \
> -               instlibdir` && \
> +               instlibdir | \
> +               sed -e "s/'/'\''/g"` && \
> +       echo "InstLibDir is <$$INSTLIBDIR_SQ>" && \
>         sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
>             -e 's|\(os\.getenv("GITPYTHONLIB"\)[^)]*)|\1,"@@INSTLIBDIR@@")|' \
> -           -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
> +           -e 's|@@CVSPS3_PATH@@|$(CVSPS3_PATH_SQ)|g' \
> +           -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR_SQ"'|g' \
>             $@.py >$@+ && \
>         chmod +x $@+ && \
>         mv $@+ $@
> diff --git a/git-cvsimport-3.py b/git-cvsimport-3.py
> new file mode 100755
> index 0000000..57f13b7
> --- /dev/null
> +++ b/git-cvsimport-3.py
> @@ -0,0 +1,344 @@
> +#!/usr/bin/env python
> +#
> +# Import CVS history into git
> +#
> +# Intended to be a near-workalike of Matthias Urlichs's Perl implementation.
> +#
> +# By Eric S. Raymond <esr@thyrsus.com>, December 2012
> +# May be redistributed under the license of the git project.
> +
> +import sys
> +
> +if sys.hexversion < 0x02060000:
> +    sys.stderr.write("git cvsimport: requires Python 2.6 or later.\n")
> +    sys.exit(1)
> +
> +import os, getopt, subprocess, tempfile, shutil
> +
> +DEBUG_COMMANDS = 1
> +
> +class Fatal(Exception):
> +    "Unrecoverable error."
> +    def __init__(self, msg):
> +        Exception.__init__(self)
> +        self.msg = msg
> +
> +def do_or_die(dcmd, legend=""):
> +    "Either execute a command or raise a fatal exception."
> +    if legend:
> +        legend = " "  + legend
> +    if verbose >= DEBUG_COMMANDS:
> +        sys.stdout.write("git cvsimport: executing '%s'%s\n" % (dcmd, legend))
> +    try:
> +        retcode = subprocess.call(dcmd, shell=True)
> +        if retcode < 0:
> +            raise Fatal("git cvsimport: child was terminated by signal %d." % -retcode)
> +        elif retcode != 0:
> +            raise Fatal("git cvsimport: child returned %d." % retcode)
> +    except (OSError, IOError) as e:
> +        raise Fatal("git cvsimport: execution of %s%s failed: %s" % (dcmd, legend, e))
> +
> +def capture_or_die(dcmd, legend=""):
> +    "Either execute a command and capture its output or die."
> +    if legend:
> +        legend = " "  + legend
> +    if verbose >= DEBUG_COMMANDS:
> +        sys.stdout.write("git cvsimport: executing '%s'%s\n" % (dcmd, legend))
> +    try:
> +        return subprocess.check_output(dcmd, shell=True)
> +    except subprocess.CalledProcessError as e:
> +        if e.returncode < 0:
> +            sys.stderr.write("git cvsimport: child was terminated by signal %d." % -e.returncode)
> +        elif e.returncode != 0:
> +            sys.stderr.write("git cvsimport: child returned %d." % e.returncode)
> +        sys.exit(1)
> +
> +class cvsps:
> +    "Method class for cvsps back end."
> +
> +    cvsps = "@@CVSPS3_PATH@@"
> +    def __init__(self):
> +        self.opts = ""
> +        self.revmap = None
> +    def set_repo(self, val):
> +        "Set the repository root option."
> +        if not val.startswith(":"):
> +            if not val.startswith(os.sep):
> +                val = os.path.abspath(val)
> +            val = ":local:" + val
> +        self.opts += " --root '%s'" % val
> +    def set_authormap(self, val):
> +        "Set the author-map file."
> +        self.opts += " -A '%s'" % val
> +    def set_fuzz(self, val):
> +        "Set the commit-similarity window."
> +        self.opts += " -z %s" % val
> +    def set_nokeywords(self):
> +        "Suppress CVS keyword expansion."
> +        self.opts += " -k"
> +    def add_opts(self, val):
> +        "Add options to the engine command line."
> +        self.opts += " " + val
> +    def set_exclusion(self, val):
> +        "Set a file exclusion regexp."
> +        self.opts += " -n -f '%s'" % val
> +    def set_after(self, val):
> +        "Set a date threshold for incremental import."
> +        self.opts += " -d '%s'" % val
> +    def set_revmap(self, val):
> +        "Set the file to which the engine should dump a reference map."
> +        self.revmap = val
> +        self.opts += " -R '%s'" % self.revmap
> +    def set_module(self, val):
> +        "Set the module to query."
> +        self.opts += " " + val
> +    def command(self):
> +        "Emit the command implied by all previous options."
> +        return self.cvsps + "--fast-export " + self.opts

"--fast-export" string is missing a leading space.  With this fix and
the latest cvsps build I'm seeing 6 of 15 failures for t9650 which is
what I was getting out of the patched t9600.

Chris
