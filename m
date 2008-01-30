From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Use config file or file for repository owner's name.
Date: Tue, 29 Jan 2008 22:16:16 -0800
Message-ID: <7vwsprj0sv.fsf@gitster.siamese.dyndns.org>
References: <1201670898-15076-1-git-send-email-ribas@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruno Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Wed Jan 30 07:17:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK6Fn-0000KV-FZ
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 07:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbYA3GQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 01:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900AbYA3GQX
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 01:16:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51596 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbYA3GQW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 01:16:22 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A7432B3A;
	Wed, 30 Jan 2008 01:16:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 81F3A2B39;
	Wed, 30 Jan 2008 01:16:18 -0500 (EST)
In-Reply-To: <1201670898-15076-1-git-send-email-ribas@c3sl.ufpr.br> (Bruno
	Ribas's message of "Wed, 30 Jan 2008 03:28:17 -0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72029>

Bruno Ribas <ribas@c3sl.ufpr.br> writes:

> Allow to use configuration variable gitweb.owner or $GIT_DIR/owner file to
> set the repository owner, it checks $GIT_DIR/owner first, then falls back to
> the gitweb.owner, if none exist uses filesystem directory's owner.
>
> Useful when we don't want to maintain project list file, and all
> repository directories have to have the same owner (for example when the
> same SSH account is shared for all projects, using ssh_acl to control
> access instead).

> +sub gitweb_get_project_owner {
> +	my $path = shift;
> +
> +	$git_dir = "$projectroot/$path";
> +	open my $fd, "$projectroot/$path/owner"
> +		or return git_get_project_config('owner');
> +	my $owner = <$fd>;
> +	close $fd;
> +	if (defined $owner) {
> +		chomp $owner;
> +	}
> +	return $owner;
> +}
> +
>  sub git_get_project_owner {
>  	my $project = shift;
>  	my $owner;
> @@ -1767,6 +1781,10 @@ sub git_get_project_owner {
>  	if (exists $gitweb_project_owner->{$project}) {
>  		$owner = $gitweb_project_owner->{$project};
>  	}
> +
> +    if (!defined $owner) {
> +        $owner = gitweb_get_project_owner($project);
> +    }
>  	if (!defined $owner) {
>  		$owner = get_file_owner("$projectroot/$project");
>  	}

I am not sure about the effect of this change on a large scale
site.  If you do not have the project list file, originally we
just needed a stat per project, but now you open an extra file
(either "owner" or "config") and read it, once per every
project.

The project list page does that for every project, and it
actually is worse because it also needs to open yet another file
"description" from the directory.  It almost makes me wonder if
are much better of to have a single file per project to read all
the necessary information off of, instead of having to open many
little files (currently it is only two---owner and description.
But who knows what other little pieces of information you would
want to add next week).
