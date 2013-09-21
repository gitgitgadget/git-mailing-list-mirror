From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH/RFC 0/7] Support for Ruby
Date: Sat, 21 Sep 2013 13:48:08 -0500
Message-ID: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 20:53:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNSJT-0000T5-MI
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 20:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab3IUSxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 14:53:47 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:34154 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab3IUSxq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 14:53:46 -0400
Received: by mail-ob0-f181.google.com with SMTP id gq1so2122367obb.12
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 11:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=EbQ9FEub0OvZ2WWAlvl4pWVWuF8IkHKs4FJq10OKHxc=;
        b=0Ec8rGfyKfTqYRlq3wgLsqG1s9WfMWWUkbMFEZTbNCn52NfJkD3zP2BnONr7ooGLL9
         +6zcLwl4PZg+FQlfi4sINbairEBe6Fs38GCdHDT7cW1nf/jKWcTExke/us2VLrnvQfb0
         f+esFB1aqbA+S4QLySRajUkmgeoZVLudLEdT6Oykq07115l51x8Cm6vX2cxBUZb1mwyP
         ac+7QALBa49uqFedNXFdrMpn9O9uEjBeXaF2xUZeqjAwhkG31qTdCHFJ3RmlCOpSvvho
         HQuqnlCDyrfBWo7Ec1z76fKgp0YmVzHlB82tM8YvddOSZcQ9Ydquc/IpaWODV2kAFmnk
         ljnQ==
X-Received: by 10.60.44.240 with SMTP id h16mr11657458oem.2.1379789625932;
        Sat, 21 Sep 2013 11:53:45 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm8625403obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 11:53:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235134>

Hi,

It was discussed before that there was a need to replace Git scripts from perl
and sh that utilize the 'git' binary to do everything they need, which requires
many forks, and that creates problems on platforms like Windows.

This is a first step meant to show how a solution using Ruby would look like.

Other alternatives just don't cut it. Shell scripts are too simple, and
invariably require forks. Perl could use Git's internal C code, but it's syntax
is too cumbersome and it's loosing more and more popularity. Python and Ruby
are the only modern languages that could fit all the needs, but Python's syntax
is not ideal, specially considering the background of the Git community, and
also, Ruby's C extensibility is simply superb.

This patch series introduces Ruby bindings for Git's C internal library, and
add example commands to show how it could be used, and how it resembles the
original C code, shell code, and perl code. Basically, Ruby fits like a glove.

== Syntax ==

First of all, the syntax of Ruby is very similar to other languages used by Git:

C:

  if (a && b || (c & FLAG) != 0)
    return 0
  else
    break
  end

  printf("format: %s: %i\n", "this string", 0)

  count += 1

Shell:

  out = `git rev-parse #{committish}`

  str = <<EOF
  multi
  line
  string
  EOF

Perl

  var ||= 'default'

The following Perl code:

  sub abbr {
    my $ref = shift;
    if ($ref =~ m{^refs/heads/(.*)$}) {
      return $1;
    }
    return $ref;
  }

Looks like this in Ruby:

  def abbr(ref)
    if (ref =~ %r{^refs/heads/(.*)$}m)
      return $1
    end
    return ref
  end

== C bindings ==

It's extremely easy to write wrappers for Git's C functions:

  static VALUE git_rb_get_git_dir(VALUE self)
  {
    return rb_str_new2(get_git_dir());
  }

  rb_define_global_function("get_git_dir", git_rb_get_git_dir, 0);

Then in Ruby:

  dir = get_git_dir()

== Much more ==

Ruby's power allows for plenty of extensibility.

For example:

  p `echo yes`
  => "yes\n"

Usually we want to chomp the last new line. Fortunately everything is open in
Ruby, so it's possible to override the `() method:

  def `(cmd)
    IO.popen(cmd) { |pipe| pipe.read.chomp }
  end

Now:

  p `echo yes`
  => "yes"

Also, in shell, if we want to make sure a sequence of commands is executed, we
would do something like:

  git command 1 &&
  git command 2 &&
  git command 3 ||
  error

This gets specially troublesome the bigger the sequence. In Ruby:

  def run(*args)
    system(*args)
    raise RuntimeError unless $?.success?
  end

  begin
    run('git command 1')
    run('git command 2')
    run('git command 3')
  rescue RuntimeError
    error
  end

Finally, Ruby has the concept of blocks:

  def run_with_lock()
    puts "lock"
    yield
    puts "unlock"
  end

  branch = 'master'

  run_with_lock() do
    puts "do stuff with #{branch}"
  end

Notice how the block inside run_with_lock() is able to access the 'branch'
variable, because it's in it's context, but the block is not actually called
until run_with_lock() calls 'yield'.

Python has a similar concept, but not nearly as powerful.

== Upgrade path ==

Ruby 2.0 didn't suffer the problems Python 3 is suffering because they have a
sane upgrade path.

Ruby 1.9 changed the syntax, so people using 1.8 had to do minor changes to
upgrade to 1.9, but they didn't miss many major features. After people updated
to 1.9, 2.0 came along with major features, but it was compatible with 1.9, so
nobody had to do any further changes.

Either way, it's still possible to run code that works in 1.8, 1.9, and 2.0.

== Community ==

The Ruby community is already heavily engaged in Git, as statistics in GitHub
show, plenty of Ruby projects use Git, outnumbering by far the Python ones.

There might be some correlation based on the fact that Mercurial is written in
Python.

http://adambard.com/blog/top-github-languages-for-2013-so-far/

== Conclusion ==

Ruby is an extremly powerful modern language, it features object oriented
paradigm, as well as functional, and procedural. It borrows from languages such
as C, Perl, and many others.

It's possible that by opening the possibilities to write Ruby scripts, many
Ruby developers would join the effort to improve Git.

Felipe Contreras (7):
  Add support for ruby commands
  ruby: add setup script
  ruby: add simple wrappers
  ruby: rewrite 'request-pull'
  ruby: rewrite perl script
  ruby: remove one fork
  ruby: rewrite 'reset'

 Makefile            |  16 +-
 cache.h             |   2 +
 git-rb-setup.rb     | 125 +++++++++++++
 git-refs.rb         |   7 +
 git-request-pull.rb | 159 ++++++++++++++++
 git-request-pull.sh | 162 -----------------
 git-reset.rb        | 223 +++++++++++++++++++++++
 git.c               |   4 +-
 ruby.c              | 511 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 1044 insertions(+), 165 deletions(-)
 create mode 100644 git-rb-setup.rb
 create mode 100644 git-refs.rb
 create mode 100644 git-request-pull.rb
 delete mode 100755 git-request-pull.sh
 create mode 100644 git-reset.rb
 create mode 100644 ruby.c

-- 
1.8.4-fc
