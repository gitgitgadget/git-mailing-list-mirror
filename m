From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC] fast-import: 'cat-blob' and 'ls' commands
Date: Wed, 26 Jan 2011 15:39:22 -0600
Message-ID: <20110126213922.GA19727@burratino>
References: <1291286420-13591-1-git-send-email-david.barr@cordelta.com>
 <20110103080130.GA8842@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Tomas Carnecky <tom@dbservice.com>, Sam Vilain <sam@vilain.net>
To: vcs-fast-import-devs@lists.launchpad.net
X-From: git-owner@vger.kernel.org Wed Jan 26 22:39:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiD5Y-0003F5-Vb
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 22:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191Ab1AZVjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 16:39:35 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47446 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932Ab1AZVje (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 16:39:34 -0500
Received: by qwa26 with SMTP id 26so1413947qwa.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 13:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ev/itsZqcGb7FKNYJnNuuN5iMe3dKvlXDp+ebuHy+B4=;
        b=svwmjcb+EhMW+iDBLk3k0SuidfyrxOfEzJ+Yo8mfJjzNF6rUsVk0NxHUovYnJhMiki
         +tpNRfiydTZZp72/FoS5y83dp4AUElKvfktVtbMMiq42qfeLFVg4be4fr5wJ3vaEhOQF
         k7B8ac6sZwaMrEGvcWGWZ/JRJj2oFPAUNjlb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RuE3GE5CTJMLf1dWO8x7caX0WKo63J3nBozVIVh3nC3ARJro6am26JEiAGTV6LdcyH
         P32g8xJDELpklPPGWDQn2DcoGGnAeZiZ4Tk36XsvkbGJkkFRWKbSBX6OLhZb6R4sKBHc
         B2HEzVtvhs6GKh0sCNfpnMM+3tbqeRVXYUu8Y=
Received: by 10.229.82.8 with SMTP id z8mr811579qck.108.1296077973451;
        Wed, 26 Jan 2011 13:39:33 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id t7sm11307487qcs.16.2011.01.26.13.39.30
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 26 Jan 2011 13:39:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110103080130.GA8842@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165553>

Hi fast importers,

I would like your thoughts on a few developments in fast-import
protocol (thanks to David, Ram, Sverre, Tomas, and Sam for work so
far).  If they seem good, I'd be happy to help make patches to other
backends so these can be implemented widely.

Contents: cat-blob command, filemodify (M) with trees, ls command.

cat-blob command
----------------

fast-import 1.7.4-rc0 added a new "cat-blob" feature.  It is meant to
allow exporters that receiving changes in delta form to avoid having
to remember the full text of blobs already exported or re-retrieve
them from the source repository.

It works like this:

1. Out of band, the fast-import frontend and backend negotiate a
   channel for the backend to send replies to the frontend.  In
   git fast-import, this is a file descriptor, defaulting to
   stdout.  So you can do:

	mkfifo replies &&

	$frontend <replies |
	git fast-import --cat-blob-fd=3 3>replies

   The intent is that stdin would typically be a socket and this file
   descriptor would point to that.

2. The frontend (optionally) declares use of this feature by putting

	feature cat-blob

   at the beginning of the stream.

3. When the frontend needs a previously exported blob to use as delta
   preimage, it uses the cat-blob command.

	cat-blob :3

   The backend replies with something like

	7c8987a987ca98c blob 6
	hello


   More precisely, the output format is

	<dataref> SP 'blob' SP <length> LF
	<full text of blob> LF

   The <dataref> can be any text not including whitespace.

   The frontend can rely on a little buffering if it wants to print a
   command after the "cat-blob", but it must read the reply in its
   entirety if it expects the backend to act on later commands.  In
   other words, the cat-blob command is not guaranteed to be
   asynchronous.

This protocol is used by the svn-fe[1] tool to handle Subversion dump
files in version 3 (--deltas) format and seems to work ok.

Does this look sane or does it need tweaking or more detailed
specification to be widely useful?  Even once git 1.7.4 is out, it
should be possible to make improvements using a new "feature" name.

filemodify (M) with trees
-------------------------

fast-import 1.7.3-rc0 introduced the ability for a filemodify (M)
command to place a tree named by mark or other <dataref> at a given
path, replacing whatever was there before.  The implementation had
some kinks, which fast-import 1.7.4-rc0 ironed out.

Without some way to specify marks or learn tree names out of band, it
is not very useful.  With some way to learn tree names, it can be
used, for example, to rewrite revision metadata while reusing the old
tree data:

	commit refs/heads/master
	mark :11
	committer A U Thor <author@example.com> Wed, 26 Jan 2011 15:14:11 -0600
	data <<EOF
	New change description
	EOF
	M 040000 4b825dc642cb6eb9a060e54bf8d69288fbee4904 ""

There is no "feature" name for this.  Corner case: a command to
replace a path with the empty tree is interpreted[2] as meaning to remove
that file or subtree, because git does not track empty directories.

Do the semantics seem reasonable?  Should this get a corresponding
"feature"?

ls command
----------

A patch in flight[3] introduces an "ls" command to read directory
entries from the active commit or a named commit.  This allows
printing a blob from the active commit or copying a blob or tree from
a previous commit for use in the current one.

It works like so:

1. Frontend writes

	'ls' SP <path> LF

or

	'ls' SP <dataref> SP <path> LF

  In the first form, the <path> _must_ be surrounded in quotes
  and quoted C-style.  In the second form, the <dataref> can refer
  to a tag, commit, or tree.

2. Backend replies through the cat-blob channel:

	<mode> SP <type> SP <dataref> HT <path> LF

   <mode> is a 6-digit octal mode: 040000, 100644, 100755,
   120000, or 160000 for a directory, regular file, executable file,
   symlink, or submodule, respectively.

   <type> is 'blob', 'tree', or 'commit'.

   <dataref> represents the corresponding blob, tree, or commit
   object.

   <path> is the path in question.  It can be quoted C-style and
   must be if the path starts with '"' or contains a newline.

3. Frontend reads the reply.  The frontend might use that <dataref> in
   a later filemodify (M) and cat-blob command.

Proposed updates to svn-fe[1] use this heavily and work well.

One ugly corner case: although it is intended to allow "missing
<path>" as a reply when the path is missing, the proposed patch
makes git fast-import use an empty tree to signal that case,
to ensure that, for example,

	ls ""
	M <mode> <dataref> ""

is always a non-operation.

No "feature" name yet.  Even better, it's not part of git yet so
I invite to nitpick to your heart's content.  Maybe you'd rather
the command be called "ls-tree" instead of "ls"?  Ask away. :)

Thoughts welcome, as always.
Jonathan

[1] http://repo.or.cz/w/git/jrn.git/blob/refs/heads/vcs-svn-pu:/vcs-svn/svndump.c
[2] Or rather, is not interpreted but ought to be, or else
fast-import will make it too easy to produce invalid commits.  One of
the patches in series [3] fixes it.
[3] http://thread.gmane.org/gmane.comp.version-control.git/162698/focus=164448
