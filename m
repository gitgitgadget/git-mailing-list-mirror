From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] contrib/svn-fe: Fast script to remap svn history
Date: Sat, 20 Nov 2010 23:17:34 -0600
Message-ID: <20101121051734.GA11856@burratino>
References: <1286431561-24126-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sun Nov 21 06:18:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PK2JX-0002fP-3I
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 06:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835Ab0KUFRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Nov 2010 00:17:48 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36005 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab0KUFRr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Nov 2010 00:17:47 -0500
Received: by gyb11 with SMTP id 11so721354gyb.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 21:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=eJELs6q/XqDz+FK+/3sY950S3Z5c0VSOrzsDkjjI90g=;
        b=kOeW7oaOkfP7QY0ZGz5f6My2c7ZGFJ/WS+MpcURmwE5aZPxonpRsGxQYfZLeIx2puo
         IJ323rxwDCO+2Wk7S6sdKps17+vFSngjpLCXm2pGCuSAPUO4sZ7xXidiDHzFqWkP5t0I
         1Xuo1qAy49F0JdLAy0y63SEX748t5a1gSsz8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AC01ZVSuzN8kM/tPETKMrkD7QO6DTFm7ZRsKj6ZiBuoKEyrQFCjcTzc+CidlIdzbdQ
         0Jf/1+8hocc6k+aHUqNMtYsdh8s4J5/FVYYeOMg6YXcnZfJQG1wqDtnpqaQ4TH6LoGDE
         kviyraZ1btoU4NvAR1KmOE2rxa5AL3MRUsaBI=
Received: by 10.150.182.1 with SMTP id e1mr6807546ybf.59.1290316666871;
        Sat, 20 Nov 2010 21:17:46 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id p1sm2334604ybn.17.2010.11.20.21.17.43
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Nov 2010 21:17:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1286431561-24126-1-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161857>

Hi David,

David Barr wrote:

> This python script walks the commit sequence imported by svn-fe.
> For each commit, it tries to identify the branch that was changed.
> Commits are rewritten to be rooted according to the standard layout.

I like the idea and especially that the heuristics are simple.

Maybe this could be made git-agnostic using the new ls-tree command
you are introducing in fast-import?  Though it would need to get a
revision list from somewhere.  Alternatively, do you think it would
make sense for something like this to be implemented as a filter or
observer of the fast-import stream as it is generated during an
import?

> A basic heuristic of matching trees is used to find parents for the
> first commit in a branch and for tags.

More precisely, the rule used is:

> +    # Find a common path prefix in the changes for the revision
> +    subroot = ""
> +    changes = Popen(["git","diff","--name-only",parent,git_commit], stdout=PIPE)
> +    for path in changes.stdout:
> +        match = subroot_re.match(path)
> +        if match:
> +            subroot = match.group()
> +            changes.terminate()
> +            break

The first change lying in one of

	trunk
	branch/*
	tags/*

determines the branch.  When a branch is renamed, this has a 50/50
chance of choosing the right branch.

> +        # Choose a parent for the rewritten commit
> +        if ref in ref_commit:
> +            parent = ref_commit[ref]
> +        elif subtree in tree_commit:
> +            parent = tree_commit[subtree]
> +        else:
> +            parent = ""

If this is a live branch, the parent is the last commit from that
branch.  Otherwise, we take the last commit whose resulting tree
looked like this one.  Or...

> +            # Default to trunk if the branch is new
> +            if parent == "" and "refs/heads/trunk" in ref_commit:
> +                parent = ref_commit["refs/heads/trunk"]

... if all else fails, we take the tip commit on the trunk.

For comparison, here's the git-svn rule:

> 	# look for a parent from another branch:
> 	my @b_path_components = split m#/#, $self->{path};

Among the paths above this commit's base directory [if this is
branches/foo, examine first branches/foo, then branches, then /]:

> 	while (@b_path_components) {
> 		$i = $paths->{'/'.join('/', @b_path_components)};
> 		last if $i && defined $i->{copyfrom_path};
> 		unshift(@a_path_components, pop(@b_path_components));
> 	}
> 	return undef unless defined $i && defined $i->{copyfrom_path};

Find the first one with copyfrom information (i.e., that was
renamed or copied from another rev in this revision).

> 	my $branch_from = $i->{copyfrom_path};
> 	if (@a_path_components) {
> 		print STDERR "branch_from: $branch_from => ";
> 		$branch_from .= '/'.join('/', @a_path_components);
> 		print STDERR $branch_from, "\n";
> 	}

Build back up the URL (so if branches was renamed to Branches but
branches/foo had no copyfrom information, we look for Branches/foo).

[...]
> 	my $gs = $self->other_gs($new_url, $url,
> 		                 $branch_from, $r, $self->{ref_id});
> 	my ($r0, $parent) = $gs->find_rev_before($r, 1);

Find the last revision that changed that path and record it.

Maybe we could benefit from including the copyfrom information in the
fast-import stream output by svn-fe somehow?  The simplest way to do
this would be some specially formatted comments.  An alternative (in
the spirit of Sam's earlier suggestions) might be to represent it in
the tree svn-fe creates, for example by introducing dummy

	foo.copiedfrom

symlinks.

Thanks, that was interesting.
Jonathan
