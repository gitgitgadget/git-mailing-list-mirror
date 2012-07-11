From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Wed, 11 Jul 2012 15:56:43 -0700
Message-ID: <7vmx35dhzo.fsf@alter.siamese.dyndns.org>
References: <20120624220835.GA4762@beczulka>
 <7v4nq0hrjb.fsf@alter.siamese.dyndns.org> <20120625075726.GO3125@beczulka>
 <7vehp3gwbx.fsf@alter.siamese.dyndns.org> <20120626212108.GR3125@beczulka>
 <7vfw9hafz8.fsf@alter.siamese.dyndns.org> <20120626223215.GB8336@beczulka>
 <20120709220321.GE30213@beczulka> <7v8vesk12v.fsf@alter.siamese.dyndns.org>
 <20120711012617.GA18369@dcvr.yhbt.net> <20120711214019.GF30213@beczulka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Marcin Owsiany <marcin@owsiany.pl>
X-From: git-owner@vger.kernel.org Thu Jul 12 00:56:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp5pz-0001Di-Kq
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 00:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754835Ab2GKW4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 18:56:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53624 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680Ab2GKW4p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 18:56:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28A605DB5;
	Wed, 11 Jul 2012 18:56:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RGH95tjiC9UDSopJwb7V9oAW2VI=; b=WXtOur
	JmzulqOwivuQ9YhqrkY8eXj/1C3J2ZH5XTcuz85OpwsoNrk4TW5X1ilRKACVQ4aj
	03B0egM/onW5b+OMrx9NzlkpcVt/Rlq6FYVrQ6L/FLO2mXYYunoYjM7Cz9ovlOF4
	ewgJpgrWYPptjZGaqots+bBwD8qk9zdR9OoX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sBCvSBRyFMEjqHeRyr/QpVGrYbERMytp
	9lUVRJnSBNtJFOSQ3ZIDbl01huvsqeaR5F784AHx8bH27bZY/0n2Ko6Q6Msy/PI9
	dqxc45H/S2XybTSyB1FJwDIYsuJdnws3ZMPJpvLGdDJ0/IjtbKyymAiwVj0JcRYE
	l1eoTCftfKs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FA255DB4;
	Wed, 11 Jul 2012 18:56:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79AAB5DAF; Wed, 11 Jul 2012
 18:56:44 -0400 (EDT)
In-Reply-To: <20120711214019.GF30213@beczulka> (Marcin Owsiany's message of
 "Wed, 11 Jul 2012 22:40:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AFAE345E-CBAB-11E1-839F-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201344>

Marcin Owsiany <marcin@owsiany.pl> writes:

> Date: Sun, 24 Jun 2012 22:40:05 +0100
> Subject: [PATCH] git-svn: don't create master if another head exists
>
> git-svn insists on creating the "master" head (unless it exists) on every
> "fetch". It is useful that it gets created initially, when no head exists
> - users expect this git convention of having a "master" branch on initial
> clone.
>
> However creating it when there already is another head does not provide any
> value - the ref is never updated, so it just gets stale after a while.  Also,
> some users find it annoying that it gets recreated, especially when they would
> like the git branch names to follow SVN repository branch names. More
> background in http://thread.gmane.org/gmane.comp.version-control.git/115030
>
> Make git-svn skip the "master" creation if HEAD points at a valid head. This
> means "master" does get created on initial "clone" but does not get recreated
> once a user deletes it.

The above description makes sense to me, but the code updated with
this patch doesn't quite make sense to me.

This is your patch with a bit wider context.

> diff --git a/git-svn.perl b/git-svn.perl
> index 0b074c4..2379a71 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1599,35 +1599,35 @@ sub rebase_cmd {
>  sub post_fetch_checkout {
>         return if $_no_checkout;
>         my $gs = $Git::SVN::_head or return;
>         return if verify_ref('refs/heads/master^0');

Does "master" matter here?

I am wondering why this is not

	return if verify_ref("HEAD^0");

Moreover, since the code will check verify_ref("HEAD^0") anyway in
the place you updated, is this early return still necessary?

>         # look for "trunk" ref if it exists
>         my $remote = Git::SVN::read_all_remotes()->{$gs->{repo_id}};
>         my $fetch = $remote->{fetch};
>         if ($fetch) {
>                 foreach my $p (keys %$fetch) {
>                         basename($fetch->{$p}) eq 'trunk' or next;
>                         $gs = Git::SVN->new($fetch->{$p}, $gs->{repo_id}, $p);
>                         last;
>                 }
>         }
> 
> -	my $valid_head = verify_ref('HEAD^0');
> +	return if verify_ref('HEAD^0');

This one matches the description.  When post_fetch_checkout() is
called, if HEAD is already pointing at a valid commit, we do not
want to run checkout (or create a ref).

>         command_noisy(qw(update-ref refs/heads/master), $gs->refname);
> -	return if ($valid_head || !verify_ref('HEAD^0'));
> +	return unless verify_ref('HEAD^0');

I do not understand these three lines.  Why aren't they like this?

	command_noisy(qw(update-ref HEAD), $gs->refname) || return;

That is, in a fresh repository whose HEAD points at an unborn
'master', nothing changes from the current behaviour.  If a fresh
repository whose HEAD points at some other unborn branch, should the
code still want to update 'master'?  Wouldn't we rather want to
update that branch?

If the caller does not handle errors, it could be even clearer to
write it like

	command_noisy(qw(update-ref HEAD), $gs->refname) ||
		die "Cannot update HEAD!!!";

>         return if $ENV{GIT_DIR} !~ m#^(?:.*/)?\.git$#;
>         my $index = $ENV{GIT_INDEX_FILE} || "$ENV{GIT_DIR}/index";
>         return if -f $index;
> 
>         return if command_oneline(qw/rev-parse --is-inside-work-tree/) eq 'false';
>         return if command_oneline(qw/rev-parse --is-inside-git-dir/) eq 'true';
>         command_noisy(qw/read-tree -m -u -v HEAD HEAD/);
>         print STDERR "Checked out HEAD:\n  ",
>                      $gs->full_url, " r", $gs->last_rev, "\n";
>         if (auto_create_empty_directories($gs)) {
>                 $gs->mkemptydirs($gs->last_rev);
>         }
>  }
