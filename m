From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Buggy handling of non-canonical ref names
Date: Wed, 24 Aug 2011 17:49:04 +0200
Message-ID: <4E551D70.9080509@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 24 17:49:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwFhZ-0005XE-RP
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 17:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab1HXPtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 11:49:09 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:47087 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab1HXPtH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 11:49:07 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7OFn42j009538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 24 Aug 2011 17:49:05 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180013>

git has inconsistencies (I would say bugs) in how it handles reference
names that are in non-canonical format (e.g., "/foo/bar", "foo///bar",
etc).  Some commands work with reference names that are in non-canonical
form, whereas others do not.  Sometimes the behavior depends on whether
the reference is loose or packed.

For example "git branch" and "git update-ref" seem to swallow them OK:

    $ git update-ref /foo/bar HEAD
    $ cat .git/foo/bar
    ef6cf90ba11dd6205f8b974692d795ea0b1c0bdd
    $ git branch /bar/baz
    $ git for-each-ref | grep baz
    ef6cf90ba11dd6205f8b974692d795ea0b1c0bdd commit refs/heads/bar/baz

But other commands do not:

    $ git rev-parse /foo/bar --
    /foo/bar
    fatal: ambiguous argument '/foo/bar': unknown revision or path not
in the working tree.
    Use '--' to separate paths from revisions
    $ git rev-parse foo///bar --
    foo///bar
    fatal: ambiguous argument 'foo///bar': unknown revision or path not
in the working tree.
    Use '--' to separate paths from revisions
    $ git rev-parse foo/bar --
    ef6cf90ba11dd6205f8b974692d795ea0b1c0bdd
    --

It seems like most of the canonicalization of reference names is via
path canonicalization using the likes of git_snpath() and git_path(),
with the exception of "git check-ref-format --print", which does the
work using its own code.  But packed references are not transformed into
paths, so they don't handle canonicalization at all.  For example, in
the following case, there is a difference between how packed and
unpacked references are handled:

    $ git update-ref refs/heads/foo/bar HEAD
    $ git update-ref -d refs/heads/foo///bar HEAD
    [Reference was really deleted]
    $ git update-ref refs/heads/foo/bar HEAD
    $ git pack-refs --all
    $ git update-ref -d refs/heads/foo///bar HEAD
    error: unable to resolve reference refs/heads/foo///bar: No such
file or directory
    $ git for-each-ref | grep foo
    ffae1b1dc75896bd89ff3cbe7037f40474e57e2a commit refs/heads/foo/bar
    [Reference was not deleted]

What is the policy about reference names and their canonicalization?  In
what situations should one be able to use non-canonical refnames, and in
what situations should it be forbidden?

Given that refnames are closely associated with filesystem paths, it is
important that every code path either canonicalize or reject
non-canonical refnames (i.e., failure to do so could be a security
problem).  In the absence of clear rules, it will be very difficult to
ensure that this is being done consistently.

I also noticed that check_ref_format() accepts ref names that start with
a "/", but that the leading slash is *not* stripped off as part of the
canonicalization:

    $ git check-ref-format /foo/bar ; echo $?
    0
    $ git check-ref-format --print /foo/bar
    /foo/bar

However, creating a reference with such a name is equivalent to creating
a reference without the leading slash:

    $ git update-ref /foo/bar HEAD
    $ cat .git/foo/bar
    ef6cf90ba11dd6205f8b974692d795ea0b1c0bdd
    $ git branch /bar/baz
    $ git for-each-ref | grep baz
    ef6cf90ba11dd6205f8b974692d795ea0b1c0bdd commit refs/heads/bar/baz

Therefore, it seems to belong in the equivalence class of "foo/bar".

The test suite for "git check-ref-format" says nothing about how leading
slashes should be handled.

Either leading slashes should not be allowed in ref names at all or they
should be canonicalized away.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
