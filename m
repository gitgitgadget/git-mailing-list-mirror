From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major bugs.
Date: Thu, 3 Jan 2013 00:34:52 -0600
Message-ID: <CAEUsAPYwinmbDkSVu71WJRgUjLfBeNdKDFt6O1f8-Ti9evn6Hw@mail.gmail.com>
References: <20130101172645.GA5506@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Thu Jan 03 07:35:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqeOY-0004rV-Bw
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 07:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831Ab3ACGez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 01:34:55 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:57003 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab3ACGex (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 01:34:53 -0500
Received: by mail-la0-f41.google.com with SMTP id em20so7387534lab.14
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 22:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=hGpngyu4UZRtADQG16rqCr0qxExWKsvylcn8IWBrPo0=;
        b=XIRzM0yIfYhVUn20hoOvbilnbepK6AG3GCYTp3x1oqg3oHTPgfsoXGj+YeZhj35aFv
         64AhTQOuhvWOZN8dKM15yPjLN+rn4Eu/SkJFG6oXDWfjaz2XCts1THfjmQtTi8J0a39/
         OyGt1a2Oy11KZkIAYhLrsZQasX//jUf6AnkS5wI5GSEM6/yz7P4AyaFgoxeKRibi7Lno
         66CCdqxzWfJfztgVvjzm0Nvz+yz/L9axUuTOcBhYNJKIPTjN80+0jjWJ0ACM+CFecXMD
         +pukCLhp7CAjSe080fZ7eWXOD3wVNEl8/rToowF9Tc9karATR5z/xVax6VNhh1C+BcJX
         b8dQ==
Received: by 10.152.105.134 with SMTP id gm6mr46154247lab.31.1357194892268;
 Wed, 02 Jan 2013 22:34:52 -0800 (PST)
Received: by 10.114.94.228 with HTTP; Wed, 2 Jan 2013 22:34:52 -0800 (PST)
In-Reply-To: <20130101172645.GA5506@thyrsus.com>
X-Google-Sender-Auth: o3WQOVkG3RJyN-jDuvbF2HLCtqg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212569>

On Tue, Jan 1, 2013 at 11:26 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> diff --git a/git-cvsimport.py b/git-cvsimport.py
> new file mode 100755
> index 0000000..6407e8a
> --- /dev/null
> +++ b/git-cvsimport.py
> @@ -0,0 +1,342 @@
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
> +        return "cvsps --fast-export " + self.opts
> +
> +class cvs2git:
> +    "Method class for cvs2git back end."
> +    def __init__(self):
> +        self.opts = ""
> +        self.modulepath = "."
> +    def set_authormap(self, _val):
> +        "Set the author-map file."
> +        sys.stderr.write("git cvsimport: author maping is not supported with cvs2git.\n")
> +        sys.exit(1)
> +    def set_repo(self, _val):
> +        "Set the repository root option."
> +        sys.stderr.write("git cvsimport: cvs2git must run within a repository checkout directory.\n")
> +        sys.exit(1)
> +    def set_fuzz(self, _val):
> +        "Set the commit-similarity window."
> +        sys.stderr.write("git cvsimport: fuzz setting is not supported with cvs2git.\n")
> +        sys.exit(1)
> +    def set_nokeywords(self):
> +        "Suppress CVS keyword expansion."
> +        self.opts += " --keywords-off"
> +    def add_opts(self, val):
> +        "Add options to the engine command line."
> +        self.opts += " " + val
> +    def set_exclusion(self, val):
> +        "Set a file exclusion regexp."
> +        self.opts += " --exclude='%s'" % val
> +    def set_after(self, _val):
> +        "Set a date threshold for incremental import."
> +        sys.stderr.write("git cvsimport: incremental import is not supported with cvs2git.\n")
> +        sys.exit(1)
> +    def set_revmap(self, _val):
> +        "Set the file to which the engine should dump a reference map."
> +        sys.stderr.write("git cvsimport: can't get a reference map from cvs2git.\n")
> +        sys.exit(1)
> +    def set_module(self, val):
> +        "Set the module to query."
> +        self.modulepath = " " + val
> +    def command(self):
> +        "Emit the command implied by all previous options."
> +        return "(cvs2git --username=git-cvsimport --quiet --quiet --blobfile={0} --dumpfile={1} {2} {3} && cat {0} {1} && rm {0} {1})".format(tempfile.mkstemp()[1], tempfile.mkstemp()[1], self.opts, self.modulepath)
> +
> +class filesource:
> +    "Method class for file-source back end."
> +    def __init__(self, filename):
> +        self.filename = filename
> +    def __complain(self, legend):
> +        sys.stderr.write("git cvsimport: %s with file source.\n" % legend)
> +        sys.exit(1)
> +    def set_repo(self, _val):
> +        "Set the repository root option."
> +        self.__complain("repository can't be set")
> +    def set_authormap(self, _val):
> +        "Set the author-map file."
> +        sys.stderr.write("git cvsimport: author maping is not supported with filesource.\n")
> +        sys.exit(1)
> +    def set_fuzz(self, _val):
> +        "Set the commit-similarity window."
> +        self.__complain("fuzz can't be set")
> +    def set_nokeywords(self, _val):
> +        "Suppress CVS keyword expansion."
> +        self.__complain("keyword suppression can't be set")
> +    def add_opts(self, _val):
> +        "Add options to the engine command line."
> +        self.__complain("other options can't be set")
> +    def set_exclusion(self, _val):
> +        "Set a file exclusion regexp."
> +        self.__complain("exclusions can't be set")
> +    def set_after(self, _val):
> +        "Set a date threshold for incremental import."
> +        pass
> +    def set_revmap(self, _val):
> +        "Set the file to which the engine should dump a reference map."
> +        sys.stderr.write("git cvsimport: can't get a reference map from cvs2git.\n")
> +        sys.exit(1)
> +    def set_module(self, _val):
> +        "Set the module to query."
> +        self.__complain("module can't be set")
> +    def command(self):
> +        "Emit the command implied by all previous options."
> +        return "cat " + self.filename
> +
> +if __name__ == '__main__':
> +    if sys.hexversion < 0x02060000:
> +        sys.stderr.write("git cvsimport: requires Python 2.6 or later.\n")
> +        sys.exit(1)
> +    (options, arguments) = getopt.getopt(sys.argv[1:], "vbe:d:C:r:o:ikus:p:z:P:S:aL:A:Rh")
> +    verbose = 0
> +    bare = False
> +    root = None
> +    outdir = os.getcwd()
> +    remotize = False
> +    import_only = False
> +    underscore_to_dot = False
> +    slashsubst = None
> +    authormap = None
> +    revisionmap = False
> +    backend = cvsps()
> +    for (opt, val) in options:
> +        if opt == '-v':
> +            verbose += 1
> +        elif opt == '-b':
> +            bare = True
> +        elif opt == '-e':
> +            for cls in (cvsps, cvs2git):
> +                if cls.__name__ == val:
> +                    backend = cls()
> +                    break
> +            else:
> +                sys.stderr.write("git cvsimport: unknown engine %s.\n" % val)
> +                sys.exit(1)
> +        elif opt == '-d':
> +            backend.set_repo(val)
> +        elif opt == '-C':
> +            outdir = val
> +        elif opt == '-r':
> +            remotize = True
> +        elif opt == '-o':
> +            sys.stderr.write("git cvsimport: -o is no longer supported.\n")
> +            sys.exit(1)
> +        elif opt == '-i':
> +            import_only = True
> +        elif opt == '-k':
> +            backend.set_nokeywords()
> +        elif opt == '-u':
> +            underscore_to_dot = True
> +        elif opt == '-s':
> +            slashsubst = val
> +        elif opt == '-p':
> +            backend.add_opts(val.replace(",", " "))
> +        elif opt == '-z':
> +            backend.set_fuzz(val)
> +        elif opt == '-P':
> +            backend = filesource(val)
> +            sys.exit(1)
> +        elif opt in ('-m', '-M'):
> +            sys.stderr.write("git cvsimport: -m and -M are no longer supported: use reposurgeon instead.\n")
> +            sys.exit(1)
> +        elif opt == '-S':
> +            backend.set_exclusion(val)
> +        elif opt == '-a':
> +            sys.stderr.write("git cvsimport: -a is no longer supported.\n")
> +            sys.exit(1)
> +        elif opt == '-L':
> +            sys.stderr.write("git cvsimport: -L is no longer supported.\n")
> +            sys.exit(1)
> +        elif opt == '-A':
> +            authormap = os.path.abspath(val)
> +        elif opt == '-R':
> +            revisionmap = True
> +        else:
> +            print """\
> +git cvsimport [-A <author-conv-file>] [-C <git_repository>] [-b] [-d <CVSROOT>]
> +     [-e engine] [-h] [-i] [-k] [-p <options-for-cvsps>] [-P <source-file>]
> +     [-r <remote>] [-R] [-s <subst>] [-S <regex>] [-u] [-v] [-z <fuzz>]
> +     [<CVS_module>]
> +"""
> +
> +    def metadata(fn):
> +        if bare:
> +            return fn
> +        else:
> +            return os.path.join(".git", fn)
> +    try:
> +        if outdir:
> +            try:
> +                # If the output directory does not exist, create it
> +                # and initialize it as a git repository.
> +                os.mkdir(outdir)
> +                do_or_die("git init --quiet " + outdir)
> +            except OSError:
> +                # Otherwise, assume user wants incremental import.
> +                if not bare and not os.path.exists(os.path.join(outdir, ".git")):
> +                    raise Fatal("output directory is not a git repository")
> +                threshold = capture_or_die("git log -1 --format=%ct").strip()
> +                backend.set_after(threshold)
> +        if revisionmap:
> +            backend.set_revmap(tempfile.mkstemp()[1])
> +            markmap = tempfile.mkstemp()[1]
> +        if arguments:
> +            backend.set_module(arguments[0])
> +        gitopts = ""
> +        if bare:
> +            gitopts += " --bare"
> +        if revisionmap:
> +            gitopts += " --export-marks='%s'" % markmap
> +        if authormap:
> +            shutil.copyfile(authormap, metadata("cvs_authors"))
> +        if os.path.exists(metadata("cvs-authors")):
> +            backend.set_authormap(metadata("cvs-authors"))
> +        do_or_die("%s | (cd %s >/dev/null; git fast-import --quiet %s)" \
> +                  % (backend.command(), outdir, gitopts))

outdir needs to be quoted in the formatted string, i.e.:

  "%s | (cd '%s' >/dev/null ..."

Also, I noticed the generated cvs-revisions file now maps cvs
revisions to blobs instead of commits.  Was this change intentional?

Thanks,

Chris
