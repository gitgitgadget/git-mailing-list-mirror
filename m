From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Review of git multimail
Date: Wed,  3 Jul 2013 00:53:39 +0530
Message-ID: <1372793019-12162-1-git-send-email-artagnon@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 02 21:26:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu6E3-0005Mv-NR
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 21:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024Ab3GBT0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 15:26:51 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:55442 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356Ab3GBT0t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 15:26:49 -0400
Received: by mail-pd0-f176.google.com with SMTP id t12so3865467pdi.21
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 12:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=/GKCw5tFR3Tv+wASr5WrFse4Xkoo9EcBvFuwkui1qPU=;
        b=m4PorWqDFiVnDHnRHJJ47HG5kYW+qY8ct5N7Mr9gzNeg3QsxpYJUoV6oTnAwA/Kqiw
         f1x03GjeeEgVNkOQ2j2v5T1xFYD0LpL7F80ci4c4kOru5/Uzf4PVQXMaRmJ1xFRgvsAJ
         LOmsDJqBET4+xrKC9yRtEb7VYuKVs5ZoNA4MpR8Sd//r5oAHML8qgKxrGL6cL+cq/rjJ
         QVn87Psxsnj+B1b5qqIEECTcE7X1RI/0OzlR51kzhg32z7x4cB2eHsNSHOuVAEVupzsv
         zU1HsWvyZNUFWNL0MNVhDYOSjmh3c/TyCIdcdF9MXodbfpDbsg/EiCQqQKuOZDkauhAR
         PF/Q==
X-Received: by 10.68.17.70 with SMTP id m6mr14357175pbd.142.1372793209138;
        Tue, 02 Jul 2013 12:26:49 -0700 (PDT)
Received: from localhost.localdomain ([122.164.185.186])
        by mx.google.com with ESMTPSA id ai6sm30528068pad.15.2013.07.02.12.26.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 02 Jul 2013 12:26:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.643.gebeea52.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229420>

Hi,

I figured that we should quickly read through git-multimail and give
it an on-list review.  Hopefully, it'll educate the list about what
this is, and help improve the script itself.

Sources: https://github.com/mhagger/git-multimail

git_multimail.py wrote:
> #! /usr/bin/env python2

Do all distributions ship it as python2 now?

> class CommandError(Exception):
>     def __init__(self, cmd, retcode):
>         self.cmd = cmd
>         self.retcode = retcode
>         Exception.__init__(
>             self,
>             'Command "%s" failed with retcode %s' % (' '.join(cmd), retcode,)

So cmd is a list.

> class ConfigurationException(Exception):
>     pass

Dead code?

> def read_git_output(args, input=None, keepends=False, **kw):
>     """Read the output of a Git command."""
> 
>     return read_output(
>         ['git', '-c', 'i18n.logoutputencoding=%s' % (ENCODING,)] + args,
>         input=input, keepends=keepends, **kw
>         )

Okay, although I'm wondering what i18n.logoutputencoding has to do with anything.

> def read_output(cmd, input=None, keepends=False, **kw):
>     if input:
>         stdin = subprocess.PIPE
>     else:
>         stdin = None
>     p = subprocess.Popen(
>         cmd, stdin=stdin, stdout=subprocess.PIPE, stderr=subprocess.PIPE, **kw
>         )
>     (out, err) = p.communicate(input)
>     retcode = p.wait()
>     if retcode:
>         raise CommandError(cmd, retcode)
>     if not keepends:
>         out = out.rstrip('\n\r')
>     return out

Helper function that serves a single caller, read_git_output().

> def read_git_lines(args, keepends=False, **kw):
>     """Return the lines output by Git command.
> 
>     Return as single lines, with newlines stripped off."""
> 
>     return read_git_output(args, keepends=True, **kw).splitlines(keepends)

Okay.

> class Config(object):
>     def __init__(self, section, git_config=None):
>         """Represent a section of the git configuration.
> 
>         If git_config is specified, it is passed to "git config" in
>         the GIT_CONFIG environment variable, meaning that "git config"
>         will read the specified path rather than the Git default
>         config paths."""
> 
>         self.section = section
>         if git_config:
>             self.env = os.environ.copy()
>             self.env['GIT_CONFIG'] = git_config
>         else:
>             self.env = None

Okay.

>     @staticmethod
>     def _split(s):
>         """Split NUL-terminated values."""
> 
>         words = s.split('\0')
>         assert words[-1] == ''
>         return words[:-1]

Ugh.  Two callers of this poorly-defined static method: I wonder if
we'd be better off inlining it.

>     def get(self, name, default=''):
>         try:
>             values = self._split(read_git_output(
>                     ['config', '--get', '--null', '%s.%s' % (self.section, name)],
>                     env=self.env, keepends=True,
>                     ))

Wait, what is the point of using --null and then splitting by hand
using a poorly-defined static method?  Why not drop the --null and
splitlines() as usual?

>             assert len(values) == 1

When does this assert fail?

>             return values[0]
>         except CommandError:
>             return default

If you're emulating the dictionary get method, default=None.  This is
not C, where all codepaths of the function must return the same type.

>     def get_bool(self, name, default=None):
>         try:
>             value = read_git_output(
>                 ['config', '--get', '--bool', '%s.%s' % (self.section, name)],
>                 env=self.env,
>                 )
>         except CommandError:
>             return default
>         return value == 'true'

Correct.  On success, return bool.  On failure, return None.

>     def get_all(self, name, default=None):
>         """Read a (possibly multivalued) setting from the configuration.
> 
>         Return the result as a list of values, or default if the name
>         is unset."""
> 
>         try:
>             return self._split(read_git_output(
>                 ['config', '--get-all', '--null', '%s.%s' % (self.section, name)],
>                 env=self.env, keepends=True,
>                 ))
>         except CommandError, e:

CommandError as e?

>             if e.retcode == 1:

What does this cryptic retcode mean?

>                 return default
>             else:
>                 raise

raise what?

You've instantiated the Config class in two places: user and
multimailhook sections.  Considering that you're going to read all the
keys in that section, why not --get-regexp, pre-load the configuration
into a dictionary and refer to that instead of spawning 'git config'
every time you need a configuration value?

>     def get_recipients(self, name, default=None):
>         """Read a recipients list from the configuration.
> 
>         Return the result as a comma-separated list of email
>         addresses, or default if the option is unset.  If the setting
>         has multiple values, concatenate them with comma separators."""
> 
>         lines = self.get_all(name, default=None)
>         if lines is None:
>             return default
>         return ', '.join(line.strip() for line in lines)

Ugh.

>     def set(self, name, value):
>         read_git_output(
>             ['config', '%s.%s' % (self.section, name), value],
>             env=self.env,
>             )
>
>     def add(self, name, value):
>         read_git_output(
>             ['config', '--add', '%s.%s' % (self.section, name), value],
>             env=self.env,
>             )
> 
>     def has_key(self, name):
>         return self.get_all(name, default=None) is not None
> 
>     def unset_all(self, name):
>         try:
>             read_git_output(
>                 ['config', '--unset-all', '%s.%s' % (self.section, name)],
>                 env=self.env,
>                 )
>         except CommandError, e:
>             if e.retcode == 5:
>                 # The name doesn't exist, which is what we wanted anyway...
>                 pass
>             else:
>                 raise
> 
>     def set_recipients(self, name, value):
>         self.unset_all(name)
>         for pair in getaddresses([value]):
>             self.add(name, formataddr(pair))

Dead code?

> def generate_summaries(*log_args):
>     """Generate a brief summary for each revision requested.
> 
>     log_args are strings that will be passed directly to "git log" as
>     revision selectors.  Iterate over (sha1_short, subject) for each
>     commit specified by log_args (subject is the first line of the
>     commit message as a string without EOLs)."""
> 
>     cmd = [
>         'log', '--abbrev', '--format=%h %s',
>         ] + list(log_args) + ['--']

What is log_args if not a list?

But yeah, log is the best way to generate summaries.

>     for line in read_git_lines(cmd):
>         yield tuple(line.split(' ', 1))

Okay, let's see how you use this iterator.

> def limit_lines(lines, max_lines):
>     for (index, line) in enumerate(lines):
>         if index < max_lines:
>             yield line
> 
>     if index >= max_lines:
>         yield '... %d lines suppressed ...\n' % (index + 1 - max_lines,)

Random helper.

> def limit_linelength(lines, max_linelength):
>     for line in lines:
>         # Don't forget that lines always include a trailing newline.
>         if len(line) > max_linelength + 1:
>             line = line[:max_linelength - 7] + ' [...]\n'
>         yield line

Random helper.

> class GitObject(object):
>     def __init__(self, sha1, type=None):
>         if sha1 == ZEROS:
>             self.sha1 = self.type = self.commit = None
>         else:
>             self.sha1 = sha1
>             self.type = type or read_git_output(['cat-file', '-t', self.sha1])
> 
>             if self.type == 'commit':
>                 self.commit = self
>             elif self.type == 'tag':
>                 try:
>                     self.commit = GitObject(
>                         read_git_output(['rev-parse', '--verify', '%s^0' % (self.sha1,)]),
>                         type='commit',
>                         )
>                 except CommandError:
>                     self.commit = None
>             else:
>                 self.commit = None
> 
>         self.short = read_git_output(['rev-parse', '--short', sha1])

Just rev-parse --verify --short $SHA1^0: if it resolves, set
self.short; one liner?

>     def get_summary(self):
>         """Return (sha1_short, subject) for this commit."""
> 
>         if not self.sha1:
>             raise ValueError('Empty commit has no summary')

What is the point of letting the user instantiate a GitObject without
a valid .sha1 in the first place?

>         return iter(generate_summaries('--no-walk', self.sha1)).next()

Not exactly fond of this, but I don't have a concrete replacement at
the moment.

>     def __eq__(self, other):
>         return isinstance(other, GitObject) and self.sha1 == other.sha1
> 
>     def __hash__(self):
>         return hash(self.sha1)
> 
>     def __nonzero__(self):
>         return bool(self.sha1)

Okay.

>     def __str__(self):
>         return self.sha1 or ZEROS

I wonder what value this adds when .short is around.

> class Change(object):
>     """A Change that has been made to the Git repository.
> 
>     Abstract class from which both Revisions and ReferenceChanges are
>     derived.  A Change knows how to generate a notification email
>     describing itself."""
> 
>     def __init__(self, environment):
>         self.environment = environment
>         self._values = None
> 
>     def _compute_values(self):
>         """Return a dictionary {keyword : expansion} for this Change.
> 
>         Derived classes overload this method to add more entries to
>         the return value.  This method is used internally by
>         get_values().  The return value should always be a new
>         dictionary."""
> 
>         return self.environment.get_values()

Why is this an "internal function"?  What is your criterion for
internal versus non-internal?

>     def get_values(self, **extra_values):
>         """Return a dictionary {keyword : expansion} for this Change.
> 
>         Return a dictionary mapping keywords to the values that they
>         should be expanded to for this Change (used when interpolating
>         template strings).  If any keyword arguments are supplied, add
>         those to the return value as well.  The return value is always
>         a new dictionary."""
> 
>         if self._values is None:
>             self._values = self._compute_values()
> 
>         values = self._values.copy()
>         if extra_values:
>             values.update(extra_values)
>         return values

Unsure what this is about.

>     def expand(self, template, **extra_values):
>         """Expand template.
> 
>         Expand the template (which should be a string) using string
>         interpolation of the values for this Change.  If any keyword
>         arguments are provided, also include those in the keywords
>         available for interpolation."""
> 
>         return template % self.get_values(**extra_values)
> 
>     def expand_lines(self, template, **extra_values):
>         """Break template into lines and expand each line."""
> 
>         values = self.get_values(**extra_values)
>         for line in template.splitlines(True):
>             yield line % values

Okay.

>     def expand_header_lines(self, template, **extra_values):
>         """Break template into lines and expand each line as an RFC 2822 header.
> 
>         Encode values and split up lines that are too long.  Silently
>         skip lines that contain references to unknown variables."""
> 
>         values = self.get_values(**extra_values)
>         for line in template.splitlines(True):
>             (name, value) = line.split(':', 1)
>             value = value.rstrip('\n\r')

Doesn't splitlines() make the rstrip() redundant?

>             try:
>                 value = value % values
>             except KeyError, e:
>                 if DEBUG:
>                     sys.stderr.write(
>                         'Warning: unknown variable %r in the following line; line skipped:\n'
>                         '    %s'
>                         % (e.args[0], line,)
>                         )

If DEBUG isn't on, you risk leaving the value string interpolated
without even telling the user.  What does it mean to the end user?

>             else:
>                 try:
>                     h = Header(value, header_name=name)
>                 except UnicodeDecodeError:
>                     h = Header(value, header_name=name, charset=CHARSET, errors='replace')
>                 for splitline in ('%s: %s\n' % (name, h.encode(),)).splitlines(True):
>                     yield splitline

Not elated by this exception cascading, but I suppose it's cheaper
than actually checking everything.

>     def generate_email_header(self):
>         """Generate the RFC 2822 email headers for this Change, a line at a time.
> 
>         The output should not include the trailing blank line."""
> 
>         raise NotImplementedError()
> 
>     def generate_email_intro(self):
>         """Generate the email intro for this Change, a line at a time.
> 
>         The output will be used as the standard boilerplate at the top
>         of the email body."""
> 
>         raise NotImplementedError()
> 
>     def generate_email_body(self):
>         """Generate the main part of the email body, a line at a time.
> 
>         The text in the body might be truncated after a specified
>         number of lines (see multimailhook.emailmaxlines)."""
> 
>         raise NotImplementedError()
> 
>     def generate_email_footer(self):
>         """Generate the footer of the email, a line at a time.
> 
>         The footer is always included, irrespective of
>         multimailhook.emailmaxlines."""
> 
>         raise NotImplementedError()

Unsure what these are about.

>     def generate_email(self, push, body_filter=None):
>         """Generate an email describing this change.
> 
>         Iterate over the lines (including the header lines) of an
>         email describing this change.  If body_filter is not None,
>         then use it to filter the lines that are intended for the
>         email body."""
> 
>         for line in self.generate_email_header():
>             yield line
>         yield '\n'
>         for line in self.generate_email_intro():
>             yield line
> 
>         body = self.generate_email_body(push)
>         if body_filter is not None:

Redundant "is not None".

>             body = body_filter(body)
>         for line in body:
>             yield line
> 
>         for line in self.generate_email_footer():
>             yield line

Nicely done with yield.

> class Revision(Change):
>     """A Change consisting of a single git commit."""
> 
>     def __init__(self, reference_change, rev, num, tot):
>         Change.__init__(self, reference_change.environment)

super?

>         self.reference_change = reference_change
>         self.rev = rev
>         self.change_type = self.reference_change.change_type
>         self.refname = self.reference_change.refname
>         self.num = num
>         self.tot = tot
>         self.author = read_git_output(['log', '--no-walk', '--format=%aN <%aE>', self.rev.sha1])

Determining author using log --format.  Okay.

>         self.recipients = self.environment.get_revision_recipients(self)
> 
>     def _compute_values(self):
>         values = Change._compute_values(self)

super.

>         # First line of commit message:
>         try:
>             oneline = read_git_output(
>                 ['log', '--format=%s', '--no-walk', self.rev.sha1]
>                 )
>         except CommandError:
>             oneline = self.rev.sha1

What does this mean?  When will you get a CommandError?  And how do
you respond to it?

>         values['rev'] = self.rev.sha1
>         values['rev_short'] = self.rev.short
>         values['change_type'] = self.change_type
>         values['refname'] = self.refname
>         values['short_refname'] = self.reference_change.short_refname
>         values['refname_type'] = self.reference_change.refname_type
>         values['reply_to_msgid'] = self.reference_change.msgid
>         values['num'] = self.num
>         values['tot'] = self.tot
>         values['recipients'] = self.recipients
>         values['oneline'] = oneline
>         values['author'] = self.author

Ugh.  Use

  { rev: self.rev.sha1,
    rev_short: self.rev.short
    ...
  }

and merge it with the existing dictionary.  Unsure why you're building
a dictionary in the first place.

>     def generate_email_header(self):
>         for line in self.expand_header_lines(REVISION_HEADER_TEMPLATE):
>             yield line
> 
>     def generate_email_intro(self):
>         for line in self.expand_lines(REVISION_INTRO_TEMPLATE):
>             yield line
>
>     def generate_email_body(self, push):
>         """Show this revision."""
> 
>         return read_git_lines(
>             [
>                 'log', '-C',
>                  '--stat', '-p', '--cc',
>                 '-1', self.rev.sha1,
>                 ],
>             keepends=True,
>             )
>
>     def generate_email_footer(self):
>         return self.expand_lines(REVISION_FOOTER_TEMPLATE)

Okay.

> class ReferenceChange(Change):
>     """A Change to a Git reference.
> 
>     An abstract class representing a create, update, or delete of a
>     Git reference.  Derived classes handle specific types of reference
>     (e.g., tags vs. branches).  These classes generate the main
>     reference change email summarizing the reference change and
>     whether it caused any any commits to be added or removed.
> 
>     ReferenceChange objects are usually created using the static
>     create() method, which has the logic to decide which derived class
>     to instantiate."""
> 
>     REF_RE = re.compile(r'^refs\/(?P<area>[^\/]+)\/(?P<shortname>.*)$')

Okay.

>     @staticmethod

Unsure what such a huge static method is doing here, but we'll find
out soon enough.

>     def create(environment, oldrev, newrev, refname):
>         """Return a ReferenceChange object representing the change.
> 
>         Return an object that represents the type of change that is being
>         made. oldrev and newrev should be SHA1s or ZEROS."""

Like I said before, use the typesystem effectively: why is using a
string with 40 zeros somehow better than None in your program _logic_?
I can understand converting None to 40 zeros for display purposes.

>         old = GitObject(oldrev)
>         new = GitObject(newrev)
>         rev = new or old
> 
>         # The revision type tells us what type the commit is, combined with
>         # the location of the ref we can decide between
>         #  - working branch
>         #  - tracking branch
>         #  - unannotated tag
>         #  - annotated tag

Could be simpler.

>         return klass(
>             environment,
>             refname=refname, short_refname=short_refname,
>             old=old, new=new, rev=rev,
>             )

Everything inherits from ReferenceChange anyway, so it should be safe.

>     def __init__(self, environment, refname, short_refname, old, new, rev):
>         Change.__init__(self, environment)
>         self.change_type = {
>             (False, True) : 'create',
>             (True, True) : 'update',
>             (True, False) : 'delete',
>             }[bool(old), bool(new)]

As a general principle, avoid casting: if new is a dictionary, what
does bool(new) even mean?  You just have to trust types, and let go of
that much safety.

>     def get_subject(self):
>         template = {
>             'create' : REF_CREATED_SUBJECT_TEMPLATE,
>             'update' : REF_UPDATED_SUBJECT_TEMPLATE,
>             'delete' : REF_DELETED_SUBJECT_TEMPLATE,
>             }[self.change_type]
>         return self.expand(template)
> 
>     def generate_email_header(self):
>         for line in self.expand_header_lines(
>             REFCHANGE_HEADER_TEMPLATE, subject=self.get_subject(),
>             ):
>             yield line
> 
>     def generate_email_intro(self):
>         for line in self.expand_lines(REFCHANGE_INTRO_TEMPLATE):
>             yield line
> 
>     def generate_email_body(self, push):
>         """Call the appropriate body-generation routine.
> 
>         Call one of generate_create_summary() /
>         generate_update_summary() / generate_delete_summary()."""
> 
>         change_summary = {
>             'create' : self.generate_create_summary,
>             'delete' : self.generate_delete_summary,
>             'update' : self.generate_update_summary,
>             }[self.change_type](push)
>         for line in change_summary:
>             yield line
> 
>         for line in self.generate_revision_change_summary(push):
>             yield line
> 
>     def generate_email_footer(self):
>         return self.expand_lines(FOOTER_TEMPLATE)

Mostly boring string interpolation.  Okay.

>     def generate_revision_change_log(self, new_commits_list):
>         if self.showlog:
>             yield '\n'
>             yield 'Detailed log of new commits:\n\n'
>             for line in read_git_lines(
>                     ['log', '--no-walk']
>                     + self.logopts
>                     + new_commits_list
>                     + ['--'],
>                     keepends=True,
>                 ):
>                 yield line

Okay.

Got bored.  Skipping to the next class.

> class BranchChange(ReferenceChange):
>     refname_type = 'branch'

Unsure what new information this conveys over the type.

> class AnnotatedTagChange(ReferenceChange):
>     refname_type = 'annotated tag'
> 
>     def __init__(self, environment, refname, short_refname, old, new, rev):
>         ReferenceChange.__init__(
>             self, environment,
>             refname=refname, short_refname=short_refname,
>             old=old, new=new, rev=rev,
>             )
>         self.recipients = environment.get_announce_recipients(self)
>         self.show_shortlog = environment.announce_show_shortlog
> 
>     ANNOTATED_TAG_FORMAT = (
>         '%(*objectname)\n'
>         '%(*objecttype)\n'
>         '%(taggername)\n'
>         '%(taggerdate)'
>         )

Now I'm curious what you get by differentiating between annotated and
unannotated tags.

>     def describe_tag(self, push):
>         """Describe the new value of an annotated tag."""
> 
>         # Use git for-each-ref to pull out the individual fields from
>         # the tag
>         [tagobject, tagtype, tagger, tagged] = read_git_lines(
>             ['for-each-ref', '--format=%s' % (self.ANNOTATED_TAG_FORMAT,), self.refname],
>             )

You could've saved yourself a lot of trouble by running one f-e-r on
refs/tags and filtering that.  I don't know what you're gaining from
this overzealous object-orientation.

>         yield self.expand(
>             BRIEF_SUMMARY_TEMPLATE, action='tagging',
>             rev_short=tagobject, text='(%s)' % (tagtype,),
>             )
>         if tagtype == 'commit':
>             # If the tagged object is a commit, then we assume this is a
>             # release, and so we calculate which tag this tag is
>             # replacing
>             try:
>                 prevtag = read_git_output(['describe', '--abbrev=0', '%s^' % (self.new,)])
>             except CommandError:
>                 prevtag = None
>             if prevtag:
>                 yield '  replaces  %s\n' % (prevtag,)
>         else:
>             prevtag = None
>             yield '    length  %s bytes\n' % (read_git_output(['cat-file', '-s', tagobject]),)
> 
>         yield ' tagged by  %s\n' % (tagger,)
>         yield '        on  %s\n' % (tagged,)
>         yield '\n'

Okay, this information isn't present in an unannotated tag.  So you
differentiate to exploit the additional information you can get.

>         # Show the content of the tag message; this might contain a
>         # change log or release notes so is worth displaying.
>         yield LOGBEGIN
>         contents = list(read_git_lines(['cat-file', 'tag', self.new.sha1], keepends=True))

You could've easily batched this.

>         contents = contents[contents.index('\n') + 1:]
>         if contents and contents[-1][-1:] != '\n':
>             contents.append('\n')
>         for line in contents:
>             yield line
> 
>         if self.show_shortlog and tagtype == 'commit':
>             # Only commit tags make sense to have rev-list operations
>             # performed on them
>             yield '\n'
>             if prevtag:
>                 # Show changes since the previous release
>                 revlist = read_git_output(
>                     ['rev-list', '--pretty=short', '%s..%s' % (prevtag, self.new,)],
>                     keepends=True,
>                     )
>             else:
>                 # No previous tag, show all the changes since time
>                 # began
>                 revlist = read_git_output(
>                     ['rev-list', '--pretty=short', '%s' % (self.new,)],
>                     keepends=True,
>                     )
>             for line in read_git_lines(['shortlog'], input=revlist, keepends=True):
>                 yield line
> 
>         yield LOGEND
>         yield '\n'

Way too many git invocations, I think.

> class OtherReferenceChange(ReferenceChange):
>     refname_type = 'reference'
> 
>     def __init__(self, environment, refname, short_refname, old, new, rev):
>         # We use the full refname as short_refname, because otherwise
>         # the full name of the reference would not be obvious from the
>         # text of the email.
>         ReferenceChange.__init__(
>             self, environment,
>             refname=refname, short_refname=refname,
>             old=old, new=new, rev=rev,
>             )
>         self.recipients = environment.get_refchange_recipients(self)

What is the point of this?  Why not just use ReferenceChange directly?

> class Mailer(object):
>     """An object that can send emails."""
> 
>     def send(self, lines, to_addrs):
>         """Send an email consisting of lines.
> 
>         lines must be an iterable over the lines constituting the
>         header and body of the email.  to_addrs is a list of recipient
>         addresses (can be needed even if lines already contains a
>         "To:" field).  It can be either a string (comma-separated list
>         of email addresses) or a Python list of individual email
>         addresses.
> 
>         """
> 
>         raise NotImplementedError()

Abstract base class (abc)?  Or do you want to support Python <2.6?

> class SendMailer(Mailer):
>     """Send emails using '/usr/sbin/sendmail -t'."""
> 
>     def __init__(self, command=None, envelopesender=None):
>         """Construct a SendMailer instance.
> 
>         command should be the command and arguments used to invoke
>         sendmail, as a list of strings.  If an envelopesender is
>         provided, it will also be passed to the command, via '-f
>         envelopesender'."""
> 
>         if command:
>             self.command = command[:]
>         else:
>             self.command = ['/usr/sbin/sendmail', '-t']

If you want to DWIM when the configuration variable is missing, do it
fully using a list of good candidates like /usr/lib/sendmail,
/usr/sbin/sendmail, /usr/ucblib/sendmail, /usr/bin/msmtp.  Also, what
happened to our faithful 'git send-email' Perl script?  Isn't that
most likely to be installed?

>         if envelopesender:
>             self.command.extend(['-f', envelopesender])
> 
>     def send(self, lines, to_addrs):
>         try:
>             p = subprocess.Popen(self.command, stdin=subprocess.PIPE)
>         except OSError, e:
>             sys.stderr.write(
>                 '*** Cannot execute command: %s\n' % ' '.join(self.command)
>                 + '*** %s\n' % str(e)
>                 + '*** Try setting multimailhook.mailer to "smtp"\n'
>                 '*** to send emails without using the sendmail command.\n'
>                 )
>             sys.exit(1)

Why do you need to concatenate strings using +?  This can take a list of strings, no?

> class SMTPMailer(Mailer):
>     """Send emails using Python's smtplib."""
> 
>     def __init__(self, envelopesender, smtpserver):
>         if not envelopesender:
>             sys.stderr.write(
>                 'fatal: git_multimail: cannot use SMTPMailer without a sender address.\n'
>                 'please set either multimailhook.envelopeSender or user.email\n'
>                 )
>             sys.exit(1)
>         self.envelopesender = envelopesender
>         self.smtpserver = smtpserver
>         try:
>             self.smtp = smtplib.SMTP(self.smtpserver)
>         except Exception, e:
>             sys.stderr.write('*** Error establishing SMTP connection to %s***\n' % self.smtpserver)
>             sys.stderr.write('*** %s\n' % str(e))
>             sys.exit(1)

Let's hope Python's smtplib is robust.

>     def __del__(self):
>         self.smtp.quit()

So you close the connection when the object is destroyed by the GC.

>     def send(self, lines, to_addrs):
>         try:
>             msg = ''.join(lines)
>             # turn comma-separated list into Python list if needed.
>             if isinstance(to_addrs, basestring):
>                 to_addrs = [email for (name, email) in getaddresses([to_addrs])]
>             self.smtp.sendmail(self.envelopesender, to_addrs, msg)
>         except Exception, e:
>             sys.stderr.write('*** Error sending email***\n')
>             sys.stderr.write('*** %s\n' % str(e))
>             self.smtp.quit()
>             sys.exit(1)

Okay.

> class OutputMailer(Mailer):
>     """Write emails to an output stream, bracketed by lines of '=' characters.
> 
>     This is intended for debugging purposes."""
> 
>     SEPARATOR = '=' * 75 + '\n'
> 
>     def __init__(self, f):
>         self.f = f
> 
>     def send(self, lines, to_addrs):
>         self.f.write(self.SEPARATOR)
>         self.f.writelines(lines)
>         self.f.write(self.SEPARATOR)

Unsure what this is.

> def get_git_dir():
>     """Determine GIT_DIR.
> 
>     Determine GIT_DIR either from the GIT_DIR environment variable or
>     from the working directory, using Git's usual rules."""
> 
>     try:
>         return read_git_output(['rev-parse', '--git-dir'])
>     except CommandError:
>         sys.stderr.write('fatal: git_multimail: not in a git working copy\n')
>         sys.exit(1)

Why do you need a working copy?  Will a bare repository not suffice?

> class Environment(object):

New-style class.  I wonder why you suddenly switched.

>     REPO_NAME_RE = re.compile(r'^(?P<name>.+?)(?:\.git)$')
> 
>     def __init__(self, osenv=None):
>         self.osenv = osenv or os.environ
>         self.announce_show_shortlog = False
>         self.maxcommitemails = 500
>         self.diffopts = ['--stat', '--summary', '--find-copies-harder']
>         self.logopts = []
>         self.refchange_showlog = False
> 
>         self.COMPUTED_KEYS = [
>             'administrator',
>             'charset',
>             'emailprefix',
>             'fromaddr',
>             'pusher',
>             'pusher_email',
>             'repo_path',
>             'repo_shortname',
>             'sender',
>             ]
> 
>         self._values = None

Okay.

> [...]

Seems to be some boilerplate thing.  I'll skip to the next class.

> class ConfigEnvironmentMixin(Environment):
>     """A mixin that sets self.config to its constructor's config argument.
> 
>     This class's constructor consumes the "config" argument.
> 
>     Mixins that need to inspect the config should inherit from this
>     class (1) to make sure that "config" is still in the constructor
>     arguments with its own constructor runs and/or (2) to be sure that
>     self.config is set after construction."""
> 
>     def __init__(self, config, **kw):
>         super(ConfigEnvironmentMixin, self).__init__(**kw)
>         self.config = config

Overdoing the OO factories, much?

I'll skip a few boring factory classes.

> class GenericEnvironment(
>     ProjectdescEnvironmentMixin,
>     ConfigMaxlinesEnvironmentMixin,
>     ConfigFilterLinesEnvironmentMixin,
>     ConfigRecipientsEnvironmentMixin,
>     PusherDomainEnvironmentMixin,
>     ConfigOptionsEnvironmentMixin,
>     GenericEnvironmentMixin,
>     Environment,
>     ):
>     pass

Sigh.  I might as well be reading some Java now :/

Sorry, I'm exhausted.

Let's take a step back and look at what this gigantic script is doing.
It uses the information from a push to string-interpolate a template
and generate emails, right?  The rest of the script is about churning
on the updated refs to prettify the emails.

>From my quick reading, it seems to be unnecessarily complicated and
inefficient.  Why are there so many factories, and why do you call out
to git at every opportunity, instead of cleanly separating computation
from rendering?
