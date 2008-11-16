From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/4] gitweb: separate heads and remotes lists
Date: Sun, 16 Nov 2008 09:34:53 -0800
Message-ID: <7viqqn377m.fsf@gitster.siamese.dyndns.org>
References: <1226842089-1159-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1226842089-1159-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1226842089-1159-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1226842089-1159-4-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 18:36:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1lY1-0004tb-CB
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 18:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbYKPRfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 12:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbYKPRfT
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 12:35:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53241 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbYKPRfS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 12:35:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2E7677E25F;
	Sun, 16 Nov 2008 12:35:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B372D7E25D; Sun,
 16 Nov 2008 12:35:00 -0500 (EST)
In-Reply-To: <1226842089-1159-4-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Sun, 16 Nov 2008 14:28:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EE4B9106-B404-11DD-845E-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101145>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> We specialize the 'heads' action to only display local branches, and
> introduce a 'remotes' action to display the remote branches (only
> available when the remotes_head feature is enabled).
>
> Mirroring this, we also split the heads list in summary view into
> local and remote lists, each linking to the appropriate action.
>
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   30 ++++++++++++++++++++++++++++--
>  1 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 0512020..6b09918 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -527,6 +527,7 @@ our %actions = (
>  	"heads" => \&git_heads,
>  	"history" => \&git_history,
>  	"log" => \&git_log,
> +	"remotes" => \&git_remotes,
>  	"rss" => \&git_rss,
>  	"atom" => \&git_atom,
>  	"search" => \&git_search,
> @@ -4467,6 +4468,7 @@ sub git_summary {
>  	my %co = parse_commit("HEAD");
>  	my %cd = %co ? parse_date($co{'committer_epoch'}, $co{'committer_tz'}) : ();
>  	my $head = $co{'id'};
> +	my $remote_heads = gitweb_check_feature('remote_heads');
>  
>  	my $owner = git_get_project_owner($project);
>  
> @@ -4474,7 +4476,8 @@ sub git_summary {
>  	# These get_*_list functions return one more to allow us to see if
>  	# there are more ...
>  	my @taglist  = git_get_tags_list(16);
> -	my @headlist = git_get_heads_list(16);
> +	my @headlist = git_get_heads_list(16, 'heads');
> +	my @remotelist = $remote_heads ? git_get_heads_list(16, 'remotes') : ();

Wasteful to run one for-each-ref for each list.

You earlier introduced $ref_item{'class'} so that you can differenciate
what you got from git_get_heads_list(); make use of it, perhaps like:

	my @heads_list = git_get_heads_list(16, \%head_class);
        my @headlist = grep { $_->{'class'} eq 'head' } @heads_list;
        my @remotelist = grep { $_->{'class'} eq 'remote' } @heads_list;

By the way, your [2/4] used "heads" and "remotes" as class, while your
[1/4] stored 'head' and 'remote' in $ref_item{'class'}.  Notice the above
suggestion corrects this discrepancy as well.
